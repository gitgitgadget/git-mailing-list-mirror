Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2123179A3
	for <git@vger.kernel.org>; Sun, 25 Aug 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724581113; cv=none; b=bdxlkCFNZ8pUiNMO6Sk8D3GNWdGyowNy0YjoMoXUUIjHsS1JCrXoTa/hcdvkp4bfvPcmhAHn7vUZchc1E6wNjqTLL1eBt2oZck+7Qe+3t+VnIsxaOHWYC8PdvXEYstzS6FKUgr4k8FgMf4nsRU1pBNB5WJPTWwvXkCG3fyF6qfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724581113; c=relaxed/simple;
	bh=ic2htbZD6Vj08wheuXREoXMzo1E/lZV4ipPXEEdbqTY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=AT2/obWqa8giccyL4C7xPsIIb1enV6ZbIjZF6oRKQed/LzmC3gcpi0omDfLO2MR0IizDY4/n17EBX3JPdLhcZK73IwvXaWKFpx+VPc7TINb6zZ1fNcXiscw9D/T0pmhSg+ql/AXGN30Xxk4JfRkAsHUgbWhV+lfL3V1usfwAX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddnV+iJo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddnV+iJo"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3717de33d58so2008228f8f.1
        for <git@vger.kernel.org>; Sun, 25 Aug 2024 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724581109; x=1725185909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLRsFzgHLym3FXT5vCXeDqHsP12/gdWYq3ftp+fwZe8=;
        b=ddnV+iJo453LFL7jqnpobLFa3IPkj58yjS8PU+PIMQKrVU3Y0ivEaCP1gdNqp10o2l
         xFEjp1M2Aw4x0P7LFmVcJO+Tm3FedWIwm3dDilkdITUGbNDk9rIWMba3iW5hu35CwOFs
         q840Mh0CCNznbrkzA7ARNel4S2LSmSmzsGacu6Tgr6h1FWI12JWjkeqV+POyEC87g5Eq
         IjeTm/WYYjLJr/dKUgam4i9Yt6ouKtVxQ3vk04OJQKfRO/ZIhwxnJ0K40mMnhDisMLaA
         ml07SA+iW4XTvkeYaUcsLHepsGBhNri25pqXTP1QVGnxb97zKqte0TMBkwZ5ea+xiIgB
         xoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724581109; x=1725185909;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLRsFzgHLym3FXT5vCXeDqHsP12/gdWYq3ftp+fwZe8=;
        b=X76C4bru/lT66tiZ9MZBFgukqHUBv0Qatgi6LWIWNYWVvYC6CT26Y99JvxvAeDfLok
         sQ6iW5zs4VaPvGClELC/vU5dRyy8VllxG6n282Zlc2KCboYlI2Fz6IyHbIMsnhLqQ9F+
         yb3VBg4LRbZErrGOKaoW/jKSqzM3rRovZEXWPPPuvVvcb+7Aw23tiGA6+w/EoAXrNMFa
         +kqJAZrD0PCzl+yH5cA5WY5vhIxkUAd2BwXpnUHeDQrx3vDWp+ep+m8z/v8+SCydAH7R
         cZUJms1NVHD3IFMto4YiYuHYWfPeyddLJHbPJQxWW12y06UH03V5/2y+sYnj18LrjOjH
         ai9w==
X-Gm-Message-State: AOJu0YwP32Q5/G/VipNkAqxdImx6I2Q9ZYUo/SUebBKxdPL6ZD3Pe0nt
	oxNy4zh3TINZVIpDcgx32dO+67wZzDhMn9etg3PkAimkOeM5968Xm+fOhw==
X-Google-Smtp-Source: AGHT+IFBjDb2Yz8hALLnphmCaBJKQCJlTWQMz/fJi/E+VU7IhPFMN+p9OLgEf2YMk6xstAs8BKGaaA==
X-Received: by 2002:a5d:464e:0:b0:371:7db6:89df with SMTP id ffacd0b85a97d-373118644e5mr4092979f8f.31.1724581109052;
        Sun, 25 Aug 2024 03:18:29 -0700 (PDT)
Received: from gmail.com (107.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110436sm8340720f8f.11.2024.08.25.03.18.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 03:18:28 -0700 (PDT)
Message-ID: <1eb33969-1739-4a27-a77b-3f4268f5519d@gmail.com>
Date: Sun, 25 Aug 2024 12:18:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/5] apply: honor `ignore_ws_none` with `correct_ws_error`
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Language: en-US
In-Reply-To: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ensure strict matching of context lines when applying with
`--whitespace=fix` combined with `--no-ignore-whitespace`.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 apply.c                  |  3 ++-
 t/t4124-apply-ws-rule.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 63e58086f1..0cb9d38e5a 100644
--- a/apply.c
+++ b/apply.c
@@ -2596,7 +2596,8 @@ static int match_fragment(struct apply_state *state,
 		goto out;
 	}
 
-	if (state->ws_error_action != correct_ws_error) {
+	if (state->ws_error_action != correct_ws_error ||
+	    state->ws_ignore_action == ignore_ws_none) {
 		ret = 0;
 		goto out;
 	}
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 485c7d2d12..573200da67 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -545,6 +545,33 @@ test_expect_success 'whitespace=fix to expand' '
 	git -c core.whitespace=tab-in-indent apply --whitespace=fix patch
 '
 
+test_expect_success 'whitespace=fix honors no-ignore-whitespace' '
+	qz_to_tab_space >preimage <<-\EOF &&
+	AZ
+	BZZ
+	EOF
+	qz_to_tab_space >patch <<-\EOF &&
+	diff --git a/preimage b/preimage
+	--- a/preimage
+	+++ b/preimage
+	@@ -1,2 +1,2 @@
+	-AZ
+	+A
+	 BZZZ
+	EOF
+	test_must_fail git apply --no-ignore-whitespace --whitespace=fix patch &&
+	qz_to_tab_space >patch <<-\EOF &&
+	diff --git a/preimage b/preimage
+	--- a/preimage
+	+++ b/preimage
+	@@ -1,2 +1,2 @@
+	-AZ
+	+A
+	 BZZ
+	EOF
+	git apply --no-ignore-whitespace --whitespace=fix patch
+'
+
 test_expect_success 'whitespace check skipped for excluded paths' '
 	git config core.whitespace blank-at-eol &&
 	>used &&
-- 
2.46.0.353.g385c909849
