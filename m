Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3F18FC70
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529243; cv=none; b=PJ23uqHh8pmmYTsaiW4suZMYWR2vu2DVhr0CmpFOQXEybMsa64940wCjz3vTXQtVvyC/M1fHWinvyxUqu14Pug15HiiefAm8rRXzlGgZ4HDKiilgefPEgNTn/PKeU5sPgwC6TYdwdEWFE98YH8V6dOAVdHORy9rHyONNtOYLGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529243; c=relaxed/simple;
	bh=v4yNsq6ujfDtOK2Orf+moulZd3mhPf/wevSsW7pYOHY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vq/RAeeJT5hTa/jGxnnYUOO877Qau5ru06q3+MUe2BAvSiPx8xZYa3VpBnifvvBJUlSpo4YiRwaWgyujT7+tFksOh1c1r3wFx/tlrsRHqGO00ZVww0Ubrr7Nx0BhDcc/8HZWEjHu8sUseKrBUFZ2BLObAgwEbmQl3N8P/45nQRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHoYMFsm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHoYMFsm"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3824446d2bcso3792045f8f.2
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 02:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732529240; x=1733134040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/G98BrnUlHtFo2kPh5/Zlbhewhrw5kQgRorj+6Ry8MQ=;
        b=EHoYMFsmzhddv4vtIHCQMFu9cc50sgqp3tSyicaT4rV+y6vvfBroG0ShfHHn6clSnq
         8e+DWg/tqkjMXm17QaM0CXly7ht4TyN9u52NUTAqUgYAv9ceL/alFgenD5Y2Zo8Ydshj
         ci+znS4LJNOY1LZ5Vu3WIP5NIh2g2skbzBr+Z9VYlTwSjaPNJ4sBTa0lbmh8rTNpLZWS
         z7Ug21I5qxXc3heFYAo0Odb5wlPdFls74X7mgCdMhlC3kJb7HZzOZg9MQPFZRAeEplOY
         abHwZ0qY3K9GfH9V8psIfN/gypYNkyO+RrQtvlUJXIbMABNewVcs6JKy2STMwchX9TLR
         trgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732529240; x=1733134040;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/G98BrnUlHtFo2kPh5/Zlbhewhrw5kQgRorj+6Ry8MQ=;
        b=MgZT5V+8PWfcSQFsSM6O4AuS2lJaJR3d7+s/1FsniKkpLQ2O3lU5C1MMa3Ye8pQhQb
         oZDHPeyH2V0sVCTpIa8nqUXNNk/NMEMS/hQ+XSq8LN0jV9yBliaYZBJdwNrlo+w7LxX5
         /LZ1xfeQtfPfgVfrtEFph7fPpwjl6EtE9kJ/TqgdfnKTPKfClyaqkEA26Te7NLNC23q9
         q2Zd8TldhivqYKyISS6PRcNc6WnLFExD/O3fXVmgG3nBIYzeUED/xRrJSwgffpD8O2Ol
         MFx011c3qTIuD5wLqPPb40G/mHeE5p4Mbac6cq8PvX3w45AF+aIAijipD0e3+eaHpyuv
         jYeg==
X-Forwarded-Encrypted: i=1; AJvYcCXeFpFdrkJtgvAdooiWtUe1Akv34r2Oaw0VYLchcgGrCw9bldqorNkEenau4RORk1YFua8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3btQ0OxYzbgDJ9f0MW4Y3JeivjWxVI4jfJvqtJMr2wSonP1Q
	1Dg4wT+roCJla1irfr4gUiG7q0l66y6f4GTEvH2ksQOJt5NYo4Z8C0ehNA==
X-Gm-Gg: ASbGncvZHW4/szRRmf/DptIxlxWKWHBMP1PEO+L2QoLfxDL76/vhIWTMNW2vTZqztlO
	/GAU2Mqxqf13Zc/esiYJgi5CU03UrhotvaCnU8GsZpzVDP9uQEwW9zLUu6Z4Ul4VdOUWiIKnIWH
	XnTqMPb7DZkyYKmQRSe7PCvOqAo/E/ywRwHeX7PYa1O1kGwE3ZELJjq3z8ry0A/ETcbspOEE7uy
	luDvKGAZCgVIgjrrU/UA0CWBwz0m0WXdK4bg3YFO4idymhiems7QoCitaw6Iy9W68v2S/MitXj0
	gPSW1cVvCs1LPSDFMKhHJ+d5m+6E
X-Google-Smtp-Source: AGHT+IE7fHJSU4sos9NQr5ylNzFlPg9DdtPUrVINjKGQRxNX5FgvwsArjcVoA1gz6rmFPbrImc3xYQ==
X-Received: by 2002:a05:6000:1788:b0:382:51d7:a2e0 with SMTP id ffacd0b85a97d-38260b61f45mr11575027f8f.27.1732529239851;
        Mon, 25 Nov 2024 02:07:19 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b? ([2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm9861161f8f.59.2024.11.25.02.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 02:07:19 -0800 (PST)
Message-ID: <7739a6e2-8758-4d0f-b1d6-f0879a89590f@gmail.com>
Date: Mon, 25 Nov 2024 10:07:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] sequencer: comment out properly in todo list
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, stolee@gmail.com,
 me@ttaylorr.com
References: <cover.1731406513.git.code@khaugsbakk.name>
 <cover.1732481200.git.code@khaugsbakk.name>
Content-Language: en-US
In-Reply-To: <cover.1732481200.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

Thanks for re-rolling, I've left some comments on the range-diff

On 24/11/2024 20:56, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Range-diff against v2:
> 1:  fc3b4438845 ! 1:  a46767263f6 sequencer: comment checked-out branch properly
 > [...]
>      @@ t/t3400-rebase.sh: test_expect_success 'rebase when inside worktree subdirectory
>       +	git checkout base &&
>       +	test_commit msg3 &&
>       +	git checkout topic2 &&
>      -+	git -c core.commentChar=% rebase --update-refs base
>      ++	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
>      ++		 rebase -i --update-refs base &&
>      ++	grep "% Ref refs/heads/wt-topic checked out at" actual &&
>      ++	grep "% Ref refs/heads/topic2 checked out at" actual

It would be nicer to use test_grep here as it prints a helpful message 
when the pattern is not found which aids debugging test failures

> 2:  710c5b1a3f6 ! 2:  7a452142666 sequencer: comment `--reference` subject line properly
 > [...]
>      @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'identification of reverted c
>       +test_expect_success 'git revert --reference with core.commentChar' '
>       +	test_when_finished "git reset --hard to-ident" &&
>       +	git checkout --detach to-ident &&
>      -+	git -c core.commentChar=% revert \
>      ++	GIT_EDITOR="cat | head -4 >actual" git -c core.commentChar=% revert \
>       +		--edit --reference HEAD &&

"cat" is not doing anything here, GIT_EDITOR="head -n4 > actual" is all 
you need (I've added "-n" there as I'm not sure how portable a bare "-4" 
is).

>      -+	git log -1 --format=%B HEAD >actual &&
>      -+	printf "This reverts commit $(git show -s \
>      -+ 		--pretty=reference HEAD^).\n\n" \
>      -+		>expect &&
>      ++	cat <<-EOF >expect &&
>      ++	% *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
>      ++
>      ++	This reverts commit $(git show -s --pretty=reference HEAD^).
>      ++
>      ++	EOF
>       +	test_cmp expect actual

This looks good - we're now checking that the user sees the comment when 
they edit the message.

>       +'
>       +
> 3:  86b4b485e0b ! 3:  4c342bc0422 sequencer: comment commit messages properly
>      @@ Metadata
>        ## Commit message ##
>           sequencer: comment commit messages properly
>       
>      +    The rebase todo editor has commands like `fixup -c` which affects
>      +    the commit messages of the rebased commits.[1]  For example:
>      +
>      +        pick hash1 <msg>
>      +        fixup hash2 <msg>
>      +        fixup -c hash3 <msg>
>      +
>      +    This says that hash2` and hash3 should be squashed into hash1 and

Stray "`"

>      +    that hash3’s commit message should be used for the resulting commit.
>      +    So the user is presented with an editor where the two first commit
>      +    messages are commented out and the third is not. 

I'd perhaps say

    If there are conflicts when applying commit hash3 then the user is
    presented ...

as we only show all the messages to the user when there are conflicts.

> However this does
>      +    not work if `core.commentChar`/`core.commentString` is in use since
>      +    the comment char is hardcoded (#) in this `sequencer.c` function.
>      +    As a result the first commit message will not be commented out.
>      +
>      +    † 1: See 9e3cebd97cb (rebase -i: add fixup [-C | -c] command,
>      +        2021-01-29)
>      +
>      +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>           Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      +    Reported-by: Taylor Blau <me@ttaylorr.com>
>           Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>       

Thanks for updating the trailers, they look good to me

Best Wishes

Phillip
