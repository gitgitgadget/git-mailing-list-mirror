Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0352199E87
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477132; cv=none; b=YR5Df3slTO+nYFR+0zAIqS0gJ2xiLdB0E1706/daa5HDW99IG/fIIDpksugPq0AnIKwDiIrR8WBgc4h3nOKqbrpYJWZ+34sRGN6P3RTDHVZ4Tweg1SAB6/uxrwfoFHW4A5NLZFMoffSRX5xnVEn5xH5d2B1C4rq/01z2CNIivaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477132; c=relaxed/simple;
	bh=Go1i3gWV7ueko/MvAzRoptBPHsEqivRITvJiUj0BCJs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t0W0wSLi1RJJQPV0qn+I7xC9MoPzoCu0/kjuqcvmoj3gueESMXuV3ZFSXiN5UBDWaB3vq/dQeujYwPfCTt3Dq5GcOnDmWNzd/FI9HWovIH9Kz6z1dbRhMBKenyh5jwUuJ5XugPbjzDwFn4p9n998yMXTtsLSPhOxAIPIUwYAxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmDVvb7G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmDVvb7G"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41551639550so9707845e9.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477129; x=1714081929; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1QFBaAsqZYFIx/JQD0X57hfvYi+kiS0nMiL94V0cwk=;
        b=TmDVvb7G3rYS1GMpwC8lxikP8KUnwuNbAoC5MeejeEhMEMc/jR99+Uz9Vszf80/xLw
         owcO5Vpg+xxEVghRRI5ohUI8vTYOXMgJVPFY2QXfxeWw4BaOrdoYyQPzi8n+ctd7vxae
         Bw8Y1MH3eEj/houKUo9uAqdfuTSrD+1pTCu18emJ8C0iLCFfvfi27VsuqTDf+V7h9mN1
         jrOXcJy/GR5+hScB9E1qPpYeAJBpOh54E1q84Gci0okk/l8gJ2rLva5TTEE7mU7Z178l
         rS+STpqcw6KUKhW22aVsh+smhm96l4hLNU/F2w8jPFhxm53aVobcvwlyIO29oDFsEQu1
         MXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477129; x=1714081929;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1QFBaAsqZYFIx/JQD0X57hfvYi+kiS0nMiL94V0cwk=;
        b=WG15eGsuhXB3j2bG2S3vl6hIIssL7LueMH8CfPZoFmhV6FZK1yvvpFW4kEVLL7g+OJ
         bZLcXXBhMMRPwNKPXp1PkMQVBzNEjG2/bhg+GjzBIJ4/sY39SFExnENl4amQ4QBYVGnE
         cwd4WD11o2OIzphGdndMmLeWfVVHmJDZ1rHOtoUDfaXmFYkU9uM5CatMQY/gB0JqpYM7
         GvKAMLBie2qd26r0S6NSCr8jWjxH1OX1KSCoR/wEuQ5hD09XuL1ZF3sIpwxwPL/udWf4
         xQMMEXRY4FYXYyEKDA84oFZCUb8+8AYYrnpQrHxpWe1RUabsZs1XSwJprPQb1753vAAQ
         VQ0w==
X-Gm-Message-State: AOJu0YwMWoabahkVNmxu3OL8jP+8+61SzOxngLJG7N6uldPC3k3lZOEx
	wOW0fVpE8u4wXoOJixLcgFfdBddk5z3XHzTMTfn05cT8majF+mEYqD3bGQ==
X-Google-Smtp-Source: AGHT+IHRaiBbMaMC5wjrILKCjGMS5ArK5JGTzOlaBSiBnJaslJGw8c6J+hPaPjnPx1LerMSHtSSXxQ==
X-Received: by 2002:a05:600c:215:b0:418:fa37:60c0 with SMTP id 21-20020a05600c021500b00418fa3760c0mr106024wmi.22.1713477128833;
        Thu, 18 Apr 2024 14:52:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020adff592000000b00343a0e2375esm2768455wro.27.2024.04.18.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:08 -0700 (PDT)
Message-Id: <f26f0695f404f242611e23f645a15af85d72d953.1713477125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
	<pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 21:51:59 +0000
Subject: [PATCH v6 2/8] SubmittingPatches: clarify 'git-contacts' location
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Use a dash ("git-contacts", not "git contacts") because the script is
not installed as part of "git" toolset. This also puts the script on
one line, which should make it easier to grep for with a loose search
query, such as

    $ git grep git.contacts Documentation

Also add a footnote to describe where the script is located, to help
readers who may not be familiar with such "contrib" scripts (and how
they are not accessible with the usual "git <subcommand>" syntax).

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e734a3f0f17..d4173d4fe84 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -493,9 +493,13 @@ security relevant should not be submitted to the public mailing list
 mentioned below, but should instead be sent privately to the Git
 Security mailing list{security-ml-ref}.
 
+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
+not part of the core `git` binary and must be called directly. Clone the Git +
+codebase and run `perl contrib/contacts/git-contacts`.]
+
 Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the `git
-contacts` command in `contrib/contacts/` can help to
+people who are involved in the area you are touching (the `git-contacts`
+script in `contrib/contacts/`{contrib-scripts} can help to
 identify them), to solicit comments and reviews.  Also, when you made
 trial merges of your topic to `next` and `seen`, you may have noticed
 work by others conflicting with your changes.  There is a good possibility
-- 
gitgitgadget

