Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BA2D0C74
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923389; cv=none; b=PwrdfD4tBOOaZynOXm2Z+Zrhl6Oqpm0ribphMpiRTDDpkqcb+6LkTb1yIqRjZfTA8zux56TaQiLGz54lhdTp5sw01ERSsUmT5zxgs2oYJx5W1gNXQ1UWoKs23S7nTZaJ7UipvR52sGSPNlvoXiWOMA2v5W4mzRb8lQo++3V41r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923389; c=relaxed/simple;
	bh=8o6Mt7ZOoUn+szAFtTCmB2KN6LAK+4sjESo2N02KSsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=adLW9tcIX5XKAOHZzDtW3Uw3VoKXvFyAUAkDzNtg1nFTw0NKFmOGdjzjCqwtUvq0LSGKyP4C725ltzCSK9xPeEyFKBDPZCyoZaDFxH8ulDnRimXFHXFigr43zOR9cCzdDZhzviLRyOPWs5srqAHWZW6551qCLjlmTUrpBGUgzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0rO8tKWm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LYCoDfZ6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0rO8tKWm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LYCoDfZ6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB8D614001A6;
	Wed,  3 Sep 2025 14:16:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 03 Sep 2025 14:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756923385; x=1757009785; bh=oBzMqxjy0A
	uRc4ihuzpj5SYYCEtHL7P/v75e4K5NrdE=; b=0rO8tKWmabc2nq3AWBdBFZ1gUS
	yiznmo7e5s/cn98Nu5j3w80c4yP/utQ9hbxZ9WcTPMBs3AzKlJVm5jFJ3gZRhNvd
	URxbAau0UHtdEFOTWtA+Q6SzP6W4pTkV70UTE5OqRmjARF55VZl8NiJEpXvtmWEP
	BZzvM11XhsBGInjCq25EZ5X6nW/JkHxJHRlucAoAUoEz52zCbsL8UZJmPOUWJbMV
	nMGDsnNV0lgGnF7wD3zi6pOZ8nZFMtYK3FgnGU0mOEPAuXmaWXOL1X8qbcRuKlED
	x0wCGKS1G269nYoQrndVi6P0Nw7kCrCSHWmhkZSbHX4vrk8k6blv1rsFKObg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756923385; x=1757009785; bh=oBzMqxjy0AuRc4ihuzpj5SYYCEtHL7P/v75
	e4K5NrdE=; b=LYCoDfZ6OY03tnAH1kPQ7KDMqmEqbdkpnrAP/42+zGb+fUJ3Jik
	hKJUV4GBpWHeeWmkfUN1pIXqfsBvWMWkybHb0B50FIP26qBPnvIAHp/Q7Erh2Ech
	YFJKKWqSIZukzjZqXCUw6zUFsEyG2K1XrrgETqZf+h1VMBXciBRH98oo1DDrK617
	KiXPTVSGKxIlbSft3mZhMF2dubB5G2bO0A3dBRL6b4HOxA/tBbNOjA9yQ0c7bruk
	vU9Z0K3vrm/9/IauTdhOBjO434bymn/0a4IkYGn8P+xqeOsfVgDDBxDrK3QJ7q2C
	IqH3FFnwqmFvQZUykoAGrnDXIYpzFDk2Oig==
X-ME-Sender: <xms:-YW4aF6SW8XxKWXRL6V4ij0tqaTFSwd0ppU72ZsB4DhSGkKUZpD-wg>
    <xme:-YW4aLUg6QhuB0YcezmdPlyca7lxGrH-yAEQZHya59GXVECobthPcG8fBQcr0vihS
    FLLkyb3VVR4npzQ3w>
X-ME-Received: <xmr:-YW4aM76bj9BXy2W2oG11Ser0AtpwYSgTqX45G0toWwVxpOuIaxNnGIyXtvSvqZjC0YxsbcuKI_C0AtSGV6zq8XFR3fLnuhHnQnCI_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepueeifffhjeefvdfhffekheeuteefkeeuffegiedtkeeguddvueejfeeuvddtvefh
    necuffhomhgrihhnpehhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohgvrdgurhgvfiesihhnuggvgigvgigthhgrnh
    hgvgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-YW4aOqs8_cOdXz4EWDSQsdRsSJvsx2EvsI_WcIIJBSCfFzhur8i3g>
    <xmx:-YW4aHn6AmOtAchKX3JfASlHRoZXLvAFxrCBLpOIQpacO2tdZXdwqw>
    <xmx:-YW4aCPS4bhB3CBr7YdXZgOR3_7e1ZvhxLH48k44FjAtenCSBn1KYg>
    <xmx:-YW4aDPvA6wgAKIPchkGfR2_prTacFZfrK1CL-gQmgHnuNnZ0aNYjA>
    <xmx:-YW4aI2a0NrKicxM6ehz1VMqn3erbFgdrS44EPS4lbUKeKhQTn2LPbOf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 14:16:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  joe.drew@indexexchange.com,  peff@peff.net,
  ps@pks.im
Subject: Re: [PATCH 2/2] refs/files: handle F/D conflicts in
 case-insensitive FS
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-2-35e69bbb507d@gmail.com>
	(Karthik Nayak's message of "Tue, 02 Sep 2025 10:34:26 +0200")
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
	<20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-2-35e69bbb507d@gmail.com>
Date: Wed, 03 Sep 2025 11:16:23 -0700
Message-ID: <xmqqms7bfll4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Similar to the previous commit, when using the files-backend on
> case-insensitive filesystems, there is possibility of hitting F/D
> conflicts when creating references within a single transaction, such as:
>
>   - 'refs/heads/foo'
>   - 'refs/heads/Foo/bar'
>
> Ideally such conflicts are caught in `refs_verify_refnames_available()`
> which is responsible for checking F/D conflicts within a given
> transaction. This utility function is shared across the reference
> backends. As such, it doesn't consider the issues of using a
> case-insensitive, which only affects the files-backend.

Sounds like a sensible way to separate the issues and
responsibilities between higher and lower layers.

> While one solution would be to make the function aware of such issues.
> This feels like...

The first line alone is only half a sentence.  "such issues. This"
-> "such issues, this".

> ... leaking implementation details of file-backend specific
> issues into the utility function.

Very true.

> So opt for the more simpler option, of
> lowercasing all references sent to this function when on a
> case-insensitive filesystem and operating on the files-backend.

So when you are trying to lock "Foo", you lock "foo", for example?
How would that let the generic code liks verify_refname_available
notice that an existing ref "Foo/bar" would crash with the name you
are trying to take, which is now downcased to be "foo"?  I am not
sure if the above explanation is sufficiently clear to convince
readers why it is sufficient..

> Reported-by: Junio C Hamano <gitster@pobox.com>

Hmph, I do not recall reporting anything, but perhaps it was a long
time ago...

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c | 19 +++++++++++++++++--
>  t/t5510-fetch.sh     | 20 ++++++++++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 9f58ea4858..466cdfe121 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -869,8 +869,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  		 * If the ref did not exist and we are creating it, we have to
>  		 * make sure there is no existing packed ref that conflicts
>  		 * with refname. This check is deferred so that we can batch it.
> +		 *
> +		 * For case-insensitive filesystems, we should also check for F/D
> +		 * conflicts between 'foo' and 'Foo/bar'. So let's lowercase
> +		 * the refname.
>  		 */
> -		item = string_list_append(refnames_to_check, refname);
> +		if (ignore_case) {
> +			struct strbuf lower = STRBUF_INIT;
> +
> +			strbuf_addstr(&lower, refname);
> +			strbuf_tolower(&lower);
> +
> +			item = string_list_append(refnames_to_check, lower.buf);
> +			strbuf_release(&lower);
> +		} else {
> +			item = string_list_append(refnames_to_check, refname);
> +		}
> +
>  		item->util = xmalloc(sizeof(update_idx));
>  		memcpy(item->util, &update_idx, sizeof(update_idx));
>  	}
> @@ -2796,7 +2811,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  			       "ref_transaction_prepare");
>  	size_t i;
>  	int ret = 0;
> -	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
> +	struct string_list refnames_to_check = STRING_LIST_INIT_DUP;
>  	char *head_ref = NULL;
>  	int head_type;
>  	struct files_transaction_backend_data *backend_data;
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 57f60da81b..84dc68e5f3 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -53,6 +53,12 @@ test_expect_success "clone and setup child repos" '
>  		cd case_sensitive &&
>  		git branch branch1 &&
>  		git branch bRanch1
> +	) &&
> +	git clone --ref-format=reftable . case_sensitive_fd &&
> +	(
> +		cd case_sensitive_fd &&
> +		git branch foo/bar &&
> +		git branch Foo
>  	)
>  '
>  
> @@ -1546,6 +1552,20 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
>  	)
>  '
>  
> +test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensitive filesystem' '
> +	test_when_finished rm -rf case_insensitive &&
> +	(
> +		git init --bare case_insensitive &&
> +		cd case_insensitive &&
> +		git remote add origin -- ../case_sensitive_fd &&
> +		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
> +		test_grep "failed: refname conflict" err &&
> +		git rev-parse refs/heads/main >expect &&
> +		git rev-parse refs/heads/foo/bar >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
