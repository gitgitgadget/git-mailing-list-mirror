Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD42904
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474835; cv=none; b=Xkyjj/xcn87VawUtb3wf6CsRyC8Fy1+7IzsteEONrhbdtzbQM2CrPzfk0FmfC8r2gzb1YAysyCsF5QdGe7vdGOV+yM16dl5etUnuIrjes0JvCroVjLyzYarl4ycGmpQmYiYVv+my6eOyzcSLPn6zN81x9ziajx2a6wTEdyP/CKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474835; c=relaxed/simple;
	bh=4ZYtMc07B+LGbBa1hJp3GSBlu79wVnwleWPrtMBibjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBrMI4cZX54DOePYe2GoxEaHEWHIE1iV5rdKrhbEUaomAtfG41u+6fTs7CF3b4RAmJZ548Sr+DzZpAzWrG5S2Sz6FLNW3BnMmKW9Q/Itjzejl8H1E0C2xbdkhjmmI9QBCCtmoWBrWoRGisRHOHJSJFfdwRlKOiAGCD2C24Prwxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWO37bzs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWO37bzs"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so20240725e9.0
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 03:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754474832; x=1755079632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J2Ow+UUUe6k4f2n3O6F/qhm31QltKhE5Q6F0b/T/ywU=;
        b=ZWO37bzsV5ixZd3t5ywhF9/A/O9CQxYnFxfuBheilygTGmSyvOdAILIk8/owCBF6Me
         /yKJKASsVlfIYgcsuxwsE5LgyLgpu8wmsmEA/6iPSec/85t1Ws6yuloHLJEX8TTlYfAl
         crKKpqamV+IH93iIn67V6cQt1cqfH3ltqw+QMGqUUdwNPf1xOEs0Nm9cWoVPhZgOZ/OV
         BNpRFvTJH1Cf89Ql3oDvgmwG3rRilUasfRizmcDCWNZI0A9WU3Bv1/bvamw2qw8mLEJ+
         BB64fiN2jAtxQxS+4fMgTOLycEfhyFzwJ0SFzAKXAecLBbNub/PDjM7ZcLW3rsczgVdv
         digw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474832; x=1755079632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2Ow+UUUe6k4f2n3O6F/qhm31QltKhE5Q6F0b/T/ywU=;
        b=kz+iq+VLX+O9vaKvYPXbi+2ZBzcp9KO16myFVYf1uB6yhxnCbXSneWV9qvnJAXMP74
         vr35iS+6DjkPsS+5EasPmdYVqkqPpCJepd32JB+BEN8cQjDDXm3L2F112Oe+dUULWlIt
         V70KVhg4uBYuvEnJ5wUKyQgGmBG9paEDrwCfOP3/Pw4fCp/kwIxG63CT/X02xBvX0555
         L007c1/Wq2VDEYDbVqxSzamwB95iQ/FHtd5/CsiNiKHj+tuZDCUOdBgiPzlzMUH8mXMA
         tS2FrkD8kMOCsnE3ovNTIXs+3R54CKEjp+ZTgAfXr6B9Vr9f4MrCk0J94eDinffosiqw
         YF/A==
X-Forwarded-Encrypted: i=1; AJvYcCVckRNBJS616DS7kSZYwlI5BZid9qyeKIoNDBRfBod4qLRHs/+iZI7EGm4w7qGPAKVHleU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83deHV5WLrKimd1WET1wBhTbfRfsmeQVK0ny+5mW3Rge2p7oF
	xzFjUGYREEjthM0sGZLVkonY8SVb9IgWbalcxuDx68c9sRag/avhM85f
X-Gm-Gg: ASbGnctH3sugOzP7w9mOtM1BKweWQuJOTCOLnTzrtbb2044U9J4IGY2fVzC6v9wx90+
	rTvD5FvsULXhIpovlBEnOVb+l14YjRfcI/IokMF6zmZISWWRsIwP0BLG2bLo8oo8+kE+sHj0B5U
	V61iWj4id2jDbO3ZKBbs/q7VJqWRGFz4kW3n5DbUemRjR7lsm7w+hPmA8v+jwvXr19E6gXMgRfj
	oVWNcAQ5Sth7LjkThXK/oEf3VvF43CQCqY+nRQS5u2xmcNdmpo4aZLaenzXLRNR8EIP+LtE+/Eo
	PcyAN7vr8dvqtI3QfSgy7ho4OiYfa69T+5p7NKpS6Pdizlm84s+MzRuuFaKn1M/uWwhgCZ+k+65
	xpOVId4Cw/ANeuRxlHE+w9QdVKym9MD5S85lojgNfrMzGhN8FQWRxm6mNr9Kfbz1CA2oR6tCM5w
	An
X-Google-Smtp-Source: AGHT+IG5TVIcBVXNVfRRRP0eBuSXqvN18kuYbOl9tsHB7d+80qCpyYtQ3utyEIRlxpRY/uYBqFWLMg==
X-Received: by 2002:a05:600c:3503:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-459e7076757mr15614675e9.7.1754474831949;
        Wed, 06 Aug 2025 03:07:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5879d76sm44812575e9.24.2025.08.06.03.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:07:11 -0700 (PDT)
Message-ID: <350146ae-b909-4d9f-91f3-64bc2ddfcd60@gmail.com>
Date: Wed, 6 Aug 2025 11:07:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] clean up some code around editors
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250805024044.30024-1-ben.knoble+github@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250805024044.30024-1-ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 05/08/2025 03:40, D. Ben Knoble wrote:
> 
> These patches clean up some old code in the editor tests and subsystem
> that does not use our modern idioms. Patrick previously argued the test
> cleanup doesn't go far enough, and he may be right, but I think the
> preserving the semantics of the test for overrides /and/ automatically
> resetting the environment is tricky, unless we can use a subshell for
> the whole thing?

I think we could do it if we put the loop inside a subshell that was 
inside test_expect_success(). That would mean we'd have a single test 
for all the various combinations. That script could certainly use more 
cleanup to stop running git outside of test_expect_success() and use 
things like test_must_fail(), write_script(), test_commit_message() etc. 
but I think that can always come later. The first patch here is a 
welcome improvement even if it does not fix all the issues in that test 
file. The second patch looks good too.

Thanks for re-submitting these

Phillip

> v1: https://lore.kernel.org/git/20250520193506.95199-1-ben.knoble+github@gmail.com/
> Published-as: https://github.com/benknoble/tree/editor-cleanup
> 
> D. Ben Knoble (2):
>    t7005: sanitize test environment for subsequent tests
>    editor: use standard strvec API to receive environment for external
>      editors
> 
>   builtin/commit.c  |  2 +-
>   editor.c          | 10 +++++-----
>   editor.h          |  7 ++++---
>   t/t7005-editor.sh |  7 +++----
>   4 files changed, 13 insertions(+), 13 deletions(-)
> 
> Diff-intervalle :
> 1:  da4fcc237b ! 1:  a37db65107 t7005: sanitize test environment for subsequent tests
>      @@ Commit message
>           Some of the editor tests manipulate the environment or config in ways
>           that affect future tests (because they test a sequence of overrides),
>           but those modifications are visible to future tests and create a footgun
>      -    for them. Use test_config and undo environment modifications once
>      -    finished.
>      +    for them.
>      +
>      +    We can't make the environment-munging override tests undo their
>      +    modifications because they rely on editor variables overriding other
>      +    previously-set editor variables.
>      +
>      +    Use test_config and undo environment modifications once finished.
>       
>           Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>       
> 2:  7b3b6b08f0 ! 2:  5450c99f59 editor: use standard strvec API to receive environment for external editors
>      @@ Commit message
>           Going back to the introduction of the env parameter for the editor in
>           8babab95af (builtin-commit.c: export GIT_INDEX_FILE for launch_editor as
>           well., 2007-11-26), we pass a constant array of strings: as the
>      -    surrounding APIs evolved to use strvecs, the editor code did not.
>      +    surrounding APIs evolved to use strvecs (see 8d7aa4ba6a
>      +    (builtin/commit.c: remove the PATH_MAX limitation via dynamic
>      +    allocation, 2017-01-13) and later 46b225f153 (Merge branch 'jk/strvec',
>      +    2020-08-10)), the editor code did not.
>       
>           There is only one caller of all 3 editor APIs that does not pass a NULL
>           environment (the same caller for which this parameter was added), and
>           it already has a strvec available to use.
>       
>      -    Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>           Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>      +    Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>       
>        ## builtin/commit.c ##
>       @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
> 3:  cb48533115 < -:  ---------- run-command: prep_childenv on all platforms
> 4:  d2e54fdf75 < -:  ---------- drop git_exec_path() from non-Git commands' PATH
> 
> base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be

