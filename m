Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4E179A3
	for <git@vger.kernel.org>; Sun, 25 Aug 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724581129; cv=none; b=EGsBrPqLRjB2F35uG4DJnnKJ/ebAr2d+fBmnD7CGN733ghGyOmxiGftl0YhAcR1Q4ddEueAZZ7i4ZPzFh+8lLCUvXaJ43qGWG5njstnbOQ0VTwwIxN5vwpXpniNbgmiAFPPKKKWWcAG7nbNmF5xbvCEZf/Vbsf/8D5PyWtzIixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724581129; c=relaxed/simple;
	bh=hr8jExKu0e/1cUjYg5epwuCqABp2PLGDxkjzjLW0gdI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZTY9aT5pdbE0MEuhpk2UAONWH4kXC8VAQBfUjNjOML0iL2IQpRb+iTsY0HSzVC3G3UUP4OCWdsO59VGnyhfwi/mgM9tDbgAg9JA4xwyG6Rh7S8XsbP30HP3hFhHj1Lnd5M4T34OLxydvk4w/H/fdAnGv0OR7UYXrxyDVhoFMrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLEbB6EW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLEbB6EW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so1955148f8f.1
        for <git@vger.kernel.org>; Sun, 25 Aug 2024 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724581126; x=1725185926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZLxg3Tjo5JORP7xvYt14xiSBMulfWGQAqSKk7lufPk=;
        b=YLEbB6EWRfAapTuIAdEALKPznJUVoPcA96DQHRKDA6Ht1GerhWnphVnkBRCC14JvZr
         TQl6BFq+YzVyeXyi+htIyX4h18t38TKdRTX+63oLqCIVn1eV3W2niD/pYDjOgbrbg/jP
         u8a10VLJ4JFxKeRHMXJ9PieDXpz3g19PbbqPGis2T61A1IJvkEVqSKcNc4ATVb0PBBYy
         VcwXGY5naqRXcMLgSOBVLxbo4o7Bgf8znPjWEcfMs9T5o6sw86elgpQE5C5xbz0rX04v
         p7WIbeDfO5+io2XJZRVfbqCgoblhNovRbwy3ZcBXkxr6+fAH14gS8wzl1JarFBepzYk4
         rFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724581126; x=1725185926;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZLxg3Tjo5JORP7xvYt14xiSBMulfWGQAqSKk7lufPk=;
        b=EBve9HIXRwPcqf6WwjO69RFDDFhkNhcsEiIEZk1hlgwJryuLKu+obqAE0UPoaSvJLu
         VVCFCkaQaZTiwwvxQdE1B4RLEQ/rTvcN7fksl0+rtEwl8zTH9SPSAonHwvHM7PqEn6sk
         n96MQIXhRqkd440ujR3Jdtt9Z/R51uyADyLZeQOQSEGl5SDaDoz3hfbk9N88UcThVvFH
         xgbHp7f02HVih9BEn25P7kw6NVW41h/T7bwiCUrF5eqE+7HtHsyJj+Lpxb9ThjqDN9J6
         jRINJCq1mNYwpPTK9B2O6q34By3e+2eAz3eX26zc231Hkdu4cW5C5JG7vR8X6Cls/4SB
         ocDw==
X-Gm-Message-State: AOJu0Yy53MkfL4+zYuiqPP13LtcgjyPd7EIaZKIWyNUpNuUWAGYqO76Z
	1HUPxzMtym/RgeILD51ayvvVZoXUBmJAvN7ZaQM2SyaJc5VCa2fALxmCmQ==
X-Google-Smtp-Source: AGHT+IFAX2QDKfh0F6uMsNgdb+xwCZziwEeEZ6gzyIq7ke7tJtKaejD5k7/SkDEAggE9aWNNgJgisQ==
X-Received: by 2002:a5d:4891:0:b0:371:83a8:afee with SMTP id ffacd0b85a97d-37311866532mr4154464f8f.27.1724581125513;
        Sun, 25 Aug 2024 03:18:45 -0700 (PDT)
Received: from gmail.com (107.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373082657bdsm8356366f8f.107.2024.08.25.03.18.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 03:18:45 -0700 (PDT)
Message-ID: <5da09529-e95b-407b-9e66-34ebac4b4128@gmail.com>
Date: Sun, 25 Aug 2024 12:18:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/5] apply: whitespace errors in context lines if we have
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Language: en-US
In-Reply-To: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the user says `--no-ignore-space-change`, there's no need to
check for whitespace errors in the context lines.

Don't do it.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 apply.c                  | 3 ++-
 t/t4124-apply-ws-rule.sh | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 0cb9d38e5a..e1b4d14dba 100644
--- a/apply.c
+++ b/apply.c
@@ -1734,7 +1734,8 @@ static int parse_fragment(struct apply_state *state,
 			trailing++;
 			check_old_for_crlf(patch, line, len);
 			if (!state->apply_in_reverse &&
-			    state->ws_error_action == correct_ws_error)
+			    state->ws_error_action == correct_ws_error &&
+			    state->ws_ignore_action != ignore_ws_none)
 				check_whitespace(state, line, len, patch->ws_rule);
 			break;
 		case '-':
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 573200da67..e12b8333c3 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -569,7 +569,8 @@ test_expect_success 'whitespace=fix honors no-ignore-whitespace' '
 	+A
 	 BZZ
 	EOF
-	git apply --no-ignore-whitespace --whitespace=fix patch
+	git apply --no-ignore-whitespace --whitespace=fix patch 2>error &&
+	test_must_be_empty error
 '
 
 test_expect_success 'whitespace check skipped for excluded paths' '
-- 
2.46.0.353.g385c909849
