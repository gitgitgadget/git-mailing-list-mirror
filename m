Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980B223DF1
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518168; cv=none; b=WwauKv2ojR2yaBHJZ/so91iuSoQ6dtlQNrsqur915GbbSVPXnko+vfa+XJyD0RrluQUG26j6ehHuPOrDQp/NvZxrHd1sJvNadeDW6fSR9zkPv7SG9HnWZxAvqxYTPtF8wDKOcNzzyaq5Vh9TFQ+de3po5duIH11HWNc7Qkf8OYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518168; c=relaxed/simple;
	bh=azLCRiK8stTCQMYGMNdVOhv/sghAv06f43lEVfOPEcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNu7BgcBkHrs+ujLNCUpVc3naTn9r0f8xlgNanmNGoOJjgBniTwvUih5nfxMKnztSUgA6IqgNUUJmLaF5SUrF4pSnNgzfh5Xb0lBRL1voqnviDLxzhsTQUkE9mf8sAq2gYCSLN6Ar/z/DJzKHBAa6pm8U6ym1V7beLJcioSHVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMLW0tGc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMLW0tGc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso38701055e9.2
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518165; x=1758122965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FSELYx5h1crfmjM5bUechM7dkRhzPd39AnEwyqXomG8=;
        b=bMLW0tGcBNGAK2IGeeKn6Z/zNPHXvcqEpIcXQdqKNq44UptfVBmbfQ0cX9H09FYX2n
         DcZq/m4tg3RgKIfgNkNoz/FskAyGcLKmXfXZinCGaic6MkXhEgax1AXF2gE6e8rSqYLw
         1pmKzQ5rxQ2i6845OiWMzNzpnDgXWMpn/lFmZFMSehkmH84B3xy9ONBl8fGLwON4lMab
         59LqpY/TSOknCas9KmxK6z516mjlJ44bpoWINd/qRrlCQNpRay1yprVJfRvjXG5E4CWR
         smmOzk0W44KpvLT0EWyBfBzvfY9s5r/9IZeGww3CJHwCMStQsCFsSW8FjWxfysvsZ/It
         u8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518165; x=1758122965;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSELYx5h1crfmjM5bUechM7dkRhzPd39AnEwyqXomG8=;
        b=cJRItHPQ1rBqMEe41Fc/ZCLhlJeJlRM88udhe89s20OafOFSLXH0nCDfiuErJigOvU
         gpsfx1IWtKKTYc6n3Nmy8GVa5ihVwoYQc3G9eOJTIU3AhfYlmt0IbnlPLBzudzxtr+i/
         jPEso7N1BD6i3xlyz4k6rW0n333/FYaZxhbL+ZQhi+1avddcZ2k7mQ9M1GDX7aom+zjg
         6jB64tb/3Rpw++FRRzEbjN3lqmMKg5Fp5LuJasdmXvOAFPxlaJ92kg68nJ8yRUX/eB5W
         7mdko78hrTMNhDQdIvdoOPnKEJxT+2ygU5zWrED3VbLa0gm6fnwD9YyJ8wa48VvNzrAQ
         ZB8A==
X-Gm-Message-State: AOJu0YyTBHDMHGCxTOjCCST8osrng1a+u733ANd7m3SvLolKs9qywx2F
	VhXfaIEpX4IGJITv2TFyrraZl71shL9ffscFOBfyp0VwQLXR+e/qc1kGBOELyQ==
X-Gm-Gg: ASbGnctf/YzQubvycBvDwJUmO8jOR1h/FXfXpczjoPYHjoCFtCNlTqJtx1QnS4Tq8V2
	OufCYGiOgQje9K71AoVWhDD4mGI6c4L1l2ShzrdPcMjx53uJb+djjYag9NFeZ8+y93QvVAI67Lh
	i3gUxpYWQJQmRJ0ZHut1yNG8SpAgUnhtE4FfsYl/C5KaXqkiqkHdkw38MI8f6+tUPt22FsH0mPX
	6DgtJcs/ssxdLDn1nYSxsnBKP5bq/pvohpJcbwo2a/s5+f3fP3gr9mqola73zh0nt01kkH4xhwj
	sHvGLg0MOI9/gIfmx37GH53nwgs+z9L3zukwvZ6p0gvensq99U3v3yZE2kDXSgTDtNwGsoq/MI3
	I6EPgily0p3LfolnIWESpu/budhIFy6R0nT2vsj4a259sD4KoExB37q2gDTyQ6SXAdw==
X-Google-Smtp-Source: AGHT+IErtfy8DTksC6NWZWh9Gv6aFpH8V8W62erJCaoEFYMJZuO+tcEZvGZDN/YTE7oY5g6/84yLGg==
X-Received: by 2002:a05:6000:2f84:b0:3e3:4863:5dfa with SMTP id ffacd0b85a97d-3e641f3154cmr12192512f8f.1.1757518164462;
        Wed, 10 Sep 2025 08:29:24 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f188sm7137107f8f.48.2025.09.10.08.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:29:24 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 3/4] t9902: switch default branch name to main
Date: Wed, 10 Sep 2025 16:29:02 +0100
Message-ID: <8e32712a158210c9e8c3462275348ead9660ceb9.1757518141.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1757518141.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk> <cover.1757518141.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Remove the penultimate use of "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
master" in our test suite. We have slowly been removing these ever
since we started to switch the default branch name used in tests to
"main".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6650d33fba6..964e1f15693 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -11,9 +11,9 @@ test_description='test bash completion'
 # untraceable with such ancient Bash versions.
 test_untraceable=UnfortunatelyYes
 
-# Override environment and always use master for the default initial branch
+# Override environment and always use main for the default initial branch
 # name for these tests, so that rev completion candidates are as expected.
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-bash.sh
@@ -1453,7 +1453,7 @@ test_expect_success 'git bisect - start subcommand arguments before double-dash
 		HEAD Z
 		final Z
 		initial Z
-		master Z
+		main Z
 		EOF
 	)
 '
-- 
2.49.0.897.gfad3eb7d210

