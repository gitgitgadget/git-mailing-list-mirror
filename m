Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45094376FE
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583536; cv=none; b=eIeHaNQZRnsj5HiNix5tOPCWmQ6DtheQ9sRJiH6eKvG0OIRlfTGEG9Sk0q5L9QB/TJtHYX5Ad42hQhqWfXncj7l+wIJIE/wN2FmzWtnpSAwucF3LP5atvtNjppfk8hWMLvBMxZrCZ3F/ePWFwhN5vE5VZ27X4Yi8qGdVj6d+jvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583536; c=relaxed/simple;
	bh=0eFxsSS+Kxz5/D5pL6c2ilW/pQpXI5U3rrgtxFv/TxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PhhzBl1cNYcSiyYAE5FTbOJfbM2gC4nZ31GZAxJ2NsrVDH6CU6De7qWJ7V0A2xV9Vte8WT0PSt5HU70tOZFtqVcyvHIk6Gz1gtqPNNhLAu47Aoen924lIt/rL9eyP0dPx1uBrw6+M//JS25mcFIwFo0NigCsL1ucyTQP7cn0vmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjZAzNby; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjZAzNby"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff817c96a5so62872027b3.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 18:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706583534; x=1707188334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VP+ch5fXR3K9e46xLslpN6uVysgmCt6NdrRJdMRxdio=;
        b=sjZAzNbyiwu3YDCQmA0xEm6PhMf7vs9NZ7QTyrxD0wx7u6KgTaKECwiG/tg1LjvlaW
         xpZP8uBZ8Z0Hk78i9t/IaYyk8vUMI5QnJamdGhMdd8mlUQqWI8CjYzZPIvYXoeQTOsNF
         i8verhq6vl+PCPc9RWT2y72CcESnVILLAcS4rNB1dmCCHoi/+yjYg5jCUcuOeUAfIJdK
         U0WKuS/fhsGPmeyLd52/jTM1JbZU/tPCkNIaDmpS5QsNsQNBd/l27pXi1HQ/sTrIHPD/
         LeLSKRdXL3pkabMji6WIU/L4dDD+ggF342anv6mMJM3V4RrHJtl9ElevQplss1MF16w+
         0g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583534; x=1707188334;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VP+ch5fXR3K9e46xLslpN6uVysgmCt6NdrRJdMRxdio=;
        b=wkhdXOhFnWSJFVjwk8WUbKz6viKQM69lICVYl9WqZdoIWYqIirE6b0LcFXDRxcQHXO
         Mf+kmGCykqpg3vVG8OxAPjvJ9gMUn4/ylPWt0yaFGJcy2Ayw+JGv/vSaSvsmANeu8Ltn
         iNK5cQClaYr0ktTeTADzKOx8O4DMutxfOM3m+2eMu9vHdz37Kyw11weBXf7Uid4z8EqT
         YjjNvfbrG1kh0647VkteHHnBcaDOKfe+H1OBNVuBP/RERwGExXmf25F102Mox2lBA12a
         SwjCij6FsgIZ+jcEpseR5qsO/kE9P7vM8Gig9nYGLbv5oA9n+OuKSt5Tfxv306UQ9cv/
         dUYg==
X-Gm-Message-State: AOJu0Yz2qhEVq42uUtKqGiOJE0wnS9YLArOg+NsqXIvBQK3btHiF2F7R
	8NF35RTKwEvg2ZfMZb5UMjw2JS0iMzRmFZO6JH9aql3N78sqHQ8HIFT9EVo4yMRb0mvLqCATD8j
	zNg==
X-Google-Smtp-Source: AGHT+IEm0EdEtIIWd6E7Gr71gRKYxuJAD9HQDiTKV+q/I0DM7pq/KSxU3SZmwjelnqWlRUWQfPil5h6EtMo=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:690c:d84:b0:603:ea10:c37c with SMTP id
 da4-20020a05690c0d8400b00603ea10c37cmr529651ywb.7.1706583534181; Mon, 29 Jan
 2024 18:58:54 -0800 (PST)
Date: Mon, 29 Jan 2024 18:58:52 -0800
In-Reply-To: <ZbhByped3D0-NBAs@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com> <9b7747d550e87457195c40a49347bc749a7290d0.1706308737.git.gitgitgadget@gmail.com>
 <ZbhByped3D0-NBAs@google.com>
Message-ID: <owly8r4734sz.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 03/10] trailer: unify trailer formatting machinery
From: Linus Arver <linusa@google.com>
To: Josh Steadmon <steadmon@google.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Josh Steadmon <steadmon@google.com> writes:

> On 2024.01.26 22:38, Linus Arver via GitGitGadget wrote:
>> From: Linus Arver <linusa@google.com>
>>=20
>> Currently have two functions for formatting trailers exposed in
>> trailer.h:
>>=20
>>     void format_trailers(FILE *outfile, struct list_head *head,
>>                         const struct process_trailer_options *opts);
>>=20
>>     void format_trailers_from_commit(struct strbuf *out, const char *msg=
,
>>                                     const struct process_trailer_options=
 *opts);
>>=20
>> and previously these functions, although similar enough (even taking the
>> same process_trailer_options struct pointer), did not build on each
>> other.
>>=20
>> Make format_trailers_from_commit() rely on format_trailers(). Teach
>> format_trailers() to process trailers with the additional
>> process_trailer_options fields like opts->key_only which is only used by
>> format_trailers_from_commit() and not builtin/interpret-trailers.c.
>> While we're at it, reorder parameters to put the trailer processing
>> options first, and the out parameter (strbuf we write into) at the end.
>>=20
>> This unification will allow us to delete the format_trailer_info() and
>> print_tok_val() functions in the next patch. They are not deleted here
>> in order to keep the diff small.
>
> Unfortunately this breaks the build:
>
> trailer.c:1145:13: error: =E2=80=98format_trailer_info=E2=80=99 defined b=
ut not used [-Werror=3Dunused-function]
>
> and
>
> trailer.c:147:13: error: =E2=80=98print_tok_val=E2=80=99 defined but not =
used [-Werror=3Dunused-function]
>
> While separating this patch from the deletion does make it easier to
> review, it may make bisection more difficult.

FTR I've tried a preview version of squashing the deletion into this
patch with "/preview" in GitGitGadget, and it generated a clean-enough
diff where the deletions weren't intermixed with additions (maybe it
uses the patience diff algorithm). But I didn't squash them for v2
because I was concerned about the range diff becoming even more
difficult to read for reviewers.

I'm OK with squashing them for v3, but I'm also not sure that's
necessary. For example, during bisection you could use DEVOPTS=3Dno-error
(or similar) in config.mak to skip over harmless errors like
"unused-function". Personally I'd prefer to keep the patches separate
because they started separately on the list.

Ultimately, I don't have a strong opinion on this. Maybe Junio or
someone else can cast the tie-breaking vote? To squash or not to squash?
I will take lazy consensus to mean "squash" for v3 if no one has
objections. Thanks.
