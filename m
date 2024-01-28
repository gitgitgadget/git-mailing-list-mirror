Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FCC6FA9
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706423958; cv=none; b=YQ5itBtZI5w8OCgG00sFYX+FvAcSMv50h0BjT6U6M9w3bEg7Rr/SAh69bndjezpS6+WSchH2lW9vWP+wXTuKFNUms31vz7G20IYokbe5ntpZzUODS+EKUmjPvbpH98Zy2vC87iRUkpTn1IuvdykEGmu9dHZmePvnUxZCnb81ISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706423958; c=relaxed/simple;
	bh=2Y8DB8c1Lm8GQ/0LZoj6QsFWmvcWYh1OuCOzRnZ/xRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CpOVPuXz+ZVl+NF+9WUwzJrASkzSdwlMYMccfNqALFzA/5npnooWOD06zeTabEaGFLcvrUXT1NEXuOn35BNj881F/Tiu3yMLXNQW3/dugapec226hI7SQz4zuhUYcxDV/07UV0S6CWPt1sa/Q12L8PkXfB3fuP4XQ3XwFSNb/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fuphfcXQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fuphfcXQ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc221ed88d9so2827088276.3
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 22:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706423955; x=1707028755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLhymtD4Dlr7RYiYfqd+mKd1vAu5bYaffR/JpwwFuhk=;
        b=fuphfcXQuBTzVfbsZGJoh7BrofjYWebq6axszmvst8S8p0WANQ7ua3jxXMQ32Y9p0Z
         K87uHpNJNX99kvfme0KfGtXt3dN3AJm3KSwvxoq7TYaoF6S3z5f/FmEaOYtcNH8Exuub
         pAoDUOAzt+LcEz2mXO5St3UV+yh8lJWdzJZ2EcI7Im0AtY6xIpkk4mEhdvjTW88v9+C9
         QEdOMjy6XgZVtsmDzOJNNTetLfPUEPSi5gQx/Rm88K1veH3ujv23P1thg56p1muGOg1G
         q2W7Zin2+V7cEpZgaQ41C4ESlvFrg3Ja4WjzRRha6uudo1osQbde4Xj4qGzjq12SlUJP
         mm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706423955; x=1707028755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLhymtD4Dlr7RYiYfqd+mKd1vAu5bYaffR/JpwwFuhk=;
        b=Z3PWRH3ZssA+Ij/SU71Hme3eyffe0N7U0Laje5AKIb7eNV57R9XNhnPWR9EDY2WUfp
         3e3ZgOjuRKBcEusyc0jKOjb45XfMAkp+wFGySavwohByZHK0cqvbcKkUbqxOEIG+z/fD
         PTAH61P83r5tvXEQUU2Lb8wXooV1vOA1z5NSaRGdYuh6/lyP7jhKLsjrUx3bKUH6urAj
         d5CuZQjpmfPhoxAmxlJDMhStIJOyWi/bSCwunVyscCvrQd7CV/bO+mrOY4LDPKsXzJDt
         9d0/fcjmBxuSAZnhsGyj03Z1VpxXxEA2Ifvq9tYbebboYXohywKuk83pSBl228ryS5XI
         Hn/Q==
X-Gm-Message-State: AOJu0Yxkuutb3BrP9FVkemiduEjcv2pmXItsSVj4d0Sckh04qKKjtbBe
	Xiu804t93XNq/ReYqW3bjGMb/l97Ho/pdtEAoHOs316pLMbWvKNdiGzepjUNQq4h+9rC2+DRKqQ
	1+A==
X-Google-Smtp-Source: AGHT+IE3TLHD7EurYGbFmsg6ZE1aaNeMj74TOOpf798nL45AU7t7zpLqB0RMHHI0pGtn9LhWC2h+i1/3kKY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1a47:b0:dbd:73bd:e55a with SMTP id
 cy7-20020a0569021a4700b00dbd73bde55amr223704ybb.4.1706423955540; Sat, 27 Jan
 2024 22:39:15 -0800 (PST)
Date: Sat, 27 Jan 2024 22:39:13 -0800
In-Reply-To: <1b4bdde65bcb375ce9ef2345814330df92e6d932.1706308737.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com> <1b4bdde65bcb375ce9ef2345814330df92e6d932.1706308737.git.gitgitgadget@gmail.com>
Message-ID: <owlyede22c8e.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 09/10] trailer: move arg handling to interpret-trailers.c
From: Linus Arver <linusa@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> We don't move the "arg_item" struct to interpret-trailers.c, because it
> is now a struct that contains information about trailers that should be
> injected into the input text's own trailers. We will rename this
> language as such in a follow-up patch to keep the diff here small.

I forgot to add this follow-up patch in this series. That will be patch
11 in v3, which renames "arg_item" to "trailer_template" (the idea being
that trailer templates are used to create new trailers, using the
template as a guide).

> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 9e41fa20b5f..ad9b9a9f9ef 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -45,23 +45,17 @@ static int option_parse_if_missing(const struct option *opt,
>  	return trailer_set_if_missing(opt->value, arg);
>  }
>  
> -static void new_trailers_clear(struct list_head *trailers)
> -{
> -	struct list_head *pos, *tmp;
> -	struct new_trailer_item *item;
> -
> -	list_for_each_safe(pos, tmp, trailers) {
> -		item = list_entry(pos, struct new_trailer_item, list);
> -		list_del(pos);
> -		free(item);
> -	}
> -}

This function will also get promoted to the API, and will be renamed to
"free_new_trailers()" initially in patch 9, but renamed to
"free_trailer_templates()" in patch 11 (we wait until patch 11 to
introduce the term "template").
