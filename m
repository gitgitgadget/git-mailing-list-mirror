Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B874C54EE9
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 09:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIPJCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 05:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiIPJCT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 05:02:19 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3882A264
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663318922; bh=4pDECPBhZIoqFbMK+rCgNrocahrnE3NZlPjlrFvYqU4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dMWC9dbEiG4D325pdm5UOu5sijKyZ6+n6OmNFVIkgbr46G3AF+rS/+Vm01CGNltxk
         1AR1TJysa1KvQrrJO7hjjxphqWtsB+3AkR5MaKsOb+zm4+lypwvYS/5X5GVmauvYuU
         /x/M0pHI87Ehr3fGebbOA1pq6CBaBtkryCPwIVHa3JbtO6RDqqqx+lDIaw5wNcaHWk
         WgSVHhY51P0B04+RN+PAApPdua4gTwAAsUM9Pz1vZk6JeMYsbA+7VfoSt3YI+TszH9
         s4X+uuU3FYEYW9ik2HKxH81E3AhG2zhIwMDfvhUBbDv7gAqaqbBvgZSBGa7bpwVr91
         oqOKUtZBx93KA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.219]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6b8m-1pNJJs1rDC-018DRb; Fri, 16
 Sep 2022 11:02:02 +0200
Message-ID: <29d50baa-1923-38e1-6ecb-73840376d28e@web.de>
Date:   Fri, 16 Sep 2022 11:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH 6/6] revision: add parents after child for ^!
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
 <84018532-169f-dc9b-f894-3d19bb7b4245@web.de> <xmqq5yhoo76m.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5yhoo76m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wIBiHcQpZ5K2xrHt/Vup1SOzYy7rPfomyQxwL+p2t680bkXvvsO
 IYZywlaDcm43/MonMP05H4J+aSS8YOqVNO04N4AdgDboEUfR42Acj1I7uwdG41wBnwQmVws
 en81nvKnW1VQoOJXjo12dh0YCfCSAiwugQK95Q85Ir40kFt5oQLEqpiqkEJVhs0NSyTb6JQ
 P/jV0z9mAPvUsGl8o3scA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KpW7oK5LGGU=:viO33ixajuypkiMe27nd1H
 3cv6k6Yo2rJsMO/ntQNhwGTOb07Xp+KkbHtxe99Zz5X9SsWQz3IRSvIJYiOmpqyc4dePsOWM8
 5y6YnRn9ZFyMMOhjR3fLMlgFfOkNPdy7g2uJwu9nSMQjZ9J1jgg05lPwZwG99xNR/7OYrZZD1
 RTqnab+UyoRYtnMHRLm4jYd/4NkJRYEeldqwjEyroUlW8yaexcYsspZX0zk9QO0WPehA24Br3
 bGJUk6My46VvoQqv+/cavwF0hwjSvaAbLDc4CGmXL4tmgZAy7RtcsT3CQ6FjXPXSMdB5Rt+2e
 4CXv/1IeX9EOoiZ5cvnJxxZ17SfULoDoyx9mpONQCo+ueHLjRQVXog2fSS8UDSKMNxrDLCVcj
 iQRHHvE9pICzvNKNUGfgiXUUP9AuzylIZL6J8zseaOxfCPcT5kjaWiBsl030YCDHoB7krUEOU
 EBoEpVbUclkXFZZXl0esFgJwLh5F1ghr69jLmd8TaJxb35OBe0+BWsVqgLB5MPpJ14NJ2F2oZ
 x740funqR5pN7ldup8dWDP8pEtMHZUQn4u1hQBaHbVqC2B/Fyd1287t1kmaUstUB9mvjLqlcE
 hX1M/yGMpcNkG0CS+3onaeB7UqML6OgZ/XGM51TN9Aokd+TiU22xBZsh/yZW14mcVRX5gK77O
 9IlrA3JOjtUzVcInbvIls/ITZZR3iYU6/mbUUMcz2GIkmgWRhxhmCf7KRJnYZtHeeKFTsN6uQ
 wjR8m87lgxuYJgR/ssegjRBy0rt7zxVkZRz2nZT2JrdynMgFIm6jBrUz932DMZcyvYwBoqiT7
 pJ9I7hipuJiCstaoxoo49q0/i7YJCHz5xezhnE23Z5l3SptcIDSC/Lgy1yTuDqBghizbN48hc
 KKdSQNyfPVCPLAfkjo2WXWXO4U0IopzUiULdls7w0Li6NF0q+rbm4NcoAGqUCz5t+G9Ntkj0P
 ds5nRDsCZLf9zeZwC5KaqmhfHgweP9ExwKEC5RWHYsaaufayIPrpP+KTu9itZBJQXEiRXvS+e
 IpbmpUXnUaN8VXGvot3w8TCiD/lec9WV/uovAC6IPaSmvAkWRgCJ6fS+6AgxI5YdenpX87p7I
 cViiAZcmLbinXoQpo5dF2AvxngD0XMA0WGm91YTBoQIc3lNdANNhqQ41VNURQ8M5AfygezOOA
 w8PkA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.09.22 um 19:53 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> gitrevisions(7) says: "A suffix '^' followed by an exclamation mark is
>> the same as giving commit '<rev>' and then all its parents prefixed wit=
h
>> '^' to exclude them (and their ancestors)."
>
> I did not mean to specify the order at all in that description when
> I wrote ca5ee2d1 (Enumerate revision range specifiers in the
> documentation, 2012-07-24) and I do not think it should be read as
> such.

Then the "then" needs to go.

git rev-parse has its own parser for ^! etc. and puts parents last,
consistent with the "then".

>> handle_revision_arg_1() however adds the negated parents first.
>
> I suspect that this was deliberately done so to match how A..B is
> added to the pending commit list in revisions.c::handle_dotdot_1()
> to tolerate "git diff A..B" as a synonym to "git diff A B", which
> dates back to cd2bdc53 (Common option parsing for "git log --diff"
> and friends, 2006-04-14).

"git diff A B", "git diff A..B", "git diff ^A B" and "git diff "B ^A"
all produce the same output.  So I suspect we could reverse the order
for A..B as well without ill effect if we wanted.

>> Split up the handling of ^! by moving the actual addition of the
>> parents after the addition of the child.
>
> I do not offhand think of anything other than the "diff" frontend
> that cares about the order of these commits from the command line, I
> am afraid that this might end up robbing Peter to pay paul.

Can't think of anything, either, but it may well be possible that yet
another untested use case could depend on getting parents first.
"git diff R^!" was untested as well and it took two years from release
to Tim's bug report after all.  And I'm not particularly proud of my
refactoring patches, so wouldn't mind dropping them.

> Can't we "fix" it at the consumer end, perhaps by checking where
> these commits came from by looking at rev.cmdline?

We could.

=2D-- >8 ---
Subject: [PATCH] diff: support ^! for merges

revision.c::handle_revision_arg_1() resolves <rev>^! by first adding the
negated parents and then <rev> itself.  builtin_diff_combined() expects
the first tree to be the merge and the remaining ones to be the parents,
though.  This mismatch results in bogus diff output.

Remember the first tree that doesn't belong to a parent and use it
instead of blindly picking the first one.  This makes "git diff <rev>^!"
consistent with "git show <rev>^!".

Reported-by: Tim Jaacks <tim.jaacks@garz-fricke.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
The check "i < rev.cmdline.nr" is necessary to avoid segfaults e.g.
in t0005.  I wonder why.  Shouldn't rev.pending.objects and
rev.cmdline.rev always have the same number of entries?

 builtin/diff.c           | 23 ++++++++++++++++++-----
 t/t4038-diff-combined.sh | 10 ++++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 54bb3de964..04c6ba0862 100644
=2D-- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -209,7 +209,7 @@ static int builtin_diff_tree(struct rev_info *revs,
 static int builtin_diff_combined(struct rev_info *revs,
 				 int argc, const char **argv,
 				 struct object_array_entry *ent,
-				 int ents)
+				 int ents, int first_non_parent)
 {
 	struct oid_array parents =3D OID_ARRAY_INIT;
 	int i;
@@ -217,11 +217,18 @@ static int builtin_diff_combined(struct rev_info *re=
vs,
 	if (argc > 1)
 		usage(builtin_diff_usage);

+	if (first_non_parent < 0)
+		die(_("no merge given, only parents."));
+	if (first_non_parent >=3D ents)
+		BUG("first_non_parent out of range: %d", first_non_parent);
+
 	diff_merges_set_dense_combined_if_unset(revs);

-	for (i =3D 1; i < ents; i++)
-		oid_array_append(&parents, &ent[i].item->oid);
-	diff_tree_combined(&ent[0].item->oid, &parents, revs);
+	for (i =3D 0; i < ents; i++) {
+		if (i !=3D first_non_parent)
+			oid_array_append(&parents, &ent[i].item->oid);
+	}
+	diff_tree_combined(&ent[first_non_parent].item->oid, &parents, revs);
 	oid_array_clear(&parents);
 	return 0;
 }
@@ -385,6 +392,7 @@ int cmd_diff(int argc, const char **argv, const char *=
prefix)
 	int i;
 	struct rev_info rev;
 	struct object_array ent =3D OBJECT_ARRAY_INIT;
+	int first_non_parent =3D -1;
 	int blobs =3D 0, paths =3D 0;
 	struct object_array_entry *blob[2];
 	int nongit =3D 0, no_index =3D 0;
@@ -541,6 +549,10 @@ int cmd_diff(int argc, const char **argv, const char =
*prefix)
 		if (obj->type =3D=3D OBJ_TREE) {
 			if (sdiff.skip && bitmap_get(sdiff.skip, i))
 				continue;
+			if (first_non_parent < 0 &&
+			    i < rev.cmdline.nr &&
+			    rev.cmdline.rev[i].whence !=3D REV_CMD_PARENTS_ONLY)
+				first_non_parent =3D ent.nr;
 			obj->flags |=3D flags;
 			add_object_array(obj, name, &ent);
 		} else if (obj->type =3D=3D OBJ_BLOB) {
@@ -590,7 +602,8 @@ int cmd_diff(int argc, const char **argv, const char *=
prefix)
 					   &ent.objects[0], &ent.objects[1]);
 	} else
 		result =3D builtin_diff_combined(&rev, argc, argv,
-					       ent.objects, ent.nr);
+					       ent.objects, ent.nr,
+					       first_non_parent);
 	result =3D diff_result_code(&rev.diffopt, result);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 9a292bac70..2ce26e585c 100755
=2D-- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -80,11 +80,21 @@ test_expect_success 'check combined output (1)' '
 	verify_helper sidewithone
 '

+test_expect_success 'check combined output (1) with git diff <rev>^!' '
+	git diff sidewithone^! -- >sidewithone &&
+	verify_helper sidewithone
+'
+
 test_expect_success 'check combined output (2)' '
 	git show sidesansone -- >sidesansone &&
 	verify_helper sidesansone
 '

+test_expect_success 'check combined output (2) with git diff <rev>^!' '
+	git diff sidesansone^! -- >sidesansone &&
+	verify_helper sidesansone
+'
+
 test_expect_success 'diagnose truncated file' '
 	>file &&
 	git add file &&
=2D-
2.37.3
