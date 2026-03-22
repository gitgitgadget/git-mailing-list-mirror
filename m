Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373840DFC5
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774220496; cv=none; b=uusQ77ZSf3rCVER9yaVVZnlYbzupAqekWLyGDLFjkL7RsLmDKymHv7pQtfCF7nLcgfEhsgxReBiSlwBn775mZm8F+yh6m2iysRBMmnpI+zcPlzZi3SmOyGk4darrnK5G6QYlV4giY5hR0u5gHotAF+ZurxzXNJPQOQkWZ9N/6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774220496; c=relaxed/simple;
	bh=za27Jo5/DR9LESN8yC/+S63qC9WAeIVjHzzLinD8GQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o10PrIWUJ3CV7I4T5Bu2b02yQ+vN5E4rp2pjtOMWh92rsctNFRVG9DzKSYa2R9VAjJiYziUdlbwe2LhvqRWND0DzV+N4KupelC0eddg3HWl9hslrhWWyzibBGFoh9GkqhlYTz1QSlm2x8Ennx00gGkNlGiZxjHDRdK379yAWV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaubgxiB; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaubgxiB"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899fc265126so50254726d6.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774220494; x=1774825294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8Ui5lK0gvlUva80Sw4LVsA9fcA50jkKrRxsdqCY918=;
        b=jaubgxiBEc8pSnAwj5Oy/o28MYtkTQc5iSEQIbXvBZzob23jAfDnYr2lUkhTrzED1z
         ZDvynT7xxeMgUfll7CNcrQmiL2V/GSYX5n49ZrxHV6xQEqyoFEIlwlDAf+VxyYXK94l3
         k8ppSiSqMU8wNFPsup6yAvLwCLEKPn3vDGiMIIq2lGnDR4gQsatzJBTD8BDhkJCEfonO
         +8tzXVppoxVD1aikJS3K/rS01AQv9+ewWThCup5xiZ38btRIRGiiRt5KzSoxMY2QZbJf
         EQxRXTziDIu0cCW41XueqqYmLuh5NL4GXSo62I09ac6OTpjwzo3vEzltoBa4qfRmIRGD
         uQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774220494; x=1774825294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8Ui5lK0gvlUva80Sw4LVsA9fcA50jkKrRxsdqCY918=;
        b=rYVSHaX04RvMGrvAJFZZm+yRThf8KVTkpjWOeq/Smb3bmM3RyyHA4F+0NNaAm9cbEx
         0sYkftfUd5B2wbk7R8MpDnsPgOBgxC4+5rAaXz1JeTQCazAkEKyjvb+cbpOiErP6Ko8g
         7oEFDEvObs1DWYjPNGKYF1XM5EBd6uqNmodblU2cXNsgdl11wgIvYqoc6N8oourXmcHV
         scagwh72Pw1PozgbG1CKnsHcCSkrS881C0UqFnZiAOnqO7LdwpULsBfoiH6g9FpVUXKg
         h0jHkWble3Cs49Dg4GVvoAWpSvP6qItO1ETD04UwEImpn+jHV9CpNDVOkxOvZh+asHZg
         DCiA==
X-Forwarded-Encrypted: i=1; AJvYcCV6/w2yu1mXXsDuQKAv4bxgczb6ThJiqO4z22bkA0UYhdsanRDsXO38Gn0tM/kTedQ+RF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKLyNn8ra95WIWTOa/totAj+mD4iOcDSvLeREA3YgQLxfPRkY
	nowt1IEPAy7kUPIQiEWsC9J1NJOvYCwljyXjPuhgUhN7t2q/QNDQM+vKst8sHA==
X-Gm-Gg: ATEYQzzjO4TbHHeKfAd9TfYZZEw2z6mmVyM6jXGK0xrQvdS71AXhE3UMJVrX61CJMWI
	AIlNsoVEehpZWi18Dgk5vZDIWBGNkqtsFSaXicPBZr4SGpbwxazyCE6qdnRiAK93YLD4zcXQBtn
	jj/IFYaMjIGM+yIx7l63YkE51YZKd1txOS8hK7lh7yLGAGYiuKz06pwkeqXMlB9tD0S7haGhlwg
	PC9Gc9aiSEgU/5W8+Jy50ZHJHCFktVAMZ7Rc4JdmumA5ATsYlBgSepVUz771+Y0c6LcMMQ9sjYA
	aY7uQ7/JQNC7CeSBhsEKN/HuXD7ubf66XcSETQtXDaysi62gDW/jxIN1z7FeFYDPcvpdQQ5x6Ob
	y6d+6uI54vHs/76DiV38Ut7AY1SyC+zhNeLBvOosJHBDMavKe2e7z7ZUXQZZsbB+M0E2qYAxadN
	M8Y1+i3Emoox9NIDjb+xQJqJ5wMWZP6teEBAwcys8aYw08HNTLyTlNhBuQDu+uGPfqYReynedcq
	xs6WlO0bf29cp13MwNa7TdHUQWRCXB4x8l1VnVjY+asIFvTiBgeGbBxFtzyXw==
X-Received: by 2002:a05:6214:3a86:b0:899:ea9e:31c2 with SMTP id 6a1803df08f44-89c85ab2286mr166304876d6.58.1774220494406;
        Sun, 22 Mar 2026 16:01:34 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c? ([2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85379401sm73583796d6.46.2026.03.22.16.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 16:01:33 -0700 (PDT)
Message-ID: <d8e6f854-e838-439f-bc5a-27cbb4091e4f@gmail.com>
Date: Sun, 22 Mar 2026 19:01:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] backfill: handle unexpected arguments
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <xmqqfr5sacps.fsf@gitster.g>
 <20260322053207.60992-1-r.siddharth.shrimali@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260322053207.60992-1-r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/26 1:32 AM, Siddharth Shrimali wrote:
> git backfill takes no non-option arguments. However, if extra
> arguments are passed with git backfill, parse_options() leaves
> them in argc and the command ignores them silently, giving the
> user no indication that something is wrong.

> @@ -135,6 +135,11 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>   
>   	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
>   			     0);
> +	
> +	if (argc) {
> +		error(_("unknown argument '%s'"), argv[0]);
> +		usage(builtin_backfill_usage[0]);
> +	}

Before we get too far into this: How does this interact with
the ongoing change to introduce revision arguments to 'git
backfill' [1]? I suppose that the important bit would be that
we still parse arguments using the revision walk machinery at
some point, but it would be difficult to guarantee that when
working on a patch disconnected from that series.

[1] https://lore.kernel.org/git/pull.2070.git.1773707361.gitgitgadget@gmail.com/

Thanks,
-Stolee

