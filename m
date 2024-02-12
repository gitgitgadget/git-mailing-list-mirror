Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D350251
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781177; cv=none; b=IxNDvtBMAK3n/kyl1gu72kmyUjH05/y8vVARC0Gr8h1wvTH0J7YD7EmSQYGxlv98OXk8OmfejWf4T5392oNXK+tZcsPn2aeBrTkPkT4lfxE0iTLR80SlDUwm6Ko3XRppMk23KVUoWDxHis/UEpAb7fuvbjSl742NgPla6/EzSyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781177; c=relaxed/simple;
	bh=lTYCpf7FjJL9TaYBQahRLIz/RU77nIqNKHT9tFnlIs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPre5kXCNhZgVFAaDNvDe5ZGemo7/oOuTDZB+EhMXFOzeWQMaQAuwyLIMFxvqOlDH9LwOnk8Q2K2vgcJlV3aPNKrI1o+6OHG15UROLmfXzPXDbCgRQpb1nPeqUTdYqMDar3jhbyhBLxSalfYhmxmtSKSt4sBYsgzcViEWSuy0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdPKR4mC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdPKR4mC"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3ce9a33fd8so72853966b.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781174; x=1708385974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTYCpf7FjJL9TaYBQahRLIz/RU77nIqNKHT9tFnlIs8=;
        b=MdPKR4mCYczhFwphtG2465ZTDw5IJJIsz+Mkt8NjjN+zdNWCcV4QxgL1k3ftwxqQmE
         I9Bce9CNtbv2v7EWw3rFaHS+Pqh8v5GxiktVAihn2SOEexBO3ApayPx2C/0iWIqJ4Oq2
         6rvMMbe5U8Fir6PaMRITz+7zpOHsELHqk7LVNsG+Ha7KwvwC93BNOt48a9uCLjGFC0Ma
         SuC3QUJ+8Kt0cOlyz6W1r8Gm81/HeGJXyhSpXI3WyjqY1pzbISKUbzxA2Bxd8foGfotj
         BEq5sKsqtT/szfyzj35R82zrXqpsdXeO0XaVzxTTvNvkGeZnEMphb8poofGRzABfrlOP
         7KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781174; x=1708385974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTYCpf7FjJL9TaYBQahRLIz/RU77nIqNKHT9tFnlIs8=;
        b=gmv7hexH3EV/4Rvy68gAFOQxymCB/Y3SlgehCaeUklUMZuxpTr7oX9sYCczln++qJ5
         GeYchCdhfDA7SfwP12ATaut8ojQsyC6984kIMUr+8BVKi6WHbxnwscDdHyBNO7xec7Pu
         C90D1r7an4Yjrg1WBybuMDrB+TbfQV2+HRWuCAGgzgINuay691ZBhZFuHVaN/lKqQyfo
         0Yyv/kq6ilw/hGcrjLiYCydoCO1mvZYBTLQ7vJ79+Z4VUyjyWqZDwn59o63BQ/XuO2Ks
         sJY/ZPRhju7lvlwpEZN41ct/gJZMUcFMczg+8zc6LbSNQcBVxgo/FW56sKblyVylrhNk
         UpVA==
X-Gm-Message-State: AOJu0YwDD4xlT9CxBtt0YAuVGm9LcFZTuo+B+bHj4+XfCi0fB+BAqnaN
	HVO3dN/zwPtOO3uomlq884jL5tutoeYy65Vr4VFxZFPyKYWNG5/+ZfFfltOAV/VHpOtz/ouLmIO
	HdmsiDVm/onUsxBhW1Jo5cnKSRF0=
X-Google-Smtp-Source: AGHT+IHtj4T7mj7Keu4x8R9GSDJ+vcBc+QYHOCC6Ysp9K0IhzvwPqsV29ThaGevYu+Jf2HpGmKDoPdFg/dGO8Z+Yv20=
X-Received: by 2002:a17:907:10d7:b0:a3c:ec8a:cf8e with SMTP id
 rv23-20020a17090710d700b00a3cec8acf8emr768593ejb.24.1707781174056; Mon, 12
 Feb 2024 15:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <3bfe4809ecbc5aa0ea52daee7684289398cb88d4.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <3bfe4809ecbc5aa0ea52daee7684289398cb88d4.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:39:21 +0100
Message-ID: <CAP8UFD0XjHtwB55XDajJia994TmUwub4L73QxhCQ8yTXc8++Ww@mail.gmail.com>
Subject: Re: [PATCH v4 23/28] trailer: add new helper functions to API
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> This is a preparatory refactor for deprecating "new_trailer_item" from
> the API (which will let us deprecate
> parse_trailers_from_command_line_args()).
>
> Expose new helper functions from the API, because we'll be calling them
> from interpret-trailers.c soon when we move
> parse_trailers_from_command_line_args() there.
>
> Move free_new_trailers() from the builtin to trailer.c because later on
> we will adjust it to free arg_item structs, which are private to
> trailer.c.

This patch seems to be also doing too much.
