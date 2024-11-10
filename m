Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA122744E
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731249733; cv=none; b=LhvA1+RR7vEAB/6iyf7jd6VlVpv7zXoCbZ73uSNYZ8DkDSvlln7ej1vAYGlOmNDfkxi5KGbXoXpIKD5Z259I9u5nl/RFGmVAEoE51ubyP03o4n2yQwwBdD+s5Z+AzBx5ao+5mj8wtLxVvRZRLkUZYNu7wInYjqALI2LiOigEai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731249733; c=relaxed/simple;
	bh=GzviRl2Eji0ULHyrESBNwGIQx4MRQNBt81lXcDoRvw4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qSMVwA+AFDhcb2sHEknrAfJPXbx39ln84bwdVAZoJwrtfGZTUicTEHlf+WY3VHjQQqDP53OMDMMRpMb9AHOPiuY2L9mYzQOtGyO/cas73lAq34uPnXIe2kztKBDEYnO9F+uoGnEAM+uqXDT4v0SvPG1xDm5B2z95SRcPZ+O4oYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSv3Vt6y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSv3Vt6y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431616c23b5so21023615e9.0
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 06:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731249730; x=1731854530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRJpwdhsrlR/AjpkXOf4bo21pEi7Gz9OmtRQSiAffig=;
        b=VSv3Vt6yR5BOSy3dKxZUw1D38HTsRhdSh9T9TLyKqjRlV310gh2atJBG3ByxYyjsMx
         K8M4moSBC1D1hiRM+j9kMWYhVWx6ZdyZxdlmIaleQzeGpVMHTdaaZnzmr0fcdjlYbGNI
         w9xCs23sOSFr1lacC86L9vekq7jI4m7EqCnLbzXwM9Q+Yv0v+VSaPvMa34mKNKst5qCR
         v+L3/UfuRQ671rNeqVKMGacnXVvOJ/ZZJXCLzTeMXCV61N1EdyCwyUVYT2ABLssZp/p+
         FFfVf6Yodz3wNS8mXowDNz535vsRorFXlgh00IEuUEwJW/JbhduGmwTSxMRtg5YAoDaw
         8mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731249730; x=1731854530;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRJpwdhsrlR/AjpkXOf4bo21pEi7Gz9OmtRQSiAffig=;
        b=j8Y3O8gaB7U9jYA50D+0409ZYyh5SzNbS3UBL+On5OqqGxUryQTu9ZO85r5heUP081
         Pe1vvB/NOPkurd9Uk4hYyLpN0REPEonDguIGwM+TelzRwgW0NRXameyYvGvx7ekVGnbb
         OYHyISn0wwobCKjV7EvhCzcx2PZ2VwLdFbK49RLf1c6dpFps6ZTfDYQ8idEzk6lCoTc6
         XGSoAoOR5ZS4cuZyiMQGFBrJYPAAu6Q929ZP5dWA9hmZytTLty/GJ6WjcMJ7ysZVCxBx
         F6R2TdC+UVht50Ud45E4Nn/UMyYvRe16CCXJXu6WWA5/XF71qPDEk5jxRZZXlFAhbWie
         Se5w==
X-Forwarded-Encrypted: i=1; AJvYcCWxKUZvlLRBqXiOw7F9LyYCSCgnP50BLJbCrJvSvS3C5tBZuxxTHpWzj0Wkxes7lEcKPZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWge5fGl4MfULvOck7vtQU55w3bjS7WsSm/QFbkr3Y4G0JDt9c
	kOKrCbmSGThS56nYJYhh1Ga+QrsgD1D6ijg/K9RvM7n8XQemvid8
X-Google-Smtp-Source: AGHT+IHw/zUR3bE+/IkguFOz+gxUp7PM4C2tjRb/UMYFaIb/7N2/ObyfDy80J3gWxlcQPvlvs4Yeaw==
X-Received: by 2002:a05:600c:501e:b0:42c:b98d:b993 with SMTP id 5b1f17b1804b1-432b74357b7mr82595795e9.2.1731249729912;
        Sun, 10 Nov 2024 06:42:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0530694sm146947065e9.7.2024.11.10.06.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 06:42:08 -0800 (PST)
Message-ID: <9d807eeb-db00-4d17-b909-b73944cff2c6@gmail.com>
Date: Sun, 10 Nov 2024 14:42:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v4 06/19] Makefile: extract script to massage Shell
 scripts
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
 <2cf8cf86218e0cb1f3477897cb3d0be950d452ac.1729771605.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <2cf8cf86218e0cb1f3477897cb3d0be950d452ac.1729771605.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 24/10/2024 13:40, Patrick Steinhardt wrote:
> 
> +	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${shell_gen_path}
> +		COMMAND ${CMAKE_SOURCE_DIR}/generate-script.sh

Same comments as the other patch - this need ${SH_EXE} as the command name

> @@ -1156,6 +1160,10 @@ string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_optio
>   string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
>   string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
>   string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
> +string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" git_build_options "${git_build_options}")
> +string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
> +string(REPLACE "@LOCALEDIR@" "LOCALEDIR" git_build_options "${git_build_options}")

s/"LOCALEDIR"/"${LOCALEDIR}"/

Best Wishes

Phillip

