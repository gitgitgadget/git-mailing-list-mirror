Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6795224CF
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299803; cv=none; b=FM+sK/oEmhExM9t2QcZdLM26eOtGj6N6awtTNfgN+R8zNAr2oPJ4o3HKnV31D2mKJ/hCrOv5crSmrV/6fMfFXmUCjhIUsO1B9p3v8TSQcx81cNWrHa2HICDGW5Spo4SlXn3ix/0IbPsJ42uHzsXQU83ht9RvvnzMKt7oAq/h1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299803; c=relaxed/simple;
	bh=fpabL8DQMyGmqfTD288V7lZnk7c4HQGlUsjKVarxKKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgQxYVKjxrD+T+DF/5Sg/oFZczmGMxjKmWDZBYusKyC9Y6wDlp6dU4BH5VVyfL6xsZ6uHRHFs6QnoG+85vzS2JBa3FS/4cj8ZcNsbfM/53J7yLWbwkbq3pZA5UKGcQUl8jpgLTDT2zRGQvUuEn9SY+maLBQX0WjMyO4DDaFmJQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izBjrVDA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izBjrVDA"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ee6ff0c7dso12777315e9.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706299800; x=1706904600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVNGp41z0oaArjmeo+dsDr6gNxzi7yb201LnkDAoKuI=;
        b=izBjrVDAQrui8fUHqqKPT9d8tmROIVvphWv8VuB+tLBPPyHoUQg8PfOLDy/WRytjNE
         xH+eebE2UJcFg9ylsGF8X1YSiv2RWV+qhQfSYMeS3r6GTQCkfV7QLpXgbhU/NAPDuUr0
         Qe6+qFytTOTvx1JhpsylS3zb6DtFiis71U+7p9nE9J6BtCVCAAX8HRBYl5EdQr8/JglH
         bkvggQqKqLONMk3E4BuEN4FeETmNn2tkgyR8/40yqmekcOkgwy4J17YjerOKFdGB8ErN
         eZ5nqkngVHSrDKgNMgG9qhiX68EhiciSJnzM2loemWZfGswoma78NEpwDWLkeI8YUtZ1
         m6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706299800; x=1706904600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVNGp41z0oaArjmeo+dsDr6gNxzi7yb201LnkDAoKuI=;
        b=fjFubj5PxfKfgkbSj6kvufeFrOIo+LM6uMQv+vMtxu5jkXhlCJqzD2s5iubXt+JYVn
         1hr30SI/iYYNRCGvjxHJdgaF80EGmV5fVZMK9INQd2wg0PGpl0l1V1G+fyFFxjPHE9Qi
         OkixddUFFL89y4xiqUQNpwy8Yh8c8EzW6UySq/aornzeJiaSwY7llaRPpKkondq6rFM/
         3d9b32iAINipuEBhGH05OI7Z8cGfOrUZZstIKhbZYqrNi5CchucBsmNgoSVkq7TUbfql
         +RQYfMrhdOh3tjJwpX0qV7rlBNib2baAE/eSvyX7i56BHwxlZ7vFqVpyrH0l0Fl5fCVq
         HmnA==
X-Gm-Message-State: AOJu0YwENrXOjwsGbylIfPvEE42JiVOGEBAeMDisOpRB4B0Cje5kqpT8
	KYdDMjph3Pr9z4HEMZP8Efy92wpNlvH45LzOucOAtwXIXetUmkWA
X-Google-Smtp-Source: AGHT+IHhc+CRs65jbveU7tHHyCGdBMp8jTs5Z8ZAMM4RQwrmVlRAwpLGsHVPD5NWrGang2ys7Oevkw==
X-Received: by 2002:a7b:c8d8:0:b0:40e:9f2f:3590 with SMTP id f24-20020a7bc8d8000000b0040e9f2f3590mr188964wml.272.1706299799761;
        Fri, 26 Jan 2024 12:09:59 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id bh27-20020a05600c3d1b00b0040e8e358f82sm6662061wmb.19.2024.01.26.12.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 12:09:58 -0800 (PST)
Message-ID: <48717a57-42ad-4c00-bdd5-c23c0f3ccbe9@gmail.com>
Date: Fri, 26 Jan 2024 21:09:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] completion: introduce __gitcomp_subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <8c902c53-815d-43c2-8ba9-8144d8884804@gmail.com> <xmqqmsssngyz.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqmsssngyz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26-ene-2024 09:26:44, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > +# Completion for subcommands in commands that follow the syntax:
> > +#
> > +#    git <command> <subcommand>
> > +#
> > +# 1: List of possible completion words.
> > +# Returns false if the current word is not a possible subcommand
> > +# (possitioned after the command), or if no option is found in
> > +# the list provided.
> > +__gitcomp_subcommand ()
> > +{
> > +	local subcommands="$1"
> > +
> > +	if [ $cword -eq $(($__git_cmd_idx + 1)) ]; then
> > +		__gitcomp "$subcommands"
> > +
> > +		test -n "$COMPREPLY"
> > +	else
> > +		false
> > +	fi
> > +}
> 
> 
> I am not at all familiar with the code in this file, so treat this
> as a question from somebody who do not know the calling convention
> used around here.
> 
> This helper function clobbers what was in COMPREPLY[@] before
> calling it, from a caller's point of view.  Is it a pattern that
> potential callers in this file should already find familiar, and
> they do not have to be reminded that they cannot rely on what they
> prepared in COMPREPLY to be preserved across a call into this
> function?  Otherwise I would suggest mentioning it in the helpful
> comment before the function, but I cannot tell if such a comment is
> even needed by the intended audience, so...

Maybe adding such a comment might suggest at first glance that we're
working different here than in the rest of the __gitcomp_* family of
functions, which is not the intention ... I dunno.
