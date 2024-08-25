Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72665179A3
	for <git@vger.kernel.org>; Sun, 25 Aug 2024 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724581062; cv=none; b=lIiSYgs39GbNQPlfbjhmoxReMQGmf5XCM+P92av8VF2wX47NEeY5r7hdN06V30fYhWCTBaMGC/a+n7X5C+EYjmRGfOHQMI5YBugHaiv0mRI4XjOK2nVNxOt0vdYRPvcMvkXXpidi2EUYMoP4bY8aEVG68gbzD8QHfRB8xqcr4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724581062; c=relaxed/simple;
	bh=TdOKBhwtAYai1j0b69Z1h+8e744KVWP5Jl1659ci+9I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CuwCnF07mnuvcByHopITW//4GOr719UBRqRpI5colf0LdYOhfibvXJkTDn3kfMCEWdHUCzXR9RtvlbfLNXFIECJP/qQvjebUOJol0Wmgfwk8AC0pGWYUV8CMzvw6wK1emnCqGRq9zyEvW4Q3cpC2c8vtqr0+XWL8dkZ5K7yk3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaCKoyiY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaCKoyiY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428119da952so29437795e9.0
        for <git@vger.kernel.org>; Sun, 25 Aug 2024 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724581059; x=1725185859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RD7xsGWQTBM3adqMZVi9tIkbVtYjUa5EBaYmSoNgxNA=;
        b=MaCKoyiY56gfa4kQUqEKzGO6I4LjPbn0SkTzyPEXNyALYmUpwbiTU+PrI8bJhcji8a
         6kOGQj9FJ6PXvcbcrPsz6ZAF979YrmnJXyM3ON3Y8eLyHePsfIG0lmYVYzyxLOlWDgPG
         ylP2kgrpojWdzVyvfU5ytIxNmyFEc2NiEl3sb4j8xYlsHMcSaBjkrozfVZ47ANdaAvfW
         oo8e/PRq5py2ljadoF6QPH4rUwYscu3nGT1eGPe06fqcGdhk4cGI0Gq16icG9URL91TV
         uSoF9XEsZToGtulBIOxL6sdzgMO6ESrNwTnyAlhILnmVXgYYN7CFEVCYOYatJyzlIpxF
         3ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724581059; x=1725185859;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RD7xsGWQTBM3adqMZVi9tIkbVtYjUa5EBaYmSoNgxNA=;
        b=c0IieAf2k78P5TO0SU+MxBlM4BdK1eNjkzVRv49d41Em2rF8lpuDsJXI7nWXb9Aga3
         CbnOSJGT8EFmftGMv5rB/y+V4cuN1yxGbrhvFb1WBUeyRVnLC8v1ZMJdg0Wba82oM3eW
         yRDkiwrmGfYVnZOms9ZI7q3ObbUkBHoEfoIJQysdtr7PFvsdugMTXK/iUsf/czkvyj9L
         GPhMl183Vx80XyBUuzozAmgI0wZyCyNsjE8hv/U6bBAvq1L5mXbIHbL31+asHra16tHm
         0UwAeFPHufgdLDj0L4A5guklDxQy/F6ZrtLUGGzz9Asnj+MDSVFf8yJYr+cBmv8DIn3r
         5shg==
X-Gm-Message-State: AOJu0Yz5mZxqHNJAGArdaxlyjkTiLLZPkw35Vd+xcSwtbgAqBWbNLxxg
	OtekcH+q7Ac+uit6Ov2iYrn3ETobEs2ULCrfTR/AW3AvAL+nd49GNj6khA==
X-Google-Smtp-Source: AGHT+IGQKfZEGeaOViLkCFHSYXPlCCcFotwp1+6K4rbJ4/Ma0AxWClJnPUKZpsVYcZgE6BT6U3UTjw==
X-Received: by 2002:a05:600c:3516:b0:426:5e8e:410a with SMTP id 5b1f17b1804b1-42acc9f66a7mr55246595e9.24.1724581058391;
        Sun, 25 Aug 2024 03:17:38 -0700 (PDT)
Received: from gmail.com (107.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefeaa45sm155810785e9.39.2024.08.25.03.17.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 03:17:38 -0700 (PDT)
Message-ID: <5e35f260-056c-4af3-95d9-70d6f117bff9@gmail.com>
Date: Sun, 25 Aug 2024 12:17:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/5] apply: introduce `ignore_ws_default`
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Language: en-US
In-Reply-To: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When we see `--whitespace=fix` we don't consider a possible
option: `--no-ignore-whitespace`.

The expected result in the following example is a failure when
applying the patch, however:

    $ printf "a \nb\nc\n" >file
    $ git add file
    $ cat >patch <<END
    --- a/file
    +++ b/file
    @@ -1,3 +1,2 @@
     a
    -b
     c
    END
    $ git apply --no-ignore-whitespace --whitespace=fix patch
    $ xxd file
    00000000: 610a 630a                                a.c.

This unexpected result will be addressed in an upcoming commit.

As a preparation, we need to detect when the user has explicitly
said `--no-ignore-whitespace`.

Let's add a new value: `ignore_ws_default`, and use it to initialize
`ws_ignore_action` in `init_apply_state()`.  This will allow us to
distinguish whether the user has explicitly set any value for
`ws_ignore_action` via `--[no-]ignore-whitespace` or via
`apply.ignoreWhitespace`.

Currently, we only have one explicit consideration for
`ignore_ws_change`, and no, implicit or explicit, considerations for
`ignore_ws_none`.  Therefore, no modification to the existing logic
is required in this step.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 apply.c | 2 +-
 apply.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 6e1060a952..63e58086f1 100644
--- a/apply.c
+++ b/apply.c
@@ -115,7 +115,7 @@ int init_apply_state(struct apply_state *state,
 	state->p_context = UINT_MAX;
 	state->squelch_whitespace_errors = 5;
 	state->ws_error_action = warn_on_ws_error;
-	state->ws_ignore_action = ignore_ws_none;
+	state->ws_ignore_action = ignore_ws_default;
 	state->linenr = 1;
 	string_list_init_nodup(&state->fn_table);
 	string_list_init_nodup(&state->limit_by_name);
diff --git a/apply.h b/apply.h
index cd25d24cc4..201f953a64 100644
--- a/apply.h
+++ b/apply.h
@@ -16,6 +16,7 @@ enum apply_ws_error_action {
 };
 
 enum apply_ws_ignore {
+	ignore_ws_default,
 	ignore_ws_none,
 	ignore_ws_change
 };
-- 
2.46.0.353.g385c909849
