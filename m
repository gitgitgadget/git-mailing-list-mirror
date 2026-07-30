Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193B38CFE1
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 03:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382874; cv=none; b=CTXqRU397XOtUybBW2vRW4KOx2k7k3VM1hw6od2SzjfNN6ByJ6Cs2+MB4LkwTPcXDmpvYXHJAMLR1P5AwJyde+Kq6vQ/bJxUpgwgLEvewMsKat4GBSxvlOr3JN7nEKJShT3ryB46S+OLiYwGlAvGhkzoIjkfs2NBNyE5O6UzknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382874; c=relaxed/simple;
	bh=Z7+20lFk4PYva7Z4a5Tn/QZldlZpt1jX0gPiKFFLl+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCj2QKHRpajodAbbo5WkBunZpGofQ5IxQoLXVYbSrPL+z6hayNE5D137pZcS3gMVrh+4D92Cx7uaeD4JQqRKoHk8sxyHwywpMa8k9BLolGEpAaH01HzMYCRkJEOWvvzGL3/esUoB/HMCDJQM7/lWRU3Rtup+H4vyzGTijzI454M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gpmfk2+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGqpqa6e; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gpmfk2+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGqpqa6e"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C77EC1400337;
	Wed, 29 Jul 2026 23:41:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jul 2026 23:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785382872; x=
	1785469272; bh=mb0na19WQBDyADbPxOFIxzNfZsGkdCTJWuB595b/qIY=; b=g
	pmfk2+58P3IQbs0SIOZzkL+3n91+ahMSc4Cw4rlza6JVuJ43bqGC/scu7/Ogez5x
	9ekgnAP/QrSl4tvLEwoIOxNQ3ykrP43gXWzMl4/xGB6/NZ+BSf+qisAcwbUAdOGq
	G07WzG+1OLodToLngXG7Rf/cpmWeO5HmEOaWa6HEMQbFkN1cY95P3AYkI/96XI9h
	MPQTTqDixhMybnMAW+kLve8ZYvotEEasnR8E9arcR1EVCAfeCOA32mh2lcvgNAI5
	xF7E/LbaAyhQxAB6fDOyuwCb71M1tNCACrpgFq/vtSQuBqkxgYxwx/idEvbunVYj
	g1VOkE1WV2t2SvjxWnGwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785382872; x=1785469272; bh=mb0na19WQBDyADbPxOFIxzNfZsGk
	dCTJWuB595b/qIY=; b=GGqpqa6e3Y67tNgKDcPd6ec+DoEgJ+nGV5rwJwJKTqco
	uRJfuzuapQRnqD+W4we10snp29PEMzqwE5/Wmi0XxyKVye5J0xWv/PFXyI9Fd1eC
	UvO3x4tpGN7qhTFVN73yIuemhnX/zItHQIGf63qoZC7r4HTZSDSzE7mdKKN1JDG0
	W1a7B9YmNUvsAQVPBlpUpEJPM9ct8FjW1gyZ8LLmfVbg4+MB+qf4Y4deWUfI5qhb
	/cii6sCn0Mt9H8ACnGAqLWpZti/V2c/HaLPYCZFohj5nwsnrZFNdtuqN0ZnnsbmS
	J8uxkJETzA5RBk6Ezv3wyEl8hRxPXo6H/gBmkInW8g==
X-ME-Sender: <xms:2MdqarrUG8Ws1pSTH2E0TbSuP1nwAZavcsC0u5qVXFIimgPWl5DMyA>
    <xme:2MdqarpOBC5EwtrWwETpIxa_ewiOash4-LEZsBGovD65kfvznW3Rkx89mCZ6vKDY9
    K6vymrYcQs1KnNOVi6IpSBw404E3DovkW0Xmsht_wmY9C1wNOHeWg>
X-ME-Received: <xmr:2Mdqal2XUYoTNVW49NY44_KsOQlnaCq6QggWwrlE1Eb9IXkAwjUCcrzfGzfXuUDJ4XlMaZArMIy2bDugB8GxyLFwbiO34cj9zg>
X-ME-Proxy-Cause: dmFkZTFsE1BsIMENIm/qyDeURXaXQS5u9ATgKO/saClpSAi6N7VYG6gU+6U8jVPlrL67S2
    ptoc4ButuFZn0L0HedRx6xgxFHSRd5DQ21qF81lDALbE1Ot+JPFoDJEG39CCPmzoSDtulN
    LX5Nig05u3XetiULrtjyuiTD1U33OnDMqZhX4x84XnqzqJVyxql4esEfduuRXUqXWVbvSo
    URAD3Vufcx9AFYrLhpHQdu8tMOd2qMLWG0KyXnOqipjOYV6rb0BbG3tROpNheuUOlllBxX
    QCKJF9TFbOqTiaJeMoUsxJchRl0ngEhpUeftFR6jh1I4cI8/f+glRZzn6kAt4TbZkFC0TF
    SoLcHkFCirtygm01+gCJqHnCD5GTnY6CCqIhk3LPlQWKJkk3VEup0S1CuOB2cw3REzWP8p
    YhZsp7YqzqdQtoV2VXkLHEC9gm3EI1aPRbEEh7taHTqXW1ue0lpw22tSX8WShT452QhIrf
    jh9GGJ5517dTyHgIMP3eGAdM9CzEL/g6XXsVNI/Bft27Whnj9KIPZO8yhWcW9q2a2Y7y0G
    2qr1SDosVcN7d+SQGKgsaz9dEUfllxMQkiYnwWZmXGW0A8VqDFndX0wVqQhoRmKEY0bMUK
    /EaX85dayRjLx6/dMPHtZ0uX3E/EykbYI0W49Q5PLKUfTEcuVtCo8wS7hSkg
X-ME-Proxy: <xmx:2MdqaqBJUYocXSM4lktrLhzYHtSe2JdQNYN2Inyl4Vwu2G4ECdNdKg>
    <xmx:2MdqateWCHYM1THs7u9VBHCl6uHyk2UlGe0-UbHCFMjXYn659dNktg>
    <xmx:2MdqavhO-RZpBxCFh5ASuhKERDoE9xeWz_Bx_ODzCvGpKF3kJG5iCg>
    <xmx:2MdqaloiTn0pPuezZDMckxUOBZ3S2icC_rbUhZi1dmazZiIGYXRAhQ>
    <xmx:2MdqavDHK9qyTjvYOZOmr5us8fzNUEt6-Lf-4iM40FjRNMXABMUAMxk0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 23:41:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] stash: reject time-based selectors in drop and pop
Date: Wed, 29 Jul 2026 20:41:08 -0700
Message-ID: <20260730034108.765430-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-597-ge6126a35d6
In-Reply-To: <20260730034108.765430-1-gitster@pobox.com>
References: <20260730034108.765430-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_stash_info_assert() verifies that a revision is a stash
reference ('.is_stash_ref'), but it does not verify whether the
reference is a positional reflog index as opposed to a time-based
selector (such as 'stash@{2.days}').

When subcommands such as 'git stash drop' or 'git stash pop' pass
time-based selectors to reflog_delete(), reflog_delete() treats
non-integer selectors as expiration cutoff timestamps.
Consequently,

 - 'git stash drop stash@{2.days.ago}' deletes all stash entries
   older than two days instead of dropping a single entry, and

 - 'git stash pop stash@{2.days.ago}' applies a single stash entry
   at that timestamp and then deletes all stash entries older than
   two days.

While the former might be remotely useful, the latter is certainly
not.  In get_stash_info_assert(), reject references where
'.stash_idx' is negative (i.e., a time-based reference was used),
ensuring that 'git stash drop' and 'git stash pop' fail early on
invalid or date-based stash references.

Document that 'git reflog expire --expire=<time> refs/stash' should
be used to prune stashes by age, and add unit tests covering
rejection of time-based selectors for 'drop' and 'pop'.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-stash.adoc |  8 ++++++++
 builtin/stash.c              |  3 +++
 t/t3903-stash.sh             | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 50bb89f483..6711157421 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -106,6 +106,10 @@ command to control what is shown and how. See linkgit:git-log[1].
 	operation of `git stash push`. The working directory must
 	match the index.
 +
+When _<stash>_ is specified, it must be a positional stash index
+of the form `stash@{<n>}` or `<n>`. Time-based reflog selectors
+(e.g. `stash@{2.days.ago}`) are not accepted.
++
 Applying the state can fail with conflicts; in this case, it is not
 removed from the stash list. You need to resolve the conflicts by hand
 and call `git stash drop` manually afterwards.
@@ -137,6 +141,10 @@ with no conflicts.
 
 `drop [-q | --quiet] [<stash>]`::
 	Remove a single stash entry from the list of stash entries.
+	When _<stash>_ is specified, it must be a positional stash index
+	of the form `stash@{<n>}` or `<n>`. Time-based reflog selectors
+	(e.g. `stash@{2.days.ago}`) are not accepted. To prune stashes older
+	than a given timestamp, use `git reflog expire --expire=<time> refs/stash`.
 
 `create`::
 	Create a stash entry (which is a regular commit object) and
diff --git a/builtin/stash.c b/builtin/stash.c
index 5041a9ba81..6f9561ee3a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -865,6 +865,9 @@ static int get_stash_info_assert(struct stash_info *info, int argc,
 	if (!info->is_stash_ref)
 		return error(_("'%s' is not a stash reference"), info->revision.buf);
 
+	if (info->stash_idx < 0)
+		return error(_("'%s' is not a valid stash index"), info->revision.buf);
+
 	return 0;
 }
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index da27a6599a..01d59c8ef4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -808,6 +808,19 @@ test_expect_success 'pop: fail early if specified stash is not a stash ref' '
 	git reset --hard HEAD
 '
 
+test_expect_success 'drop and pop reject time-based reflog selectors' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD && git stash clear" &&
+	git reset --hard &&
+	echo foo >file &&
+	git stash &&
+	test_must_fail git stash drop stash@{2.days.ago} 2>err &&
+	test_grep "is not a valid stash index" err &&
+	test_must_fail git stash pop stash@{2.days.ago} 2>err &&
+	test_grep "is not a valid stash index" err &&
+	git stash drop
+'
+
 test_expect_success 'ref with non-existent reflog' '
 	git stash clear &&
 	echo bar5 >file &&
-- 
2.55.0-597-ge6126a35d6

