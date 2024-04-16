Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7B139D04
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308525; cv=none; b=lxH+gm+lqFP0pHabDWZZWnhwqo2+y3zufmxYPQFaagY4sh9hzm6apBaWXqiHBipwnFMcsUam3VU9NkOhASr2Tyhv2LtMJtQR/XfoMSCeioaL5WSME8UdGCzNMkjoAtQyVES7GbY9KjMAwXXtd+H+8up8OXcVCgEX59Ox41T4LDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308525; c=relaxed/simple;
	bh=/i06gN9JLo58SuBMM0MO5GoNa1bohi+U/TSGRMHyU4c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OU1WewNIDlJPTw6FGTOHD9R+icg3xC3iIMQ52JlOnzCHomqT70TJCEcgGiU8O6O5riYGWSbUzZHnp8S0O6h73Ip0QsmlU4uyQTBb2Pf6oz+NRBdU1J1qP/PUt4ji93F9RBn1uVYNISb1fgK6vgcUQmNiwEWiKNwThrhEkjjCW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lx+nqW1R; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lx+nqW1R"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41885eeb104so9624765e9.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308522; x=1713913322; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdXn5fyYAH0E/Lcv+UDT/JGyNE1XzO7g9pDM4UO1A3o=;
        b=Lx+nqW1RcOJkPT9bYuJWIajlab/5qQbaNtK5ABNQK5fsewNLjTczbGd3gPuKxUJ8W6
         JI+rfz+LL3GYX/qbFqwfzy2uwqtH3UAZszPy9r0sADwvCr4WTDLRnG7dY+sB34DfbXGH
         5bUk/52+XEcYvKCxBTfE2WGpCpF1ZljbrKCIO5bjkzAU3hF+lejqXvQM4nKTUWauaXyl
         NKE52HbtpyUQiLSoLX8r2GwcsojB53PATpvVtylwr/468YybNkoOaoqed+/6SsDIIBG3
         EpGK4Zjj6tRNtVLYoauHSBZ9+iQdlXgHTPpQ8JhzPrd3rJb2HnSJeYKCl2RsF1WJ5atK
         1e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308522; x=1713913322;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdXn5fyYAH0E/Lcv+UDT/JGyNE1XzO7g9pDM4UO1A3o=;
        b=pMqgsdP1d+Fu+M+J2iJccOHsKys+eS9lL8bfhu/31d0wlaKICOMvVyhd6mhMhd8Ldc
         QN8ejzVhGP79KrEwg7DaBobhJ/2urrkQQLbbHR6DleJwfQAeU8JqOfJCm9VSNj2oZTys
         aT9W3BoRmjn+cXDZF2O+dwhqQOkwD9cNBNDE4EzNa2SsLvg100imYe6Grv3/8+N32iTm
         RvrfcZV4iePLLebhhVlAqrLagMXVSV/LTRfq5LMPAPKus2UIiaZ//7vM4MWwKFXe+UZW
         jhZ2otLNkYSuDNCl8347iyU3Zz1YUh+UbWXDbmJMk1wNJ6uPMvteoPnC0PsZa2MAZeU3
         5rTg==
X-Gm-Message-State: AOJu0Yx8wZ5CbUvb7HBm+quUn7vy53WUFuvZufURgP0pAurfZv+L6c1I
	alJh/TOx5PggXkhKihsPzEHixFuwPydKuCR7Q6hS5QWwm/5CaRlO6B2DPw==
X-Google-Smtp-Source: AGHT+IFQ7c6HF4k7ei8rSnzAU/BS5TA1ida44aUXMy+7wuHLSuAqV99/WAobKFBR8AXfBFFHllFMbw==
X-Received: by 2002:a05:600c:46cc:b0:417:f5ab:cae with SMTP id q12-20020a05600c46cc00b00417f5ab0caemr10106903wmo.10.1713308521861;
        Tue, 16 Apr 2024 16:02:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c248700b0041668770f37sm392318wms.17.2024.04.16.16.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:02:00 -0700 (PDT)
Message-Id: <92d72a8a25a74c63fbd9736bbfe3c6b3618164cc.1713308518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
References: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:01:51 +0000
Subject: [PATCH v5 2/8] SubmittingPatches: clarify 'git-contacts' location
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
 Documentation/SubmittingPatches | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e734a3f0f17..0d4276c6c7e 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -493,9 +493,14 @@ security relevant should not be submitted to the public mailing list
 mentioned below, but should instead be sent privately to the Git
 Security mailing list{security-ml-ref}.
 
+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
+not part of the core `git` binary and must be called directly. Clone the Git +
+codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
+in your system).]
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

