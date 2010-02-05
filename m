From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Fri, 5 Feb 2010 22:31:14 +0100
Message-ID: <cb7bb73a1002051331q75429a4ey442fe8382523d2e8@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vaavo90ic.fsf@alter.siamese.dyndns.org> <cb7bb73a1002041538m64c6a6b3p5ee8bbaf0d78457@mail.gmail.com> 
	<201002051136.43738.johan@herland.net> <7veikzfysv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:32:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVmF-0003hD-Jt
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab0BEVbl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 16:31:41 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:38242 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927Ab0BEVbk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 16:31:40 -0500
Received: by ewy28 with SMTP id 28so503357ewy.28
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 13:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/BeCW6JgqMvUx0YHhoqHdfdLqlVrrecrLqpxcHFa6KE=;
        b=J4hCH/fj8qGlya6/tT1wUaVir8LHV29HzYgbCu268qsP7dxMKxZONTslz67kBxMS4V
         r7BKAb//dYKvNdNeikES596xsDb+l+sUzcRdHAENBMQ/AAXmM2Cles8RKqDoAmA4/Vo5
         BsP+zP6r09kz5601qbrSEzSaF6TAe3PHrtpTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NjxWglygAvphhPanXBgySbLiHp/9D+C94XXvqG16X4sKSGydhzWUc4EFJ+Vn0IQWVz
         a4629SzbH3M/4RZforK3RD8UaXPkiliKqRGwoa2hOqnOAOguieBbfobracbo7rFCNago
         8sXRhhXGCvKrKr7l+CFCvI/PPw8UZngmw9vsw=
Received: by 10.213.109.152 with SMTP id j24mr2748044ebp.25.1265405494156; 
	Fri, 05 Feb 2010 13:31:34 -0800 (PST)
In-Reply-To: <7veikzfysv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139096>

On Fri, Feb 5, 2010 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * format-patch
>
> To add notes to format-patch output, we might want to do something li=
ke:
>
> =A0 =A0$ git format-patch --notes-ref=3Dcommits --notes-ref=3Damlog -=
1
>
> and produce:
>
> =A0 =A0From 8bff7c5383ed833bd1df9c8d85c00a27af3e5b02 Mon Sep 17 00:00=
:00 2001
> =A0 =A0From: Andrew Myrick <amyrick@apple.com>
> =A0 =A0Date: Sat, 30 Jan 2010 03:14:22 +0000
> =A0 =A0Subject: [PATCH] git-svn: persistent memoization
> =A0 =A0X-Notes: pulled on Fri Feb 5 07:36:12 2010 -0800
> =A0 =A0 from git://git.bogomips.org/git-svn.git/
> =A0 =A0X-Notes-amlog: <1264821262-28322-1-git-send-email-amyrick@appl=
e.com>

+1 for header style note exporting. X-Git-Notes might be better.

> Points to notice:
>
> =A0- There is no point forcing users to spell "--notes-ref" parameter
> =A0 starting from refs/notes/; we should DWIM if they are missing;

Agreed.

> =A0- We would want to allow more than one notes hierarchy specified. =
This
> =A0 would affect format_note() function---take list of struct notes_t=
ree,
> =A0 perhaps;

I get the impression everybody wants this ;-)

> =A0- Allow callers of tell format_note() to add the name of the notes
> =A0 hierarchy the note came from (or just always add it if it is not =
the
> =A0 default "refs/notes/commits").

This is probably the most bothering issue: find, for each output
format that involves notes, the smart way of also outputting the
namespace it came from.

> =A0- For format-patch that produces a mbox output, the email header p=
art may
> =A0 be a better place to put notes (obeying the usual "indent by one =
space
> =A0 to continue the line" convention).

How would you cope with multi-line notes? One X-Git-Notes header per li=
ne?

> * "log --format=3D%N" and "log --show-notes"
>
> Currently %N expands to the hardcoded "log --show-notes" default form=
at.
> We can probably keep it that way. =A0When the user asked for a non de=
fault
> notes hierarchy (i.e. other than refs/notes/commits), we may want to
> adjust "Notes:" string to use "Notes-%s:" to show which hierarchy it =
came
> from, and concatenate them together.

We might want to do without the dash in standard log output: Notes:
and Notes <namespace>:

> For "log --show-notes" output, we also might want to move the notes t=
o the
> header part like I illustrated above in format-patch output, instead =
of
> "start with unindented Notes: and indented body at the end". =A0I.e. =
instead
> of showing this:
>
> =A0 =A0$ git log --notes-ref=3Damlog -1 4d0cc22
> =A0 =A0commit 4d0cc2243778b38c3759c6a08f4f1ed64155a070
> =A0 =A0Author: Junio C Hamano <gitster@pobox.com>
> =A0 =A0Date: =A0 Thu Feb 4 11:10:44 2010 -0800
>
> =A0 =A0 =A0 =A0fast-import: count --max-pack-size in bytes
>
> =A0 =A0 =A0 =A0Similar in spirit to 07cf0f2 (make --max-pack-size arg=
ument to 'git
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0Acked-by: Nicolas Pitre <nico@fluxnic.net>
>
> =A0 =A0Notes:
> =A0 =A0 =A0 =A0<7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>
>
>
> show it like this:
>
> =A0 =A0$ git log --notes-ref=3Damlog -1 4d0cc22
> =A0 =A0commit 4d0cc2243778b38c3759c6a08f4f1ed64155a070
> =A0 =A0Author: Junio C Hamano <gitster@pobox.com>
> =A0 =A0Date: =A0 Thu Feb 4 11:10:44 2010 -0800
> =A0 =A0Notes-amlog: <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>
>
> =A0 =A0 =A0 =A0fast-import: count --max-pack-size in bytes
>
> =A0 =A0 =A0 =A0Similar in spirit to 07cf0f2 (make --max-pack-size arg=
ument to 'git
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0Acked-by: Nicolas Pitre <nico@fluxnic.net>

The footer approach has the benefit of allowing multi-line notes to
just be printed the same way as multi-line commit messages, whereas
the header output would require one header line per commit line.

--=20
Giuseppe "Oblomov" Bilotta
