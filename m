Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E110A1F
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587659; cv=none; b=hfERhAdjBIcLwg7AdyrfOpvUGwFI0/8nxroLfQ1yCUKmpw8fZ+9yixrpzciJplPX5S43m4HaG0IykkFfvYKCQq2wD2CsjLQI9AFvRGYVuDF0l1TJ7VVbfWG9UOcAzB6NbUXUyqHYsICO3U53g61Y3LNlL5bW0hNz1TAQWqzsHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587659; c=relaxed/simple;
	bh=Ld3CoMhl4OxvWO6FFbAz4y0V4VhxP/HfLkHwglz+Ais=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nsgLbJ1qNRl4s0+A5DYvd2mIb3ST0xsF15I0LrDqFLmV3PEQA2iTupNvuecNNzDCgwIQUVOmyFzsnIeWT7KMGFtnWNQq4Spt3wVWxd+GzPFjC4A6Y76gV0bg86tCCti27hAK+Nl5jv6QPd0z9N8QFo8ZPQjcqRDgA/4F0gYTanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXeqzyTh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXeqzyTh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso2874134a91.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 13:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709587657; x=1710192457; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y/SXSKaVbmTIxt3Gw2elq6zog9L5ot1c/FErO3mhRo=;
        b=GXeqzyThYyZ4AhAkAxDmzvbplI2UZj2xAdqTzRxrTiUhcQGWg94KexioHayzcXYCOZ
         I0dkmTJLRyAucK8rsHsOb9gfCpLiMxft1GiM/UdwPHP0HV6sHtCbxbC4FVUhQPOj83wz
         CxJseuHNP5j9yZVnmCBwcMxz1Ox1yUkFdSAWu0BqqsoMet2gGGYLaRFhQyJEp9U+6Qk/
         JKuWCsAdtyNl6CIoBhM52Uvh6YSsCHY242x36u5KZpVhyUBbiE5b/3x4yLd2JNpd35IO
         YLOuq9WRRvUsEF6wM53/WPo8N7io6is1rYbwHg7BuEOZhH5+Pp7l6OyzwWXkaQAIQs7c
         fzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587657; x=1710192457;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Y/SXSKaVbmTIxt3Gw2elq6zog9L5ot1c/FErO3mhRo=;
        b=ZH4Ip6q2YAzbuCem4zEd68pZ1gEvQdKt7eX6b0Pg6RaciDpgTNa5ujqz/ZDFJpJFsL
         Uto+KWBhHVOu7Ssr4R0C4rWPz2jQ8K4y6e3Xky5eJ7Gix8ZQzlKR+cW9IkUWBMDJxj23
         MjRCIp3PGqvW63NGAKExUwUST9KgtFWfWQdl11PTIp4sbA7yblCYaPw4Pq8iebOdrhen
         ndUwrFdiCGN/O7A1P/lONUdkaJ1caYo0QSs/uGI0jtwfn+BFnxVcl/BS4E8Qxu/31vGF
         QcH0zz5H0ZVBr23TtboILGtmju8UAZQdASf3qae0uPTbksMd2k0KJDZSmEgWJltvX+Wr
         XvMg==
X-Forwarded-Encrypted: i=1; AJvYcCX6JvDZm2mCG0RZfcsC5haSx0xuAw1VuCF9CEz0yt0Vdy5KIrqpzL4TwQ8SmbkReJQthOnuQhmCMGE0tM83W606xu1T
X-Gm-Message-State: AOJu0YyxEpWEobH77TdgDXw+9+5JJU2Q3kBL6sht4CMhB+2Itb0iwMEF
	k44fUFCMa7XLJxZJP2sYJ1aYP342dIfkvrBZKWhVd/mawdKUEBXS
X-Google-Smtp-Source: AGHT+IFazHmOASOtzzCp9/+IoqD6QdnXeFkAEjaodwiEgiApYuFu0gZaCYt6YV8973rj9YP4TPUWRA==
X-Received: by 2002:a17:90a:f2c9:b0:29a:d44d:4231 with SMTP id gt9-20020a17090af2c900b0029ad44d4231mr7080949pjb.4.1709587657152;
        Mon, 04 Mar 2024 13:27:37 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id u19-20020a17090a891300b00299f727f7a5sm8253955pjn.46.2024.03.04.13.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 13:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 02:57:32 +0530
Message-Id: <CZLA8TF4XG5S.KU06P62V03TV@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <christian.couder@gmail.com>, <git@vger.kernel.org>,
 <johannes.schindelin@gmx.de>, <newren@gmail.com>
Subject: Re: [PATCH v2] setup: remove unnecessary variable
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240229134114.285393-2-shyamthakkar001@gmail.com>
 <20240304151811.511780-1-shyamthakkar001@gmail.com>
 <xmqqjzmhq2vb.fsf@gitster.g>
In-Reply-To: <xmqqjzmhq2vb.fsf@gitster.g>

On Mon Mar 4, 2024 at 11:46 PM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> > -
> > -test_expect_success 'template can set core.bare but overridden by comm=
and line' '
> > -	test_when_finished "rm -rf subdir" &&
> > -	test_when_finished "rm -rf templates" &&
> > -	test_config core.bare true &&
> > -	umask 0022 &&
> > -	mkdir -p templates/ &&
> > -	cp .git/config templates/config &&
> > -	git init --no-bare --template=3Dtemplates subdir &&
> > -	test_path_exists subdir/.git/HEAD
> > -'
>
> This removal is a bit unexpected.  Is it because we established with
> the previous test that core.bare in the template should not affect
> the outcome, so this is not worth testing?

Yes, in the previous testcase we determined that template cannot set
core.bare. Therefore, this testcase would be like testing
--bare/--no-bare option, which is already done in 0001-init.sh and
t5601-clone.sh. However, I don't have strong opinion on this. I can add
it back if you think it is worth it.

Thanks.
