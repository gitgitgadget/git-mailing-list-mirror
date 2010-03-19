From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: About single user setup for lightweights
Date: Fri, 19 Mar 2010 13:14:11 -0400
Message-ID: <32541b131003191014u6439f0dhe90eca77f42e24dd@mail.gmail.com>
References: <87r5nht6uf.fsf@newsguy.com> <32541b131003181913v7319d6a1ydd72c0177729dbf4@mail.gmail.com> 
	<87k4t81vt8.fsf@hbox.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Harry Putnam <reader@newsguy.com>, bazaar@lists.canonical.com,
	mercurial@selenic.com, git@vger.kernel.org
To: Martin Geisler <mg@lazybytes.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 18:14:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsfmQ-0001Mo-18
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 18:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab0CSROd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 13:14:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60996 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab0CSROc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 13:14:32 -0400
Received: by gyg8 with SMTP id 8so1642514gyg.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YC2zNjG4eNdssGVYIOQ3+lvmxqUo2l7/dk+mdgFigfQ=;
        b=oIdfHMFAQuIMRZgJlurToaFuvn7jNPKGuN8UWZr/CvCKn3XTHa15BFYlchlHRKtL9Z
         qM80EwL3o3t7NbNVlyEeRiNVgRGJ+nJC8PwOEQEiXGySapQyJAKbQtLpWSUYegXwuTv0
         erFcVsFcEvXBHSRH6kCbcl1mZhx7tpvMq4Rao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rfkRuNWNhOeYNejbK44QCWpfGxOGfFowd5J77JLRotJNWy6fk7ZOQC1ORaWWm6V8ZQ
         lLpEbP+zISi2FHhfLMBDx3VvZj0IxQ0eLJgmd02jAGMFKaLdjAx3h0A2+mN3CtkIrLhb
         UdW5atITZwftQYdlaQJNlLMVilltzVW+kR2j4=
Received: by 10.150.242.40 with SMTP id p40mr5103605ybh.205.1269018871178; 
	Fri, 19 Mar 2010 10:14:31 -0700 (PDT)
In-Reply-To: <87k4t81vt8.fsf@hbox.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142620>

On Fri, Mar 19, 2010 at 5:53 AM, Martin Geisler <mg@lazybytes.net> wrot=
e:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> git sucks at handling large binary files (>50 megs or so) unless you
>> have boatloads of RAM. If your binary files are moderately sized (a
>> few megs) then it'll probably be reasonably efficient. I don't know
>> about hg and bzr for memory usage.
>
> Mercurial also uses lots of RAM, way more than I had hoped. I did som=
e
> tests with this recently:
>
> =A0http://markmail.org/message/uxqtmmnkyimxse5b
>
> They show a factor 3-6 blowup when working with a 256 MB file.
>
> We don't really recommend storing such large files in Mercurial. Inst=
ead
> we recommend storing the files outside of the tree, e.g., on a server
> with a huge disk. The bfiles extension can do this:
>
> =A0http://mercurial.selenic.com/wiki/BfilesExtension

You might find my "bup" program entertaining:

  http://github.com/apenwarr/bup/

It happens to use the git file format, but the hashsplitting algorithm
would work with any repo and the code is written mostly in python.
Because it breaks larges files into chunks, it tends to avoid the
memory growth problems (at the cost of somewhat worse compression and
deltas).  At least you can then store them in your repository.

bup is intended for use as a full-system backup tool, but it would be
interesting to take the same techniques and use them to solve the
general case of large files in git/hg.

Have fun,

Avery
