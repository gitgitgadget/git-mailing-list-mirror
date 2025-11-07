Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8B2F692C
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530604; cv=none; b=QiTPR90bvtqGAwTCYNqE6bt8cdf5ksqgxZNLUlU+Ol2Oh8EWwbwsATYzt19sJ6Fx/roz0+L387EEyFXDBKae1OhwB9E3S7VN0BH66A2GAreO+XpvPtTLHh6+55KLTpoKAcsXd380wQnlcot4FFUQeSojLH/QiPPqS/d85zJNVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530604; c=relaxed/simple;
	bh=8EIof9o15QXUeiA5Y9Cq5R5ucCxV5wfcB7iRF2FZfj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxYo2X/U6wmEIjoCUlTPnoRZz1IVMOqCLAn+/zGbJeP/cN3gjLEVjgo30Cw67LPW6Cc6xXfSuNbYXdhHu1nysxPLJOGC+BQ3QytRSYYIGJgAHlQHNEUeEbHZdOakcG67djRZMOKLPP9rW3EShnSAsPA+64Z5+lxSo8uuprowTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzoryPn7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzoryPn7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477442b1de0so5890185e9.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762530601; x=1763135401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VAR/SbI2d43MxYij7uoy+gJI2DtBwSWBzSvKPZGztDY=;
        b=OzoryPn7KMZtwSNFrZZzV0CbH3wTYyISr0L2mAq4QX1xRfYODMltA5BUicc710DlZi
         LMLQPwfPfHe+LFRl73fm4ZRLgaWx1yMHi48qaEC7MmJc8Fv5baESAirGkg5wNK05MGAl
         6TYsFR5H3IMQnSgX4GpMUL3hR/LFvcGN8JE/rPNk12Z/4G4Cvpuh0cLaAP6GiL2g625i
         KC71euL64cDOe2Lp4J3I8edlNynndJKb207JAcxcyDtKjK6sl4SG8KXfjAoWbT1bJ4LU
         9DwH7yHLfe1ytlCEn9NibqBBoLoy0ncT8tF0amLFkPU6lJ/BZ2SMVk3L4p/HAMpx6+NZ
         wrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530601; x=1763135401;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAR/SbI2d43MxYij7uoy+gJI2DtBwSWBzSvKPZGztDY=;
        b=PpIB+HXJeeRz9lhiDj3GTdW26ljU007XVw5xmZxnn9gGm4pGfFT7qpJA4M7y3rAG+7
         GZiRGECmVttf3Xn7Fhn9fujeRcLbG9A3/ZSfbiADvJEgW4RbhmViCOOhF8xhx4RoBnrq
         8CbbWBGuXeqTuPTo4OuAdeFGMzlss0YWJEv8imAr9Qf00BLdEtIlgFPeRbNWAnzeRlIv
         Z8LQVoNdbFfSsKk85t4Hk5/Z0p0sQEia4OH6pXlpgM0sv+BT0HW+3SXMOQOhoFbJUi3F
         jxNbT1ZABhE7N82vyGhP+1NZBuM/s+Do75W4ZQ0rQ32SBBfKmkAs0e1nMGjimQRLRAjp
         ojoA==
X-Forwarded-Encrypted: i=1; AJvYcCXhCx1er6diKlNret8rENvnbDV0CTRUzOkZrZLeKzBdks3da9xwgeSxcauKQ3OWtK0zMW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iBfe911XxMq8+1M9WdIIK2Krc7KNM/sE3s5C5VNlOaByFrw/
	2wjkep5nYfKNWmmrL9wvQCYiDKZE1bfGndi5OeBZlY8bCmtRICSLbESu
X-Gm-Gg: ASbGncuSoFrL7BfLH9H/Y5XpdySNfZJx+nwF8NFuG33gjF6P/uIXIZ4eeSo7ReSAyO+
	vx+8eJ1kmM8Vvvk8D5ksi/UEhQU1PuBtki9F+RrEEPmp0g8lbNsXyECtgv8r15XR9tPk3R8Bmpf
	fYiQbEGvDXaHvUL1AK56AZ7/Gx+sNAh81eTYPxTcVlTLjJPpcJWTtyarKZBEMBWsOUOJVDq+45G
	qc6j9uL6+/kj+0WWGjn1VMhtliJpumq48OyZKGrMtvl/Wc4+8FqcTYfn0NZwB1lGlxEDxqZos/Z
	g8dW4n1gpO8+dqcoXBumLCuZfs70HnOQdRiMK+NzvANBzcwQ2F4/kQLAAjsDQKJNvXSq2l/XO0o
	js4V26UktBDq2p6rb6kWZjrmWAcj7fmNSITlDNV3XqWpwlHjHgEQIfGdJ0oZxxO0rRHNB81qcWA
	/HO5N5N1qUkvoZFZ4W7bXuao1nF2nBmCn3rOF2vc8Q3lOy+2kZuZPwq+59t7IMF94=
X-Google-Smtp-Source: AGHT+IFN2OZO4TKAciRzDk+LDurpMNQhFiMjWbwAcdPRSs3TRFwKU70GyEdiedGN2KM7jyO4lNzMXQ==
X-Received: by 2002:a05:600c:1e8b:b0:477:1326:7b4b with SMTP id 5b1f17b1804b1-4776bcb59f2mr31416715e9.19.1762530600448;
        Fri, 07 Nov 2025 07:50:00 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67920fcsm6249919f8f.39.2025.11.07.07.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 07:49:59 -0800 (PST)
Message-ID: <08a6c461-e162-4eee-a42d-1da8f05a0606@gmail.com>
Date: Fri, 7 Nov 2025 15:49:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/2] blame: make diff algorithm configurable
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
 <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

On 06/11/2025 22:41, Antonin Delpeuch via GitGitGadget wrote:
> Changes since v4:
> 
>   * hide --minimal option
>   * simplify tests to minimize spun processes
>   * remove redundant XDF_NEED_MINIMAL in bit mask

Excellent, the range-diff below looks good. Thanks for working on this

Phillip

> Antonin Delpeuch (2):
>    xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
>    blame: make diff algorithm configurable
> 
>   Documentation/diff-algorithm-option.adoc |  20 +++
>   Documentation/diff-options.adoc          |  21 +--
>   Documentation/git-blame.adoc             |   2 +
>   builtin/blame.c                          |  52 +++++-
>   diff.c                                   |   2 -
>   merge-ort.c                              |   2 -
>   t/meson.build                            |   1 +
>   t/t8015-blame-diff-algorithm.sh          | 203 +++++++++++++++++++++++
>   xdiff/xdiff.h                            |   2 +-
>   9 files changed, 279 insertions(+), 26 deletions(-)
>   create mode 100644 Documentation/diff-algorithm-option.adoc
>   create mode 100755 t/t8015-blame-diff-algorithm.sh
> 
> 
> base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2075%2Fwetneb%2Fblame_respects_diff_algorithm-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2075/wetneb/blame_respects_diff_algorithm-v5
> Pull-Request: https://github.com/git/git/pull/2075
> 
> Range-diff vs v4:
> 
>   1:  e81a5d2bd2 = 1:  e81a5d2bd2 xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
>   2:  920a6f3acb ! 2:  60015bbada blame: make diff algorithm configurable
>       @@ builtin/blame.c: static int blame_move_callback(const struct option *option, con
>        +		return error(_("option diff-algorithm accepts \"myers\", "
>        +			       "\"minimal\", \"patience\" and \"histogram\""));
>        +
>       -+	*opt &= ~(XDF_NEED_MINIMAL | XDF_DIFF_ALGORITHM_MASK);
>       ++	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
>        +	*opt |= value;
>        +
>        +	return 0;
>       @@ builtin/blame.c: int cmd_blame(int argc,
>        -		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
>        +		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
>        +			       N_("spend extra cycles to find a better match"),
>       -+			       PARSE_OPT_NOARG, blame_diff_algorithm_minimal),
>       ++			       PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, blame_diff_algorithm_minimal),
>         		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions from <file> instead of calling git-rev-list")),
>         		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file>'s contents as the final image")),
>         		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
>       @@ t/t8015-blame-diff-algorithm.sh (new)
>        +	EOF
>        +
>        +	git -c diff.algorithm=histogram blame file.c > output &&
>       -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
>       -+	sed -e "s/ *$//g" without_varying_parts > actual &&
>       ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
>       ++	    -e "s/ *$//g" output > actual &&
>        +	test_cmp expected actual
>        +'
>        +
>       @@ t/t8015-blame-diff-algorithm.sh (new)
>        +	Commit_2 }
>        +	EOF
>        +
>       -+	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram &&
>       -+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
>       -+	sed -e "s/ *$//g" without_varying_parts > actual &&
>       ++	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram > output &&
>       ++	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
>       ++	    -e "s/ *$//g" output > actual &&
>        +	test_cmp expected actual
>        +'
>        +
> 

