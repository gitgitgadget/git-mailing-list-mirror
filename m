Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9002D5A14
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786426; cv=none; b=ZTZWB9CrC92Ud7i52bsFh0Dk8J7bRVv1rtQwkTc2KckPar7ZH4zvYnrb4Nh9RnhrOLQ1ntq2k6e8PytbeA3vQHtiKMOlR3JfUmXy/I2kXwC+y6uAw0j4hC7BnN5UnwLjNX4uyw68+Y+moZUYB7d1NDFiPyIi0Th+PLMRMiI/82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786426; c=relaxed/simple;
	bh=Dly8OaLJJK7qBCWhe4WQliOdmzHfX/x6C5abxQzRMX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sM+YRWfEocb3vBrJxSygEQT7DJc/92R1eBc2ceOonfRtZiEwuU3ArhgKQUdvB/6ZP4XccEvacHTT0K5qpSO0AB1V+UUJVmgHWF6tAS3hwyymsqbjG7Z+OfIemDi+fj1FGB7MPy85PrN6XiroVAm1OEaW3iQW5OzZyht2PThLhh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aigPpQCK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aigPpQCK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47774d3536dso14312785e9.0
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786423; x=1763391223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2TEhbv9JVQkHS3XJH7Pcm8eBjUcBJyoTHmzLbPGbNTE=;
        b=aigPpQCKLHAwNrmoEbc4mgfODwZ3J0Pe0A37OS0boaZeQ8pYiTpXVKJiHKDCHqRlYg
         FjdjayWmvBDwI4P1x+Y+W/dUDAxxkYmARWNW4wP+K2MtpR3ObKYY6QQduHWu6Nde2Lqo
         MVVf9JMmsEtoxrgC100z+ISpCsQHQMXPSMg7m00cPay0eFiObI1IVI9QuihnIfarLMU+
         iyPMIVzg6B5xnGrkbGtpgJvta9WFvveEh7x1iEQ0kWN/dmW0oNhI+O9CdhWr0WqTxIuK
         OmYAtlZRSgjYkplO/pxE42DiItg0/LNm+GD790RqKsqj+jcK6VsMYp5YVGtChPDui+PI
         ISeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786423; x=1763391223;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TEhbv9JVQkHS3XJH7Pcm8eBjUcBJyoTHmzLbPGbNTE=;
        b=lIEiD7vt0b6AvBO7fNsx+pyJBAT3D40xIKWMzUgj2aK/X2L1qE1kIVyM3xrP35zEiR
         W4243vkJlWBeAgLwvibu5uyKdHZSINfL+5ymfgjy9Mx/GOski/MfnorUyMUbcxKP178T
         mADhzv9hxjklyxl/4uGjkmx1yzYIKRTlzBtJenvlWOcRPHVGoehaBCWaCMnWDPd7qtEX
         GojnqhHXljTjpyphWNc/VgDV66LDOXk+hE7geX7rf3Fc0+0Da17uFLjeB8WL8tK8HgrM
         4yaBjN7P1Ws0dJWuNFRKeRGpwm/iC2xC+UnTpvE+h94umKLrgMkh5EVtRLVR5fUVFLvC
         52kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmGEPOqLzCLDZmthlNoXKJJ3IoV01GAfrqeVjRX+QLiDYSxA8/d8j8kUswGINw/GAt1Os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypv7dL1D3Lh3jGApA0eyuL2Rc7oAqqQeBBOtnJxBvzKOwv1dLk
	bE8I8y8Yz72Aj2ZLZfwe5EvUj6N5+v4jacMNI1xuV/NocK/tyAVQO1JOokLPYQ==
X-Gm-Gg: ASbGncvTEkO3JHYtFeE0/QTA8+U9QCB1FKJfiBFaeWjoVDp9ReD4kxKvorGzVjJOrJC
	fXEJnBIa1+6PGpMZS5xJLkK2OEzPtA6PwGYBl2BpJvFIbxjGDXPtNfa6GzsHzth604X0IzXxkst
	3j7H/vgyGAPHE+6VP66by2dbB2CCskGSSTZVk+vQGhZAdSZZ4tkn1CDXi2bgSqrGKJ9M7weWbro
	U1URRHot/860csOiTodjx7g1jEBaKfw71ecDD/GhtGT1VzqMQa+s4SsLCnz20Mwq5b1etHDO4RT
	NG58VcC+HiP8z9sG61U7KFkXpgoVcQzLgGpCL1bNt7QiKsVxsWoqZrj3tW4Qcd0lU6GEhYkOfB+
	z9vRbkSp1/WBJOwDGZkR3veHmUSF+8lJFP4/yC+M5xbTQlafhVKES4WLq3CMu4pyBT4xUuziP61
	1gihXLRXP8tE95ZEo4uvzNg40d5Kgka/Uj1mvTS1HXe7xF78vv7DJdyqx0NtNHT6U=
X-Google-Smtp-Source: AGHT+IFs38aaPk8VhGgTb7OVv+FDXrK8PdPTArkkk1uvXqv1rEkgBeCUWYGpZ6G9PkYTBB5SjbS5yQ==
X-Received: by 2002:a05:600c:1913:b0:477:7a94:6918 with SMTP id 5b1f17b1804b1-4777a946ba0mr43829685e9.18.1762786422344;
        Mon, 10 Nov 2025 06:53:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777bbb8cf3sm28831685e9.15.2025.11.10.06.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:53:41 -0800 (PST)
Message-ID: <d2bdce87-fcd9-4f2f-a46d-b6af58af6e7e@gmail.com>
Date: Mon, 10 Nov 2025 14:53:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/12] Incomplete lines
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251105213052.1499224-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 05/11/2025 21:30, Junio C Hamano wrote:
> One of the common kind of whitespace errors is to lack the final
> newline at the end of a file, but so far, neither "git diff" or "git
> apply" did anything about them.
> 
> This series introduces "incomplete-line" whitespace error class,
> that you can add to either the core.whitespace configuration
> variable, or the whitespace attribute in your .gitattributes files.

I've read through all the diff related changes but not the changes to 
apply. I've left a few comments but the cleanups and the new 
implementation of the new feature look good to me.

Thanks

Phillip


> The class is disabled by default, so the final step enables it for
> our project by defining it in the .gitattributes file.
> 
> The incomplete line marker that is given for a context line is not
> considered an error.  The reasoning is that your preimage did have
> incomplete line, but you did not touch the contents on that
> incomplete line in your patch, so you left the line intact.  It is
> not a new breakage you are responsible for.
> 
> If the incomplete line marker follows a postimage line, on the other
> hand, it means that you added a new line at the end of the file that
> is incomplete *and* that line did not exist in the preimage.  The
> last line of the preimage may have been incomplete already, but then
> you updated the contents on that line, so you could have easily
> fixed the incompleteness of the line while at it.  Either way, you
> are responsible for the incompleteness of the last ine in the
> resulting file.
> 
> The organization of the series is as follows.
> 
>   * The first patch [01/12] is a clean-up we have seen earlier on the
>     list already (https://lore.kernel.org/git/xmqqfrb4hyjl.fsf@gitster.g/).
> 
>   * The patches [02/12] - [08/12] are preliminary clean-up made to
>     both "git diff" and "git apply" machinery.
> 
>   * The patch [09/12] shifts the bit assignment (cleaned-up in
>     [01/12] without changing any values) to make room for new
>     whitespace error class (which was last updated in 2007 IIRC, so
>     the set of whitespace errors surprisingly haven't changed for
>     quite some time), and defines the new "incomplete-line" class.
> 
>   * The patch [10/12] teaches "git apply --whitespace=<mode>" and
>     "git apply --check" about the incomplete-line error class.
> 
>   * The patch [11/12] teaches "git diff [--check]" about the
>     incomplete-line error class.
> 
>   * The final patch [12/12] enables the incomplete-line error class
>     for our project for C source files and shell scripts.  I didn't
>     touch the cover-all * entry.
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
>   diff.c                         | 148 +++++++++++++++++---------
>   diff.h                         |   6 +-
>   t/t4015-diff-whitespace.sh     |  63 ++++++++++-
>   t/t4124-apply-ws-rule.sh       | 187 +++++++++++++++++++++++++++++++++
>   ws.c                           |  20 ++++
>   ws.h                           |  26 +++--
>   9 files changed, 448 insertions(+), 87 deletions(-)
> 
> Range-diff against v1:
>   1:  4168f28fe7 =  1:  8a493cdea5 whitespace: correct bit assignment comments
>   2:  53b7a010e7 =  2:  a01d99a055 diff: emit_line_ws_markup() if/else style fix
>   3:  d93dd05543 =  3:  e3ea40af19 diff: correct suppress_blank_empty hack
>   4:  5f58400bd7 =  4:  e15e89d3e2 diff: fix incorrect counting of line numbers
>   5:  84c4ca147f =  5:  c007b3d7a7 diff: refactor output of incomplete line
>   6:  55b42a1944 =  6:  0cea57091b diff: call emit_callback ecbdata everywhere
>   7:  6947838d13 =  7:  523196b440 diff: update the way rewrite diff handles incomplete lines
>   8:  63c36c6f70 =  8:  e098932784 apply: revamp the parsing of incomplete lines
>   9:  00b645bb4e !  9:  28538f149f whitespace: allocate a few more bits
>      @@ Metadata
>       Author: Junio C Hamano <gitster@pobox.com>
>       
>        ## Commit message ##
>      -    whitespace: allocate a few more bits
>      +    whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
>       
>           Reserve a few more bits in the diff flags word to be used for future
>      -    whitespace rules.  No behaviour changes intended.
>      +    whitespace rules.  Add WS_INCOMPLETE_LINE without implementing the
>      +    behaviour (yet).
>       
>           Signed-off-by: Junio C Hamano <gitster@pobox.com>
>       
>      + ## Documentation/config/core.adoc ##
>      +@@ Documentation/config/core.adoc: core.whitespace::
>      +   part of the line terminator, i.e. with it, `trailing-space`
>      +   does not trigger if the character before such a carriage-return
>      +   is not a whitespace (not enabled by default).
>      ++* `incomplete-line` treats the last line of a file that is missing the
>      ++  newline at the end as an error (not enabled by default).
>      + * `tabwidth=<n>` tells how many character positions a tab occupies; this
>      +   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
>      +   errors. The default tab width is 8. Allowed values are 1 to 63.
>      +
>        ## diff.c ##
>       @@ diff.c: enum diff_symbol {
>        
>      @@ diff.h: struct diff_options {
>        	const char *prefix;
>        	int prefix_length;
>       
>      + ## ws.c ##
>      +@@ ws.c: static struct whitespace_rule {
>      + 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
>      + 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
>      + 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
>      ++	{ "incomplete-line", WS_INCOMPLETE_LINE, 0, 0 },
>      + };
>      +
>      + unsigned parse_whitespace_rule(const char *string)
>      +@@ ws.c: char *whitespace_error_string(unsigned ws)
>      + 			strbuf_addstr(&err, ", ");
>      + 		strbuf_addstr(&err, "tab in indent");
>      + 	}
>      ++	if (ws & WS_INCOMPLETE_LINE) {
>      ++		if (err.len)
>      ++			strbuf_addstr(&err, ", ");
>      ++		strbuf_addstr(&err, "no newline at the end of file");
>      ++	}
>      + 	return strbuf_detach(&err, NULL);
>      + }
>      +
>      +
>        ## ws.h ##
>       @@ ws.h: struct strbuf;
>      + #define WS_CR_AT_EOL            (1<<9)
>      + #define WS_BLANK_AT_EOF         (1<<10)
>      + #define WS_TAB_IN_INDENT        (1<<11)
>      ++#define WS_INCOMPLETE_LINE      (1<<12)
>      +
>      + #define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
>      + #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
>        #define WS_TAB_WIDTH_MASK       ((1<<6)-1)
>        
>        /* All WS_* -- when extended, adapt constants defined after diff.c:diff_symbol */
> 10:  662f15d0b4 ! 10:  7369e77309 apply: check and fix incomplete lines
>      @@ Commit message
>           what happens when A ends in an incomplete line, for example), and
>           text-oriented tools often mishandle such a line.
>       
>      -    Introduce a new whitespace rule "incomplete-line", which is off by
>      -    default for backward compatibility's sake, so that "git apply
>      +    Implement checks in "git apply" for incomplete lines, which is off
>      +    by default for backward compatibility's sake, so that "git apply
>           --whitespace={fix,warn,error}" can notice, warn against, and fix
>           them.
>       
>      @@ Commit message
>       
>           Signed-off-by: Junio C Hamano <gitster@pobox.com>
>       
>      + ## apply.c ##
>      +@@ apply.c: static void record_ws_error(struct apply_state *state,
>      + 	    state->squelch_whitespace_errors < state->whitespace_error)
>      + 		return;
>      +
>      ++	/*
>      ++	 * line[len] for an incomplete line points at the "\n" at the end
>      ++	 * of patch input line, so "%.*s" would drop the last letter on line;
>      ++	 * compensate for it.
>      ++	 */
>      ++	if (result & WS_INCOMPLETE_LINE)
>      ++		len++;
>      ++
>      + 	err = whitespace_error_string(result);
>      + 	if (state->apply_verbosity > verbosity_silent)
>      + 		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
>      +@@ apply.c: static int parse_fragment(struct apply_state *state,
>      + 		}
>      +
>      + 		/* eat the "\\ No newline..." as well, if exists */
>      +-		len += skip_len;
>      ++		if (skip_len) {
>      ++			len += skip_len;
>      ++			state->linenr++;
>      ++		}
>      + 	}
>      + 	if (oldlines || newlines)
>      + 		return -1;
>      +
>        ## t/t4124-apply-ws-rule.sh ##
>       @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excluded paths' '
>        	git apply --include=used --stat --whitespace=error <patch
>      @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
>       +	git apply --whitespace=error <patch &&
>       +	test_cmp sample2-i target &&
>       +
>      ++	cat sample-i >target &&
>      ++	git apply --whitespace=error --check <patch 2>error &&
>      ++	test_cmp sample-i target &&
>      ++	test_must_be_empty error &&
>      ++
>       +	cat sample2-i >target &&
>       +	git apply --whitespace=error -R <patch &&
>      -+	test_cmp sample-i target
>      ++	test_cmp sample-i target &&
>      ++
>      ++	cat sample2-i >target &&
>      ++	git apply -R --whitespace=error --check <patch 2>error &&
>      ++	test_cmp sample2-i target &&
>      ++	test_must_be_empty error
>       +'
>       +
>       +test_expect_success 'last line made incomplete (error)' '
>      @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
>       +	test_must_fail git apply --whitespace=error <patch 2>error &&
>       +	test_grep "no newline" error &&
>       +
>      ++	cat sample >target &&
>      ++	test_must_fail git apply --whitespace=error --check <patch 2>actual &&
>      ++	test_cmp sample target &&
>      ++	cat >expect <<-\EOF &&
>      ++	<stdin>:10: no newline at the end of file.
>      ++	6
>      ++	error: 1 line adds whitespace errors.
>      ++	EOF
>      ++	test_cmp expect actual &&
>      ++
>       +	cat sample-i >target &&
>       +	git apply --whitespace=error -R <patch &&
>       +	test_cmp sample target &&
>       +
>      ++	cat sample-i >target &&
>      ++	git apply --whitespace=error --check -R <patch 2>error &&
>      ++	test_cmp sample-i target &&
>      ++	test_must_be_empty error &&
>      ++
>       +	cat sample >target &&
>       +	git apply --whitespace=fix <patch &&
>       +	test_cmp sample target
>      @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
>       +	git apply --whitespace=error <patch &&
>       +	test_cmp sample target &&
>       +
>      ++	cat sample-i >target &&
>      ++	git apply --whitespace=error --check <patch 2>error &&
>      ++	test_cmp sample-i target &&
>      ++	test_must_be_empty error &&
>      ++
>       +	cat sample >target &&
>       +	test_must_fail git apply --whitespace=error -R <patch 2>error &&
>       +	test_grep "no newline" error &&
>       +
>       +	cat sample >target &&
>      ++	test_must_fail git apply --whitespace=error --check -R <patch 2>actual &&
>      ++	test_cmp sample target &&
>      ++	cat >expect <<-\EOF &&
>      ++	<stdin>:9: no newline at the end of file.
>      ++	6
>      ++	error: 1 line adds whitespace errors.
>      ++	EOF
>      ++	test_cmp expect actual &&
>      ++
>      ++	cat sample >target &&
>       +	git apply --whitespace=fix -R <patch &&
>       +	test_cmp sample target
>       +'
>      @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
>       +	git apply --whitespace=error <patch &&
>       +	test_cmp sample3 target &&
>       +
>      ++	cat sample-i >target &&
>      ++	git apply --whitespace=error --check <patch 2>error &&
>      ++	test_cmp sample-i target &&
>      ++	test_must_be_empty error &&
>      ++
>       +	cat sample3 >target &&
>       +	test_must_fail git apply --whitespace=error -R <patch 2>error &&
>       +	test_grep "no newline" error &&
>       +
>       +	cat sample3 >target &&
>      ++	test_must_fail git apply --whitespace=error -R --check <patch 2>actual &&
>      ++	test_cmp sample3 target &&
>      ++	cat >expect <<-\EOF &&
>      ++	<stdin>:9: no newline at the end of file.
>      ++	6
>      ++	error: 1 line adds whitespace errors.
>      ++	EOF
>      ++	test_cmp expect actual &&
>      ++
>      ++	cat sample3 >target &&
>       +	git apply --whitespace=fix -R <patch &&
>       +	test_cmp sample target
>       +'
>      @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
>       +	test_must_fail git apply --whitespace=error <patch 2>error &&
>       +	test_grep "no newline" error &&
>       +
>      ++	cat sample-i >target &&
>      ++	test_must_fail git apply --whitespace=error --check <patch 2>actual &&
>      ++	test_cmp sample-i target &&
>      ++	cat >expect <<-\EOF &&
>      ++	<stdin>:11: no newline at the end of file.
>      ++	7
>      ++	error: 1 line adds whitespace errors.
>      ++	EOF
>      ++	test_cmp expect actual &&
>      ++
>       +	cat sample3-i >target &&
>       +	test_must_fail git apply --whitespace=error -R <patch 2>error &&
>       +	test_grep "no newline" error &&
>       +
>      ++	cat sample3-i >target &&
>      ++	test_must_fail git apply --whitespace=error --check -R <patch 2>actual &&
>      ++	test_cmp sample3-i target &&
>      ++	cat >expect <<-\EOF &&
>      ++	<stdin>:9: no newline at the end of file.
>      ++	6
>      ++	error: 1 line adds whitespace errors.
>      ++	EOF
>      ++	test_cmp expect actual &&
>      ++
>       +	cat sample-i >target &&
>       +	git apply --whitespace=fix <patch &&
>       +	test_cmp sample3 target &&
>      @@ t/t4124-apply-ws-rule.sh: test_expect_success 'whitespace check skipped for excl
>        test_done
>       
>        ## ws.c ##
>      -@@ ws.c: static struct whitespace_rule {
>      - 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
>      - 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
>      - 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
>      -+	{ "incomplete-line", WS_INCOMPLETE_LINE, 0, 0 },
>      - };
>      -
>      - unsigned parse_whitespace_rule(const char *string)
>      -@@ ws.c: char *whitespace_error_string(unsigned ws)
>      - 			strbuf_addstr(&err, ", ");
>      - 		strbuf_addstr(&err, "tab in indent");
>      - 	}
>      -+	if (ws & WS_INCOMPLETE_LINE) {
>      -+		if (err.len)
>      -+			strbuf_addstr(&err, ", ");
>      -+		strbuf_addstr(&err, "no newline at the end of file");
>      -+	}
>      - 	return strbuf_detach(&err, NULL);
>      - }
>      -
>       @@ ws.c: static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
>        	if (trailing_whitespace == -1)
>        		trailing_whitespace = len;
>      @@ ws.c: void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws
>        	/*
>        	 * Strip trailing whitespace
>        	 */
>      -
>      - ## ws.h ##
>      -@@ ws.h: struct strbuf;
>      - #define WS_CR_AT_EOL            (1<<9)
>      - #define WS_BLANK_AT_EOF         (1<<10)
>      - #define WS_TAB_IN_INDENT        (1<<11)
>      -+#define WS_INCOMPLETE_LINE      (1<<12)
>      -
>      - #define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
>      - #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
> 11:  36de2ac901 = 11:  17c2fa50a7 diff: highlight and error out on incomplete lines
> 12:  e82056bf55 = 12:  73af29fba7 attr: enable incomplete-line whitespace error for this project

