Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB72DCC04
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871362; cv=none; b=CFr4SeaiySDmP+udgCN1tH2i3/2Hglqmj1UntCpy1d5TEhju12nNvB2/1+K4I565O+3Ye1Ey1B28eut048Vzg/vXZQeMiXx9QNF3/YrpXmpP4fhGR8HcrsAQhv8X9jpvZvA6A59o2PvTSqKIEUQCxCPbyliYAovDt/iiAXC89Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871362; c=relaxed/simple;
	bh=4B8Tr4jjxVz1cds4zfmjXK9PS5ebf9WrqYmy2NG99oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GThFObdxMn6zVSqMkfiJW6rduAnHiKa4WZQ5gOF+CRI5beonv7Ob0Y6vNBleEK7rBkGWnW03qVTGa6ePvQUxtTV+zYf9WAa8IlMR+34VABH122azD8+cP1CkIFCznwcTKPBXsmv8GXVJFRZ/I2fvkSOUX025NVxxvh0mRJ2Vt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFyaIqLj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFyaIqLj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775895d69cso22340875e9.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 06:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762871358; x=1763476158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jkEkoieTSK4+4Uz3KnbmtsvDuUbgZxhLPmDKlssj1Zg=;
        b=ZFyaIqLjC+sHAPm2CeIclzfepBDpMtNIBY1EgSXSllnyfsDiQpiFDsaz+gNw/vPb8T
         osR4wiCrAJptZlCO2vR/1wQ2G5LLtd2FFD79A1IuMczs5pIfe3G/x7PJyK4KfVm9+Hg2
         zKgRF/a6c84o6SLhiTfnOdIgVvb9iQJ6Vg5tSQ37Gj9ZMxTPnz9/uJCYfSNgcn6olPuv
         hZw/sgw5LuC0gLw6zpDmQrvgb3fSIFRgPRk/UmnVE6qsZhVOavl3LJ5TEhPqMI1gXfCa
         aUyLOBxjipexw6a0UWqqvbRNZMzf9+oeneqM+5tp8unthspgpZfzxYTNREy9C7FNnVck
         8PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871358; x=1763476158;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkEkoieTSK4+4Uz3KnbmtsvDuUbgZxhLPmDKlssj1Zg=;
        b=bkB8iRItbIGe5b44tqABpIBDSXVHOFkHU0FBlUdZWTmD9gT290vjszdjMhcUtJaGvH
         Q2fZLtOp0cyxYiy6VfTfSmjBLa19HbwApMjnMfsQY3/YKNkovnDiURiDLIYj1qyZBPGj
         h1H0BHWUqEfU1Hrs+eHMReSaQuWmsYliSGS/tCxC0ppoTIF00JO5NC+5DdeWop4PrBn2
         k7J5sVq3HYg8fKHvJCMk3JjLu7SRbi1FrAfBahSuKQrmfhzDrrhSJacFJI24/ewQx1a5
         aNFNkNpQtx2HQF6Uk7coC5tcerQPr7SU5RioAB+rJTetsNT0JCFKozLM8xft/u7uXZVf
         fIjg==
X-Forwarded-Encrypted: i=1; AJvYcCW0BezrwIYO48KmgBBM5y7dJolOhMBE1uZwkeRut9iN0GuDLwIlNP++7SO9SlJ44aMkgcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0dYNY31Ra8covK8PkPQqEIIglJKv2hURKlkvPDOgEUY3d+Fwv
	0nSYklgwdxFxczTyK4TMjULIk/i136DDQ5HIW/n/+oX8728EKE6d7mOH
X-Gm-Gg: ASbGncvQCNgpmJ0jna4pRCMRsKCT5GOuGap9khAyzI+kTAZSe2XBMh5P0AjUhRYCPkZ
	lJQ80lospI2hWcDq67RDgyVQ8oWdhJC7nSTmrp6s+Bb6hucyqSGK3w6S4xTiw3LUXGMDBybzWI3
	Oih6ahim/s8eGlkkn+hDicGuz1Eg2Qk+QMujGGZ1ahDfHzcyxPD3ihcqnHzNziucIxsYnuo7TnF
	Duixyp59YOdWioWRKCybuswBshuegIkn0qQRS/FaIzkcnpRR8q/vh6KYnAtPU7SEQLMFz1tGqKY
	lV+eulqz22M+wXnoLqckXeD4Mh/MeIsTMbevSk4p8DHiFMxGPrx50w+lof/ayR2UsPGSUR4uA5g
	q4JEHQW//CTrMfnQ/s+lBShcWvtG9qbMb93JaMUcGz9jXzv0yc+6Df35MSNOhkkxu6P1FPwSw4/
	Qh1jOjUXmJUhgpW00SWiMHXdXyc0NulL6C2aOHPSxpUUgTKukmND87wURnNaXL+jaz2cASPwHiP
	A==
X-Google-Smtp-Source: AGHT+IGL2YM2mebXXrbbJDAsEDEVTm4ZU5CZij1jpmmBEl0+WEf18dzV9LGDch6szoVHFkHHXkOnVw==
X-Received: by 2002:a05:600c:4ed2:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-4777d945f1dmr59056875e9.27.1762871356728;
        Tue, 11 Nov 2025 06:29:16 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477773f7749sm180676455e9.7.2025.11.11.06.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:29:16 -0800 (PST)
Message-ID: <bc2b7b52-a8f9-473c-a6fe-2c0d3fa089ea@gmail.com>
Date: Tue, 11 Nov 2025 14:29:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/12] Incomplete lines
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20251105213052.1499224-1-gitster@pobox.com>
 <20251111000451.2243195-1-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251111000451.2243195-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2025 00:04, Junio C Hamano wrote:
> Changes in v3:
> 
>   - The proposed log message of [PATCH 05/12] explains that it
>     semi-duplicates the same code shared in two case arems in
>     preparation for later changes.
> 
>   - The internal helper function to emit the "\ No newline" marker
>     line is now called emit_incomplete_line_marker().
> 
>   - Two conditionals in [PATCH 07/12] both of which switched on !endp
>     have been consolidated into a single if/else statement.
> 
>   - The tests in [PATCH 11/12] checks the output from "diff --check"
>     now.

The range-diff looks good. I'm still not keen on patch 4 but all the 
other diff related changes look fine to me.

Thanks

Phillip

> 
> Changes in v2:
> 
>   - rolled the definition (but not implementation) of the new
>     "incomplete-line" class into step [09/12] that shifts the bit
>     assignment.  The documentation of core.whitespace has also be
>     updated in this step.
> 
>   - "git apply --check" miscounted line number reported for the
>     incomplete line error, which has been corrected in step [10/12].
> 
>   - t4124-apply-ws-rule.sh has been extended to cover "git apply
>     --check" and the diagnostic output from it in step [10/12].
> 
> Junio C Hamano (12):
>    whitespace: correct bit assignment comments
>    diff: emit_line_ws_markup() if/else style fix
>    diff: correct suppress_blank_empty hack
>    diff: fix incorrect counting of line numbers
>    diff: refactor output of incomplete line
>    diff: call emit_callback ecbdata everywhere
>    diff: update the way rewrite diff handles incomplete lines
>    apply: revamp the parsing of incomplete lines
>    whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
>    apply: check and fix incomplete lines
>    diff: highlight and error out on incomplete lines
>    attr: enable incomplete-line whitespace error for this project
> 
>   .gitattributes                 |   4 +-
>   Documentation/config/core.adoc |   2 +
>   apply.c                        |  79 ++++++++++----
>   diff.c                         | 152 ++++++++++++++++++---------
>   diff.h                         |   6 +-
>   t/t4015-diff-whitespace.sh     |  67 +++++++++++-
>   t/t4124-apply-ws-rule.sh       | 187 +++++++++++++++++++++++++++++++++
>   ws.c                           |  20 ++++
>   ws.h                           |  26 +++--
>   9 files changed, 455 insertions(+), 88 deletions(-)
> 
> Range-diff against v2:
>   1:  c045e93ce5 =  1:  c045e93ce5 whitespace: correct bit assignment comments
>   2:  0d95d68fb4 =  2:  0d95d68fb4 diff: emit_line_ws_markup() if/else style fix
>   3:  c331218334 =  3:  c331218334 diff: correct suppress_blank_empty hack
>   4:  be1473fc5a =  4:  be1473fc5a diff: fix incorrect counting of line numbers
>   5:  7bcd6efba8 !  5:  9410e4257a diff: refactor output of incomplete line
>      @@ Commit message
>           the code path that handles xdiff output and the code path that
>           bypasses xdiff and produces complete rewrite patch.
>       
>      +    Currently the output from the DIFF_SYMBOL_CONTEXT_INCOMPLETE case
>      +    still (ab)uses the same code as what is used for context lines, but
>      +    that would change in a later step where we introduce support for
>      +    incomplete line detection.
>      +
>           Signed-off-by: Junio C Hamano <gitster@pobox.com>
>       
>        ## diff.c ##
>      @@ diff.c: static void emit_context_line(struct emit_callback *ecbdata,
>        	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT, line, len, flags);
>        }
>        
>      -+static void emit_incomplete_line(struct emit_callback *ecbdata,
>      -+				 const char *line, int len)
>      ++static void emit_incomplete_line_marker(struct emit_callback *ecbdata,
>      ++					const char *line, int len)
>       +{
>       +	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
>       +			 line, len, 0);
>      @@ diff.c: static int fn_out_consume(void *priv, char *line, unsigned long len)
>        		}
>       -		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
>       -				 line, len, 0);
>      -+		emit_incomplete_line(ecbdata, line, len);
>      ++		emit_incomplete_line_marker(ecbdata, line, len);
>        		break;
>        	default:
>        		BUG("fn_out_consume: unknown line '%s'", line);
>   6:  1a6f143377 =  6:  cdc6516009 diff: call emit_callback ecbdata everywhere
>   7:  dfc810b1d6 !  7:  9acb9b6217 diff: update the way rewrite diff handles incomplete lines
>      @@ diff.c: static void emit_rewrite_lines(struct emit_callback *ecbdata,
>       +		char *pdata = NULL;
>        
>        		endp = memchr(data, '\n', size);
>      - 		len = endp ? (endp - data + 1) : size;
>      -+		plen = len;
>      +-		len = endp ? (endp - data + 1) : size;
>       +
>      -+		if (!endp) {
>      ++		if (endp) {
>      ++			len = endp - data + 1;
>      ++			plen = len;
>      ++		} else {
>      ++			len = size;
>       +			plen = len + 1;
>       +			pdata = xmalloc(plen + 2);
>       +			memcpy(pdata, data, len);
>      @@ diff.c: static void emit_rewrite_lines(struct emit_callback *ecbdata,
>       +	if (!endp) {
>       +		static const char nneof[] = "\\ No newline at end of file\n";
>       +		ecbdata->last_line_kind = prefix;
>      -+		emit_incomplete_line(ecbdata, nneof, sizeof(nneof) - 1);
>      ++		emit_incomplete_line_marker(ecbdata, nneof, sizeof(nneof) - 1);
>       +	}
>        }
>        
>   8:  c66b547f13 =  8:  86c14ee62d apply: revamp the parsing of incomplete lines
>   9:  bdc2dbbe4b =  9:  b62d4020e7 whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
> 10:  806aa30511 = 10:  081c21b14e apply: check and fix incomplete lines
> 11:  0cfb6ab295 ! 11:  73182b19a8 diff: highlight and error out on incomplete lines
>      @@ diff.c: static void emit_diff_symbol_from_struct(struct diff_options *o,
>        		emit_line(o, set, reset, line, len);
>        		break;
>       @@ diff.c: static void emit_context_line(struct emit_callback *ecbdata,
>      - static void emit_incomplete_line(struct emit_callback *ecbdata,
>      - 				 const char *line, int len)
>      + static void emit_incomplete_line_marker(struct emit_callback *ecbdata,
>      + 					const char *line, int len)
>        {
>       +	int last_line_kind = ecbdata->last_line_kind;
>       +	unsigned flags = (last_line_kind == '+'
>      @@ t/t4015-diff-whitespace.sh: do
>       +'
>       +
>       +test_expect_success "incomplete lines on both pre- and post-image" '
>      -+	# The interpretation taken here is "since you are toucing
>      ++	# The interpretation taken here is "since you are touching
>       +	# the line anyway, you would better fix the incomplete line
>       +	# while you are at it."  but this is debatable.
>       +	echo foo | tr -d "\012" >x &&
>       +	git add x &&
>       +	echo bar | tr -d "\012" >x &&
>       +	git diff x &&
>      -+	test_must_fail git -c core.whitespace=incomplete diff --check x &&
>      ++	test_must_fail git -c core.whitespace=incomplete diff --check x >error &&
>      ++	test_grep "no newline at the end of file" error &&
>       +	git diff -R x &&
>      -+	test_must_fail git -c core.whitespace=incomplete diff -R --check x
>      ++	test_must_fail git -c core.whitespace=incomplete diff -R --check x >error &&
>      ++	test_grep "no newline at the end of file" error
>       +'
>       +
>       +test_expect_success "fix incomplete line in pre-image" '
>      @@ t/t4015-diff-whitespace.sh: do
>       +	git diff x &&
>       +	git -c core.whitespace=incomplete diff --check x &&
>       +	git diff -R x &&
>      -+	test_must_fail git -c core.whitespace=incomplete diff -R --check x
>      ++	test_must_fail git -c core.whitespace=incomplete diff -R --check x >error &&
>      ++	test_grep "no newline at the end of file" error
>       +'
>       +
>       +test_expect_success "new incomplete line in post-image" '
>      @@ t/t4015-diff-whitespace.sh: do
>       +	git add x &&
>       +	echo bar | tr -d "\012" >x &&
>       +	git diff x &&
>      -+	test_must_fail git -c core.whitespace=incomplete diff --check x &&
>      ++	test_must_fail git -c core.whitespace=incomplete diff --check x >error &&
>      ++	test_grep "no newline at the end of file" error &&
>       +	git diff -R x &&
>       +	git -c core.whitespace=incomplete diff -R --check x
>       +'
> 12:  33c5ae40db = 12:  85748701b4 attr: enable incomplete-line whitespace error for this project

