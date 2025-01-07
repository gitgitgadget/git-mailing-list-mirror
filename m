Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230F198A0D
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273800; cv=none; b=c3rhN+SFZ1iLMhR+s9Gb76SWzD6dctYinkInPY8JGo9zkHUYWBIWAuP8FqUkpPXrKLQuxqDsQWHqLcPerjtbF5lLMnzh0ti4GqM8zEgJDWgsDJrsDtIfDkMkmh92b0L69ba4pvBkRhkKB3F5ikO6rO6mPIdweiNsmuFuuHwsTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273800; c=relaxed/simple;
	bh=JzigLIr5xhhPPInQqNXpm/aSUNHR7Ul00gy2At5HKxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OXkLls9tRKbam3ZxiSeEQl5zYFtkRT+TmpK+QN7Y2AIasTNU0cAaung7XjM9ryjLLOu1zLJQBbodna2LK5o68NS3y1COfDA4oYH7myOzq6h6wo4UVUQqeyp/jzcCymo5CfzgPUk6TFCSy+0+z3xlN0b8k0u6n/se+laBK1s1A3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mUCfdEQv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sp0v5AWi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mUCfdEQv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sp0v5AWi"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 041A2138016A;
	Tue,  7 Jan 2025 13:16:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jan 2025 13:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736273795; x=1736360195; bh=688CSiD/Q3
	Bz806LvYnecPmRf9N6F5jMthmUMruAKZ4=; b=mUCfdEQv5MUEJt2IyUDrv5ED1Q
	QrY6Zuab3uSf5ys4CyWm39qiyOXaKDcywtvfTWITztvmEhCB6Gez+bg9Xc86K4WA
	Zt7Wp0/a0Zs4N8OuX/GzD7R5k4lzyBrKZ1B1zpTDfyVi85OGnVMArp6dmjMDZWi8
	HUiC0eXyMFNSSrU02WFattTiDPWSi/ZZ1Wy0GnPfBVpcZbFIhFAAPllLUqgT1ADT
	IjRBqpGLh7BZz0MrQ94BPmwwkjF/UbtLHutmpfL7TRq4Ny8MD2vJEV18HDUIBG6T
	Cnns92X1LgvJvgR1SUkHuZFB3s97gC7cZ3sxdXi10KLmZ1SYCL1SgYIFI11w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736273795; x=1736360195; bh=688CSiD/Q3Bz806LvYnecPmRf9N6F5jMthm
	UMruAKZ4=; b=Sp0v5AWis1iBh4Y8EiOXDwAEL6WJe66bUe21F2md363TPuVU8A/
	nb4+eLfR8H2H2KcCDDz6IS0l+UN/lvLR4kaUhyBL/z5Btx7wQ65KcQD9rBvA8HJO
	traq4rLpvzxERNgAjTT2leR2gGx2dD6eTcyqyACORHwe19+jzXqLLCz+jaucfKJV
	uYXHwKoPMhyVnQG4t+HWg9rOV7F2Epku4DuwYinjxA0MrpBc7Kbg2t9EXaz6vcd2
	MIan0tN1UAX2MwScmyyx1uuktq7oY1U7G1nk/SeNlM7SPrLJ3qfZ83WX/DOMnwro
	w3JhYuStH/gIKH5ortcF0FHgGmdWaHISnBA==
X-ME-Sender: <xms:g299Z9PryfGEZ3gFzftSMFqh3uchm2b5Fs6Z86NpeALIHjVi7c0dig>
    <xme:g299Z_8WUwXJ6IzIWgCA4uDGQYa3CP0Zqij4CthBKJ_-GDz1TDleb8wmxt2t9TUxI
    BoOaHrAt_ZAQR7K2Q>
X-ME-Received: <xmr:g299Z8Q8fjepay3uH_0NFouy9pkOUo7SfyinXS0R9gW5OVBqfggH3YVJ2If_5TcQVwNOANxrYg1pPjazpN47eCBUfbNLakuZEw7_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhfohhrihhjih
    elkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:g299Z5tj60yzzyL6OHkUnHO1KlPfjDnh-aQnWpEEjSswEjVpEYKKVA>
    <xmx:g299Z1dv3rRnHD53kja7vguLdzPnPhA0tjlwQeTPBsW7F9jAHTLOKw>
    <xmx:g299Z10u2HFAn0s51omC5GTe7CZzFKCAbktMs1bvKtJ9z6f5j5_SjA>
    <xmx:g299Zx_dDIkxPB2tUtFDbb_ISTwYQydqb8phtN2HAgC7BQvu6qU6-w>
    <xmx:g299Z-Fxe6V20niTt8pBxHNNH2Bs_PrkCtBkID9oIe5cqhYMrFr6iAO5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 13:16:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t/unit-tests: match functions signature with
 trailing code
In-Reply-To: <20250107091932.126673-2-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Tue, 7 Jan 2025 10:19:31 +0100")
References: <20250107091932.126673-1-kuforiji98@gmail.com>
	<20250107091932.126673-2-kuforiji98@gmail.com>
Date: Tue, 07 Jan 2025 10:16:33 -0800
Message-ID: <xmqq7c76trpa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> The `generate-clar-decls.sh` script extracts signatures of test
> functions from our unit tests, which will later get used by the clar to
> automatically wire up tests. The sed command only matches lines that
> ended immediately after `void)`, causing it to miss declarations with
> additional content such as comments or annotations.
>
> Relax the regular expression by making it match lines with trailing data
> after the function signature. This ensures that all valid function
> declarations are captured and formatted as `extern` declarations
> regardless of their formatting style, improving the robustness of the
> script when parsing `$suite` files.
>
> This will be used in subsequent commits to match and capture the
> function signature correctly, regardless of any trailing content.

I am not sure if this is going in the right direction, though.

Especially for things like test suites that are looked at and worked
on only by develoeprs *and* these tools, being uniform and consistent
weighs more than being more flexible.

Let me state it in another way.  How many of the existing test
pieces are picked up by the current pattern, and among them how many
of them would see vast improvements if they are allowed to have
arbitrary garbage after their "I do not take any arguments" function
signature?  Are new tests you are migrating from outside the clar
world lose a lot if they are no longer allowed to have comments
there, or would it be suffice to have the comments before the
functions (which many of our function definition do anyway)?

A quick peek at [PATCH 2/2] tells me that this is not even something
that would make it easier to port the existing tests by allowing
more straight line-by-line copies or something.  The patch splits
many in-line test pieces in the "main" into separate functions, and
it does so in a rather unusual format, e.g.,

  void test_hash__multi_character(void) TEST_HASH_STR("abc",
          "a9993e364706816aba3e25717850c26c9cd0d89d",
          "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")

where TEST_HASH_STR() expands to the function body that starts with
a "{" and ends with a "}".  It can well be written more like

    void test_hash__multi_character(void)
    {
	TEST_HASH_STR("abc",
        	"a9993e364706816aba3e25717850c26c9cd0d89d",
		"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
    }

and we do not need this step at all if we did so.  Such a construct
would be a lot friendlier to the editors that auto-indent, too.

So, I do not quite see much value in this particular change.

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  t/unit-tests/generate-clar-decls.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
> index 3b315c64b3..02e45cf0ba 100755
> --- a/t/unit-tests/generate-clar-decls.sh
> +++ b/t/unit-tests/generate-clar-decls.sh
> @@ -14,6 +14,6 @@ do
>  	suite_name=$(basename "$suite")
>  	suite_name=${suite_name%.c}
>  	suite_name=${suite_name#u-}
> -	sed -ne "s/^\(void test_${suite_name}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
> +	sed -ne "s/^\(void test_${suite_name}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\).*/extern \1;/p" "$suite" ||
>  	exit 1
>  done >"$OUTPUT"
> --
> 2.34.1
