From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] commit -c/-C/--amend: acquire authorship and restamp time 
	with --claim
Date: Tue, 3 Nov 2009 14:39:05 -0200
Message-ID: <55bacdd30911030839v724924bm7a49a08172ed7573@mail.gmail.com>
References: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com> 
	<1257101127-8196-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5sixbd1.fsf@alter.siamese.dyndns.org> <55bacdd30911011257m22ee85f2wc5d51865f7f2aadd@mail.gmail.com> 
	<7vbpjlycqc.fsf@alter.siamese.dyndns.org> <55bacdd30911011654k22eb6b13r28897bf71fc5e11b@mail.gmail.com> 
	<7v1vkhy6n4.fsf@alter.siamese.dyndns.org> <7vskcxwro7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 17:40:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5MQJ-0006DT-Nf
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 17:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbZKCQjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 11:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbZKCQjY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 11:39:24 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:39566 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbZKCQjX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 11:39:23 -0500
Received: by gxk26 with SMTP id 26so3630120gxk.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 08:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=v7RDOihKb2xtFqebwLBCt1mA6diOhnt91V3WABfLJlM=;
        b=T1pU5uvHM15OJB8AMdq38OUQYbq8w31Csn8g6TSE7opFEJCouItsLyj6Wh+ITu1yom
         KgT1w7+BQSFyg4ivBrTFQdglTYf4kNw4PuWs6h9X2XkiisaprithsodCghWmqknArkZr
         gmATka/g1isLNNfyM674IocL+V+1JzXvqjxfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vBAQm9MLzUUGLFROyvLrBOV1sQsqK6+zKqsQVd0jYcVT61y4l5OyWYYL79C1Tnn+5c
         5pCb44oA6DuUytirwxgUaXg/3NBDTV6BExxh9pCBVMFDSdgW3cD3WV9xydWxwT+EIjPz
         yPr8LtrXQ7wl//S4Qh8fFdXc3kv6FFi0fFtmk=
Received: by 10.150.213.7 with SMTP id l7mr536400ybg.220.1257266365317; Tue, 
	03 Nov 2009 08:39:25 -0800 (PST)
In-Reply-To: <7vskcxwro7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131978>

I am gonna check all this information but you probably missed the last
patch I sent: http://marc.info/?l=3Dgit&m=3D125712272606721&w=3D2
Could you please check this one... while I am checking this e-mail.

Regards

2009/11/2 Junio C Hamano <gitster@pobox.com>:
> The last one was probably harder to read since it was an interdiff. =C2=
=A0Here
> is what I am considering to queue.
>
> No, I didn't use --mine option when I ran "commit --amend" to record =
this
> one ;-)
>
> -- >8 --
> From: Erick Mattos <erick.mattos@gmail.com>
> Date: Sun, 1 Nov 2009 16:45:27 -0200
> Subject: [PATCH] git commit --mine: ignore authorship information tak=
en from -c/-C/--amend
>
> When we use -c, -C, or --amend, we are trying one of two things: usin=
g the
> source as a template or modifying a commit with corrections.
>
> When these options are are used, the authorship and timestamp recorde=
d in
> the newly created commit is always taken from the original commit. =C2=
=A0This
> is inconvenient when you want to just borrow the commit log message, =
or
> your change is so significant that you should take over the authorshi=
p
> (with the blame for bugs you introduced).
>
> Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0Documentation/git-commit.txt | =C2=A0 =C2=A07 +++-
> =C2=A0builtin-commit.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 10 +++-
> =C2=A0t/t7509-commit.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0103 ++++++++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 116 insertions(+), 4 deletions(-)
> =C2=A0create mode 100755 t/t7509-commit.sh
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 0578a40..7832720 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
> =C2=A0--------
> =C2=A0[verse]
> =C2=A0'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend=
] [--dry-run]
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[(-c | -C) <commit>] [-F <file> |=
 -m <msg>]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[(-c | -C) <commit>] [-F <file> |=
 -m <msg>] [--mine]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--allow-empty] [--no-verify] [-e]=
 [--author=3D<author>]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--cleanup=3D<mode>] [--] [[-i | -=
o ]<file>...]
>
> @@ -69,6 +69,11 @@ OPTIONS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Like '-C', but with '-c' the editor is inv=
oked, so that
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the user can further edit the commit messa=
ge.
>
> +--mine::
> + =C2=A0 =C2=A0 =C2=A0 When used with -C/-c/--amend options, declare =
that the
> + =C2=A0 =C2=A0 =C2=A0 authorship of the resulting commit now belongs=
 of the committer.
> + =C2=A0 =C2=A0 =C2=A0 This also renews the author timestamp.
> +
> =C2=A0-F <file>::
> =C2=A0--file=3D<file>::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Take the commit message from the given fil=
e. =C2=A0Use '-' to
> diff --git a/builtin-commit.c b/builtin-commit.c
> index beddf01..aa42989 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -51,7 +51,7 @@ static const char *template_file;
> =C2=A0static char *edit_message, *use_message;
> =C2=A0static char *author_name, *author_email, *author_date;
> =C2=A0static int all, edit_flag, also, interactive, only, amend, sign=
off;
> -static int quiet, verbose, no_verify, allow_empty, dry_run;
> +static int quiet, verbose, no_verify, allow_empty, dry_run, renew_au=
thorship;
> =C2=A0static char *untracked_files_arg;
> =C2=A0/*
> =C2=A0* The default commit message cleanup mode will remove the lines
> @@ -91,8 +91,9 @@ static struct option builtin_commit_options[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_FILENAME('F', "file", &logfile, "read =
log from file"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_STRING(0, "author", &force_author, "AU=
THOR", "override author for commit"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_CALLBACK('m', "message", &message, "ME=
SSAGE", "specify commit message", opt_parse_m),
> - =C2=A0 =C2=A0 =C2=A0 OPT_STRING('c', "reedit-message", &edit_messag=
e, "COMMIT", "reuse and edit message from specified commit "),
> + =C2=A0 =C2=A0 =C2=A0 OPT_STRING('c', "reedit-message", &edit_messag=
e, "COMMIT", "reuse and edit message from specified commit"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_STRING('C', "reuse-message", &use_mess=
age, "COMMIT", "reuse message from specified commit"),
> + =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN(0, "mine", &renew_authorship, "the=
 commit is authored by me now (used with -C-c/--amend)"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOLEAN('s', "signoff", &signoff, "add=
 Signed-off-by:"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_FILENAME('t', "template", &template_fi=
le, "use specified template file"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOLEAN('e', "edit", &edit_flag, "forc=
e edit of commit"),
> @@ -381,7 +382,7 @@ static void determine_author_info(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0email =3D getenv("GIT_AUTHOR_EMAIL");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0date =3D getenv("GIT_AUTHOR_DATE");
>
> - =C2=A0 =C2=A0 =C2=A0 if (use_message) {
> + =C2=A0 =C2=A0 =C2=A0 if (use_message && !renew_authorship) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *a,=
 *lb, *rb, *eol;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a =3D strstr(u=
se_message_buffer, "\nauthor ");
> @@ -747,6 +748,9 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (force_author && !strchr(force_author, =
'>'))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0force_author =3D=
 find_author_by_nickname(force_author);
>
> + =C2=A0 =C2=A0 =C2=A0 if (force_author && renew_authorship)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Using both --=
mine and --author does not make sense");
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (logfile || message.len || use_message)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use_editor =3D=
 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (edit_flag)
> diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
> new file mode 100755
> index 0000000..ec13cea
> --- /dev/null
> +++ b/t/t7509-commit.sh
> @@ -0,0 +1,103 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Erick Mattos
> +#
> +
> +test_description=3D'git commit --mine'
> +
> +. ./test-lib.sh
> +
> +author_header () {
> + =C2=A0 =C2=A0 =C2=A0 git cat-file commit "$1" |
> + =C2=A0 =C2=A0 =C2=A0 sed -n -e '/^$/q' -e '/^author /p'
> +}
> +
> +message_body () {
> + =C2=A0 =C2=A0 =C2=A0 git cat-file commit "$1" |
> + =C2=A0 =C2=A0 =C2=A0 sed -e '1,/^$/d'
> +}
> +
> +test_expect_success '-C option copies authorship and message' '
> + =C2=A0 =C2=A0 =C2=A0 echo "Initial" >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -m "Initial Commit" --author Frigat=
e\ \<flying@over.world\> &&
> + =C2=A0 =C2=A0 =C2=A0 git tag Initial &&
> + =C2=A0 =C2=A0 =C2=A0 echo "Test 1" >>foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -a -C Initial &&
> + =C2=A0 =C2=A0 =C2=A0 author_header Initial >expect &&
> + =C2=A0 =C2=A0 =C2=A0 author_header HEAD >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> +test_expect_success '-C option copies only the message with --mine' =
'
> + =C2=A0 =C2=A0 =C2=A0 echo "Test 2" >>foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -a -C Initial --mine &&
> + =C2=A0 =C2=A0 =C2=A0 echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMA=
IL> $GIT_AUTHOR_DATE" >expect &&
> + =C2=A0 =C2=A0 =C2=A0 author_header HEAD >actual
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual &&
> +
> + =C2=A0 =C2=A0 =C2=A0 message_body Initial >expect &&
> + =C2=A0 =C2=A0 =C2=A0 message_body HEAD >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> +test_expect_success '-c option copies authorship and message' '
> + =C2=A0 =C2=A0 =C2=A0 echo "Test 3" >>foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 EDITOR=3D: VISUAL=3D: git commit -a -c Initial=
 &&
> + =C2=A0 =C2=A0 =C2=A0 author_header Initial >expect &&
> + =C2=A0 =C2=A0 =C2=A0 author_header HEAD >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> +test_expect_success '-c option copies only the message with --mine' =
'
> + =C2=A0 =C2=A0 =C2=A0 echo "Test 4" >>foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 EDITOR=3D: VISUAL=3D: git commit -a -c Initial=
 --mine &&
> + =C2=A0 =C2=A0 =C2=A0 echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMA=
IL> $GIT_AUTHOR_DATE" >expect &&
> + =C2=A0 =C2=A0 =C2=A0 author_header HEAD >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual &&
> +
> + =C2=A0 =C2=A0 =C2=A0 message_body Initial >expect &&
> + =C2=A0 =C2=A0 =C2=A0 message_body HEAD >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> +test_expect_success '--amend option copies authorship' '
> + =C2=A0 =C2=A0 =C2=A0 git checkout Initial &&
> + =C2=A0 =C2=A0 =C2=A0 echo "Test 5" >>foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -a --amend -m "amend test" &&
> + =C2=A0 =C2=A0 =C2=A0 author_header Initial >expect &&
> + =C2=A0 =C2=A0 =C2=A0 author_header HEAD >actual &&
> +
> + =C2=A0 =C2=A0 =C2=A0 echo "amend test" >expect &&
> + =C2=A0 =C2=A0 =C2=A0 message_body HEAD >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> +test_expect_success '--mine makes the commit ours even with --amend =
option' '
> + =C2=A0 =C2=A0 =C2=A0 git checkout Initial &&
> + =C2=A0 =C2=A0 =C2=A0 echo "Test 6" >>foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -a --mine -m "Changed again" --amen=
d &&
> + =C2=A0 =C2=A0 =C2=A0 echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMA=
IL> $GIT_AUTHOR_DATE" >expect &&
> + =C2=A0 =C2=A0 =C2=A0 author_header HEAD >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual &&
> +
> + =C2=A0 =C2=A0 =C2=A0 echo "Changed again" >expect &&
> + =C2=A0 =C2=A0 =C2=A0 message_body HEAD >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> +test_expect_success '--mine and --author are mutually exclusive' '
> + =C2=A0 =C2=A0 =C2=A0 git checkout Initial &&
> + =C2=A0 =C2=A0 =C2=A0 echo "Test 7" >>foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git commit -a --mine --author=3D=
"Xyzzy <frotz@nitfol.xz>"
> +'
> +
> +test_done
> --
> 1.6.5.2.246.gc99575
>
>
