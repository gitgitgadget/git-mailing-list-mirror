Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F31CD1EE
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220969; cv=none; b=YFt9k797s4KTEDTRAaEvK7ggirdN8+O4BNxUEkDyBmPmZrD/IOllUAWrdJp1snDjkfB4Q1LYyUl0BJZjz1zTL8CU2L+OfKSxz8wKkCe7Q9WjMvOiukqW5m/gNwTjGTs/j3u+DiF5WDD4wxl4Ay0Q5PrTYa2flhyYGjaFSv6Obj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220969; c=relaxed/simple;
	bh=aCQC+zcdgrPqDTIx7IQGUX/IphV3zmuEqNwR5gEJUgo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JZqXGLPCLYM7FCcCnANoFbGWBbcOFhG1FhUYzfHgapR+R6oh/XW0I33MOwklOy9Y/ZRDldp+VsOBOxgUOTMiccM985cDG+QmAD04Dg+jc+AsDbgKytNLXo6HX9U7YSal+w+p9vemaRTZST0g+HA7OEGAp2uh1+ktHqnvhz8IQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SnxX9jg7; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SnxX9jg7"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6eeb741c26eso14657497b3.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732220966; x=1732825766; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91YQYNqDCCw0Vf6dhkAR7qS/fOK/HJd+8YdWLuIKFAs=;
        b=SnxX9jg71QEpQ22du7XFhzjOCRghOgDYcepYRIvjEVzRu9lpvSR7hGqoYpKXoDslYd
         Sq7EeXMOmpaEeWhS2LgyLQ864BClgrFiIeKEndLB40c5CWvQ9ciCjqysisziR/icSU8q
         AGsdlNf/5LN1nnhCjwQ1xklWxwK76tq4/zQoDCP6WMxSpNusii+KhLGiN76WLrrFoGxF
         M2t9l1XxbOlCKuBDhornx2DLtBTYiKS1p+plEGoFAbpR5QjmBgk0ir6qDeQj3WjKpcRv
         ZFV7MGswxtoT+rr+PknE2rZM505Mu3yMXQscvv6TgPXTH6xKy4VBzUjbfMhj4f4bOaFz
         9c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732220966; x=1732825766;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91YQYNqDCCw0Vf6dhkAR7qS/fOK/HJd+8YdWLuIKFAs=;
        b=c03LSAXL94aIpOWBDTv5ZiYwxl1knpEj73dqIsIb+7WE0YrC93ZEHIBo9X1xtYxWNo
         wMK6sufzHXlGPTaCRAhnpbllOE2T/tSqt/Gct1/6HZNrrI6DoC8P7r53BPs8BQisFwRr
         gHu8CXyGRY80sNUm6t1FgaIV9YWsrJzTrk9BAndGR8w15ByUitiIKeiog0FiH3Th5wYr
         xEahlBhuJzVpOisjuzvsDWqCMnKUpm93mD9YnSk84GG+ZRxWzMnObhAzmJJQ7kaQOhUc
         H/38x2yvdvXDaXApVmpSBLqcRy9iM2ToAqNOV4JeiNASWZff8rkeE4vWCiJihfdT0vuH
         QbPg==
X-Gm-Message-State: AOJu0YxK4KmCnXA0RUlP90mguVua8jfPI55dGLY8aNU/Xo56CGEnFxVG
	vteD6TXK/ncIt+YIYXBXlu6i59AnprmQjmw/lbVrXPyE9tj3v0O/GxyMu5LwKagGfMH/dBLX8Pd
	x
X-Gm-Gg: ASbGncvgFqDNeSPfZvBsx8FN+sIZqWEVfekZnXOOY07v6Tc230qQ3mIiu7H1dabf7UV
	9fe/HuDYTCrLOKQ4Vw+ImNbDpVQuiLDM9+V/W+RlxbEAZUElKU/yOwGTnp0YQz3yLjGJAYfTVYu
	pC6oxSpRCEgWeGDjvSi7zls8Sft14jWZdvWT976zrgmTjXn1QWav4mpATqrvRBtceRENKW4N0kf
	SjWEmqi1ubRfMc22KxA+YxnnPUBZ1yFQTeSJCTUM6kL0xTUjsJnaGHiY+Re67ntFa1vhzqEM/aG
	z2swmW5d1XR2Lo07PuOdlw==
X-Google-Smtp-Source: AGHT+IGlYj4xtkp2AniIO9MRJOu5bSvKLXfGuiGiZ/XkBVOPXYyzmJWHLE8xet0QYLrl4UTGK/qWgA==
X-Received: by 2002:a05:690c:450e:b0:6e2:50a:f436 with SMTP id 00721157ae682-6eee0a4e216mr7686587b3.36.1732220965816;
        Thu, 21 Nov 2024 12:29:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee009b85esm1107677b3.115.2024.11.21.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:29:25 -0800 (PST)
Date: Thu, 21 Nov 2024 15:29:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] t/perf: use 'test_file_size' in more places
Message-ID: <50c1368630684f235548d2e9a68d4de3745b5fe6.1732220875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The perf test suite prefers to use test_file_size over 'wc -c' when
inside of a test_size block. One advantage is that accidentally writign
"wc -c file" (instead of "wc -c <file") does not inadvertently break the
tests (since the former will include the filename in the output of wc).

Both of the two uses of test_size use "wc -c", but let's convert those
to the more conventional test_file_size helper instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
I noticed while reviewing Stolee's --full-name-hash series that he added
new test_size tests that use the test_file_size helper instead of "wc
-c". I thought it would be good to clean up the existing uses of "wc -c"
in the perf suite as a result, which is what this patch does.

 t/perf/p5311-pack-bitmaps-fetch.sh | 2 +-
 t/perf/p5332-multi-pack-reuse.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
index 426fab87e32..047efb995d6 100755
--- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -39,7 +39,7 @@ test_fetch_bitmaps () {
 		'

 		test_size "size   $title" '
-			wc -c <tmp.pack
+			test_file_size tmp.pack
 		'

 		test_perf "client $title (lookup=$1)" '
diff --git a/t/perf/p5332-multi-pack-reuse.sh b/t/perf/p5332-multi-pack-reuse.sh
index 5c6c575d62c..d1c89a8b7db 100755
--- a/t/perf/p5332-multi-pack-reuse.sh
+++ b/t/perf/p5332-multi-pack-reuse.sh
@@ -73,7 +73,7 @@ do
 		"

 		test_size "clone size for $nr_packs-pack scenario ($reuse-pack reuse)" '
-			wc -c <result
+			test_file_size result
 		'
 	done
 done

base-commit: 4083a6f05206077a50af7658bedc17a94c54607d
--
2.47.0.237.gc601277f4c4
