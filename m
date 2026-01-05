Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA9221FBD
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619019; cv=none; b=qQeLW2Fkh5XwelQuyLprLbcbNmFgv0yP1MgJs0DA9IZAwgcLzkBXMhMoyv7UWnd6E1qj7O6doUZaOSgVQstxvwbp4EqPmpe7l2WB59G+OLTv4syOCBgUu3Ovb2W/qWZ7fdxjZUIG+x4vPlvrjZooe0F8zKNQR7iCoiZFu/Aqeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619019; c=relaxed/simple;
	bh=gqwIlp1afjSxkX7FXOSVU/4Prja7v4bdi58G//HUQsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCUEKuzoagcLOBGes881I7C9akijEJgdVAEVMZHTlE5t8mEYoerW7w98w3w1QnHUzBprZaNWobB4SkVuaIt2eBOvBItGiVXPugQxluX83CEzKeUENI8hDlZz9uPkZ+6ie9HmwjsdJLGDHYKS176r1hrRMrXejOpA8VO2anGDaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsPHnNJo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsPHnNJo"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-594330147efso16321562e87.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 05:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767619016; x=1768223816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWOfxfYufk9zUhSnoU3xxcCVaqii3XScSUkw04mDn3o=;
        b=EsPHnNJo5Yh3tUYxuHBvLVP5nZP2KI9+IndSIGPezUlIhLwIhyxuzW1JYRzL/0ft0s
         lUYpW9x38x6olLzV/GS2BRnznFYZD3gBQqA3exK1mKV4WuNpUV1jvSiHeg8hvI4sljdD
         0wzNdRGbWZmLuZ/n3ck5PCrb31JapmAT/p4iGueUCSNt61iu15jdNUi9rvANldQd1qyT
         Ao3yx1GchpwgA7EfuNQ254I57DOBlyE4e7ELr4XrZzfX1/JfKEsLP0oD15LRFDhss2/i
         nTN/fw2fBeWVCW8Vr5/GSOGuH3tKSW+flg736e2Wr8CE+Wedz2ESu3zewcaXfpgOV6Qt
         ZstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767619016; x=1768223816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWOfxfYufk9zUhSnoU3xxcCVaqii3XScSUkw04mDn3o=;
        b=WQMkK9ZLV5MKhEpbtF6oGw4gd3UQCObossLr733XR9ch+AwZvdcZHO9pJRCjRBpn6r
         K06nG8CnS6gog1DFlL6BcWMfHskU0yyNwXDgbX99rLt09jhlyuZOoIgbjmIDQSlzHxAn
         Oe0dMltri7i6MLko7vMqVgXIHCSYozW1B9t5WjKHcAk4sHapN0wHjvAbQSVpdXUMQGv4
         1M0TKdeE0rFyLuH66Yw/uHk+2PUP/T7/4DeAVenmoK/mbWySrj0ADI4pxJqwtDvt3L0v
         3w9jmHkmbpKVi2DMpq8I1rWVla4qQNlT6GsA+mLmt7scEKf9FTBenRpSpt/TRCXeyvov
         HNHA==
X-Gm-Message-State: AOJu0YwAxpC4Op7gdljeN+68pRQdoPU3MGYTgqdyDtlqC84Odr3VAeps
	3tqZ4fZlS2dldnPN2vWe5F8mzgtP0hN6H3QEONNWJWTePxm8SECuI91WeNNKMg==
X-Gm-Gg: AY/fxX60t9mq/XGdrvmgS70Jz/aw+J/U0j90QezR3M6rFAMem/VkUj1AZ2wc9oqFKaz
	fk6A4C9+n/f98JHTY9zYy0onWVrR57NmgHI4kUw23HZ8FuwdlnOT72RJd9WTXkpq8W1m/3heMen
	kIfZnLmqcAcO6PtQXJBI19Oq1r9lTWvA8AYPinzQEZeg7oFfuN6p/nCi1n0nQJKZQ7kJ70gNvdw
	nPjg18a9UycbPydDc/ge8+LlcvS8QThz5vvCwv3PBgY5FjTf+gGFhVOQRN2VpLVXNg2EQNpxnId
	jDxf8WGgRHpftZPkMFFO9v960knvvllCzLFQpCDq6GxCG7C37olGgivDG0qF6SvLKB4zBvVj/n/
	dJAmHP3aop70hhmSGdcuMTx2XFp0RJmJP35RAr84i0vMldSOl565Ixnj76ZFnniNODgrYl1BHot
	ugNDAFyQivAQ5f9CkRCiLRmsp1yR/qaNNGNzJfMjVS06U9jhhWDeF4fSfvRT+Y3u69zRQaP6TS2
	IjXVp0OLm2Pq3o=
X-Google-Smtp-Source: AGHT+IE+2Slij6Ia/GYXtLm/LhwOIoOsHlEU4rEhq8xpe7PhryRXK/vnIhldWvnjAJDmZovfo9D3pg==
X-Received: by 2002:a05:6512:31d1:b0:598:853e:871f with SMTP id 2adb3069b0e04-59a17de08e2mr17132847e87.51.1767619015613;
        Mon, 05 Jan 2026 05:16:55 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f4e4sm14402345e87.83.2026.01.05.05.16.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Jan 2026 05:16:55 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Another look?
Date: Mon,  5 Jan 2026 14:16:54 +0100
Message-Id: <20260105131654.88348-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqldickzva.fsf@gitster.g>
References: <xmqqldickzva.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please don't.  Unless my assumption, which is that in the old code
> "!sti" and "!ours && !theirs" is equivalent, is wrong, all you need
> to do around that part is to first check "if (!ours && !theirs)" and
> say "your branch is up to date with...", and then have the check
> "else if (abf == ABQ)" next.  That way, when we check abf we know
> the branches are different.

It seems to be an incorrect assumption. This code change breaks several
tests including old ones:

```
diff --git a/remote.c b/remote.c
index 1f87b85b22..8db4fcd7b5 100644
--- a/remote.c
+++ b/remote.c
@@ -2303,7 +2303,7 @@ static void format_branch_comparison(struct strbuf *sb,
 				     enum branch_mode_flags advice_flags,
 				     int show_divergence_advice)
 {
-	if (!sti) {
+	if (!ours && !theirs) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
 			branch_name);
```


Harald
