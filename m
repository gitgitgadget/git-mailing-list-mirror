Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C85335C7
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734306892; cv=none; b=s+tTbtc5fT5AZrBNHSD3oGy4Gw41rcBbbxQx8FuSeBIBE0otBkMhnzvrUUX6Qw2r32JRlIacxok7u2TvAfnDK4Pjvz2uUFbc8wXB/QVW0uKvgDvRPVyHB3NCSW0yINg8NDT4EmlmwEeMhace/56FsyqRuJe1FDmgxKLhONdvI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734306892; c=relaxed/simple;
	bh=B1uA2KVWUZdTX9ElGi1lOh5xzsayYggC4xESwppoj2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TP5eoKBisTeZV6xYEOrG2HyF/kzPYPojD5J51/hjLiscTZ/w5JgpqFwa8PKsRcOq63scER+PYKtLg+PZfa8UhOy2ec2F6C6BqfzObTkObz7D6kklmkJCxm+OCwAHBShtFq7pc5aT9b1sWDTZ6so5EQ3/wlicQbl8eU0tMBDCsyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rsxkiPte; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cG04t02W; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rsxkiPte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cG04t02W"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A80C5138349A;
	Sun, 15 Dec 2024 18:54:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 15 Dec 2024 18:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734306888; x=1734393288; bh=4iUAK3q5fK
	Ese3bKeFDn8UkcPppAw7Xt0W44OWyYM8g=; b=rsxkiPtep6p7q/S7tCYtmXDXSq
	HPH4DeExA8s4FilhocYCKbZlQLrab/ELggie7yjncDBJhCO47eM5uzzrw/yzymLV
	vDDdzBkPI13DLHbaEsPIrWicTQxPfdLGkeroY04jPQCDZFYvObqtGVVvmfTkT02k
	ZWUkqpnBKoNyY1LE6zWqRjniPf5qIKjHT5WHljNJIaFJyrvqftDZzmVOkGCP9TfA
	2HJa06V93d9/vOErunPY17ZPjqGtxqKYpfuVhRAqk8hpafOpiktqz5VEob3TYe6U
	nUMg7UGxChUApRT9/JrQXpymjf6qGRG+JrDcY+yR3kXUDvNKD9M2gevL4ViA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734306888; x=1734393288; bh=4iUAK3q5fKEse3bKeFDn8UkcPppAw7Xt0W4
	4OWyYM8g=; b=cG04t02WWueR12LoshK2OHk+akaAAlLEMoOS8wYWuSQzS3i6Cq5
	1Cyop6fX5n0lcaSkzHM2fclBGlK0hGHExSzdlXiY11n5d79Zkrw+TyR7RTIqr9MS
	uIEQdGyGMm5KAacRx9vhUocbFsXN3oXAvl8yXWm+Hlye1exhhAFaz43hwPouXvYU
	/9DWC40rznKn2LEWvFMC+y8lqoUfea+JKZuI4wagSG0h/E4hsILsNrMFzqDeXY61
	eE4G9sBKAPhT5303J6xYlGQbeHfAJAaU3E4X3sPd91hWKuw1m5ZA10RDPzdeOFRD
	D4gIx5RxFa2MZxw3WwcTplKghNpYhe+bCfw==
X-ME-Sender: <xms:SGxfZ4ADt58241_nJ3mMEek9cTDvOIzJfxLKYYHFGSkbJ5Vk4FZwKQ>
    <xme:SGxfZ6iZB_BiN-PDKjMItG1BIWI9p0VS5mCHDT9hGURm6JgXskn1Dz-0wIax1LnuQ
    tBSi3kw8oJiPFmFOQ>
X-ME-Received: <xmr:SGxfZ7m0iVXMFLPQ5vo2L8vq-BlNk8oFH3MkkET-iXz3AaGkPjM-sJoh2yj2bAeetV8SlJIWXHXLOuYUyWVqz04Pv37tdj7wv37hNHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishgtoh
    holhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:SGxfZ-yUb3GKudXVMuB0wC35oi0QEHpLVWyhx0HKvh3n5aegUYoJag>
    <xmx:SGxfZ9Q0IrqBbnKBSI-oGAqHnfpXORKvsCTMf1scbWPzBLSs55OfBw>
    <xmx:SGxfZ5aSXQgWDS4OK_heREYKY_9JIVD7vfMWn5_FAmZJzIwiAnyHOw>
    <xmx:SGxfZ2S_b0oagS7vIa7BCS5QnPFldCQoGVfuMsf8wXf6ljcWtiEang>
    <xmx:SGxfZ2KykoywHSoQ5Cq528h0el2su6ZMwIcYxmYqV4Snf1_U6qYZZIXI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 18:54:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/8] refs: add reflog support to `git refs migrate`
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
	(Karthik Nayak's message of "Sun, 15 Dec 2024 17:25:37 +0100")
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
	<20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
Date: Sun, 15 Dec 2024 15:54:46 -0800
Message-ID: <xmqq34io8ptl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Overall, this series is a bit more involved, and I would appreciate it
> if it receives a bit more scrutiny.
>
> The series is based on top of e66fd72e97 (The fourteenth batch,
> 2024-12-06) with `kn/reftable-writer-log-write-verify` merged in.

t1460.6 does not pass for me.  I noticed it after I merged it to
'seen', but it fails standalone as well.

  $ git log --first-parent --boundary master..kn/reflog-migration
  65a841566a refs: add support for migrating reflogs
  44ffb130f3 refs: allow multiple reflog entries for the same refname
  6134624eaf refs: introduce the `ref_transaction_update_reflog` function
  65a73fce30 refs: add `committer_info` to `ref_transaction_add_update()`
  5ed33e32c7 refs: extract out refname verification in transactions
  e9851924a2 refs/files: add count field to ref_lock
  cdfa2c379a refs: add `index` field to `struct ref_udpate`
  ee4d52c7f2 refs: include committer info in `ref_update` struct
  df5d7a7ba5 Merge branch 'kn/reftable-writer-log-write-verify' into kn/reflog-migration
  - 49c6b912e2 reftable/writer: ensure valid range for log's update_index
  - e66fd72e97 The fourteenth batch

...
ok 5 - files: migration to same format fails

expecting success of 1460.6 'files -> reftable: migration with worktree fails':
                        test_when_finished "rm -rf repo" &&
                        git init --ref-format=$from_format repo &&
                        git -C repo worktree add wt &&
                        test_must_fail git -C repo refs migrate \
                                --ref-format=$to_format 2>err &&
                        cat >expect <<-EOF &&
                        error: migrating repositories with worktrees is not supported yet
                        EOF
                        test_cmp expect err

++ test_when_finished 'rm -rf repo'
++ test 0 = 0
++ test_cleanup='{ rm -rf repo
                } && (exit "$eval_ret"); eval_ret=$?; :'
++ git init --ref-format=files repo
Initialized empty Git repository in /home/gitster/w/git.git/t/trash directory.t1460-refs-migrate/repo/.git/
++ git -C repo worktree add wt
No possible source branch, inferring '--orphan'
Preparing worktree (new branch 'wt')
++ test_must_fail git -C repo refs migrate --ref-format=reftable
++ case "$1" in
++ _test_ok=
++ test_must_fail_acceptable git -C repo refs migrate --ref-format=reftable
++ test git = env
++ test git = nongit
++ case "$1" in
++ return 0
++ git -C repo refs migrate --ref-format=reftable
/home/gitster/w/git.git/t/test-lib-functions.sh: line 1175: 3403665 Aborted                 "$@" 2>&7
++ exit_code=134
++ test 134 -eq 0
++ test_match_signal 13 134
++ test 134 = 141
++ test 134 = 269
++ return 1
++ test 134 -gt 129
++ test 134 -le 192
++ echo 'test_must_fail: died by signal 6: git -C repo refs migrate --ref-format=reftable'
test_must_fail: died by signal 6: git -C repo refs migrate --ref-format=reftable
++ return 1
error: last command exited with $?=1
not ok 6 - files -> reftable: migration with worktree fails
#
#                               test_when_finished "rm -rf repo" &&
#                               git init --ref-format=$from_format repo &&
#                               git -C repo worktree add wt &&
#                               test_must_fail git -C repo refs migrate \
#                                       --ref-format=$to_format 2>err &&
#                               cat >expect <<-EOF &&
#                               error: migrating repositories with worktrees is not supported yet
#                               EOF
#                               test_cmp expect err
#
1..6
