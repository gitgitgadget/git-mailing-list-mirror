Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4C2F7F02
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305505; cv=none; b=sH+swUpZbMvuD4f4RYWY1g4HfAOtuY/4MCr0G8CyYy+bIMSyYyQHQ2ht2q/DQ713bgCCkzRyBurN5bDOiVr8Ew8zXYj95/t7iuqrVipYLtn+6X7Ebb+PbDnewMQD2Kby8ilqEFPSOkuW7YSo9V5wv62fU9XHVfAbBBnFqhY0ROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305505; c=relaxed/simple;
	bh=lpbH7ARYda+VF351ecWBE54uXiRrdSDjKprb15aajVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMKpfWPhQ+TPUY9O/FsNW98kIW5n16shrj13wmfpMLYh64WdVvXEX7mXhLyBUgBmQVwEXaD422tWy+AJ4Hibj9cfYJqB7jNSlGxXVfs0uVZIc+mHz50vzgkCblVPdmG1CW+X19NsWhEc3strupbSelFUXwKR2/qq5iireTGT61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=N9tQmeNq; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="N9tQmeNq"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6682259cb3dso2962450d50.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784305502; x=1784910302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lpbH7ARYda+VF351ecWBE54uXiRrdSDjKprb15aajVE=;
        b=N9tQmeNqBIz/YYpHY8c6IRCeB4zKBqphTQ/1MhQmB4htZc0WTNyZydEA6H2g3yuIC3
         tTd/sdma3J5gOEpKP8mNpmag0QgWRk7ggo8UcbR4ZwwRqZ75fPkYA/fk1SBi5abqPU78
         WtT7XJhif8viPM2xrVhjoI3RZcLx7BuPKAGe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305502; x=1784910302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lpbH7ARYda+VF351ecWBE54uXiRrdSDjKprb15aajVE=;
        b=s46EGp9Iq4MybiuGmzqmSqh4CH4GOMuQqMVA22shK2YXnK8KbvLO2zQBnFFYVqOSCA
         k8CyVRfS2gHjLdRY+hUXBlI1XruwKcy5J8UF2Eod6Apa2XPvRCcKt7ntFxFhopUmTtKj
         Ffjcj/CuR/9yDCCnVzMROwgZ0fBAJUHn0YgrgdnqA6K1BywiowhgdKaOGr+yeVxurT9N
         BWaJs64gJlJ3rDd8Bz1nF6PnVsb2MGtyDPdY52vZTf/etBsqIiqsS0mK/IqQygV0wekJ
         ck8PucJt4b1pjHMx7MROrOyfBcgh/s8X3mno7EXimH7pX0r1gux3IINfnHWdYjT9SRaE
         L3Zg==
X-Gm-Message-State: AOJu0Yz3qj2kZ5wHPCLrWsU4tJ6k+6KdirQqsDV2PusXwRHczhGHh+LT
	ESvMLgP1omKKMimy+qeWvd5XSX2C20BueYUSa5RLNNoJL1aG9lQMR2obPZOoj1iOTn0=
X-Gm-Gg: AfdE7cn3uuSOaMKOV2gAGeDYXnbTZhAyqFZXCUoG1Oh5+TU0xdb1Jw8T8yugP1W1dCf
	kqjmEiviy9l8yzLKFmOg1kIVR+8TKd3FsABD6Xcyqw5NS0YvQvRSmDVdAD2VeuuvJT0X8iniJb1
	XXSB20jHqcab5X2aLICBvd5AZYPNzDFJNYcpNKbLEAH6ZSfz6h7bFneL4spoJVqQvFj1hIn231h
	ALByw0OL9sv9FwOYXcXF5bmKWq/ueLR4+Xbk8+9Pj/9Rppa7eCnm06zvOdivjeIAfR67X0PmTmT
	N47iVIUEq4o/8V2X2OlzMxEIa43xXU1ZufGvpeeIVc2owbb/ZCgJCDtM/Pgv9ROtR2D/kWOdD4E
	DW3H+lsMSw5OGL0Z3req52Cy05Z8fGlkYghajrz6UM0R4706mdgvkr/iX9Ue2dgUdVMUKtp12Ke
	VEYLQXDM8fqDwf8bWJqkDy514dBAhKWW5yA46HICI1hURrI9opEIjNLs4bf3crIUBelTNbPg==
X-Received: by 2002:a53:ad46:0:b0:668:c30:5cc3 with SMTP id 956f58d0204a3-6682a101723mr2507995d50.50.1784305502467;
        Fri, 17 Jul 2026 09:25:02 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6683b56fbf3sm1817430d50.8.2026.07.17.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:25:02 -0700 (PDT)
Date: Fri, 17 Jul 2026 11:24:59 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] trace2: tolerate failed timestamp formatting
Message-ID: <alpXW5U6sndZtgqV@com-79390>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>

On Wed, Jul 15, 2026 at 04:12:11PM +0000, Derrick Stolee via GitGitGadget wrote:
> This change removes all uses of xsnprintf() from the trace2/ directory.
> There are two uses of xstrdup() that could be considered for removal,
> but they only die() on out-of-memory errors instead of formatting
> issues. I chose to leave those in place for now.

I may be missing some Git for Windows context, but I dug into this a
little and I'm not sure 'gettimeofday()' is the culprit...

In my understanding Git for Windows's 'gettext.h' appears[1] to redirect
the 'vsnprintf()' inside 'xsnprintf()' to 'libintl_vsnprintf()'. In this
case, we have seven '%' placeholders. Gettext can store only six plus
its end marker inline, so parsing the seventh causes an allocation
before any timestamp values are read.

A failure there would produce the observed -1, after which 'xsnprintf()'
dies and trace2 can recurse.

I think that also explains why calling 'snprintf()' directly helps.
tr2_tbuf.c doesn't include gettext.h, so I think it bypasses libintl. If
I'm reading compat/mingw.c correctly, 'gettimeofday()' fills tv and
always returns zero [2], making the zero-initialization unrelated.

Would it make more sense to fix the xsnprintf()/libintl boundary and
treat Trace2 reentrancy separately? I still can't explain why the
allocation failed, so there may be another GfW-specific piece I’m
missing.

I think something like the following (untested) would prevent the
redirection to `libintl_vsnprintf()`:

--- 8< ---
diff --git a/wrapper.c b/wrapper.c
index 16f5a63fbb..2976d4e110 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -7,7 +7,14 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "parse.h"
+
+/*
+ * xsnprintf() only formats non-translated strings. On MinGW, avoid
+ * redirecting its vsnprintf() call to libintl's allocating replacement.
+ */
+#define _INTL_NO_DEFINE_MACRO_VSNPRINTF
 #include "gettext.h"
+#undef _INTL_NO_DEFINE_MACRO_VSNPRINTF
 #include "strbuf.h"
 #include "trace2.h"
--- >8 ---

Thanks,
Taylor

[1]: https://github.com/git-for-windows/git-sdk-64/blob/1351ad2fc39a1f74c56b2cc2b38107ec8df8eb40/mingw64/include/libintl.h#L731-L754
[2]: https://github.com/microsoft/git/blob/vfs-2.55.0/compat/mingw.c#L1609-L1618
