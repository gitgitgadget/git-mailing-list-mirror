Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428F47A6B
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770957032; cv=none; b=B5AypUYjjmYyVWHuFMU57zHslivMcyRYPkh3P/6CFUMoHRI02s72uNTAwilA6lKECO9EogewSSX30LQz1rB6O4m5U7qmL/KzZGDnQo/b6gCqapU+mO4FtqAqKPIuayhgJLqAZn7PIEhxam7Hs7yFE/dTJpvv/lK5DOBPqFuOsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770957032; c=relaxed/simple;
	bh=JZ0gbHHN7nNXtz8++pnCG3y0x853DKvsatlNcxcvQTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cWNKIs2Dx2e1jSwoiGS/pVh+tJgza7keK3gqEA8Jv2gzRNbiSxC1D3WPo56uxURNPgjwB4CDJdCMTORM3FRqDwA9WLrU1vOIIcd94eU50cwynmI0n5yXnHBgBy3W2ksx1Dp3t4l8OIKZsOqhCUAVjaHA3xj7lJMYhrEfJDkhhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TZ1QWv3v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tEmQ+rRX; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZ1QWv3v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tEmQ+rRX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 180281D00192;
	Thu, 12 Feb 2026 23:30:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 12 Feb 2026 23:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770957029; x=1771043429; bh=Iipq9iQOVC
	umDHGDkoHOzi33GZ23SxQFlkVloHZc6Us=; b=TZ1QWv3virf+Lj0I0Is3crSfJp
	5DwB+m00fSnSLK9DbgdoeRtcfkp4tbIX3/SIik6YbS3L2HgAyVqL6OfPh8rlB0nd
	qUmRsqpIwV3yv0/lEVm+oWCNRLzNqVvtVwUmqspnIsVf7gwuhcrrb1ffFJ7BkOPH
	NtUv3u1c2gO+Cri7QNfVdhUVc6VOqjqj8J4tEi1MMI0o8MWUyUCVCbnpnW8h2kJb
	4grRWqMEeG/UmBFr5GFJaf93pJc0eZ+IMeVvckKwBvLJEVtGx523R2pDtCdV7b2S
	1YdnhzzCCmE/KrgifzgdXa6uGC7vsiJuq4/5WvaAGy83x3+gcT+m1miiLBQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770957029; x=1771043429; bh=Iipq9iQOVCumDHGDkoHOzi33GZ23SxQFlkV
	loHZc6Us=; b=tEmQ+rRXeIFu5FO48Tnbxr+g9pwCm8k1l8VZzgJ0fAZQjybbt5A
	idbLWypCptZeJ1biYAA5r8A9+JJrUPNNDTYHy2kpscfeYR4vjb45uyzTAu9JBpmo
	CkuNFnhat3l+RSwDF2YJRKn6PIocr3wyvHg0tYEJDgTRYnkSw2W0CIgZ8vQqqUBi
	omtV5rod/OdhuGqqSEWfW919U+HDK459mCP7YfmKC1jy9l/0LO+hutspBNM323y8
	DwIGhFRY7PhdeasWawiy51pi3uBgSY1QDlvEFCCzgAaqieY7Ktz0Ij1XCipX2/vH
	+5ECCTDmR2JJykrz59MDtfPHMrLZvTuM69w==
X-ME-Sender: <xms:5aiOabTbf-_1qIlm1y5Jg0u2bYA5SNJLgIyeo70N8mNrtA6vhUIpQQ>
    <xme:5aiOaToq8ZXqUSc6nvZjB9BphqnzK_dLO5wqKhAbPFanSJEt0O7tHVvx9L_CHBhWY
    HJf-NEJJKlhthb_t_3p1TdCPUTDo2v5KLYbcQ0T9ioew4bhfN5W2qo>
X-ME-Received: <xmr:5aiOaZKpKWBcmZo74qP7f70QkcWfrkXPJMBL_34zQTr5gff2GRHaa5SoMJuyG6fUryTAj_nn4H9n7KYTUtsqX5Aan8a1s-k8xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:5aiOaWqJT9TfYsddPlxqfGixsI051Dpuu97IJqcVJgU7tEYo4fkaHA>
    <xmx:5aiOaRx7IKrKGgH0-i4Ca6isGjMPu_Iec1lE1dM4ojujP2DAn_2Wqw>
    <xmx:5aiOaaPsO2jbol7yvcsBIXNxqp1UZ0D-YizZv4mw3d4noK9AHxQ2rg>
    <xmx:5aiOaW57mw5xM5U2teHFcSA3YannvWhQpCrsegkd0VJCCQeFE55KEA>
    <xmx:5aiOaTJ_eI4LhhNMKJdQ-HUsK9RlTgkfvLCw51v8h8pmsknuJJS5UuwA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 23:30:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  peff@peff.net
Subject: Re: [PATCH v2 2/2] help: cleanup the contruction of keys_uniq
In-Reply-To: <20260213033729.50208-2-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Fri, 13 Feb 2026 09:07:29 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260213033729.50208-1-amishhhaaaa@gmail.com>
	<20260213033729.50208-2-amishhhaaaa@gmail.com>
Date: Thu, 12 Feb 2026 20:30:27 -0800
Message-ID: <xmqqecmpnu3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> +	}
> +	else{

Style:

	} else {

> +		for (size_t i = 0; i < keys.nr; i++) {
> +			const char *var = keys.items[i].string;
> +			const char *wildcard, *tag, *cut;
> +			const char *dot = NULL;
> +			struct strbuf sb = STRBUF_INIT;
> +
> +			if (type == SHOW_CONFIG_SECTIONS) {
> +				dot = strchr(var, '.');
> +			}

No {braces} around a single-statement block.  Wouldn't it easier to
follow if we do not rely on the initialization?  I.e.,

			if (type == SHOW_CONFIG_SECTIONS)
				dot = strchr(var, '.');
			else /* SHOW_CONFIG_VARS */
				dot = NULL;

or even

   			switch (type) {
                        case SHOW_CONFIG_SECTIONS:
				dot = strchr(var, '.');
				break;
			case SHOW_CONFIG_VARS:
				dot = NULL;
				break;
			default:
				BUG("%d: unexpected type", type);
			}

?

But all of the above might become a moot point; see below.

> +			wildcard = strchr(var, '*');
> +			tag = strchr(var, '<');
>  
> +			if (!dot && !wildcard && !tag) {
> +				string_list_append(&keys_uniq, var);
> +				continue;
> +			}
>  
> +			if (dot)
> +				cut = dot;
> +			else if (wildcard && !tag)
> +				cut = wildcard;
> +			else if (!wildcard && tag)
> +				cut = tag;
> +			else
> +				cut = wildcard < tag ? wildcard : tag;

How much are you saving by conflating SHOW_CONFIG_SECTIONS and
SHOW_CONFIG_VARS into this same "else" block?  In CONFIG_VARS mode,
dot is always NULL, and when dot is not NULL, neither wildcard or
tag affect the final output at all.  Would the logic become clearer
if you split these two mode into two, I have to wonder?

> +			strbuf_add(&sb, var, cut - var);
> +			string_list_append(&keys_uniq, sb.buf);
> +			strbuf_release(&sb);
> +		}
>  	}
> +
>  	string_list_clear(&keys, 0);
> -	string_list_remove_duplicates(&keys_uniq, 0);
> +	string_list_sort_u(&keys_uniq, 0);
>  	for_each_string_list_item(item, &keys_uniq)
>  		puts(item->string);

You inherited the source of ugliness from the original.  Even in
HUMAN mode, you sort-u keys_uniq and run puts(), and the only thing
that makes it a no-op is the fact that in the if/else above, keys_uniq
is left untouched.

I wonder if the above should look more like this:

	switch (type) {
	case SHOW_CONFIG_HUMAN:
		show_config_human(&keys);
		break;
	case SHOW_CONFIG_SECTIONS:
		show_config_sections(&keys);
		break;
	case SHOW_CONFIG_VARS:
		show_config_vars(&keys);
		break;
	default:
		BUG("%d: unexpected type", type);
	}
	string_list_clear(&keys);
        return;

without keys_uniq string list in this function (it would be an
implementation detail in show_config_sections() and _vars().

q> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index d3a0967e9d..0dbe6dd46f 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -160,6 +160,24 @@ test_expect_success 'git help --config-for-completion' '
>  	test_cmp human.munged vars
>  '
>  
> +test_expect_success 'git help --config-for-completion' '
> +	file="$GIT_SOURCE_DIR/Documentation/config/add.adoc" &&
> +	test_when_finished "git -C \"$GIT_SOURCE_DIR\" checkout -- Documentation/config/add.adoc" &&
> +	cat <<-\EOF >>"$file" &&
> +	aa*.b::
> +	aa.b::
> +	EOF
> +	git help -c >human &&
> +	grep -E \
> +	     -e "^[^.]+\.[^.]+$" \
> +	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
> +	     sed -e "s/\*.*//" -e "s/<.*//" |
> +	     sort -u >human.munged &&

Dedent "sed" and "sort" to the same level as "grep -E".

> +	git help --config-for-completion >vars &&
> +	test_cmp human.munged vars
> +'
> +
>  test_expect_success 'git help --config-sections-for-completion' '
>  	git help -c >human &&
>  	grep -E \
