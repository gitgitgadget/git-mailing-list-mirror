Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD391F12F8
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247270; cv=none; b=Ddt5cba/lOJ8C4am0zxbg3PlHvPuMoCYjP8mNabTovMnjLYJ6ZjTCxiKsZolqh4rI4ZT0lcOP8+mE8f0TW0XFdUiiECev5aI5grlkpfsH/dcoN15HFLcpyN2Z9YdeVxU5wnpldZ2tX3zuIuxpcnk8Gd8LCKzOdMPaWeDXVOTtsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247270; c=relaxed/simple;
	bh=Dyhq/XK5FJrezUMoatELVgjbmNc/PX99d1AsTZh5N9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eCn5YXgqkyk1KfCDbMWSqV65ilZI/bAxJ5j+FH1oD/djom60hWEdgwQ89VBkHPuzi9Vk5S2YMtMCUBdfPBaRESY/cYYGA12gkgQJv/SqZHchrMBG0XRmqvQ96y80SN0GCknfVBtBkVqR+qe5MYd7q+iH51eZE4jTNY8RAY2ot/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnR28fI1; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnR28fI1"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37902f130e1so7068881fa.1
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764247267; x=1764852067; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dyhq/XK5FJrezUMoatELVgjbmNc/PX99d1AsTZh5N9s=;
        b=cnR28fI1QdjXkSWWirxgbEeRaekNDfGVSqEZeJfu2ku9DB3qJbg6p5xwVa2Awd4sYl
         yicqyHkYSItm6XdrvF4I7McuhHwuSGgoK/3oxN5nA8fY5ee3wSr9mZkO+GS2AVA0oV0v
         0v156JK0oM1zc+/6pA4/9onLV1spzizEe9Yli/LpVRH6Xk96HE6mI3TqCB2wq8J22YrS
         HtCZAYzfTmqDrJeROWAUSBP4vcOy7uVoBGEMYQyd1pGhdvGtlvae65/x7WGqYT3lM/lj
         66OtQF5wXIHA56HZBzAtPfjPakHkFfuYP940dSI0Qs6/v/Jo1MUVOucYP7BkKV1eBXUa
         rZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764247267; x=1764852067;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dyhq/XK5FJrezUMoatELVgjbmNc/PX99d1AsTZh5N9s=;
        b=KeYHeFiLsPLZ5EjMuWtPaBAcrEYvKE97sZKwlwf37UIUKtUShY8k41ce2eQuWb3+HC
         xhvqo52Jii3+sKIxhrnDCGoFiuuIbT4I39ROh0eMdj8IhXn6giizmNjIxZ6PeCEpyofV
         NP7C8wIZVG0dRc5O4fMGKSvNuqTikGvEB3QbBGS8068+1E/sWDAsF7wEsO5tEOaJcWCB
         hu3WIfgnqN1pB0hinxwvhIBWPzDu5LEH22ZknSAzaDFTVrioeFQB7cvTt+GZhVsofKS6
         GEHrJphICi6QfIqQQgw4c5B++RZZU0e01RCtAy2e11NL1QHWAq1sTuS8CkBMYKFuWVHw
         MMww==
X-Gm-Message-State: AOJu0YyzmHtLizeRTrJGJT8MPqWQ1qfImSmcQdycRjWY61CEUcF9Gv2l
	tm+w5XTCgya89eBrh8vPgMd4czk1OQwVidjjN/C12w+Qq+WQFXuySmCNFnVKFUCEx/QHPHRP2Pl
	bApFHUK7Lzc9b2dffVpVnsR8N7bOmvSpQwo39
X-Gm-Gg: ASbGncvizFluD1vf6lmBsbbOAqqhpevdgqcRvyDp3U6DnxH3rR5XDQQfQCsfXHWbEBt
	7XnPwwpA/sbf44dXD3OLGFbD6XGUZbWrxUj1NTyF0NCrbmsB83yitWl/Sdy161FO5cBRA4IUcYW
	R/CGyzxz9u4qCRbkh97XOKeKI3sOikRaAjP3DKWF/SSbK98yphrFu2x48aY/OhSHqG2dT6f1DKv
	H/wqKIgQSFlUP40zV/3RrWs+W/3XNuGFTIltyrFmtfXENKdpWLVHiHxFrqjEJ6u9AQMHg==
X-Google-Smtp-Source: AGHT+IG9NaqUU89coinPkHXiRzF3JXGtik0KP37+vO7cvN4j4j6EzCKoKp2QUqEadEVJoqAtzr/LZnmdFOiHAkmbnG0=
X-Received: by 2002:a2e:b04c:0:b0:37a:47a4:d5cc with SMTP id
 38308e7fff4ca-37cd9259d86mr52358641fa.36.1764247266563; Thu, 27 Nov 2025
 04:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOazyz31vWPgGAFv2AHGzXO3MBGnz-EVW_ndPNgERBvRdAFS6A@mail.gmail.com>
In-Reply-To: <CAOazyz31vWPgGAFv2AHGzXO3MBGnz-EVW_ndPNgERBvRdAFS6A@mail.gmail.com>
From: Alon Bar-Lev <alon.barlev@gmail.com>
Date: Thu, 27 Nov 2025 14:40:49 +0200
X-Gm-Features: AWmQ_bl0zyAwQH3croCziQtrraML5D8H0vIKduYlBh-OroS_iE5RM9xZeaeeZp8
Message-ID: <CAOazyz3f9Ggx88akX8G5LJYzJZxCCp8VZgCPtoM0YCJ8p_UzFg@mail.gmail.com>
Subject: Re: git submodule of reference with no branch
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Does anyone have an idea how to handle a submodule reference without a branch?
If this is not supported, will you accept a patch?

Thanks,
Alon

On Sat, 22 Nov 2025 at 04:13, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
>
> Hello,
>
> I use Gerrit as a code review platform, there are some events in which
> I would like to review a feature that touches two repositories, one is
> a submodule of the other.
>
> The git module reference is set correctly, but since the change is
> under refs/changes/xxx and not under refs/heads/xxx, git cannot find
> this reference when trying to check out the repository.
>
> I could not find any option to either have an explicit reference
> without a branch or somehow to tweak the configuration to search under
> refs/changes instead of refs/heads.
>
> I understand the branch concept makes sense when updating as usually
> we are following a repository branch stream, however, I do not
> understand what purpose does the branch serve during checkout. The
> checkout should be possible based on the reference regardless of the
> branch.
>
> Does anyone have an idea if it is possible to have a submodule with a
> reference only or tweak git to search a different hierarchy of refs?
>
> Thanks,
> Alon
