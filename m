Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38F15AF8
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAwhVxJb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336755f1688so4456724f8f.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 04:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704975661; x=1705580461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORAwadX6d0AZai+gYLbTc/tLXocsrUXzz+ytEdKN0KY=;
        b=IAwhVxJbXhxmMZlrbvumAO1xzY0XN0HRbgoSOoAzymy5WxSQslZdQAFBhb/fcRaGVs
         vifA13Gk+zmFuPynjzuAc8FLC17iEpAsxVtbYyymbgo8dUfVHfrQ/QDa+sEkJL3evrER
         7E4xpT0Txh57hDd1wvF9k5ujvcpMTtO7+29vj6tqVz9o6Gd0NGLd/oDWixAY71yvdJr1
         utIEzQbyk8I77Myp0fVX49OWLuny3SadvwXh8bv6xe7/0Y1L7RG7Si9i5ehr1TbI5+oq
         KV6T6x3S2etpkoRycphEdch0ssoTTxZ6KDawnG7I7proP6HtCR98T2pxyi218qXnEVRr
         eSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704975661; x=1705580461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORAwadX6d0AZai+gYLbTc/tLXocsrUXzz+ytEdKN0KY=;
        b=KYyHdNPIRbmaVXvQ0mUr7dFdJ47GA2NqAUff0AWkDggxJuncYp7Kv7n1b5vAQqZWuh
         VpGs6m5ME89iiiPFyDH3VQ/NPSVIBGX4xUGOQ/U5/PAnKSYuG96C0DtYus3L0EdJ13r4
         x6QxmKCEsriaDk6Hdbynqd2vC1BuXt1wa3a/YcpHJTRumfCNmJfc95YVFdGax6/YB8yl
         eEOAZK+dQblJmkh0U80hEeq7rayVQZ4ZP4CAlDJAA1bBrL+TLMbobyXhDrSVra5cBZMM
         KpU6NYWRVO/mxflqHZ5rmV7CK4oibQl8FmCHn/pq5W3uTUbtW6GxrE2Q3frdV4UBLlQt
         MTyw==
X-Gm-Message-State: AOJu0YytROYBlPVOFsrJE4V6XISHHYWTvMxm9fo5WRvK+v/o1RtF1TsO
	Txzn8Q22oYHYNBVooZeK+4THqAMBfXA=
X-Google-Smtp-Source: AGHT+IEHmo7niD/y4PLOQYxujnjNvg9L13zaAqA/5rZ2ouXQVAUgRYrRSBNUGacSHm07AN4UVdt9Mw==
X-Received: by 2002:adf:a3d9:0:b0:336:6dba:e092 with SMTP id m25-20020adfa3d9000000b003366dbae092mr609670wrb.3.1704975661048;
        Thu, 11 Jan 2024 04:21:01 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id u17-20020adfed51000000b00336673a4153sm1089559wro.80.2024.01.11.04.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 04:21:00 -0800 (PST)
Message-ID: <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
Date: Thu, 11 Jan 2024 13:20:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/3] branch: error description when deleting a not fully
 merged branch
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
Content-Language: en-US
In-Reply-To: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The error message we show when the user tries to delete a not fully
merged branch describes the error and gives a hint to the user:

	error: the branch 'foo' is not fully merged.
	If you are sure you want to delete it, run 'git branch -D foo'.

Let's move the hint part so that it is displayed using the advice
machinery:

	error: the branch 'foo' is not fully merged
	hint: If you are sure you want to delete it, run 'git branch -D foo'
	hint: Disable this message with "git config advice.forceDeleteBranch false"

Rubén Justo (3):
  advice: sort the advice related lists
  advice: fix an unexpected leading space
  branch: make the advice to force-deleting a conditional one

 Documentation/config/advice.txt | 157 ++++++++++++++++----------------
 advice.c                        |  14 ++-
 advice.h                        |  15 +--
 builtin/branch.c                |   8 +-
 4 files changed, 99 insertions(+), 95 deletions(-)

-- 
2.42.0

