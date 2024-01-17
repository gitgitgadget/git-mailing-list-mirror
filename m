Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C0A2D628
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532871; cv=none; b=PmxWQwhtKkgbMU6+1dqXl2MXr/l6tpXbGMqwDPLlSER+ASU6B7GugYqjNQOIgG46wKXglXPy4BOxVCWNc/+xf0LGP39enZABc/Qf6LuzX05iQA2haIFfL0zVMDuWnJgdl0ZVuSY3qljx9P7adUpsrXr/V9GxbZn0bLI7VOdDyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532871; c=relaxed/simple;
	bh=9q8moGDNuSQhETWfUrFBhuPusWRM5LCimAu8x4ZWYwg=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=NSQvw/6WGa5RCLibOvWznmB2Rxz0mIj2YspKBBSlu/SXeroTIMrvxHsPGlNpoc/IFGUZyy9jbT99fx8bp/XPt1z0lLBYghP35E28M0cEnpZBH5nYjWrPM2NNzrYJC71dbsv2sjlACYn9ZWhP3ZcsTOgEyPi00Gp0M3Th7FnjTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xwBpMsLu; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xwBpMsLu"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CB4D822B6F;
	Wed, 17 Jan 2024 18:07:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9q8moGDNuSQhETWfUrFBhuPusWRM5LCimAu8x4
	ZWYwg=; b=xwBpMsLuMNTgz5Tt1C6M0Yfnf3pDMMO8Tzxh2fi8HoY8XcHKtAO92k
	M3VbUe9ZU8yFUGC/ZwmTzlMZrJ8SJTZYFGcv7mjxDMDvYCnCIFhawY8o/svaDbva
	zP9HYfFUGw06IAa0fuUCqOlJuhgLF8mhlyPK3BtTP1NX4RylXVBrA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C301422B6E;
	Wed, 17 Jan 2024 18:07:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67F3C22B6D;
	Wed, 17 Jan 2024 18:07:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/1] builtin/show-ref: treat directory directory as
 non-existing in --exists
In-Reply-To: <ZadzwA6vNnRPbKYh@tanuki> (Patrick Steinhardt's message of "Wed,
	17 Jan 2024 07:29:20 +0100")
References: <20240110141559.387815-1-toon@iotcl.com>
	<20240110141559.387815-2-toon@iotcl.com>
	<CAPig+cTRHHJ3pzWJtVJf8rKhvAJFYqrO0JsyTRTi6T5s+gznDg@mail.gmail.com>
	<874jflfc26.fsf@iotcl.com> <ZadzwA6vNnRPbKYh@tanuki>
Date: Wed, 17 Jan 2024 15:07:44 -0800
Message-ID: <xmqqmst3tv7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3A1331BC-B58D-11EE-8078-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> With that in mind I think it is okay to already mention the new backend
> in commit messages -- at least I have been doing that, as well. Also,
> the tree already knows about the reftable backend because we have both
> the library and technical documentation in it for quite some time
> already.
>
> The patch itself looks good to me, thanks! Whether we want to reroll
> just to amend the commit message I'll leave to you and others to decide.

Yup.  The patch looks good.  Here is what I tentatively queued.

----- >8 -----
From: Toon Claes <toon@iotcl.com>
Date: Wed, 10 Jan 2024 15:15:59 +0100
Subject: [PATCH] builtin/show-ref: treat directory directory as non-existing
 in --exists

9080a7f178 (builtin/show-ref: add new mode to check for reference
existence, 2023-10-31) added the option --exists to git-show-ref(1).

When you use this option against a ref that doesn't exist, but it is
a parent directory of an existing ref, you get the following error:

    $ git show-ref --exists refs/heads
    error: failed to look up reference: Is a directory

when the ref-files backend is in use.  To be more clear to user,
hide the error about having found a directory.  What matters to the
user is that the named ref does not exist.  Instead, print the same
error as when the ref was not found:

    error: reference does not exist

Signed-off-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/show-ref.c  | 2 +-
 t/t1403-show-ref.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7aac525a87..6025ce223d 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -239,7 +239,7 @@ static int cmd_show_ref__exists(const char **refs)
 	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
 			      &unused_oid, &unused_referent, &unused_type,
 			      &failure_errno)) {
-		if (failure_errno == ENOENT) {
+		if (failure_errno == ENOENT || failure_errno == EISDIR) {
 			error(_("reference does not exist"));
 			ret = 2;
 		} else {
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index b50ae6fcf1..a8055f7fe1 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -260,9 +260,9 @@ test_expect_success '--exists with non-commit object' '
 
 test_expect_success '--exists with directory fails with generic error' '
 	cat >expect <<-EOF &&
-	error: failed to look up reference: Is a directory
+	error: reference does not exist
 	EOF
-	test_expect_code 1 git show-ref --exists refs/heads 2>err &&
+	test_expect_code 2 git show-ref --exists refs/heads 2>err &&
 	test_cmp expect err
 '
 
-- 
2.43.0-367-g186b115d30

