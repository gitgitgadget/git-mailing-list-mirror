From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Documentation/remote-helpers: Add invocation section
Date: Wed, 31 Mar 2010 00:47:09 +0530
Message-ID: <f3271551003301217h44c99d5bye4a614840661b05c@mail.gmail.com>
References: <f3271551003300947u4c7c2a83q13aaf786140bfa37@mail.gmail.com> 
	<20100330183748.GA10647@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 21:17:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwgwT-0004Ys-ET
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 21:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab0C3TRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 15:17:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55329 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0C3TRb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 15:17:31 -0400
Received: by gyg13 with SMTP id 13so2288939gyg.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9zgNB2yj8U3I4g345QPF5HPBSl157LksKT1gdMJLke0=;
        b=NL/XsQMAJbjc0Kl0L8FahaZRtWz8t7BI4tyn0wRYdrwIQV/4ZA4w4MA+ExjFonybDA
         OgGa9ELB8DDxr0O0dc/UcSOrGNqH30bNu2ydvpo266qReHTNvth62Tm8fdF48BrpbUds
         QytqiAOlHVjuXomsSSVwqeLXLfsFmYWO4bhJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=e1fcUZjUzVgx35vy7+NHxcZEY9Ga6CLtSDCAUjeiIagX1ZQe3B+aUA6TOuyeLm0xJk
         FO4y0mjTUAoiWPh5tfTt+Kv0r8aU9N1aiHFhnOnmxtYGEgeqpbci3UXENIqSpOdn9gat
         3WcEvGC4Ag3oiuUtspeKmRmUNprmYX5AL3MLs=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 12:17:09 -0700 (PDT)
In-Reply-To: <20100330183748.GA10647@progeny.tock>
Received: by 10.91.161.39 with SMTP id n39mr1211670ago.98.1269976649339; Tue, 
	30 Mar 2010 12:17:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143590>

Hi Jonathan,

On Wed, Mar 31, 2010 at 12:07 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> =A0The first argument identifies a <repository> as it would be specif=
ied to
> =A0git; typically, this is either a configured remote nickname or a U=
RL.

=46irst, "identifies a <repository> as it would be specified to=A0git"
doesn't emphasize on the fact that the repository is remote- it
emphasizes on repository, which isn't the desired result. Secondly,
why use the term "remote nickname"? `git remote add` adds a "remote",
not a "remote nickname" and similarly.

> =A0The second argument, if present, is a URL for the remote repositor=
y.
> =A0without such an argument, invocations for remotes with multiple
> =A0URLs set would be ambiguous.

Okay. I've explained what the ambiguity means in v3 of the patch. Thank=
s :)

>  If the second argument is missing,
> =A0this remote nickname does not have a URL set and should probably h=
ave
> =A0some transport-specific configuration set up separately.

I guess this didn't come out right. I'm dropping this line because I
don't think it's necessary. Including this line would mean that we'd
also need to explain other exceptional cases, like when the first
argument is not really a configured remote etc.

> =A0The URL in the second argument can be an arbitrary string. =A0It i=
s up
> =A0to the remote helper to assign meaning to it.

I'm not sure this is correct. Here's an excerpt from remote.c
	if (argc > 2) {
		url =3D argv[2];
	} else {
		url =3D remote->url[0];
	}
Notice how url is set to remote->url[0], in the `else` branch, where
the remote is an "ordinary remote" built by remote_get(). Even though
url may be any arbitrary string in the `if` branch, there'll be
problems when the program gets into the `else` branch transparently.

-- Ram
