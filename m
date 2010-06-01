From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] revert: change help_msg() to take no argument
Date: Tue, 1 Jun 2010 01:27:45 -0500
Message-ID: <20100601062745.GA27593@progeny.tock>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
 <20100531194240.28729.49459.chriscool@tuxfamily.org>
 <20100601050815.GB22441@progeny.tock>
 <20100601054034.GA6638@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 01 08:27:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJKx9-0000JO-FP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 08:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab0FAG1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 02:27:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57809 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab0FAG1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 02:27:50 -0400
Received: by gwaa12 with SMTP id a12so3299967gwa.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 23:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CAV3rLOGbF4O1sbABmYSgllJZbCNzHcCu93lltj4aI4=;
        b=v+wGtqJbkM4HL7ICsgAzqjUcpHHZIk/P6uZFz+XAxk06qQnliDf4H+YWa7GZYnbOiS
         y3caqtQD29OC0sfppihVAgg1+xuLDf9v5rHV0xkMxqj+irYItNtflGRNhWyTer9gupst
         LzO1uDTRZPnktVrj7hWlv2tcFX1RGR3LMnPYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XUdT9QP3NoXENo4P5sLwibnw5pqDll1eFNY1FO8HLG28uxvLZv8V1L0d7W/bSjIXVm
         cKYrPQtqdlImd0W4XqWk0/0C/0Gsz3pRVEam8JMpDTJyvFWZjYarJZhoqGjPXzrOoJvn
         yfxAq1/XHwl/LQXYAq7FBVXoWFXOdEZYSEY6E=
Received: by 10.231.187.3 with SMTP id cu3mr7163013ibb.75.1275373669321;
        Mon, 31 May 2010 23:27:49 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm29896865ibl.10.2010.05.31.23.27.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 May 2010 23:27:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100601054034.GA6638@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148081>

Jeff King wrote:

> You cc'd me, which I guess means you git-blame'd the line in question=
=2E
> But you really need to parent-blame about five steps back

Worse, I used =E2=80=98git log -- builtin-revert.c=E2=80=99 and stopped=
 reading when
it seemed you must know be current maintainer for that line.  Sorry
about that.

> we could actually make it stash the
> original authorship information somewhere (in addition to the commit
> message template) and then pull it out automatically.

I think that can wait for cherry-pick --continue.

Here=E2=80=99s an ugly patch to use --author.  I call it ugly because t=
he
relevant part of t3507-cherry-pick-conflict.sh output looks like
this:

| Automatic cherry-pick failed.  After resolving the conflicts,
| mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
| and commit the result with:=20
|=20
|         git commit --author=3D'A U Thor <author@example.com>' \
|                     --date=3D'1112912113 -0700'

In other words, the command is long and the date human-unfriendly.

Anyway, given that cherry-pick --continue is just around the corner, I
withdraw my complaint about the =E2=80=98commit -c=E2=80=99 version.

Thanks for the pointer.

diff --git a/builtin/revert.c b/builtin/revert.c
index bbafc41..9b8e7d6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -252,9 +252,16 @@ static char *help_msg(void)
 		"and commit the result");
=20
 	if (action =3D=3D CHERRY_PICK) {
+		const char *ident =3D git_author_info(IDENT_ERROR_ON_NO_NAME);
+		const char *ident_end =3D ident ? strchr(ident, '>') : NULL;
+		if (!ident_end || ident_end[1] !=3D ' ')
+			die("git_author_info returned nonsense");
 		strbuf_addf(&helpbuf, " with: \n"
 			"\n"
-			"        git commit\n");
+			"        git commit --author=3D'%.*s' \\\n"
+			"                    --date=3D'%s'\n",
+			(int) (ident_end + 1 - ident), ident,
+			ident_end + 2);
 	}
 	else
 		strbuf_addch(&helpbuf, '.');
