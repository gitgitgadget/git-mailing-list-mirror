Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75606342519
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634990; cv=none; b=TcI78fquQN2mNHy+QX9NcitiXcuf3tAn1/RNpgToMI83L/0kj2YhN2Bk1oC1An4G2jEBSjTFVOXFb17jLzIoGt3PRykcHpAAcp7Rz4jmG3HyYhyJnA51ViWzT8NcWTLEFAz1BANLF8rCbqE76vqjI0G1A0wjfBtmzwamvjjzmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634990; c=relaxed/simple;
	bh=+e4+c4KBDsvwPaHpIDIZWXguXEaSH7JZycUZhWTmULk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LufxR3lUzzNN/73zA6Tva+pMTdTRAnSX4+UIccsu32Bt8fuDK5E5K0nywU6d5pMM/EJY72wdc8TZrAy6Rq6tYUJHWcJo0lKZAbu/VI4V6dkjdfLDg72obDSxbl+U0f4SAekQ3HZDFoXzHpTG4JE/+RjMyJ89pd1UiYBEJvUahF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=GNQHW9+z; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=LMQRLt3O; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="GNQHW9+z";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="LMQRLt3O"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=GNQHW9+zxZR8pVKE5Fj1hMgHYRQxch3CBOeDI+K4M9kzK6hcqdsLs6VUVctudTdzKj1/LE7mWdZVRfGqCcjX1K3AVMkL30LxiXZPbFtSvFxI46rHH5dix3uzFbImF7BaXQLEPgGkG6hPB4nkisU+2ofJufY6rMPB3cJ9Wa/02IOce7H0Gr3KAUZH06w6IYuuS8oiWIsl3GwWo9dnk77xyAbhuI6FAC/4v/1b6RPm5GSi10kZ7ltr4cAUWzvltuQgi1m2BTAFhvXFH6fBxdi4rdMMsSWNrfBlJaewFJEIKt3B2Eezn01vusbNQ04Wm20qBvfNJk4aBnjiZ1eXct4GMw==; s=purelymail1; d=malon.dev; v=1; bh=+e4+c4KBDsvwPaHpIDIZWXguXEaSH7JZycUZhWTmULk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=LMQRLt3O2TSxMWgEhG8A+d3+n209EVPRJaj/qWOXwQjBcVLFYmcOSGb6B30gh4R0BKxInSVMjgh3ikfP9eUQA0hD8p7l6a/dQMMqo+TcBq+I49sKLQk92j8mk+jZ93FpUI2z/kMomxvp0U8t3ZfS1EjXM5XPZtml8uZfTOr7K6wCnk/4vEHddAwpZbQ5ZqLPFxztqqGercjZl2at2XJ6fVoZYtiwRqUTMyQWAYiKdlBj8rDKV0m1NfMh3pw3tbuTMAcY7fcY6qegNFeeymjB30jr5jFluW6fLYmsYwvT9PpZiOkxKH/OF8TSsHe1A7s6s7zg2X/6VsQYICnYk3KhTw==; s=purelymail1; d=purelymail.com; v=1; bh=+e4+c4KBDsvwPaHpIDIZWXguXEaSH7JZycUZhWTmULk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1122676285;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 27 Mar 2026 18:09:46 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>
Subject: [PATCH v1] replay.c: support replaying root commits
Date: Sat, 28 Mar 2026 02:09:30 +0800
Message-ID: <20260327180930.104563-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

'git replay' does not support replaying root commits, as indicated by
the FIXME comment. If a user attempts to replay a root commit, the 'die()'
in 'replay_revisions()' will be called.

The reason for this is that the call 'base =3D pickme->parents->item' in
'pick_regular_commit()' will cause a null pointer dereference error in the
case of a root commit.

Fix this by adding new conditional statements: the difference between the
root commit its 'common ancestor' is equivalent to the difference from
an empty tree object, and it must be placed on the user-specified target
branch 'onto'. Therefore,  We set 'base' to 'NULL', 'replayed_base' to
'onto', and use 'lookup_tree()' to instantiate the OID of the empty tree
in order to pass it to 'base_tree'.

Signed-off-by: Tian Yuchen <cat@malon.dev>
---

To be honest, I'm not sure whether setting 'base =3D NULL' is proper or
not. Feel free to give feedback and suggestions!

 replay.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/replay.c b/replay.c
index a63f6714c4..80497191a8 100644
--- a/replay.c
+++ b/replay.c
@@ -225,12 +225,21 @@ static struct commit *pick_regular_commit(struct repo=
sitory *repo,
 =09struct commit *base, *replayed_base;
 =09struct tree *pickme_tree, *base_tree, *replayed_base_tree;
=20
-=09base =3D pickme->parents->item;
-=09replayed_base =3D mapped_commit(replayed_commits, base, onto);
-
+=09if (pickme->parents) {
+=09=09base =3D pickme->parents->item;
+=09=09replayed_base =3D mapped_commit(replayed_commits, base, onto);
+=09=09base_tree =3D repo_get_commit_tree(repo, base);
+=09} else {
+=09=09/*=20
+=09=09 * Root commits have no parents. Their base is the empty tree,
+=09=09 * and they should be replayed directly onto the target 'onto' commi=
t.
+=09=09 */
+=09=09base =3D NULL;
+=09=09replayed_base =3D onto;
+=09=09base_tree =3D lookup_tree(repo, repo->hash_algo->empty_tree);
+=09}
 =09replayed_base_tree =3D repo_get_commit_tree(repo, replayed_base);
 =09pickme_tree =3D repo_get_commit_tree(repo, pickme);
-=09base_tree =3D repo_get_commit_tree(repo, base);
=20
 =09merge_opt->branch1 =3D short_commit_name(repo, replayed_base);
 =09merge_opt->branch2 =3D short_commit_name(repo, pickme);
@@ -293,8 +302,6 @@ int replay_revisions(struct rev_info *revs,
 =09set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
 =09=09=09   &detached_head, &advance, &onto, &update_refs);
=20
-=09/* FIXME: Should allow replaying commits with the first as a root commi=
t */
-
 =09if (prepare_revision_walk(revs) < 0) {
 =09=09ret =3D error(_("error preparing revisions"));
 =09=09goto out;
@@ -309,9 +316,7 @@ int replay_revisions(struct rev_info *revs,
 =09=09khint_t pos;
 =09=09int hr;
=20
-=09=09if (!commit->parents)
-=09=09=09die(_("replaying down from root commit is not supported yet!"));
-=09=09if (commit->parents->next)
+=09=09if (commit->parents && commit->parents->next)
 =09=09=09die(_("replaying merge commits is not supported yet!"));
=20
 =09=09last_commit =3D pick_regular_commit(revs->repo, commit, replayed_com=
mits,
--=20
2.43.0

