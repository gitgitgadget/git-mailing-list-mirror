From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit -c/-C/--amend: acquire authorship and restamp
 time  with --claim
Date: Sun, 01 Nov 2009 18:58:39 -0800
Message-ID: <7v1vkhy6n4.fsf@alter.siamese.dyndns.org>
References: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com>
 <1257101127-8196-1-git-send-email-erick.mattos@gmail.com>
 <7vr5sixbd1.fsf@alter.siamese.dyndns.org>
 <55bacdd30911011257m22ee85f2wc5d51865f7f2aadd@mail.gmail.com>
 <7vbpjlycqc.fsf@alter.siamese.dyndns.org>
 <55bacdd30911011654k22eb6b13r28897bf71fc5e11b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 04:00:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4n9S-0006ug-Ep
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 04:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbZKBC6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2009 21:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087AbZKBC6n
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 21:58:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbZKBC6m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2009 21:58:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F4BE8E35E;
	Sun,  1 Nov 2009 21:58:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rD3umGyynXey
	a+Zwa8HBljo567g=; b=p+45xPGH6g0MkH2omXlV5rumIwWmgntgOmi03jJuyY+d
	1tvtrQIXpg8VKgqbg8b3oAD/MyJaeW0KtKTX/Yf5YxjUDccOHQKc6heHZRnV3inv
	S0H2Wy61jPfMEnrFLwMPltEWWvzJUCc6FlW30Mtlo17GuGUT552Tv3XM7wJ8Fuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iPqhZ9
	wwmGfwj7y9CTlL2SrL+Vh+FW/qeLiO3ZZ/S61KXEQHEqAsAB3zOhMeCiYnXx+0ev
	zlYMsMSBqZQ0ob0zkagKxFi5Qz48R5oE5qjU6tZTg6w5G6EV4200MJt2lxNN7RD+
	T/erOsVmWqSId5zzM6/0B+3ErMCnL+U2mmgGA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0ED528E357;
	Sun,  1 Nov 2009 21:58:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9145D8E355; Sun,  1 Nov 2009
 21:58:40 -0500 (EST)
In-Reply-To: <55bacdd30911011654k22eb6b13r28897bf71fc5e11b@mail.gmail.com>
 (Erick Mattos's message of "Sun\, 1 Nov 2009 22\:54\:34 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1EAD040-C75B-11DE-8CEE-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131892>

Erick Mattos <erick.mattos@gmail.com> writes:

> 2009/11/1 Junio C Hamano <gitster@pobox.com>:
>> Erick Mattos <erick.mattos@gmail.com> writes:
>>
>>>> =C2=A0 =C2=A0% git commit --claim --author=3D'Erick Mattos <eric@m=
attos>' -C HEAD
>>>>
>>>> Should you detect an error? =C2=A0Does your code do so? =C2=A0Do y=
ou have a test
>>>> that catches this error?
>>>
>>> It works as intended. =C2=A0Both together.
>>
>> That does not make any sense. =C2=A0If you are saying this is yours =
and it is
>> his at the same time, there can be no sane way to work "as intended"=
, no?.
>
> I am adding a new option not changing the option --author already in
> git.  So it does work together.

Somebody who says "this commit is mine, and its author is this other
person" is not making any sense.  The resulting commit can either have
that person (i.e. the committer) as the author, which is what the "clai=
m"
option means, or it can have the person named with --author as the auth=
or,
but both cannot be true at the same time.

When you introduce a new option, sometimes it cannot sanely be used wit=
h
an existing option.  In such a case, two options (the new one and the
existing one) are called mutually exclusive.  And you add some code to
catch an user error to use them together.

>>>>> + =C2=A0 =C2=A0 git commit -c HEAD <<EOF
>>>>> + =C2=A0 =C2=A0 "Changed"
>>>>> + =C2=A0 =C2=A0 EOF &&
>>>>
>>>> What editor is reading this "Changed"?
>>>
>>> Nobody cares... =C2=A0Just a text to change the file.
>>
>> I actually care. =C2=A0Who uses that Changed string, and where does =
it end up
>> with? =C2=A0At the end of the log message? =C2=A0At the beginning? =C2=
=A0What "file"?
>
> I didn't get it.  -c option does not accept -m option and starts an
> editor to change the message.  The text "Changed is just a forced
> message.  I can not use an editor in interactive mode in a script...

How are the existing tests that try "commit -c" do this?  I do not thin=
k
there is any here-text redirect into "git commit".

It is sometimes easier to show by example than by giving nudging words
that only show direction, so here is a suggested rewrite on top of your
patch.  I am not very happy with the option name "mine" either, but at
least I think this gets the semantics right.

 Documentation/git-commit.txt |   10 ++--
 Makefile                     |    1 +
 builtin-commit.c             |    9 ++-
 t/t7509-commit.sh            |  144 +++++++++++++++++++++++-----------=
--------
 4 files changed, 92 insertions(+), 72 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 01eeb3e..7832720 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dr=
y-run]
-	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--claim]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--mine]
 	   [--allow-empty] [--no-verify] [-e] [--author=3D<author>]
 	   [--cleanup=3D<mode>] [--] [[-i | -o ]<file>...]
=20
@@ -61,18 +61,18 @@ OPTIONS
 -C <commit>::
 --reuse-message=3D<commit>::
 	Take an existing commit object, and reuse the log message
-	and the authorship information when creating the commit.
+	and the authorship information (including the timestamp)
+	when creating the commit.
=20
 -c <commit>::
 --reedit-message=3D<commit>::
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
=20
---claim::
+--mine::
 	When used with -C/-c/--amend options, declare that the
 	authorship of the resulting commit now belongs of the committer.
-	This also renews the author timestamp.  Therefore this option
-	sets the use of only the message from the original commit.
+	This also renews the author timestamp.
=20
 -F <file>::
 --file=3D<file>::
diff --git a/Makefile b/Makefile
index 15ea32d..a9108b3 100644
--- a/Makefile
+++ b/Makefile
@@ -1944,3 +1944,4 @@ coverage-report:
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		| tee coverage-untested-functions
+
diff --git a/builtin-commit.c b/builtin-commit.c
index 1aeafa6..aa42989 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -51,7 +51,7 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty, dry_run, claim;
+static int quiet, verbose, no_verify, allow_empty, dry_run, renew_auth=
orship;
 static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -93,7 +93,7 @@ static struct option builtin_commit_options[] =3D {
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit mes=
sage", opt_parse_m),
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and=
 edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse messa=
ge from specified commit"),
-	OPT_BOOLEAN(0, "claim", &claim, "acquire authorship and restamp time =
of resulting commit"),
+	OPT_BOOLEAN(0, "mine", &renew_authorship, "the commit is authored by =
me now (used with -C-c/--amend)"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template=
 file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
@@ -382,7 +382,7 @@ static void determine_author_info(void)
 	email =3D getenv("GIT_AUTHOR_EMAIL");
 	date =3D getenv("GIT_AUTHOR_DATE");
=20
-	if (use_message && !claim) {
+	if (use_message && !renew_authorship) {
 		const char *a, *lb, *rb, *eol;
=20
 		a =3D strstr(use_message_buffer, "\nauthor ");
@@ -748,6 +748,9 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
 	if (force_author && !strchr(force_author, '>'))
 		force_author =3D find_author_by_nickname(force_author);
=20
+	if (force_author && renew_authorship)
+		die("Using both --mine and --author does not make sense");
+
 	if (logfile || message.len || use_message)
 		use_editor =3D 0;
 	if (edit_flag)
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index 6d9eb26..ec13cea 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -3,85 +3,101 @@
 # Copyright (c) 2009 Erick Mattos
 #
=20
-test_description=3D'git commit
-
-Tests for --claim option on a commit.'
+test_description=3D'git commit --mine'
=20
 . ./test-lib.sh
=20
-TEST_FILE=3D"$PWD"/foo
+author_header () {
+	git cat-file commit "$1" |
+	sed -n -e '/^$/q' -e '/^author /p'
+}
+
+message_body () {
+	git cat-file commit "$1" |
+	sed -e '1,/^$/d'
+}
=20
-test_expect_success '-C option should be working' '
-	echo "Initial" > "$TEST_FILE" &&
-	git add "$TEST_FILE" &&
+test_expect_success '-C option copies authorship and message' '
+	echo "Initial" >foo &&
+	git add foo &&
+	test_tick &&
 	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\=
> &&
-	sleep 1 &&
-	echo "Test 1" >> "$TEST_FILE" &&
-	git add "$TEST_FILE" &&
-	git commit -C HEAD &&
-	git cat-file -p HEAD^ | sed -e '/^parent/d' -e '/^tree/d' -e '/^commi=
tter/d' > commit_1 &&
-	git cat-file -p HEAD | sed -e '/^parent/d' -e '/^tree/d' -e '/^commit=
ter/d' > commit_2 &&
-	cmp commit_1 commit_2
+	git tag Initial &&
+	echo "Test 1" >>foo &&
+	test_tick &&
+	git commit -a -C Initial &&
+	author_header Initial >expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual
 '
=20
-test_expect_success '-C option with --claim is working properly' '
-	sleep 1 &&
-	echo "Test 2" >> "$TEST_FILE" &&
-	git add "$TEST_FILE" &&
-	git commit -C HEAD^ --claim &&
-	git cat-file -p HEAD^ | grep '^author' > commit_1 &&
-	git cat-file -p HEAD | grep '^author' > commit_2 &&
-	test_must_fail cmp commit_1 commit_2
+test_expect_success '-C option copies only the message with --mine' '
+	echo "Test 2" >>foo &&
+	test_tick &&
+	git commit -a -C Initial --mine &&
+	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >=
expect &&
+	author_header HEAD >actual
+	test_cmp expect actual &&
+
+	message_body Initial >expect &&
+	message_body HEAD >actual &&
+	test_cmp expect actual
 '
=20
-test_expect_success '-c option should be working' '
-	echo "Initial" > "$TEST_FILE" &&
-	git add "$TEST_FILE" &&
-	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\=
> &&
-	sleep 1 &&
-	echo "Test 3" >> "$TEST_FILE" &&
-	git add "$TEST_FILE" &&
-	git commit -c HEAD <<EOF
-	"Changed"
-	EOF &&
-	git cat-file -p HEAD^ | grep '^author' > commit_1 &&
-	git cat-file -p HEAD | grep '^author' > commit_2 &&
-	cmp commit_1 commit_2
+test_expect_success '-c option copies authorship and message' '
+	echo "Test 3" >>foo &&
+	test_tick &&
+	EDITOR=3D: VISUAL=3D: git commit -a -c Initial &&
+	author_header Initial >expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '-c option copies only the message with --mine' '
+	echo "Test 4" >>foo &&
+	test_tick &&
+	EDITOR=3D: VISUAL=3D: git commit -a -c Initial --mine &&
+	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >=
expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual &&
+
+	message_body Initial >expect &&
+	message_body HEAD >actual &&
+	test_cmp expect actual
 '
=20
-test_expect_success '-c option with --claim is working properly' '
-	sleep 1 &&
-	echo "Test 4" >> "$TEST_FILE" &&
-	git add "$TEST_FILE" &&
-	git commit -c HEAD^ --claim <<EOF
-	"Changed again"
-	EOF &&
-	git cat-file -p HEAD^ | grep '^author' > commit_1 &&
-	git cat-file -p HEAD | grep '^author' > commit_2 &&
-	test_must_fail cmp commit_1 commit_2
+test_expect_success '--amend option copies authorship' '
+	git checkout Initial &&
+	echo "Test 5" >>foo &&
+	test_tick &&
+	git commit -a --amend -m "amend test" &&
+	author_header Initial >expect &&
+	author_header HEAD >actual &&
+
+	echo "amend test" >expect &&
+	message_body HEAD >actual &&
+	test_cmp expect actual
 '
=20
-test_expect_success '--amend option should be working' '
-	echo "Initial" > "$TEST_FILE" &&
-	git add "$TEST_FILE" &&
-	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\=
> &&
-	echo "Test 5" >> "$TEST_FILE" &&
-	git add "$TEST_FILE" &&
-	git commit -m "--amend test" &&
-	git cat-file -p HEAD | grep '^author' > commit_1 &&
-	sleep 1 &&
-	git commit -m "Changed" --amend &&
-	git cat-file -p HEAD | grep '^author' > commit_2 &&
-	cmp commit_1 commit_2
+test_expect_success '--mine makes the commit ours even with --amend op=
tion' '
+	git checkout Initial &&
+	echo "Test 6" >>foo &&
+	test_tick &&
+	git commit -a --mine -m "Changed again" --amend &&
+	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >=
expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual &&
+
+	echo "Changed again" >expect &&
+	message_body HEAD >actual &&
+	test_cmp expect actual
 '
=20
-test_expect_success '--amend option with --claim is working properly' =
'
-	sleep 1 &&
-	echo "Test 6" >> "$TEST_FILE" &&
-	git add "$TEST_FILE" &&
-	git commit -m "Changed again" --amend --claim &&
-	git cat-file -p HEAD | grep '^author' > commit_1 &&
-	test_must_fail cmp commit_1 commit_2
+test_expect_success '--mine and --author are mutually exclusive' '
+	git checkout Initial &&
+	echo "Test 7" >>foo &&
+	test_tick &&
+	test_must_fail git commit -a --mine --author=3D"Xyzzy <frotz@nitfol.x=
z>"
 '
=20
 test_done
