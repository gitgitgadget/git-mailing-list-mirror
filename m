From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 11 Jan 2010 20:40:07 +0100
Message-ID: <4c8ef71001111140j7e7d0081o7718d956104a2451@mail.gmail.com>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
	 <20100104053125.GA5083@coredump.intra.peff.net>
	 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
	 <20100104064408.GA7785@coredump.intra.peff.net>
	 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
	 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
	 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
	 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
	 <4c8ef71001111119p253170f8q37bcd3708d894a62@mail.gmail.com>
	 <alpine.LFD.2.00.1001111124480.17145@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 20:43:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUQ7p-0004ST-Fm
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 20:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab0AKTkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 14:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875Ab0AKTkK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 14:40:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:18360 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab0AKTkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 14:40:08 -0500
Received: by fg-out-1718.google.com with SMTP id 22so877547fge.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 11:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=U7yLsnUOBbU5kEElSqknpRikKsR4CNXpWklUY3AdFW0=;
        b=B6EE8/BKW2/AcdTvOYXAVcO3eU7FBrZPduI/pNPhsLZn0EUM8MiLY8dIfgrb9bu+K4
         PY+8546SRhKL2q7dMLU7mGARqiOXXTRi/OxxRsul8wtipDm2iEfeyxYIRiArpxsL0k+n
         M04tAT3X40QgEFW7TS7xxXzZn395dZ0J+IvpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XlKK2IZCwhMQMXRQZqouzwhPkFKfTFPSc+pCzhb8pIgekUI5GSZjLSplC082HCHcDG
         gMXkuPpcy8C1myHhTRRqMQgvvTPwFycZ86V/7A/0/n3igyIZbuhHCFUgQ0yhgFlDFFGg
         cVmuLrYnZ7OGhoPE6rAD8lOZD8KrCIw021QkA=
Received: by 10.239.143.133 with SMTP id k5mr1041196hba.57.1263238807404; Mon, 
	11 Jan 2010 11:40:07 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001111124480.17145@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136658>

On Mon, Jan 11, 2010 at 20:29, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 11 Jan 2010, Fredrik Kuivinen wrote:
>>
>> Any ideas on how this can be explained?
>
> Could it be a bad 'strstr()' implementation?
>
> Try a complex pattern ("qwerty.*as" finds the same line), and see if that
> too is slower than before. If that is faster than it used to be (with
> --no-ext-grep, of course), then it's strstr() that is badly implemented.

Ah, yes, that's it. With the pattern "qwerty.*as" I get 2.5s with the
patch and 6s without.

Thanks.

- Fredrik
