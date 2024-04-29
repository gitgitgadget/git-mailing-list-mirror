Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F312A163
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415828; cv=none; b=nwkpole2PCOKlBvfClqVkzkw/IajSjoR9dUL7j9ix6PZLmoTrY7tpwct0n9U3dFcEB63xaz61dAzolEyEDcaNq/iJs5oOXEa345hxSPGWdcFMhNGY4sEy89cCDb6ag9CjSZRT4PcqttkIRHU/nTOdOj6gmA8+a4xQKAyk77sORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415828; c=relaxed/simple;
	bh=yFM5oI63A9uNsDc6KN2pfgod3ZImNPjtAA08IR99yjA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vExWiqjddiEzp0YwKQbePB2KqqjR0WSt7xMt2q/Rgf7uhBxQcupLBL9qMafG8RB+r5btXHZi5J2d/cWnq0BuWMEhgVHMnrKu11EgsaeuqCZEZdw48Vh1HVaTix+8coQWBIUspyAI3JaF1BCrro/GOcahG5Es4j29mkNe+NpZOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH6QHWfk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH6QHWfk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41c1b75ca31so11605405e9.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714415825; x=1715020625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSwtg4YXCraQfJxePaAe0vpas53CBWi4HkuctTIDVkk=;
        b=NH6QHWfkFTNTH6Q9BWRp3PUhUOAFI4JC0GC64BQJmcHkprq4UBbuAKQ1B/GRzvHrZG
         rt0Vg2Jku9T8i4FO9BerNRo55oNSNlBHMvdOxHHqaLfxQyHVjPJy9l9HJQhMgjToM2b5
         4SQb8DeIiuz92bnzcFWBxbMF640zRLXTwbaeRq5YOCFzLAlSML1coM7Kf4F/dwMqwFzg
         nDSIG2YIUM8PS3QahqpkHaAFCcMDia4rJl4xQ7rfvXnnh09JdAGvA+bf4K9BBziR30dw
         UURcSDyl+WgpMqmuiw6kMlHSiMAQ99Wx220EC43DSaCLEMt8oZYIGJ48UupBI+95KN3r
         UPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415825; x=1715020625;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSwtg4YXCraQfJxePaAe0vpas53CBWi4HkuctTIDVkk=;
        b=HApcZaHJVz/lItBBkYBmJp1zlObJf0qxbdys2xekgI1y2FH99vDGpMvOXkV/wPk3eO
         W1dZgRaOIxF9kMRCFJPU8+qea5lZSDmnlik0eP3IkLAJVLOiQHubm85o/hrcAYX8PslL
         oNnbQQm5p0E8CsQj/V4rc+tYAEUXTfqILjnCsTMgQAu8B3wFp27T0J0gME2QdWJRNxQw
         2ge/Yev9bLFYuizB2CMKR3ah0T7CdKrb/wokpHAwjWBH3hyKw3bK840ZtVF/2W+DVaRl
         5HgSij5ZcB0ALDtKJBx5Urp1ffJw6fn++K+mDXyW+FTBt+OOeRMpPkqp019mexJLmLx6
         QDiA==
X-Gm-Message-State: AOJu0YzMSapA2NdFZcS8VbgHy982raXxhPkCfty1qEWYvhyGn5orbMvT
	+uYX6vfzs4HKXdPA42XBbeHVt5uQGl3nr/NXfunjKN7JSuXAPFjQaZdLTw==
X-Google-Smtp-Source: AGHT+IE7UcoMaz7rUJ3m5py29qua7ulkpIn/B2NN+wV5gZnhgCtEFltpOxycAeQ3kXZ0TMUpnQRtgw==
X-Received: by 2002:a05:600c:3542:b0:415:6afd:9ba6 with SMTP id i2-20020a05600c354200b004156afd9ba6mr8281405wmq.1.1714415824647;
        Mon, 29 Apr 2024 11:37:04 -0700 (PDT)
Received: from gmail.com (111.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.111])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c502800b0041b4c293f75sm17354556wmr.13.2024.04.29.11.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 11:37:04 -0700 (PDT)
Message-ID: <10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
Date: Mon, 29 Apr 2024 20:37:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
In-Reply-To: <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is no need to show some UI messages on stderr, and yet doing so
may produce some undesirable results, such as messages appearing in an
unexpected order.

Let's use stdout for all UI messages, and adjusts the tests accordingly.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 13 ++++++-------
 t/t3701-add-interactive.sh | 12 ++++++------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 0997d4af73..fc0eed4fd4 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -293,10 +293,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	fputs(s->s.error_color, stderr);
-	vfprintf(stderr, fmt, args);
-	fputs(s->s.reset_color, stderr);
-	fputc('\n', stderr);
+	fputs(s->s.error_color, stdout);
+	vprintf(fmt, args);
+	puts(s->s.reset_color);
 	va_end(args);
 }
 
@@ -1326,7 +1325,7 @@ static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
 		err(s, _("Nothing was applied.\n"));
 	} else
 		/* As a last resort, show the diff to the user */
-		fwrite(diff->buf, diff->len, 1, stderr);
+		fwrite(diff->buf, diff->len, 1, stdout);
 
 	return 0;
 }
@@ -1778,9 +1777,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 			break;
 
 	if (s.file_diff_nr == 0)
-		fprintf(stderr, _("No changes.\n"));
+		err(&s, _("No changes."));
 	else if (binary_count == s.file_diff_nr)
-		fprintf(stderr, _("Only binary files changed.\n"));
+		err(&s, _("Only binary files changed."));
 
 	add_p_state_clear(&s);
 	return 0;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 04d8333373..c5531520cb 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -45,13 +45,13 @@ test_expect_success 'warn about add.interactive.useBuiltin' '
 	cat >expect <<-\EOF &&
 	warning: the add.interactive.useBuiltin setting has been removed!
 	See its entry in '\''git help config'\'' for details.
-	No changes.
 	EOF
+	echo "No changes." >expect.out &&
 
 	for v in = =true =false
 	do
 		git -c "add.interactive.useBuiltin$v" add -p >out 2>actual &&
-		test_must_be_empty out &&
+		test_cmp expect.out out &&
 		test_cmp expect actual || return 1
 	done
 '
@@ -335,13 +335,13 @@ test_expect_success 'different prompts for mode change/deleted' '
 
 test_expect_success 'correct message when there is nothing to do' '
 	git reset --hard &&
-	git add -p 2>err &&
-	test_grep "No changes" err &&
+	git add -p >out &&
+	test_grep "No changes" out &&
 	printf "\\0123" >binary &&
 	git add binary &&
 	printf "\\0abc" >binary &&
-	git add -p 2>err &&
-	test_grep "Only binary files changed" err
+	git add -p >out &&
+	test_grep "Only binary files changed" out
 '
 
 test_expect_success 'setup again' '
-- 
2.45.0.2.g84ce137e4a
