Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F5322C65
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927498; cv=none; b=Zv9FH1egWBBtwvmvTIdwVAYCd+ChxPB7Ts8J/kpswZXNyG8V1bP8p1SQiN/U0i5zSmwGaMJce//p42Pgc1RtKpH2vadYyahC1nrNZKmGOLA7GdbqF9kaHHYNgbScqsQienR+DCfzqOdmqhOOMtSnbhaOev7c1tbtg1p7suT87rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927498; c=relaxed/simple;
	bh=ElX7ZefVsRsh59bvw56PRpLaETua/Ug4l6XK9p91Rss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dIooDN38tCE7YhWglrubsgL4h7K536DbDhkIgX2F++34Qr6jbnKjFHnmuoVqTrrXhDRTWnLqQ2kc9DtfuNyCJ4rA+ypNlrZ1PMD1FUWWq4IJELWSHhjCQeGjcr1ELBY5BGTD5s2053AjpRRt4jY+RdqpJsNf0TJVHwGiWJ3IESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eaEf5tGW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yd+akw1g; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eaEf5tGW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yd+akw1g"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2525A7A0063;
	Tue, 20 Jan 2026 11:44:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 11:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768927494;
	 x=1769013894; bh=UnMmq5GNu8mCbKhJXBm02FQ2LAbHZSaNXYeKvsEHw44=; b=
	eaEf5tGWNRVidbdUukXH69/tsoYDYfgUH+Cg3mJtbZo3TVNrkYkiVEcWLjC+He+t
	vrOSA733O7SlK/yqzKv4+Fai8C65TG2O32o9C5x+comqnUB6nm5snhIJ+4xlSy94
	2WUK1zxXqWvSCLKbC+jB7Jp07C9scKDN4BZdZvqF/3LfeK9j1hN6e/nk2GLGguLj
	d4gkDgrbrIMgLoDH2QPDvXaZKuojhpWOosMRUCjlqAxghrLe/oMl5LfUPSdicCFF
	XzAthehWVZqP28VBm5d+1Zllh6TMfl3CFf2LFI2f7SresdXff7Pz4fzanaPMJ5GU
	zQeacSHLuvtCEJqysF5/iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768927494; x=
	1769013894; bh=UnMmq5GNu8mCbKhJXBm02FQ2LAbHZSaNXYeKvsEHw44=; b=y
	d+akw1g2jDzX2gJP+dpQ+DjGGWJeQDt6+M1spH409Evx4848FGdLYcVh2hAPbkHD
	MJfFypKu+MoaEBQIWHllEGu0iEHl7/MKjZG/CGrp5Bo6mMrHxnEKUcyJFhVdrQ1O
	bErZ4hf6s74ezcvtLt1G8TDUnWPJBAEOJ3ToQxLKyj/Wu6qtgxnbuS0LWfmWUlZ3
	qdQyfOqlUlQ962ES9i6pNoqVjEW3u3yOG6RpXvh5TACa6GFcOyYCgtfal0fUnpy0
	TnN1ErSdadnKiyPZ3uq1Xnjgb2FfoZx7W6Ay5SyOIrlvVqowtuxhs/u2pndJRcrt
	Wgo+4T5WHMjEkjm1MtqMA==
X-ME-Sender: <xms:BrFvaS9oJMKwFbNOHxcKu4qTnsztl4xZy4sJwvn_97X2M1vTsY_s-w>
    <xme:BrFvaZtWnY-WG-8Sg8EC8_OWkUpiBH_KzO-HRJ3AlTYzqMN7pqlztMf2OkY5mz_aG
    fe1Lgek42WHJ9QspGG7QcLJoGG2ecXxmz6yzq6rFOf1MUtI-Rlx5iM>
X-ME-Received: <xmr:BrFvadAvmzBtR7dXrdmSiZA6W5hDxrTXL2_JzlgKNGTQsHTFe4oLQtp7_ZheN5qYsHn9Md0b2zGecN8UqzkSuZIO0F5xgv5c7x9rd7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhrhgv
    higrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BrFvaZVJ6GsJ6JUevJ4siRvE-cNsY4y1nhzRgUi4szr6YdbASHNZdg>
    <xmx:BrFvaTBooFw-BCxKHtXnfHCl_k8vTRee2ryKn0Kc4pToXyYkzAcB-g>
    <xmx:BrFvaU_KvYj5dAgChRdScPbuioWDqanSFcimfnWsNFPsY-nhP0hDdA>
    <xmx:BrFvaSExUUeECfc4izJNyEOpuSJFosycGFZ1F7SmwenEMxKk_-Bggg>
    <xmx:BrFvaQg6WnmEQqaOUXFC2Wg2ygQTFs3orPeEFpHdI3U40ypdS2MxhAq7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 11:44:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [GSOC][PATCH] t5500: simplify test implementation and fix git
 exit code suppression
In-Reply-To: <20260113175913.474414-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Tue, 13 Jan 2026 23:23:03 +0530")
References: <xmqqbjixljfg.fsf@gitster.g>
	<20260113175913.474414-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Tue, 20 Jan 2026 08:44:53 -0800
Message-ID: <xmqqikcw1bei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> The 'shallow since with commit graph and already-seen commit” test previously used a
> convoluted here-doc that combined manual input construction with packetize, echo and
> embedded Git commands. This structure hid failures from the git commands, as their
> exit codes were suppressed inside echo command substitution and pipe upstream,
> also making the test harder to follow.

Very nicely written problem statement, but your line-wrap setting is
way too big.

Drop "previously".  The problem statement that describes the
status quo is written in the present tense.  I.e., "Now it is X,
which has problems Y and Z", not "It used to be X (before this
patch), which had problems Y and Z".

"and pipe upstream" -> ??? "and being on the upstream side of pipes"???

> The changes simplify and make the test more robust.

And then you tell somebody sitting in front of a keyboard to make
changes to the code to make it better.  I.e.,

    Instead of computing the pack protocol lines inside here-doc
    that is fed to the program being tested (i.e., 'git
    upload-pack'), use the "test-tool pkt-line pack" helper to
    prepare the input to the command in a file first, and then feed
    it to the command.  This has a few advantages:

     - It makes debugging of the pkt-lines that are fed to the
       command easier.

     - We no longer need to count number of bytes on each line
       ourselves; the tool does it for us.

     - Execution of "git" commands are done outside the here-doc,
       and it is easier to see any failure would be captured before
       we even run the "git upload-pack" test.

or something, perhaps?


> * Assign the results of Git commands to variables up front and chain them with &&,
> so the test detects any failures immediately, avoiding any exit code suppression.
>
> * Use test-tool pkt-line pack to construct the input and then pass it to git-upload
> in a temp file, instead of relying on here-doc and manual packetization.
> This avoids formatting issues and ensures correct v2 protocol guidelines.
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>  t/t5500-fetch-pack.sh | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 2677cd5faa..62cf0e1ff7 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -892,15 +892,20 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
>  	test_commit other &&
>  	git commit-graph write --reachable &&
>  	git config core.commitGraph true &&
> -
> -	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
> -	0012command=fetch
> -	$(echo "object-format=$(test_oid algo)" | packetize)
> -	00010013deepen-since 1
> -	$(echo "want $(git rev-parse other)" | packetize)
> -	$(echo "have $(git rev-parse main)" | packetize)



> +	oid_algo=$(test_oid algo) &&
> +	oid_other=$(git rev-parse other) &&
> +	oid_main=$(git rev-parse main) &&

OK.

> +	test-tool pkt-line pack >input <<-EOF &&
> +	command=fetch
> +	object-format=$oid_algo
> +	0001
> +	deepen-since 1
> +	want $oid_other
> +	have $oid_main
>  	0000
>  	EOF

Nice.

> +	GIT_PROTOCOL=version=2 git upload-pack . <input >/dev/null	

There is a trailing whitespace on the above line.

>  	)
>  '
