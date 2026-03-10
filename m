Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DB2EC562
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153179; cv=none; b=YWNUNX4QRgFz3AaL6w7YB7UeOhaWJgXEXcne3W3l+K43eg1mF4IwpG8qyhlV3Z3+QOIBUAQClacI6k2QAFCw4Ys1djrpIH/sMAAeSHyCxUslXi6DcePBUWWjPyJCOLrfW2i8eKflYL13MbNSXNYAtolAwYSVgTTwiSrYrp+aLRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153179; c=relaxed/simple;
	bh=bBLnlL52rNur7Ksg17IjBuQ6Bge/v0iy2Sez9cSCCDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXdi2apnTPWHfTwDZN/UER11XPRQVei88fSmU/DzV0XQex08LfT0beuDxYa5p1Lqh0qhI5RxzB+hslRB6YQPq8Hi+SaG4FxCeiCufbYEl62OVwmlXw5k2WaTkhY5CCVNwDFHYsp/ssoZfrNBxpO/WX1MBtH1XVWcIO5vKOKYiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKZ7VS3K; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKZ7VS3K"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b942b36de08so678432666b.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153176; x=1773757976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sdgaeL3gwETMaPOGt/cioaCjOZgz7P6mXaf9qlbrSe4=;
        b=GKZ7VS3KA10+/9XHLl779/An/WOLYiu5Y08zlQn4Sp1MZPFlUtPUMVCyb+KEFiKC/N
         NbHoKuIx5r6Z9A6uvNjCmUTlUvJNiCYNpYNolU7ULpxEsLxcDg/L74+A0k1GYZThP8N0
         sXhkGbgZGOXveUT1nXg9IwQPxdr9uIL3zZr8wLqJq6tTznZ5MpEBL61uO/mmgQQrB0T/
         zOBDHqBqfxnsgeUah+kaTant9Ry7ATrmrWcpX9wNHBnDzceaO5P8txyajB+SfV+LQMfr
         3grtc3DVVl+OkPiqajarpg+G4VJmbdzmy59MBGz2vLt9GBKdfuA1fLh+PwjJklj+cst3
         EgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153176; x=1773757976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdgaeL3gwETMaPOGt/cioaCjOZgz7P6mXaf9qlbrSe4=;
        b=k/DT/UpHnh2fJpR4xfVD/uywAHSgR5bHrxFKijNgwqWOfgJ1Ult5jh35XTCxhWHjrL
         SShrjC6a9tzOn0+yhJzwUO3RX7uPeYL/WptPzQ4IjCJGIePJuIRWOA7hO0Nf4yPyYUY6
         gvcAKQTRL8LGjSP/DQsmsXqW8OHAPILqpWqugYDCgqFbNUkgUDVwnW0GLQ47iUgH0n/Q
         NlaXPOWUR2aySY7F1FG/1WaShTAsqXirLMECyVXzW/yqxaiW72BVVVqH0ijdbIbFvt9G
         DRgc9lPBISlm3y7LNDjvaUIrf/wxZD7KiQNOsAz46A/pdC8rKo7JNg3zw/x9cg8EkfW2
         BI8g==
X-Forwarded-Encrypted: i=1; AJvYcCXgUI1yYlnKgKDfXeuBwtdFbLEoe+lQQrZNFIb9sFUirI7nScRnGtUxgDS+uGb6VhUgo5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTryGietKNoH35DOwO9ydzfCn8rAZUf9Kjjs1g0i0w/f3bRXl
	/IXZF5A8ic/Vh/zyhscUna0pbPa2x6csIB1afrPrreMDVxrxKREmPGBe
X-Gm-Gg: ATEYQzyq6JrIjarA7kbcQbN2xTTjVFX1s+5XaEfu+ISfDgjglCvr01czie1R2deKJ1c
	QtGTJBWF659ZYS1YSjsBuX8IPbsQkc3/aeWfoBrkQVEJX+gfinxQZqN50LwjwpXvLFBFmBnkAFu
	p0WfgI/DLRhNImysOQMNk7+Pce+VuEdT7n/anQtmmtzssgkVixpgPH2bCJHby9NGUYyvD7qCX8w
	/AP1zd0+yZygUXVJDfRWuJgJAcRyBA578BVwK0Be3ZTiwietsQ7/Cb2LW7Tn5k2YdjeRpxlCgYq
	H7NH81yy+SX581s5yEy3jryXFQ3ygn8avBWdtOTwNyyDnzd0QjIKfjppwHWRRLnSt3dKrlvZw3n
	MQm5ZExhMLSv9HvFa3SzsU+eRvD6rXOTwcaosw/a/by+7KfEiWiGdZwN9BwWKLAdQDfKger9qoQ
	i6GRcpkncoibsI+mlF0oBYXGl8goQx65c/qHAKzHjXpG90ZYqESpETQnh5YHObaOSWZGy3Tt3Xl
	zm2hSHZqVEPLetn
X-Received: by 2002:a17:907:d92:b0:b93:758a:4487 with SMTP id a640c23a62f3a-b97118b1d1cmr229315366b.13.1773153175909;
        Tue, 10 Mar 2026 07:32:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef42a85sm512145966b.6.2026.03.10.07.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:32:55 -0700 (PDT)
Message-ID: <8855efd5-a53a-47fc-8708-4cd6d416e441@gmail.com>
Date: Tue, 10 Mar 2026 14:32:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 1/5] pretty.c: add %(count) and %(total) placeholders
To: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <cfed3bddf66ed2fab1f4da896759de1ba086578f.1772839973.git.mroik@delayed.space>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cfed3bddf66ed2fab1f4da896759de1ba086578f.1772839973.git.mroik@delayed.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2026 23:34, Mirko Faina wrote:
> diff --git a/pretty.c b/pretty.c
> index e0646bbc5d..e29bb8b877 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1549,6 +1549,21 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>   	if (!commit->object.parsed)
>   		parse_object(the_repository, &commit->object.oid);
>   
> +	if (starts_with(placeholder, "(count)")) {
> +		if (!c->pretty_ctx->rev)
> +			die(_("this format specifier can't be used with this command"));

 From the user's point of view it would be more helpful if this message 
told them which format specifier isn't supported

	die(_("%s is not supported by this command"), "%(count)");

Normally we do not add code that cannot be exercised so you may want to 
squash this change into a later patch that adds support and 
documentation for the new specifiers.

Thanks

Phillip

> +		strbuf_addf(sb, "%0*d", decimal_width(c->pretty_ctx->rev->total),
> +			    c->pretty_ctx->rev->nr);
> +		return 7;
> +	}
> +
> +	if (starts_with(placeholder, "(total)")) {
> +		if (!c->pretty_ctx->rev)
> +			die(_("this format specifier can't be used with this command"));
> +		strbuf_addf(sb, "%d", c->pretty_ctx->rev->total);
> +		return 7;
> +	}
> +
>   	switch (placeholder[0]) {
>   	case 'H':		/* commit hash */
>   		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));

