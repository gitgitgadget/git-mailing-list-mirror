Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82219604D8
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846843; cv=none; b=DO+rDTTeSg+NPpZIi05frcnqtBmntFV8zKXh0PypwXvuhrhL4SDjlaMST22N2G9sWFXCXJwdgcJrOeCIh5h3y/zoudX9QdInAIdsjfk4Gz000AWByHue12GtL8T/BDEOMHksyHz7a8Z08sWRzdesv3yBS+I60cW9JFcPZLuAbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846843; c=relaxed/simple;
	bh=jpBmNIzlhhKabIKFwrkvqAho1LlULPezpc3oTsDdkp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rZZ0mcHQB+xJbjuZO6Y3pWC4a+qyp0+2Dux3B7Lt5rwKJlXc1F9Rb8AXX+cuGNUssHTR5FO+wGTKnOfomM+cGrqmB95GoZY0H4JBxDOd0BPXJjSW+7CjgB2nl7BEkK758JeyLP11dQJckhBm1bXvDE1iQ0m2Om3GLm0KZJHpFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJw1m+dR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJw1m+dR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60781e8709eso11241287b3.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707846840; x=1708451640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk9vOnyrueS6urkF0OV0J8BaJEqbXZJzdJ8+71Ff7ss=;
        b=XJw1m+dRtTOrdEQZaItuLMn7HDnJh1RTzJsZ/yckvCH+gjDVwtG9u3UzDhq0ZhHlsD
         FEUJe6mXkUqSK8lK27D5C/RjgdljlOznM/EvDo+/H4XunxuwQXU8rNFrr1u+bjKfn8n9
         VFh5cvwqsnI2k6SWEOY977xkXPgr3eyHv0Nr3JtUtXQcdzlTmt7/q+NKK7/7uXLHQUS9
         9xEZqGUoeq/eUIWNMZAdZhfpwe+eWdfqE6QyJzBKp0HxXTQA9GBOmIbQgNsI+kbKswyW
         TDMT7ZsKVXfdSFrHkK9J17SIInekws1woKhfx49hMSG0MVoiDnemj7LVWxE8FCUpPH47
         I46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846840; x=1708451640;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qk9vOnyrueS6urkF0OV0J8BaJEqbXZJzdJ8+71Ff7ss=;
        b=t0n/apcLkbDkGc+CwF4GROogfzaD4YvgOOn5oMZc67OwPkAAh5NHPbYs8QGT3XVuIt
         aP5inQF+hMjWnngVxEe8fl13hMgdnUQMOS+9Ckc2npE91/ntdUOe5QC+HPifrvEhDt5/
         +e8VaqCpv3bFA69dPCxp6cTyEbGHEqjAgrZ0sdwLhT3xwHznlnS802vsJdWW/3Yo6mFO
         r47tp03T3tb4jlI3kTwlFn4i6loSNzDL7PG4QyRQeigPSvcWPe/A0s/OQ7mhzzuv5Ote
         x2JbWg8yTLRc5a0Krzp69mEn/jLZMaI7k0iFbZ1yacIYLfpy2ZCjqQljB1FNKxwhpYVz
         aaQg==
X-Gm-Message-State: AOJu0Yzt6eTKZh6kdCTiBXkOJooHFlvV4XU5e4g1xhAQNelPKCmZR6PV
	vKI0hZCo3wn1OPXuO0xwDG+yWrR9/0WLDFWy90jOc7qd2/cIwbuqVKvcgtZTZs8XPQ8nCasFuoN
	zXg==
X-Google-Smtp-Source: AGHT+IEcssCrcXYQy9S4F59dvmJlQeGdrCVPY2Re7E2yZ58/Uk/lDe/BKovbSpd8clM/t+ceyLq8KpCaDCA=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:690c:3190:b0:607:7927:dea1 with SMTP id
 fd16-20020a05690c319000b006077927dea1mr494926ywb.1.1707846840524; Tue, 13 Feb
 2024 09:54:00 -0800 (PST)
Date: Tue, 13 Feb 2024 09:53:59 -0800
In-Reply-To: <CAP8UFD3pcyRYaJLBmiDdN3sdvRzo==dx-CQKoX1w1n6Hsg5+-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <94bf182e3ffbf8ed6e20cd77b2e46e5b83c44d34.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD3pcyRYaJLBmiDdN3sdvRzo==dx-CQKoX1w1n6Hsg5+-g@mail.gmail.com>
Message-ID: <owlycyt0b688.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 22/28] trailer: prepare to delete "parse_trailers_from_command_line_args()"
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> Expose more functions in the trailer.h API, in preparation for deleting
>>
>>     parse_trailers_from_command_line_args()
>>
>> from the trailers implementation, because it should not be concerned
>> with command line arguments (as they have nothing to do with trailers
>> themselves). Indeed, the interpret-trailers builtin is the only caller
>> of this function inside Git.
>>
>> Rename add_arg_item() to trailer_add_arg_item() to expose it as an API
>> function. Rename new_trailers_clear() to free_new_trailers() because it
>> will be promoted into an API function; the API already has
>> free_trailers(), so using the "free_*" naming style will keep it
>> consistent. Also rename "conf_info" to "trailer_conf" for readability,
>> dropping the low-value "_info" suffix as we did earlier in this series
>> for "trailer_info" to "trailer_block".
>
> That's a lot done in a single patch. I think splitting it into 3 or
> more patches would be nice for reviewers.

Thank you for pointing this out (and, for everyone else reading, please
don't hesitate to ask for this from me); will do in the next reroll.
