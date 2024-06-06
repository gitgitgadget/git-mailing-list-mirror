Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73F266AB
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694661; cv=none; b=EqoJ0AlEK/AycLjKYSsRu3vuOkQT3QmK1vHH3QKNN/65uNv/wyTPec7SryhzdI0ijwwS0YEOnFnNT5Vhn6w2/OuZn7PzLNHzX6SjX5yZ75ZwywFmm4XfsVFBjCPTfa66GjzFflYTtGaqB6uRZZGoyXDHhgsCgRxGNhuVB9c96yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694661; c=relaxed/simple;
	bh=BbxSZDUca9hh6FjeqMcGZ7ZqWnyZHzTIvwLr94Wkiqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fn3mBJ1ZJ6eA+D6WS7kpznA4L7aEH2iqg649+hp2jCCdw2JCrnmyPo01CC1lI770QXyDhzLwDPiKXv0kH6E/TXmLbcEdAzPA8oFB1K7T5Nv+36oCdnbYu/Uqu0JCz9nTl353ykf3eLnV4il6csVvjSZaM9dfe1y9BA+6rqKeubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7k64Hju; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7k64Hju"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6c7cded01so4548325ad.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694660; x=1718299460; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LC/ya1bckeaM7AXf2xVxymalhs/ThMlwQMrh82w0Q8A=;
        b=J7k64Hju7IPzlunh2+HMDUg5bNUpP3Y9Byo6jMstcl6XzoHDqlk+tkeZ4ds/NBwDZa
         U8cqoAZf6kO9jemzWSHHyNfdFTtYvFbY4iDPbIBT53PzjcRHMNgM+v17fSnqEureqt5s
         zLPDqAV0WyLVxYwsiHzaYoRPrtBGm83OoKBAcMWSYC0x7EKF/Nx+svMstFBCtkoAtf4T
         YXtLnxDRfWqHy2kXESMbt7nJhkjf/rE2AFQ0JkwsZ+W3d94QVGoz6QMCs2sKBXGKqjgm
         23oh/d39PS/CmOBVL0Kd19LllckLzy9iOuVpEHGE19G5cm5FmNbvWcLD1qyfhGPMmmrn
         HSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694660; x=1718299460;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LC/ya1bckeaM7AXf2xVxymalhs/ThMlwQMrh82w0Q8A=;
        b=gm63FGmua/+SdJ9CwGU81C80ckgIykg+Zn6WdGzJ928Xb9b/qZqdR9DZYnZdufu24T
         NjEz54b0Bp6qb7BvF9FC3HDqL1Ah3445vOncnQvp6Uso519rkIRZqfY4gne3iKDyNgfP
         aa//o8RoGM49lzhWdS6JmM0vkpV0DP2l4FMJR+gp147ov6zR9eJ75sJfsWEL5xIIwn6D
         gBP9rCnHr89RiekO/HbpLxKwApOpHmGMabzDqqyq6H1CJR7vpg8BTj2KBg0OxbOIp3Zk
         9TQBMYLj0MJh6K6hRP/W72W0sJr33qwO7R9U5Bop2h7fvart/9KkMkeS0CGTkdp3NhN1
         t7DA==
X-Gm-Message-State: AOJu0YxzWWZ/jBANTuFKrckcPvF2h62PY7zuW3dNm1qZ1yVRx55WoB30
	Wc6EZw7TutxaXLYGqvxL3iGJwxd7Tz0Mr3l3e7qi4HPCrs+e51+g
X-Google-Smtp-Source: AGHT+IF8aGZBYMWlhh20C+umIOHeGxet3tXe4Jbgrix/BgvOeCeFWiS3IblsNGCHrSnqhJ6HB+xTSA==
X-Received: by 2002:a17:902:f541:b0:1f6:18f9:b764 with SMTP id d9443c01a7336-1f6d02f1b80mr3333445ad.30.1717694659617;
        Thu, 06 Jun 2024 10:24:19 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e0647sm17816275ad.196.2024.06.06.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:24:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Philip <philip.c.peterson@gmail.com>
Subject: Re: [PATCH v2] apply: add unit tests for parse_range
In-Reply-To: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>
	(Philip Peterson via GitGitGadget's message of "Sun, 26 May 2024
	07:54:33 +0000")
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
	<pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>
Date: Thu, 06 Jun 2024 10:24:18 -0700
Message-ID: <xmqqle3im1bx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philip Peterson <philip.c.peterson@gmail.com>
>
> Also rename parse_range to parse_fragment_range for external linkage.
>
> Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
> ---

This version saw no reviews (unfortunately).

I just gave another quick glance, did not spot anything glaringly
wrong, and the way the tests are organized as a series of ...

> +	TEST(setup_static((struct test_case) {
> +		.line = "@@ -4,4",
> +		.offset = -1,
> +		.expect_suffix = " +",
> +		.expect_result = FAILURE,
> +		.expect_p1 = 9999,
> +		.expect_p2 = 9999
> +	}), "negative offset");

... rather pleasant to read.  I'd admit that it does not count as a
proper review, though.

Thanks.



