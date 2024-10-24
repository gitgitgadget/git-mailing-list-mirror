Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A8167D80
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767245; cv=none; b=Qm1gDzp7WmjEk3zssO/9qQBOzGFooPC21hb7EYocRd7WlTCyO9aB+X6botx0ClWvSfC2xbHRPFMjJ/cv1Z2Dmb8ElbmJZzRbpDfzjrzvmpHOwmXMnY/2VIitJOuVBlih5e2Ow9x8l22AN0T8aTgkCuD4rtrPNBy9stHOUzgKUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767245; c=relaxed/simple;
	bh=uqlshgltXFAQ19fLAHtDymk/RRdPM/F0J1TMQo2taHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3JG9xa6qAfMGWhEddpC5RqgAKqloiU5RScdslNUQli+N/+QIDALhXe4Dgwwg96ausC97uTyeKYs74Rta4PX7hXmhDTxs8WjQqUClz5NVVQG+Z6oqguFLcfwq3jfVZcOlmp2VJKOlyuIRdZhbqWU1VYsvVucrIGL1KbB2pve4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJeV2x+T; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJeV2x+T"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so3326988a12.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729767241; x=1730372041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86xIw2VVIyJL9GTMuyfy/TpQO2X8nZz9C3YInx5BVhc=;
        b=eJeV2x+To//YaGwhANSIjf+VTQuutnRXkMN7nfsZEZzRmZnLA2NQO8C2MrZ1yaf9ur
         lDB9rFoiNL4Ag/pF6ncV4OPlG+Je5+dAjzwi4X71eICsVvVp96tu4c8kWV854ew/ldkN
         2qixMq5ZQaAKp0apEgNkjRpk5VAZd3NEn+pG8M0ONJKid6XX9ULqIc4UNWMB8A6g0tSQ
         MItMee818aikuia8YzGucJB2Rf9dsTtuNG9fAicLh6eu8GXTm16FJJ77FEos0kfkHr28
         OC4Z/s+DPJECkY6WbYMl4TNexIbsMmmR8/684Q1wfiBrvGljsxx7Fba1Jj9uXnXG6cr9
         QRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767241; x=1730372041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86xIw2VVIyJL9GTMuyfy/TpQO2X8nZz9C3YInx5BVhc=;
        b=p8YWTd6QxKa611A3OdSi0ExAS6jC5XhZkWfHJAVUscM/AuSHrYUkRC/hrCLNLuVyEq
         5Mw0dKx1209ejicp1x8sCHlbiPzSgS0xOvT1aOQxHpHmUoD8sCv9g8ifKQ4Id+ahogew
         5e+UgDJFPpz2ENjy616ayOf5oPpszMK63K1VSkeJ0m7/z+4p0rOwROdN9IY2KEYRjrY4
         x2h705HVBJI5C+2luF1HkpqHxOBbKueF/S8WjXgsmMA47rxuHgXog6Q/SViXIeCb8qDO
         zyBqVEVgyFIFeHub0mTjA2nmE8kXscoWEoEMsxwylk9TMlIBNidtjPOccIdvRtMkq1fd
         RtKw==
X-Gm-Message-State: AOJu0Yxsi86kGQ5vLV9DGyJSWLN8PdO5QwGGVnNpqr6QZvjAbGEHS1YE
	gT655wRmCZEJBCho1qSavi2IaEOwtrMh2j/uOg9Pwbp5IXQHVs3GA3bKFGPO
X-Google-Smtp-Source: AGHT+IFejqxssJCN1AG7U/be07frOPMbLoqgVAFBhnFfNpMTYmvFnosgh/fB31KB35a0v+jTgIkOuQ==
X-Received: by 2002:a05:6402:5288:b0:5c9:7395:b9b6 with SMTP id 4fb4d7f45d1cf-5cba2110aa3mr1799604a12.16.1729767240807;
        Thu, 24 Oct 2024 03:54:00 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a4f0sm5603864a12.48.2024.10.24.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:54:00 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	me@ttaylorr.com,
	kristofferhaugsbakk@fastmail.com,
	jltobler@gmail.com
Subject: [PATCH v3] CodingGuidelines: discourage arbitrary suffixes in function names
Date: Thu, 24 Oct 2024 12:53:57 +0200
Message-ID: <20241024105357.2605168-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <https://lore.kernel.org/r/20241021124145.636561-1-karthik.188@gmail.com>
References: <https://lore.kernel.org/r/20241021124145.636561-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We often name functions with arbitrary suffixes like `_1` as an
extension of another existing function. This creates confusion and
doesn't provide good clarity into the functions purpose. Let's document
good function naming etiquette in our CodingGuidelines.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

I decided to send in a third version based on the feedback received from
Justin and Junio, this version is bit less aggressive and more hopeful.

 Documentation/CodingGuidelines | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 30fda4142c..87904791cb 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -621,6 +621,20 @@ For C programs:
     - `S_free()` releases a structure's contents and frees the
       structure.
 
+ - Function names should be clear and descriptive, accurately reflecting
+   their purpose or behavior. Arbitrary suffixes that do not add meaningful
+   context can lead to confusion, particularly for newcomers to the codebase.
+
+   Historically, the '_1' suffix has been used in situations where:
+
+   - A function handles one element among a group that requires similar
+     processing.
+   - A recursive function has been separated from its setup phase.
+
+   The '_1' suffix can be used as a concise way to indicate these specific
+   cases. However, it is recommended to find a more descriptive name wherever
+   possible to improve the readability and maintainability of the code.
+
 For Perl programs:
 
  - Most of the C guidelines above apply.

Range-diff against v2:
1:  dd556a8029 ! 1:  617b8831d3 CodingGuidelines: discourage arbitrary suffixes in function names
    @@ Documentation/CodingGuidelines: For C programs:
          - `S_free()` releases a structure's contents and frees the
            structure.
      
    -+ - Function names should be self-explanatory, clearly reflecting their
    -+   purpose or behavior.
    ++ - Function names should be clear and descriptive, accurately reflecting
    ++   their purpose or behavior. Arbitrary suffixes that do not add meaningful
    ++   context can lead to confusion, particularly for newcomers to the codebase.
     +
    -+   The '_1' suffix for function names has historically indicated:
    ++   Historically, the '_1' suffix has been used in situations where:
     +
    -+    - functions processing one of several elements that all need to be
    -+      handled similarly.
    ++   - A function handles one element among a group that requires similar
    ++     processing.
    ++   - A recursive function has been separated from its setup phase.
     +
    -+    - recursive functions that need to be separated from a setup stage.
    -+
    -+   To maintain clarity and avoid confusion, such arbitrary suffixes are
    -+   discouraged, as they provide no meaningful insight into the function's
    -+   role.
    -+
    -+To maintain clarity and avoid confusion,
    -+   arbitrary suffixes such as _1 are discouraged, as they provide no
    -+   meaningful insight into the function's role.
    ++   The '_1' suffix can be used as a concise way to indicate these specific
    ++   cases. However, it is recommended to find a more descriptive name wherever
    ++   possible to improve the readability and maintainability of the code.
     +
      For Perl programs:
      
-- 
2.47.0

