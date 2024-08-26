Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5B81749
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697275; cv=none; b=tGurAVcoNpkITKFUy+4U2Gd2HqpZ7//FIxornAUl3ajqjauFRO6v8raObEM3Wa1hfAQy88CT6buXodHV8iBFkuuPkHgHSFtO77Xek3R64lQpP7EWShwT+LSUksuiLjRoTJLtc0/xiHve74C2SelQxUMJsKed/+cGJnM0TXSyXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697275; c=relaxed/simple;
	bh=ORtVBLioEmx1ROZNnBUvpTh7vGosRepQ0V1PD+hPdPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrlnyIFBuh0SYYNhbi1oXPQrpKMRdELeOwIsum20cp0EE9Md9kC58r9pGpyTwan7uB3EVHlP+3MKCT+HAGo6mjvdS52kDYkgyFxbu1cI3lBqB/FEERT6kd9yB/dUEeIcPtS36wbUy6Ila7YOEObUAGJYyD/2ehlfi6xVHVCqFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luAcxx9N; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luAcxx9N"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso6934505a12.1
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724697272; x=1725302072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7cJ2m9PeW0gcJjPr62gZ4SFv012FTWLQQh73Lq7QL+A=;
        b=luAcxx9N0Mt/G0Zl1QxFhlbs5SqLsZIp5Lq8vsAdoJXWWNsk29B/UFWwSpFQRvHYTC
         A8B/J1AvPZAoN6zA4Q6g7rV5C8vC0E/vyxfrrQRIUVdBXX/Zg//eCHJJdrUc/kA9H3er
         1TjtEeuNggWfCiE5v4B9drKvK2yqMR4yKQmWJvI8UbYIJx2heA308hsNrlGdE/Cq0Mf2
         OY0O2/kgBaAHmQzF3MSsObrz1wVr4DJPYVTOH2u+KfxM9UeNaBvKjSv1UaB4/otYADHQ
         6SBHsuZ0txmBi3CIwt5bO3h00wm+/tUKy+U8eI+uL4dUGcfnDlZrRRVFGjEAsziWOr/E
         Y2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724697272; x=1725302072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cJ2m9PeW0gcJjPr62gZ4SFv012FTWLQQh73Lq7QL+A=;
        b=pkcjUyFDTY/5UOJRE/dIRbJA4uwlXec70TL/wKIRO00dNvhXEPUxkl1UCkqit1irZ+
         AocaJID3oGwA0hx8vVwYf6ik3tF1T67goTBmlcgRwQUdai7qNiAOU4IGD0pqeY5NcbZu
         6e4gR24PvGjJ58NFhdbfU9zV50POJkG4fu/bcanA/oZOF4nE2+bjuF95JXioLAp7cZbJ
         c0VT4c49YTSpgiYdygdd94YLz2CMQgZeaOLuVBF1rmsl8zoKdskhXpDcgNvApnyQeXjD
         /ogYXBMnAzbFRcHP/n2lyAy4nBnkhN4fxcNk81BYVwrdc29TpK/odnbnp/V8Z3kgJm/Z
         OdQA==
X-Gm-Message-State: AOJu0YyEqtwJOe9kXmj/ZDbjo+y3Awj+woq0RhwaWzGdc8bLtnAT5DpN
	Fe2rRBzuVrwaOzuiZnnPVbNNcBpQXed5T08PHynsZ/SLfawqI1SmnDptWl81Ugg8qbBA8HGBNxs
	2+qRnSYjYOrpJeiDCY5wOpGT230c=
X-Google-Smtp-Source: AGHT+IESC7PNGQc9cUmCqZakBBb1DSK/WAZXPPs8B+Zr37+/dNYvltj8WMtYTL0wyNWY/T0kgzVh7ynTtEgFHMA11LU=
X-Received: by 2002:a17:907:1c1f:b0:a7a:a960:99ee with SMTP id
 a640c23a62f3a-a86a52c11cfmr662515466b.32.1724697272219; Mon, 26 Aug 2024
 11:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823120514.11070-1-chandrapratap3519@gmail.com>
 <20240826173627.4525-1-chandrapratap3519@gmail.com> <xmqqcylvjhtt.fsf@gitster.g>
In-Reply-To: <xmqqcylvjhtt.fsf@gitster.g>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 27 Aug 2024 00:04:06 +0530
Message-ID: <CA+J6zkQKc=NmBnuih9Y+2oMjQtVOhKxJ_RfOLGxvWxcBbMH+kA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 0/6] t: port reftable/stack_test.c to the unit
 testing framework
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 23:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > Changes in v2:
> > - Use 'size_t' as array index instead of 'int' in a test that is
> >   modified in patch 2.
> > - Fix a coding style violation in the newly introduced test in
> >   patch 6.
>
> If I recall correctly, the first iteration conflicted too badly with
> other topics in flight, and kept out of 'seen' so far.

Yeah, I remember Patrick was working on some other patch
series involving 'reftable/stack_test.c' which caused conflicts
with this series. I _did_ make sure to rebase this series on top
of that one.

> Have you tested this series, not just standalone, but see how well
> it works together with other topics by creating trial merges of it into
> 'next' and 'seen'?

I did notice some small Makefile conflicts with the latest 'master'
on the GitHub CI, but other than that, no, I haven't checked the
patch against 'next' or 'seen'.

> It some other topics that conflict with what you do in this topic
> have advanced (or better yet, graduated to 'master'), it may not be
> a bad idea to consider rebasing the topic to more recent 'master',
> possibly merging other topics into it first.

I generally make sure to rebase my patches on top of the latest
master before sending them to the mailing list. I'll add 'next' and
'seen' to my checklist as well.
