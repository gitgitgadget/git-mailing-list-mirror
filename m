Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277E13AD20
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655776; cv=none; b=n3dmWbl3IHl/U3NDekzLHFITWKUq+2WkN8luMnoMOw5fXIko61AHX1dTYa1fH7uioNR6KhsKldXQrMiSJeUNelzISeEO3VHP3Ffzv8U5WsZgxMVxHD0DlFyFA77Qhi7DwpWRMjMfsBQdQBAe6n9DTDL1U3dfOv3D07lzxWf7lH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655776; c=relaxed/simple;
	bh=BtoNwDE+NBfOyqzmDNjfbpRkfUoLPVFYGt/jeoPsYiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iciIXxyxeaMA8ZWEj4wy9WXwDH78KEi/P8zOMa2S+3uPO1JPeNDDqm7wais/ujwGH7Uh2zTJxjCru07VilyhxS6/brbwYPNrkFS7F7fPd6hdothMb8Top7+mddpwrcSzWRelMmZoyEd0Miefl/LLae/UsZYm8eGUz3XPAMEYunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D0T0kiL9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VF91iMd5; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D0T0kiL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VF91iMd5"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2CCB1138FF30;
	Mon, 26 Aug 2024 03:02:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 03:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724655773; x=1724742173; bh=HTFl1Y6eTO
	h0b13G8jHMJ++aK+N46U7tleTTx4QermM=; b=D0T0kiL9E6bQseowAiEqAo2NtL
	BcYnKBMH0fTbD7BFR/I0sUU+jhLm45SDFsohIJRy3SyJ8u0669YdXROtn00yoQ5r
	ehBMutagtl/ZCAj2pGKQl8yjpT1qkWVNxSFsIa4t9Roy3rGOJBfZoaNJdLAE3bp7
	okluagna2Xq6KGAgu45wOgfNBovjQQoBvQDmqT0T3AH/Y+BXQuqkv+hBPD+1NKn0
	OY901FyfrW9UBPdwmhdl6hjLiitxYjQOSf+bXl7oADmRilOdyerhGXFikjJbS3Gh
	AoE6oU1LBvbC6qrDPBwoGH1spvz2w5wMPRZ7Km4ri72FFAmjjX/ssntqae+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724655773; x=1724742173; bh=HTFl1Y6eTOh0b13G8jHMJ++aK+N4
	6U7tleTTx4QermM=; b=VF91iMd50fZAW5tp7R+xhDef7SWv5Jpg424GFSeXNgWF
	Q7RRqFbZFeOldQkDaLmaVtuN4wvm6+lolssdZGXI2hGLWWpihbp5E5ElKzSAVLaD
	hcqmoZU626z9JNmsjCJKqeLitTpgMgNGiVmbwJZCc2+NSWHGU0wx87cFEIdXUlGJ
	cCH3Mf9NBj0DM6AgKFQW6nikQajI4vafuCmJO7Q1LYCVInuZApvyRmKNaAWDq4bB
	ZwQKi1Zvokr1fSF36qq5/g2wRF7kfZFHV0BEjYHNKva3kEdr3XwyAL9lGei+Hqld
	e+hoQyR2lWxjOCR6T/u/wFDeW1ZznKCq8AyIuLbokA==
X-ME-Sender: <xms:nCjMZvBhp_rbTa2XqdoYEvSlbXRbf0OWwvad7_CC7v91XP993uaKUA>
    <xme:nCjMZlhveMxRps4cKE23yYiuQSkIr0PgaLW9zrFxUcW-seajnYNMemcX2TqqpRnYx
    wHSTaM7py3f-_i3-A>
X-ME-Received: <xmr:nCjMZqnQ0C9t_sfQ7RK9JWlcdUYvlNY-exi0Sj7SodkaGadFOzWvc-aETsLr0Rrr-q7pb7DyU2qrzF7IPXx_PKlpeJJ76GWBAgEvxw6RkyxHQqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:nSjMZhwaECYtitAyoVtz14Mv8a_gd1lL0-TG8grvZPfjRhxagBKU7w>
    <xmx:nSjMZkQKZEJa3PlVsPRChBCKlYjyUM9JaeeNhSX59PD3zLFl0EHDng>
    <xmx:nSjMZkYTaBV6teVWK3L7-0eBj7B7vZR_GodIhNlem4kWfsNGyCL_TA>
    <xmx:nSjMZlSqxon3WKdKI5-Ed_CNh3UmDwm5zpcainJ-eHZvz42Qgts1-w>
    <xmx:nSjMZpIwAy64UzvG_VPNXjsByDavDuSTpEeV3pcP1j_z8ZLQ7n1cks2q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 03:02:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63d0c264 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:02:48 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:02:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
Message-ID: <Zswok6P5dYf7ob5P@tanuki>
References: <20240824172028.39419-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824172028.39419-1-shyamthakkar001@gmail.com>

On Sat, Aug 24, 2024 at 10:50:23PM +0530, Ghanshyam Thakkar wrote:
> Add tests for oidset.h library, which were not previously present using
> the unit testing framework.
> 
> This imposes a new restriction of running the test from the 't/' and
> 't/unit-tests/bin' for constructing the path to the test files which
> are used by t_parse_file(), which tests the parsing of object_ids from
> a file. This restriction is similar to the one we already have for
> end-to-end tests, wherein, we can only run those tests from 't/'. The
> addition of allowing 't/unit-tests/bin' for allowing to run tests from
> is for running individual unit tests, which is not currently possible
> via any 'make' target. And 'make unit-tests-test-tool' also runs from
> 't/unit-tests/bin'
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> I know there is some hesitance from the community in imposing the
> restriction of running the unit tests from certain directories, so
> if this case does not justify imposing such a restriction, I am fine
> with removing t_parse_file() in the next version.

Another option would be to set up a preprocessor define that gives us
the path to the unit test root directory. But I'm also okayish with the
current version. If it turns out to be annoying we can still iterate.

> diff --git a/t/unit-tests/lib-oid.c b/t/unit-tests/lib-oid.c
> index 37105f0a8f..8f0ccac532 100644
> --- a/t/unit-tests/lib-oid.c
> +++ b/t/unit-tests/lib-oid.c
> @@ -3,7 +3,7 @@
>  #include "strbuf.h"
>  #include "hex.h"
>  
> -static int init_hash_algo(void)
> +int init_hash_algo(void)
>  {
>  	static int algo = -1;
>  
> diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
> index 8d2acca768..fc3e7aa376 100644
> --- a/t/unit-tests/lib-oid.h
> +++ b/t/unit-tests/lib-oid.h
> @@ -14,4 +14,5 @@
>   */
>  int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
>  
> +int init_hash_algo(void);
>  #endif /* LIB_OID_H */

Let's add a comment to explain what this does. Also, do we maybe want to
give it a name that ties it to the unit tests? `init_hash_algo()` is
quite generic and may easily lead to conflicting symbol names.

Maybe something like `t_oid_init_hash_algo()`. `t_` to indicate that it
is testing-related, `oid_` indicates that it's part of "lib-oid.h", and
the remainder describes what it does.

> diff --git a/t/unit-tests/t-oidset.c b/t/unit-tests/t-oidset.c
> new file mode 100644
> index 0000000000..4a63f9ea94
> --- /dev/null
> +++ b/t/unit-tests/t-oidset.c
> @@ -0,0 +1,222 @@
> +#include "test-lib.h"
> +#include "oidset.h"
> +#include "lib-oid.h"
> +#include "hex.h"
> +#include "strbuf.h"
> +
> +static const char *const hex_input[] = { "00", "11", "22", "33", "aa", "cc" };

I think we typically write this `const char * const`, with another space
between `*` and `const`.

> +static void strbuf_test_data_path(struct strbuf *buf, int hash_algo)
> +{
> +	strbuf_getcwd(buf);
> +	strbuf_strip_suffix(buf, "/unit-tests/bin");
> +	strbuf_addf(buf, "/unit-tests/t-oidset/%s",
> +		    hash_algo == GIT_HASH_SHA1 ? "sha1-oids" : "sha256-oids");
> +}

I wouldn't prefix this with `strbuf_`, as it is not part of the strbuf
subsystem. The function just happens to use a strbuf.

> +static void setup(void (*f)(struct oidset *st))

I was wondering what `st` stands for. I'd either call it just `s` or
`set`.

> +{
> +	struct oidset st = OIDSET_INIT;
> +	struct object_id oid;
> +	int ret = 0;
> +
> +	if (!check_int(oidset_size(&st), ==, 0)) {
> +		test_skip_all("OIDSET_INIT is broken");
> +		return;
> +	}
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(hex_input); i++) {
> +		if ((ret = get_oid_arbitrary_hex(hex_input[i], &oid)))
> +			break;
> +		if (!check_int((ret = oidset_insert(&st, &oid)), ==, 0))
> +			break;
> +	}

In both of these cases I'd split out the assignment into a separate
line. While the first instance is likely fine, the second instance makes
me a bit uneasy as it is a macro. I generally do not trust macros to do
the correct thing when being passed a statement with side effects.

[snip]
> +static int input_contains(struct object_id *oid, char *seen)
> +{
> +	for (size_t i = 0; i < ARRAY_SIZE(hex_input); i++) {
> +		struct object_id oid_input;
> +		if (get_oid_arbitrary_hex(hex_input[i], &oid_input))
> +			return -1;
> +		if (oideq(&oid_input, oid)) {
> +			if (seen[i])
> +				return 2;
> +			seen[i] = 1;
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}

This function is somewhat confusing. Contains what? What are the
parameters? Is one of them the expectation, the other one the actual
state? What do we compare against?

I think it would help to get it a more descriptive name that says what
we check for and remove the dependence on global state. Also, the `seen`
array does not seem to be used by any caller. So maybe we should
allocate it ourselves in this function such that it is self-contained.
It requires more allocations, sure, but I highly doubt that this is
going to be important in this test.

Patrick
