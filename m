From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 7 Jul 2009 21:57:14 +0200
Message-ID: <81b0412b0907071257q14bb544dp99846f2a35fbada2@mail.gmail.com>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.01.0907071142330.3210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOGnB-0006Xg-EV
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 21:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757016AbZGGT5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 15:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758150AbZGGT5U
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 15:57:20 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:45267 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758237AbZGGT5S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 15:57:18 -0400
Received: by bwz25 with SMTP id 25so2315452bwz.37
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gWAAgnKlesFwgB3V4Ic/uWhaN4UC70wNDt3wOqTPWPw=;
        b=Egxbiqgp9ZB6rgHMvDoxbozcUz+S5DWYPg8mxLRHadrYLXISzJysW11G3ZoXlMTKsU
         H1Cy3oi/pdASD9GWiwaIjC6BIgRBNXK5banygdgQqU/4enOxSh/t7OoGHc6egjq4dhKN
         2A1NcDipNBMjbj2acl08JLTPH6dkjrKkF7l0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZLq8CuPUMHmeHlvGSvvF4onIjYRZ062XDH2II2xaX1nZk0+alJ1NUIKQdDK5M6qXLm
         81G954o1nUfhSivC3UgLBiezMLl+FpyEavnOXdOGZbJfwOd5fSbN6Bb0biNuuZmkKfRK
         bUBSO7MpTw2JxBeqEsuShxWSbiLwqgDR4QUog=
Received: by 10.204.112.205 with SMTP id x13mr6063839bkp.170.1246996634088; 
	Tue, 07 Jul 2009 12:57:14 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0907071142330.3210@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122864>

On Tue, Jul 7, 2009 at 21:17, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
> So right now, my personal opinion is:
>
> =C2=A0- let's just face the fact that the only sane filename represen=
tation is
> =C2=A0 NFC UTF-8. Show filenames as UTF-8 when possible, rather than =
quoting
> =C2=A0 them.
>
> =C2=A0- Do case (b) above: add support for converting NFD -> NFC at r=
eaddir()
> =C2=A0 time, so that OS X people can use UTF-8 sanely.
>
> =C2=A0- add a "binary encoding" mode to filesystems that actually use=
 Latin1,
> =C2=A0 just so that if people use Latin1 or Shift-JIS filesystem enco=
dings, we
> =C2=A0 promise that we'll never munge those kinds of names.
>
> =C2=A0- Maybe we'd make the "binary encoding" (which is effectively e=
xisting
> =C2=A0 git behavior) be the default on non-OSX platforms.
>
> but that's just my gut feel from trying to weigh the costs of trying =
to do
> something more involved against the costs of OS X support and just le=
tting
> crazy encodings exist in their own little worlds. So a development gr=
oup
> that uses Shift-JIS (or Latin1) would be able to work internally with=
 git
> that way, but would not be able to sanely work with the world at larg=
e
> that uses UTF-8.

Maybe we could at least let the user save the encoding of file names
in the tree objects somehow?
