Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C715B104
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083270; cv=none; b=BhPqz2s0cNs0R3xsDtGzJHeRtRNSeDRL5rvHztBPmccfOuJ+pj5SniyKeJvC7Ow1ZM6+LPsSrSzyrAeczdEDKg+YTDAY7iiNh7J14mAU1Au6M3vGB2UH+kdvZGeqYHINIGyMNP3WAjnwyj/SbptGnbmkDQg1Dy8A4w7P0+qXJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083270; c=relaxed/simple;
	bh=yF8G0CLZmsgi05kC6edzNtFU3ERngv4T6mH7RDuyXSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZR1iefIf6/XoFq9u62NmQccxFdHeyO6YH6VUvVv/zJahSaEjU+EshHwnTeN1r4tYlWHk6sW94RU7N+a/qMTRasTvtbbUGze7fBQCNbuwwbsc5hyeUvacGTXSncpET7iBPz4ztMjGwOy3FVVjDrk8BPMlU+NhEV5iKkBILh9KCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jjds4fKa; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jjds4fKa"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ED25E2AC2F;
	Tue,  2 Apr 2024 14:41:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yF8G0CLZmsgi05kC6edzNtFU3ERngv4T6mH7RD
	uyXSs=; b=Jjds4fKa4+trPsQWzP9oBPH5qQhYiE28n153ZS1SvWmNtQcpmMRaqi
	YXB75wEIX5gvvQQ74zvRaiZKV/SMr9TymLZNZi+Ln1NVMYuRAtCJ6/3OXiQNCVNa
	OxYoW7tpv49BycaaaBUAin3bFm/J4ywb0AnfDq8MRd51Shme0CGfk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E691E2AC2E;
	Tue,  2 Apr 2024 14:41:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01FAD2AC2D;
	Tue,  2 Apr 2024 14:41:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Aishwarya Narayanan
 <aishnana.03@gmail.com>,  git@vger.kernel.org
Subject: Re: GSoC 2024 [PATCH v2] Fix Git command exit code suppression in
 test script t2104-update-index-skip-worktree.sh
In-Reply-To: <Zgw_KJ3wO-x2LXI0@tanuki> (Patrick Steinhardt's message of "Tue,
	2 Apr 2024 19:23:52 +0200")
References: <CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3DodreYoL7g@mail.gmail.com>
	<ZgvmoSOPs6FG4jGZ@tanuki>
	<CAPig+cRtzbv57=k7ti0YcsRR05gz4v_gExgwi6qCtT6f0i2oKA@mail.gmail.com>
	<Zgw_KJ3wO-x2LXI0@tanuki>
Date: Tue, 02 Apr 2024 11:41:03 -0700
Message-ID: <xmqqmsqb4ngg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8FE1EE2A-F120-11EE-AFC3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Micro correction: Documentation/CodingGuidelines says this:
>> 
>>     We use tabs to indent, and interpret tabs as taking up
>>     to 8 spaces.
>
> Huh, that's even weirder. The diff changes indentation from four spaces
> to two spaces for me.

Indeed, the original is already flawed.

----- >8 --------- >8 --------- >8 --------- >8 ----
Subject: t2104: style fixes

We use tabs to indent, not two or four spaces.  

These days, even the test fixture preparation should be done inside
test_expect_success block.

Address these two style violations in this test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2104-update-index-skip-worktree.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git c/t/t2104-update-index-skip-worktree.sh w/t/t2104-update-index-skip-worktree.sh
index 0bab134d71..7ec7f30b44 100755
--- c/t/t2104-update-index-skip-worktree.sh
+++ w/t/t2104-update-index-skip-worktree.sh
@@ -11,27 +11,27 @@ TEST_PASSES_SANITIZE_LEAK=true
 sane_unset GIT_TEST_SPLIT_INDEX
 
 test_set_index_version () {
-    GIT_INDEX_VERSION="$1"
-    export GIT_INDEX_VERSION
+	GIT_INDEX_VERSION="$1"
+	export GIT_INDEX_VERSION
 }
 
 test_set_index_version 3
 
-cat >expect.full <<EOF
-H 1
-H 2
-H sub/1
-H sub/2
-EOF
+test_expect_success 'setup' '
+	cat >expect.full <<-\EOF &&
+	H 1
+	H 2
+	H sub/1
+	H sub/2
+	EOF
 
-cat >expect.skip <<EOF
-S 1
-H 2
-S sub/1
-H sub/2
-EOF
+	cat >expect.skip <<-\EOF &&
+	S 1
+	H 2
+	S sub/1
+	H sub/2
+	EOF
 
-test_expect_success 'setup' '
 	mkdir sub &&
 	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2 &&
