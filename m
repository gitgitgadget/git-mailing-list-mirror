Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54D3D68
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574289; cv=none; b=Q5/AyNMTqRyp4t1r7OeMTG07Au5Rzy4dB1BAfiTdvj0HPHfglXyyNY0ribN2IuHpddrU32VoahZhdE9m9Y/IJCeaX9zEgpFc/Sr7A7FVUGYoUWAFpMwLIXYbj9qZJ/IS2PyrqWNr9dr3PWxYW9tbUMcuj1f666+cQkSH9fNUdVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574289; c=relaxed/simple;
	bh=U4kLgDbYobradV1k8QQnfHNloO4Ej5q+1YVddpGVJ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/fyqOM0F07Emi5skW5BLJTEmakVxsZcaq/9fdQzVqACPPICPQ2XqPAPNvAccs4sUkbzd8/1rJAe3+wGH/5NpdM3uqd3gZN+bwqlTeToYjq4g/Kp6OQxNZMTJxiGu7UjsezVj4ACsSqEtUmMkslk+4zkanrX9jMEaAVVuFYJz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gE8+QQ6v; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE8+QQ6v"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d748d43186so16702395ad.0
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 16:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706574287; x=1707179087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrXfj9vGPsFkLTbKBifNAHPByTa4tclq0kAZqQeC4m4=;
        b=gE8+QQ6vYYK1VykmBmbeFbvPoK3yMpLmWztlBlyvEav/SLso5W4gs77sDKkLqr/KZC
         p/OMtSxbPBNHbFiR8ozQGhZlnqQvsULmPaBi7H6zITuY3i3UgJVdJnO4bohxjmMB50aV
         BsKOqeGxTN0JMhKax5gNMuU9Mbdetz87kx9z6TzRr3wUEvNoXgK+Wcif7Wi8arIOCPTD
         0qWZ5eE8HlUUX3W6fjv9A9h80n3kPablhxByi55yhCWteRc0DYuOlvqs/YkmmVRXGPf8
         N6x/Pqep+mg5WkPnAwMbyCPLR7aNPikaNVVOrxbMwnguzPfJdsE6Qa1rbe8CR79ZUGgw
         EuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706574287; x=1707179087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrXfj9vGPsFkLTbKBifNAHPByTa4tclq0kAZqQeC4m4=;
        b=AgFdEFSa+fq0hhpfiDKKIqSS+zpA7PyRwIHyCO/mcyJn/axSFHJAqcJcG4B/fKg78W
         KT5e9i1UdXLBTHBlCCzBOmu+76MnXOqm7QUlcoSM1364cHFa8PUxWeAN+A/g7VOdGtOC
         mfxlkkVUlN0b/e3WxncvY9cClYLn/FNB7mnKJTVFyt16Tzw1oRP9Il5/dBWquSXVgxti
         y+TL4mCR+SWLf2qgOjAFssccFU4RBMlJcVxx9HIWfHw0UczdHnljU/Q2fwwzg39XIp20
         pH7IaQRCv75K9sswuJylsQqfQbN/5rpDZjgPhsZwsXPGLZdMZv3Vts5jh7nt0QmxDCXq
         RJXA==
X-Gm-Message-State: AOJu0Yx0JmN3ZqfrgQZL0BVGjroiyUi2iRG65K7DPGW/2qndluQYU3HT
	qYBjdqlben0/7o9G0HYE1RygxIT9K6KpLCdwzt7jBcOhJonEtF7nregEAhkG0Q==
X-Google-Smtp-Source: AGHT+IFSpMRX0YXMR9Fxn56KjarbHw5ZFCyzZua6JN78zlU6Z36nz/HcASJWp0xp49hr/gPURoLaCQ==
X-Received: by 2002:a17:903:2281:b0:1d7:617f:6dea with SMTP id b1-20020a170903228100b001d7617f6deamr4339164plh.59.1706574287195;
        Mon, 29 Jan 2024 16:24:47 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:4527:c1dd:9b37:d3a0])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001d8e4de7a44sm2272089plb.127.2024.01.29.16.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:24:46 -0800 (PST)
Date: Mon, 29 Jan 2024 16:24:42 -0800
From: Josh Steadmon <steadmon@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 03/10] trailer: unify trailer formatting machinery
Message-ID: <ZbhByped3D0-NBAs@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Linus Arver <linusa@google.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <9b7747d550e87457195c40a49347bc749a7290d0.1706308737.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b7747d550e87457195c40a49347bc749a7290d0.1706308737.git.gitgitgadget@gmail.com>

On 2024.01.26 22:38, Linus Arver via GitGitGadget wrote:
> From: Linus Arver <linusa@google.com>
> 
> Currently have two functions for formatting trailers exposed in
> trailer.h:
> 
>     void format_trailers(FILE *outfile, struct list_head *head,
>                         const struct process_trailer_options *opts);
> 
>     void format_trailers_from_commit(struct strbuf *out, const char *msg,
>                                     const struct process_trailer_options *opts);
> 
> and previously these functions, although similar enough (even taking the
> same process_trailer_options struct pointer), did not build on each
> other.
> 
> Make format_trailers_from_commit() rely on format_trailers(). Teach
> format_trailers() to process trailers with the additional
> process_trailer_options fields like opts->key_only which is only used by
> format_trailers_from_commit() and not builtin/interpret-trailers.c.
> While we're at it, reorder parameters to put the trailer processing
> options first, and the out parameter (strbuf we write into) at the end.
> 
> This unification will allow us to delete the format_trailer_info() and
> print_tok_val() functions in the next patch. They are not deleted here
> in order to keep the diff small.

Unfortunately this breaks the build:

trailer.c:1145:13: error: ‘format_trailer_info’ defined but not used [-Werror=unused-function]

and

trailer.c:147:13: error: ‘print_tok_val’ defined but not used [-Werror=unused-function]

While separating this patch from the deletion does make it easier to
review, it may make bisection more difficult.
