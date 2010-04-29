From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Multiblobs
Date: Thu, 29 Apr 2010 11:28:20 -0400
Message-ID: <x2v32541b131004290828ua9c2d194o1280177360dd231e@mail.gmail.com>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com> 
	<loom.20100428T204406-308@post.gmane.org> <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com> 
	<alpine.DEB.2.00.1004291231410.16241@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Apr 30 21:27:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7vra-0007Ed-KN
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450Ab0D3Qrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 12:47:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62591 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413Ab0D3Qrj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Apr 2010 12:47:39 -0400
Received: by gwj19 with SMTP id 19so187615gwj.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q4xoj6GiYdqpTK4bAUS4Sf1krecu1fGI6jnsQwpwTUU=;
        b=g893GTdHZlAUOF9z+r7YMX9KGDmnUusZE6KUx2h8kulPx3StOuKsfyjNuyRGaSx1sv
         8bCmos07KtRKsVKUVxR+XpRXfkoSWN2zA3tUNtgiWzFddJjbDe848vZtXys2I4Wf7f+p
         SNjhO0uBIRpxA+Bdp7YBfQFJx2lrxXwNRa6kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZlEEZbe9brp1joTbrGPQ7WN8zBju0JZFuJE2k4WrnUVr+eXCs30lj28X/agdfDZ6Bz
         9QVTLQPMYSeAcGsfgTkS8BNEeDF3mCLni0XPkcmnj40KzYKtG3hXRUJnsUuAhDguQxCS
         R60M1H3/9oyjAQd8JHFNx7bGyUwlqqOOWh7Hs=
Received: by 10.150.118.13 with SMTP id q13mr1502569ybc.255.1272554920862; 
	Thu, 29 Apr 2010 08:28:40 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Thu, 29 Apr 2010 08:28:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1004291231410.16241@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146050>

On Thu, Apr 29, 2010 at 7:34 AM, Peter Krefting <peter@softwolves.pp.se=
> wrote:
> Avery Pennarun:
>> But why not use a .gitattributes filter to recompress the zip/odp fi=
le
>> with no compression, as I suggested? =A0Then you can just dump the w=
hole thing
>> into git directly.
>
> The advantage would be that you could look at the history of the indi=
vidual
> components of the zip/openoffice file and follow changes.

This use case seems to be converging more and more on the
"clean/smudge filter like" idea, which might be ok.  But I think it
would be a kind of messy if the git index/worktree shows only one
file, but the actual object shows up as a tree, though.  What should
'git show HEAD:filename.odt' do?  How about 'git cat-file
HEAD:filename.odt'?  What if I *do* want to check out one of the
individual components?

It might be saner to just write some wrapper scripts on top of git,
and cleanly just check in the individual components.  Then just build
a Makefile and run something like 'make extract' before checkin (to
make sure all the .odp files/etc are broken into components) and 'make
assemble' after checkout.

Have fun,

Avery
