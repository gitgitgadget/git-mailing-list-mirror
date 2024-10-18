Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2820604B
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281935; cv=none; b=BS+NcyGvPcwo15nrm55XcVjZX46FTTlK404WnU2FcP1yYIvCPq+MJTqLXQXb55H5ByCVApQIyeEy+lOJv2Zz3ogSi+2e3WErKRXIA0meSKBCPjJkGRbowojdLEYvjTONkY1jZWKvRtHLeQwvx5TVNyy3rrM9MZwrpEqsiaqzwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281935; c=relaxed/simple;
	bh=ksLAQdmo+17Oro65LYYrnNzTaruq0ytRq47ViXBVjj4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=W0OeV29ShV05CC5Hp0TB054V6wsXHcsMxRtl0Qeh/eYWkIt5ezSPUsUKIsAzpGEKHMKFD7jecA5Zn4j2ObJOiNl+3gjzOjQb2XdeFOEFpOzVdksxj5JuPi7CR1ERqAJ6CtGwKHEciIymvSUxNnefT810oStGoBNqbwCys6fTYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=V4YM2/bP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fK7C/ITX; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="V4YM2/bP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fK7C/ITX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3B9025400F5;
	Fri, 18 Oct 2024 16:05:30 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 18 Oct 2024 16:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729281930;
	 x=1729368330; bh=EexUfDAWkV5GbsS43EhzS+25qpA6oWNDKDzw92WiAmM=; b=
	V4YM2/bPOq6st4V5A2yuz2fzgCktWRMI+bq4wODiQwdY0en14soG98Ms3kwt54I9
	7KXYGB8JU/9lvftS9kSP6qR6L1tWr4RVrQ7PBJM5LcGJBXfv0YGtmH/vJtgzmWTW
	BpAgjIcRZSsMLB8NuJxS8omg92jBHHxVDx1bq/LsmomIHYCiKQIFdLfjLXhe10Lt
	CNblzvJ9iw7z7jucfVbbPBssFrziBtkMSXNUQeFoapklC4e3kgFNXZz0vTN3zUMi
	m6Zwtkq/rhbuDljftW/mIFaq4zb1Ycs6RVW2bsgMvx5ch4382UhIaifBnTn8vs7A
	PFyIofo+X2r2XZLkPsfvrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729281930; x=
	1729368330; bh=EexUfDAWkV5GbsS43EhzS+25qpA6oWNDKDzw92WiAmM=; b=f
	K7C/ITXpbKnbFq76tDHdwRPu++dgxR8r4Kt6j1RWeH49Lr6AWfdQBHT6kQlUF9JC
	+k8hdaxMVBimcqie4r7eb6Ti3IAalyhthlNJMzqk1MPkM2zhhjqDe+xUJCqFd7tP
	K1d/JwQrjZ34HeyAqrs8CB8sh20JoNwX1mQK7XNbOAw9UZcmmoSXmbQpVwrxEWzi
	Hf+GB/2E1DSaG7xw7n6RoaJ72dlqCSB4/BHPrTEbRGppI0nARpwaVX5/14mllOqX
	vIoG5QaVZNEFtRMKEPsm2cCYalfj4gM7Z3pTXFfyGjg9s3sY2oUb2JoQYhDAgP9R
	9+9s8VDkfA4WrypMyqtNw==
X-ME-Sender: <xms:ib8SZ1hYMbf7FvCl0p7_Rj1mGYK5pmsggvl8OOZSh3eHM0bAT2HlyTc>
    <xme:ib8SZ6DJd15Tu4jV8uVvBQ6rEJivy4LthLqQTC1z1dS12za9Tknlhkc_yqyIQi_nK
    PGN_52ljymyupMLDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeehudfgvefgfefgffdvhfffvdevveegheehudetvdfgueffjeevjeduge
    evfedvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ib8SZ1HxBm-1fLOeNbdFiIQyWpLpwvU6Swoqfweok0y5SWtn1u6sPw>
    <xmx:ib8SZ6TxUnwhVElv-vNj_EmaJ7nQr84d1bcmxNwfMEpS-7SikqS_IQ>
    <xmx:ib8SZyz_3aufZ932zqPg6aT3bRZ8a9NuPqx2nXNhl6rB2Ye6qjCGwQ>
    <xmx:ib8SZw7KPYa-2hF1RLvlfN49GnHp36dQdGXAnolUl3r-PmyF2AOUlQ>
    <xmx:ir8SZ28jJHq7eyd7VG8_4Nb6MOHqHO1TkrAHol1raF1dIzlUHmFpZ-6W>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C465B780068; Fri, 18 Oct 2024 16:05:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 22:04:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Seyi Kuforiji" <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <b005084c-2710-4567-9217-27f34c2bbc95@app.fastmail.com>
In-Reply-To: <20241018191744.209746-1-kuforiji98@gmail.com>
References: <20241018191744.209746-1-kuforiji98@gmail.com>
Subject: Re: [[PATCH][Outreachy]] t7011-skip-worktree-reading.sh: ensure no whitespace
 after redirect operators
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hiya

> [[PATCH][Outreachy]]

Apparently you can=E2=80=99t nest brackets like this according to git-am=
(1).  I
got this:

    ] t7011-skip-worktree-reading.sh: ensure no whitespace after redirec=
t operators

Doesn=E2=80=99t really matter though.  I suspect `[PATCH Outreachy]` wou=
ld work.

On Fri, Oct 18, 2024, at 21:17, Seyi Kuforiji wrote:
> As discussed in the thread on lore.kernel.org (link below), it is impo=
rtant

This is documented in Documentation/CodingGuidelines at =E2=80=9CRedirec=
tion
operators=E2=80=9D.  That=E2=80=99s a more straightforward reference.

> to ensure there is no whitespace after redirect operators. This change=
 updates
> the script to conform to this standard, changing instances like:
>
>     foo > actual &&
>
> to:
>
>     foo >actual &&

We can see that from the patch.  Saying what it does is redundant in
this case in my opinion. :)

I think it suffices to say that you are fixing the code style.  If so
this would have been enough:

> As discussed in the thread on lore.kernel.org (link below), it is impo=
rtant
> to ensure there is no whitespace after redirect operators.

...

You seem to be wrapping the lines at 80 columns.  72 columns is more
common here.  The idea is (I think) that you add some slack for things
like commit message indentation in git-log(1), multiple levels of email
quoting and so on.

It=E2=80=99s kind of indirectly mentioned in Documentation/MyFirstContri=
bution.
I also found this:

https://lore.kernel.org/git/ZrCdDHqKfwWbr_Zn@tanuki/

>
> Reference:
> https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2=
SS_b7V8Hg@mail.gmail.com/
>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  t/t7011-skip-worktree-reading.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-=
reading.sh
> index 4adac5acd5..c86abd99bf 100755
> --- a/t/t7011-skip-worktree-reading.sh
> +++ b/t/t7011-skip-worktree-reading.sh
> @@ -32,24 +32,24 @@ setup_absent() {
>  }
>
>  test_absent() {
> -	echo "100644 $EMPTY_BLOB 0	1" > expected &&
> -	git ls-files --stage 1 > result &&
> +	echo "100644 $EMPTY_BLOB 0	1" >expected &&
> +	git ls-files --stage 1 >result &&
>  	test_cmp expected result &&
>  	test ! -f 1
>  }
>
>  setup_dirty() {
>  	git update-index --force-remove 1 &&
> -	echo dirty > 1 &&
> +	echo dirty >1 &&
>  	git update-index --add --cacheinfo 100644 $EMPTY_BLOB 1 &&
>  	git update-index --skip-worktree 1
>  }
>
>  test_dirty() {
> -	echo "100644 $EMPTY_BLOB 0	1" > expected &&
> -	git ls-files --stage 1 > result &&
> +	echo "100644 $EMPTY_BLOB 0	1" >expected &&
> +	git ls-files --stage 1 >result &&
>  	test_cmp expected result &&
> -	echo dirty > expected
> +	echo dirty >expected
>  	test_cmp expected 1
>  }
>
> @@ -59,7 +59,7 @@ test_expect_success 'setup' '
>  	touch ./1 ./2 sub/1 sub/2 &&
>  	git add 1 2 sub/1 sub/2 &&
>  	git update-index --skip-worktree 1 sub/1 &&
> -	git ls-files -t > result &&
> +	git ls-files -t >result &&
>  	test_cmp expect.skip result
>  '
>
> @@ -86,7 +86,7 @@ test_expect_success 'update-index --remove' '
>  	setup_dirty &&
>  	git update-index --remove 1 &&
>  	test -z "$(git ls-files 1)" &&
> -	echo dirty > expected &&
> +	echo dirty >expected &&
>  	test_cmp expected 1
>  '
>
> @@ -110,16 +110,16 @@ test_expect_success 'ls-files --modified' '
>  	test -z "$(git ls-files -m)"
>  '
>
> -echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A	1" > expected
> +echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A	1" >expected
>  test_expect_success 'diff-index does not examine skip-worktree absent
> entries' '
>  	setup_absent &&
> -	git diff-index HEAD -- 1 > result &&
> +	git diff-index HEAD -- 1 >result &&
>  	test_cmp expected result
>  '
>
>  test_expect_success 'diff-index does not examine skip-worktree dirty =
entries' '
>  	setup_dirty &&
> -	git diff-index HEAD -- 1 > result &&
> +	git diff-index HEAD -- 1 >result &&
>  	test_cmp expected result
>  '
>
> --
> 2.47.0.86.g15030f9556

The diff here is clean.  It only does what you describe in the commit
message.  Good.

I checked the file and I can=E2=80=99t find any missed instances.  Nice!

--=20
Kristoffer Haugsbakk
