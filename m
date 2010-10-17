From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCHv2 1/5] worktree: provide better prefix to go back to
 original cwd
Date: Sun, 17 Oct 2010 17:01:38 +0700
Message-ID: <20101017094524.GA6034@do>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
 <1287185204-843-2-git-send-email-judge.packham@gmail.com>
 <20101016184259.GB30457@burratino>
 <4CBA63E2.8030502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens.Lehmann@web.de, gitster@pobox.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 12:02:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Q42-0004oi-Qq
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 12:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271Ab0JQKBy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 06:01:54 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34801 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212Ab0JQKBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 06:01:53 -0400
Received: by pxi16 with SMTP id 16so320472pxi.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vnE9BQG7dtIYMgjc76n2OI3ZrS0knm9jL2DyRJX3eqQ=;
        b=KK19cgdYNAl5C/34EsthevfS8uIuY4ds/V46TRJFwt/48qhRvxGoF4iQcRl/7NmnJK
         /ir5e2/2abiKzkbDykFXfILZxiXuGUqz8rFQSudj16JlJtbv9FOekI098lnzrRhP2gHx
         Ek21hh2zEnb2gIIgGFU4A5Ss3RJA3i8m9D2JM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MaVIw6++uyO5dQNhHeWv/17UB+9nf3ImPbScPN77OXTe5w0t648KaHpQ0DO6U7oLtB
         MqWXu5hp7VXyjGN8MwWMHX69zd2Y9H96Qiio5nLP1IJSUIZ5c9g5ZM0AwsQjtTKqpjVu
         Xg801YU+7FOQBjx2FzK7g8kDbPzHyQFktwbvw=
Received: by 10.142.49.11 with SMTP id w11mr2368497wfw.218.1287309711158;
        Sun, 17 Oct 2010 03:01:51 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.198.15])
        by mx.google.com with ESMTPS id p8sm20230360wff.16.2010.10.17.03.01.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 03:01:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 17 Oct 2010 17:01:38 +0700
Content-Disposition: inline
In-Reply-To: <4CBA63E2.8030502@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159200>

On Sat, Oct 16, 2010 at 07:48:02PM -0700, Chris Packham wrote:
> On 16/10/10 11:42, Jonathan Nieder wrote:
> > Hi,
> >=20
> > Chris Packham wrote:
> >=20
> >> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
> >>
> >> When both GIT_DIR and GIT_WORK_TREE are set, if cwd is outside wor=
ktree,
> >> prefix (the one passed to every builtin commands) will be set to N=
ULL,
> >> which means "user stays at worktree topdir".
> >>
> >> As a consequence, command line arguments are supposed to be relati=
ve
> >> to worktree topdir, not current working directory. Not very intuit=
ive.
> >=20
> > Thanks.  More detailed history for this patch:
> >=20
> >  - v0: http://thread.gmane.org/gmane.comp.version-control.git/15759=
9/focus=3D157601
> >  - v1: http://thread.gmane.org/gmane.comp.version-control.git/15828=
7
> >  - v2: http://thread.gmane.org/gmane.comp.version-control.git/15836=
9
> >=20
>=20
> I think I must have missed v2. I was playing around with my gmail
> filters around that time so I could have missed them. Actually now I'=
ve
> found the message it's missing the last 'm' in gmail.com. I'll grab t=
he
> latest patch and give it a test when I get a chance.

I missed the last "m" in your email address. That's why v2 never reache=
d you.
I thought I sent you an email but probably forgot it.

Anyway v2 does not work if worktree and cwd are on different Windows dr=
ives.
This on top should fix it:

---8<---
diff --git a/setup.c b/setup.c
index 2389a9e..35d2691 100644
--- a/setup.c
+++ b/setup.c
@@ -371,12 +371,8 @@ static const char *setup_prefix(const char *cwd)
 	}
 	/* get /foo/, not /foo/baa if /foo/baa1 and /foo/baa2 are given */
 	else if (worktree[len] && cwd[len]) {
-		while (len && !is_dir_sep(worktree[len]))
-			len--;
-		len++;
-
 		/* Worktree and cwd are on different drives? */
-		if (len =3D=3D 3 && has_dos_drive_prefix(cwd)) {
+		if (!len && has_dos_drive_prefix(cwd)) {
 			if (startup_info) {
 				/* make_path_to_path will add the trailing slash */
 				startup_info->cwd_to_worktree =3D make_path_to_path(NULL, worktree=
);
@@ -384,6 +380,10 @@ static const char *setup_prefix(const char *cwd)
 			}
 			return NULL;
 		}
+
+		while (len && !is_dir_sep(worktree[len]))
+			len--;
+		len++;
 	}
 	else {
 		if (worktree[len]) {
---8<---

>=20
> > Any thoughts about the previous questions?
> >=20
>=20
> I haven't caught up on the newest thread so no great revelations. Exc=
ept
> that for the grep submodules use-case we can assume that the worktree
> will be a subdirectory of the cwd. I don't think we want to limit
> ourselves to that one use-case.

While at it, have you thought of support --recursive and
--full-tree [1]? There are issues with --full-tree and prefixes [2],
which is why it is dropped but I think it's a good idea.

--full-tree disregards where you stand and greps in whole repo. In a
repo with submodules, that would mean grep the supermodule and all
submodules regardless where you stand, even if you stand in a
submodule.

[1] http://mid.gmane.org/7vk4xggv27.fsf@alter.siamese.dyndns.org
[2] http://mid.gmane.org/7vskaqptvj.fsf@alter.siamese.dyndns.org
--=20
Duy
