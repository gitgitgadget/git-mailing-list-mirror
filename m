Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1A331203
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645322; cv=none; b=s53lmoEfSkm7iApbSf0BAwb2l89/QAzS0Z2PUNH0d1D/4JPt9MqM8lMOI5R7pqPJcweiHIJDfiA70C1clBrsHJWMpS19fdb6cCZUR6BHpk42I8qsm5E+b/z+NI0o5OOv+UXej0HDGKqtmcv5OMoyhsOM6Cn9zZ290A2oAh5Bnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645322; c=relaxed/simple;
	bh=kQQfVV9PvkfJX7dK/JkPEmAAOFc41n43pPoGYceqfww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFqgmUoVNNH/AiuuRj68jT2zw1v2/oL+qFto6g+NlyhqyM49EKpBoHAzz03lmD1pVUXA5YtcR3WM30f1rzbscyVkBfStq7gquciWbV+lnbaa+eCC8qINZPqKVqCoEVgo09Z31N05/BrKA6B3ixxlm/UIxXzUcjpv1R/hZJeLfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j0CArMCv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aIFM0jNE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j0CArMCv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aIFM0jNE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B68FE14001FC;
	Thu, 13 Aug 2026 14:21:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 14:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786645319;
	 x=1786731719; bh=XSq0f9CHRRxqvyStAnGRJfBYmt0TvIOETRMmmhZct8E=; b=
	j0CArMCvHxpQO5VQLprHcDX4yAoc+9fYSQQ2Ys/rpxTezi9bLR2o8Kwz9vS7YLBb
	B3APERUUcmLFt9CGo689tgeL1HYrNCgmKtKv5C2s+nd4aeBLSShoF5DEfiwQg78f
	nbLPWSM/UGY37UX4kwXkK3IgrQ1P1QqKcR+TM62+cyShEkMb4FWP6fBWqss+TgAk
	6spUxfHIYQ35JWtOiW9vrFpNNUeu9M5iAdnZ22oZkOfa41puWizIuhu9jkUxGtkA
	9Wi149iq77Z+PThueiJNNLeJ4VS/JpBHuPFF/q6hwbhvCny8WxSdDCvHDwae9wJ9
	LbMSDlOzu9ZYfkRzjGiNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786645319; x=
	1786731719; bh=XSq0f9CHRRxqvyStAnGRJfBYmt0TvIOETRMmmhZct8E=; b=a
	IFM0jNEKgCOHNQXqHz0doYtUYudgZ5mxnAPAzBqiqc/qhDzyA3KXGU2DVeaaFTTn
	+lUDW5BatdHOpN6E6Np5/yt5/6GGq7JySvCcTvKSSGtKqFtJ70LafEZagAcbO/wV
	TxoXglVsUtLqJiuwIrCuBVEa9/w90PVwKeFMII8+xjFSAXbnmVBP54KqswWYQP7I
	DAJQIhwBtLGZobq8GGZxuwjFzqXkticaHmFxAtWwenfdtdWJg9i5lmtwGPcENUpU
	xbHeu0MXefGl/9mWmi7Q9KrBf1kpfo2RDlbmgLs0oEaakXtuor6JlsONrDDVY6U3
	wgpN+NQFhqFKLa+xcQaAw==
X-ME-Sender: <xms:Rwt-amw_8LN4x7omPepvfowuXU7eCg15aVDhjYf7zmm1dqDc-ZpafQ>
    <xme:Rwt-apTJBPmvA2i_9PFPhSHZtVNm7WzhQMyDeUZQwkar4JB8ISoX3HWvzdkw0OEoT
    tnt1pEoZW8Fg4R6E1y7JXkT7lis7gpMqqX4wDHof1_VLLzFLkt25Vw>
X-ME-Received: <xmr:Rwt-atXZfu6a6jKsqqyHIq-xJG0ICZW7o89MYs8tuw95ozG-OUehhLl29k2etAlxx859VrHjsKDKaloVTR23dKN1syOqdBP1Bw>
X-ME-Proxy-Cause: dmFkZTGsY/+enoOsyxDKCOGcwL9hM91us3yT3lBJA0yi5uRKmI6fzBAWGQkvIRH1UFrbJ5
    aLyCiPQxnb3JEWuwUc7XURvB4eLZ1rEsGp5VnZpNWubHk66vgdKP6FoHANMd8iaZKPCp6d
    vWGfpfzqOPmWuYsRqc+O7qJS40qfNZIKfDcl6JlchXcYZOSaLtc9awGufTx8qakXBZc2vk
    yTtZEtnHzs0xHmqdU5bxwLjrHfLXKwrE/iesvRAVGlplglRfVxdy+dtHCTJgUKxhqhHDsq
    nvX2jP0g1qFoU6Kn8uwWWUIbO7l/cKzI5MmS/Wn+vwb4/W0RmduftTKqDNvQtUdZb1ULFS
    998ghlYb1tRgf6ldZE3QEAM2xgnheyjkDGCzmaaUNx0I3HldaWPloT0ryV1ULUc08/ki79
    kNsiuQARDkVdPYc+HNutimNR8STqpshqH21Ua/wx+e5fw2zdAWKP/lMX7BXtfYKl8vZUcg
    wjojad1EtKpgOZQlkBO09GJl4+Ub9m1nAmF4NiebAxRvOCViuDrfdz9u+0mqLBsRVj1RV8
    r45rIkizxdMNMSC7yYrbxRlHKiMNl7Ut9Bvlvn4cVt5ac2HAIn6ABbnJnCTHFgqXJAUo0P
    w5LBI+sH/ClU7v/bQfw2Bww4Tfe4mDB0yAtoMD1R3GPGK/tWcMqz1r8HpjuA
X-ME-Proxy: <xmx:Rwt-arYrNOPSD0kWUHJYjElhzixcRE-MWbveVYjCsg_h_Rm3pvYM0Q>
    <xmx:Rwt-aj1WhWn0_hqhiqYukVBtn1p7cSvESvbTO6D13gjIckfkTwj2ag>
    <xmx:Rwt-atjTEm5aEApqrS5OKkqYgRSLksT_nRRUXFBxYptpYyFSJC0PiA>
    <xmx:Rwt-anZWY-t_hGz6k1XKlv_umOR5xR_9sKUq5zJEHnoHhzttPPJ8TA>
    <xmx:Rwt-aoJNjUqJzHI0jE5jvKCHRn-__gSwc8M7Vjq42hmbSOWUFPk4nxaM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 14:21:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 2/4] format-rev: factor option variables into a struct
In-Reply-To: <factor_opts_into_struct.b82@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 13 Aug 2026
	19:23:58 +0200")
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
	<factor_opts_into_struct.b82@msgid.xyz>
Date: Thu, 13 Aug 2026 11:21:57 -0700
Message-ID: <xmqqfr0hswxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> We will in two commits add three more options to this command.
> Let’s prepare for that by moving option variables into a struct
> so that we get less local variables.
>
> This allows us to inline `format_nul_data` into this new
> structure. Let’s also rename `stdin_mode_arg` to `stdin_mode`.
> (We couldn’t use `stdin_mode` before because of the enumeration
> with the same name.)
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  builtin/name-rev.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 254c88199fd..7d824aa1c5d 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -772,16 +772,19 @@ int cmd_name_rev(int argc,
>  	return 0;
>  }
>  
> -struct format_nul_data {
> +struct format_rev_data {
> +	const char *format;
> +	const char *stdin_mode;
>  	bool nul_input;
>  	bool nul_output;
> +	struct string_list notes;
>  };
>  
>  static int format_nul_cb(const struct option *option,
>  			 const char *arg,
>  			 int unset)
>  {
> -	struct format_nul_data *data = option->value;
> +	struct format_rev_data *data = option->value;
>  	data->nul_input = 1;
>  	data->nul_output = 1;
>  	BUG_ON_OPT_NEG(unset);
> @@ -813,31 +816,30 @@ int cmd_format_rev(int argc,
>  		   const char *prefix,
>  		   struct repository *repo UNUSED)
>  {
> -	const char *format = NULL;
> +	struct format_rev_data data = {
> +		NULL, NULL, 0, 0, STRING_LIST_INIT_NODUP
> +	};

It will make it easier to maintain if you used designated
initializer here, i.e.,

	struct format_rev_data data = {
		.notes = STRING_LIST_INIT_NODUP,
	};

The other members not explicitly mentioned by the initializer will
be zero-initialized.

Other parts of the patch look good.

Thanks.
