Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2125DCE5
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113451; cv=none; b=nvuu0kS5oIjCD7DkbVGRC/AqOQXx85DQp8Vejdih50BL1inbqirRUEXy9MhSxFQX3ZLlMybIuks770NjAedBqyEzXNqc67lZ9KNRw3JXVP+ES56xYvokgszV0YzsygOqUde/N36GWH/lsbv6uYdtFEa3xjayYN1UziL7z9wo3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113451; c=relaxed/simple;
	bh=z21m6Z3sbFxQB6y1x02+M0S6qFO7HTaQzNVhL6SDiMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAVLd645HGBsJWBqxX3fW99xRQ+q4pj64Ou99EkQPMzdVq7/RCB8qEjWNtexHzdMgkzHCDJjBqkx5HEZ65BAbJkQk5udB2RiOMsKUEhrhtEhJqlBPdtwgFChdcwy6jLmhtbx1gNBy49eh99DgF4B30tb57lYnFn4U00NYIymPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=URrARlvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m31dqN5w; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="URrARlvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m31dqN5w"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id EEF431382753;
	Tue,  4 Mar 2025 13:37:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 04 Mar 2025 13:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741113448; x=1741199848; bh=jheO4Gxjzz
	1OuqoYQI5TEPvboGNcmb7Faiy8plN2xME=; b=URrARlvUKuhkYcDLrNi3mtS2IO
	2PFpqmoRtJ9FxeMFN9OF+17JkF47BchefHtW0PzT4WIAxjE6WwoNEu5E+IYozbPO
	KAPR461gx4J2/RSj75Bf4nrToOY3iqEoS7I2xZU+zVOS9KtIeRLk4DgVNLQSndoU
	vaP+rYNW0tCnLazYGQqb201DY/SKDADT1IbQXyXbTN//8W/OILyIsT8mGkiV9oTs
	CuSi3GSN6lU8coGwR4i+X4D6E0VhfnUMM2Dff5OwnS3Rt385/PqocO0SQGwhYv7G
	NZumdJvOZMF6oTrFIwF3zesCJJtSO3mvB3JTON3gBQENeIYAAmkJ4umAlw4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741113448; x=1741199848; bh=jheO4Gxjzz1OuqoYQI5TEPvboGNcmb7Faiy
	8plN2xME=; b=m31dqN5weMKcmJ3+PASiwMFwkRDVyl7bk/JOBp20mx1bpgPjRP2
	S23mjFjNEGxsJVFX82glCMY95F6PZFM2AbrjR0FmmfEMs2fLHtmMAazH0I9Rot9P
	dtL+EdFhP9SGe9BCnvW2NQxH0LegNRB02gkXMknYyoa2LYWhqOL1TnoZ6gLJV+Lm
	FuwZJjqyzLxwBALIeciOj4FdhNnVtw5GeHc+0jLMWM6e1Lj7cTf+7hOj02MTcyim
	um/lblImKPHzQqvHAle9lFA+rv+GMCRX0dJr9VXG8VXdzKGzgN5k7Kntze9wBAtk
	tgi6L0xL6QUXUTaCccitd385Y9VW0yLnx6A==
X-ME-Sender: <xms:aEjHZ0WoCkVm7XD1xUylovSBFBw7vW5nJBkvkaJHAFArVVBb03O9WA>
    <xme:aEjHZ4m_STYaKItLfEWZhjnOerj7ObC3H2_JPqKdtNR3euO-F1K0hS9ZEDAC7I-L5
    ZmUV3OFaTZNhD_svw>
X-ME-Received: <xmr:aEjHZ4b7J7cKDU9Jiv6Ah7C9lLx3Pjora2VW9vBNb2sjPS-kiIsVOf_Iahf3tiClnfHel0aWQ29YQ9CrcupRh5SnX7LnrdOqYrl5XmPPFYHPXx6dUuRS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepgeeuveeiffdufeffgeevtefgvdduteffveefffej
    ieehtedvveffhedvfeekgeeknecuffhomhgrihhnpehfvgguohhrrghprhhojhgvtghtrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    thhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:aEjHZzXoa0AS-1bulFk4HDMh3jI5KPrULQk7EGQJuGeZLfSZIf8K5g>
    <xmx:aEjHZ-lAsaMxw7bVsB6sKl86xMgWyexGOVYNbaaBF_2xzf2HwnD88Q>
    <xmx:aEjHZ4eVfFj1axMRuurIR3MHgS2UZgxkGhCNGmCHN_ybqSo9K_b50w>
    <xmx:aEjHZwGGdPhJ7cllfYX0hc1FC7rKtx1jc11aAx-J6HaB9f-WdvbEgw>
    <xmx:aEjHZwiFGSRt5t0tK2zZqdWt2CidAzHjRl0E4tiv74pm6rNMFtjSvOxA>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 13:37:28 -0500 (EST)
Date: Tue, 4 Mar 2025 13:37:26 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.49.0-rc1
Message-ID: <Z8dIZmscTdi8dZAY@teonanacatl.net>
References: <xmqqjz94r8p0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjz94r8p0.fsf@gitster.g>

Junio C Hamano wrote:
> A release candidate Git v2.49.0-rc1 is now available for testing at
> the usual places.  It is comprised of 367 non-merge commits since
> v2.48.0, contributed by 68 people, 17 of which are new faces [*].
[...]
>  * Lazy-loading missing files in a blobless clone on demand is costly
>    as it tends to be one-blob-at-a-time.  "git backfill" is introduced
>    to help bulk-download necessary files beforehand.

In <Z8HW6petWuMRWSXf@teonanacatl.net>, I noted that one of the git
backfill command's test fails on s390x:

expecting success of 5620.4 'do partial clone 2, backfill min batch size':
        git clone --no-checkout --filter=blob:none      \
                --single-branch --branch=main           \
                "file://$(pwd)/srv.bare" backfill2 &&
        GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
                -C backfill2 backfill --min-batch-size=20 &&
        # Batches were used
        test_trace2_data promisor fetch_count 20 <batch-trace >matches &&
        test_line_count = 2 matches &&
        test_trace2_data promisor fetch_count 8 <batch-trace &&
        # No more missing objects!
        git -C backfill2 rev-list --quiet --objects --missing=print HEAD >revs2 &&
        test_line_count = 0 revs2
+++ pwd
++ git clone --no-checkout --filter=blob:none --single-branch --branch=main 'file:///tmp/git-t.6AFX/trash directory.t5620-backfill/srv.bare' backfill2
ok 3 - do partial clone 1, backfill gets all objects
Cloning into 'backfill2'...
+++ pwd
++ GIT_TRACE2_EVENT='/tmp/git-t.6AFX/trash directory.t5620-backfill/batch-trace'
++ git -C backfill2 backfill --min-batch-size=20
++ test_trace2_data promisor fetch_count 20
++ grep -e '"category":"promisor","key":"fetch_count","value":"20"'
error: last command exited with $?=1
not ok 4 - do partial clone 2, backfill min batch size

Being a new command, perhaps it's not terrible if it doesn't
work on a less popular architecture, but I don't want to let
it slip past without anyone noticing.

As I mentioned the other day, I don't have shell access to
the s390x host, but can run the test suite with additional
debugging if needed.  I have the test-results directory from
the build as well.

If anyone wants to poke at it, the full build log (which
contains the test-results directory as a base64-encoded,
zst-compressed tar archive) can be found here for a few
weeks:

    https://kojipkgs.fedoraproject.org//work/tasks/7999/129807999/build.log

-- 
Todd
