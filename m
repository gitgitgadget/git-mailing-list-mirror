Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE7548F4
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538592; cv=none; b=CRofqvdin6yuv2EmiIjylT58nLseL/tsgbAJJH7uHmX2okHutelDg55EKYrUKxEAgWHRDDKmu0/o0n/qapdtKgQVZu1OYQOkejqkfnfyyRipu55uBY3nZzmexFlV66X6YTYZhoK0xDwswqgJNE6acy2fW+oXfU2/ZcxTlJW1Xko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538592; c=relaxed/simple;
	bh=OG+54LYbKF5KyJDKhPriR/x7+q5O1/IExK4Lm1AjtTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MJ/pOKO/i8SLnMZQgN9YE8xgEmYSwawfPq95Oj6BZossjt0f0mTmZJv1LOz0AA02A2VpYF2gd+bQuJR+0yDIspqsVKPQl7zkLA2EWOf/Xqq7BCIJjQ3DHYBmjbqxTaU+kSGGXaymfe0L8SifiIZlrNkLDowBqiZBszFxfBUy+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhvXtGHb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhvXtGHb"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso4839217276.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710538588; x=1711143388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jocI4bIsES/xcyyrF87HoFGCpeGdjyiAQaVIHJwZ8oY=;
        b=uhvXtGHbpdoXjV9T0hvBGKZUUvl/hlrkGspReBDJii3DYfdKnc+eOAmazcOswgW9Tp
         p74zG06osfDh846Z6/rkTbw1A9H/9wa5xzn7hJvnxR5erMKpiD8mI4JOZwsLQv0VfXvo
         7frQusG6Dlu9B1/+CtjDXJ2U+KAxV0l+hPJ9dI71NnIIodOeGqv5Pw7b6ToA3Gyl6TDh
         hGkjsQciTRE4PH8qCJjER4/9TZNuIC3cHuWT8tP/7oBbjq7p/MXYTc4gVebkZiqOX0CJ
         qezDnhKRKn7BhobThIOvN5KHvFLp7IDb15kBVKwWxVjU0aR8SHaUs5Ly/m4yEwIqJZLO
         PMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538588; x=1711143388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jocI4bIsES/xcyyrF87HoFGCpeGdjyiAQaVIHJwZ8oY=;
        b=R6b32hBeflg8GvPpdWZ+B90v1xc9LzTKa7vCLKX0ydP34TS7l466XJYgmeA22HuRJn
         83roSTl8PueYCYWg76vX2Y5bZqYCLDjTUYN2WTGLDO9Dm0BaulY8nq0F280JAzOCxf8b
         tRvseP1ED9KxHCdpMJ9Fdv/3HaQAhbcwIIz40Wqac7BOGPLkKOGZqd6rfllM+ikqlGgv
         fJK5x+AVJ1hrg6tJnq65ekEV7Y+W56OnnUnioR6YLRQOgnDG/UA+g3J1e7dtfgIKvL7n
         IwNcK4cRKX87ULvd2/H5FxRJsC70UGgcVU24nAK1edcCOyGD6BtQveqelBpkAkpa+1y3
         QEzA==
X-Gm-Message-State: AOJu0YzFlongoXwV1Do9P6iPkO8smtJra83ABlAKCJr264ai1HyvvBa1
	dikTR0YrwKCkQwq/9zSawEVZ982ddd6QEVVP2Le0IAg9wKb0z6B1vC6MMKqRXNhboz+EYEeVxC9
	g/g==
X-Google-Smtp-Source: AGHT+IETXKhLYUdGWTquP3AAwmCY7zhoWKjP9W1u+5kMFShPSMOVMqU4ysmmp6Y28Pr7YZAQEvBUsytpesg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2605:b0:dcb:b9d7:2760 with SMTP id
 dw5-20020a056902260500b00dcbb9d72760mr1742339ybb.13.1710538588083; Fri, 15
 Mar 2024 14:36:28 -0700 (PDT)
Date: Fri, 15 Mar 2024 14:36:26 -0700
In-Reply-To: <xmqqjzm3qumx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com> <xmqqjzm3qumx.fsf@gitster.g>
Message-ID: <owly4jd741ph.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 0/5] Unify trailer formatting functions
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Not about the series, but about the way it was sent.
>
> The messages in this series have exactly the same kind of breakages
> in the recipient names/addresses we recently saw:
>
>     https://lore.kernel.org/git/xmqqh6hkxox6.fsf@gitster.g/
>
> Human-readable names with a SP inside [square bracket] pair
> appended, and one of the addresses had that square bracket applied
> inside <angle bracket> pair and breaking MTAs (I manually fixed
> khaugsbakk's address before sending this response, so replying to
> this messages should be OK).

UGH, I'm so sorry about that.

> What are you and Aryan's pull.1675.v3 did differently from other
> series sent via GGG to trigger this, I have to wonder?

I realize now that it's because I copy/pasted the "Cc: ..." lines in the PR
description from
https://github.com/gitgitgadget/git/pull/1632#issue-2068188239, such
that when I pasted those in for the PR description for this series at
https://github.com/gitgitgadget/git/pull/1694#issue-2187804953, it
carried over the email addresses as Markdown-formatted hyperlinks.
Currently it reads

    Cc: Christian Couder [chriscool@tuxfamily.org](mailto:chriscool@tuxfamily.org)
    Cc: Junio C Hamano [gitster@pobox.com](mailto:gitster@pobox.com)
    Cc: Emily Shaffer [nasamuffin@google.com](mailto:nasamuffin@google.com)
    cc: Josh Steadmon [steadmon@google.com](mailto:steadmon@google.com)
    cc: Randall S. Becker [rsbecker@nexbridge.com](mailto:rsbecker@nexbridge.com)
    cc: Christian Couder [christian.couder@gmail.com](mailto:christian.couder@gmail.com)
    cc: "Kristoffer Haugsbakk" [code@khaugsbakk.name](mailto:code@khaugsbakk.name)
    cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>

when I click on "edit", where the last line must be from your manual fix
which GGG picked up. I've cleaned up the PR description manually now,
and for this message I'm also attempting to clean up those square
brackets.
