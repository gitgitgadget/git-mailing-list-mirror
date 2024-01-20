Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283012B65
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705782323; cv=none; b=UYnbmIY2inSG9R2v0TWJJ3tnOdvgW3WuBTwOepsTaKMhErNM8zsuPI1efZ5+8hJcrL1T5MAQyqdOildyjkk7XKBDxqiumRPqNo9TcOfE32TGv5WTFQcc19GSHwhOWiMALEjx/8qJfDP/pJJq5PBCjrjsGuND5ooJlCuxjadOcGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705782323; c=relaxed/simple;
	bh=emDquhBtV9DdQRy8lDA1rjQFYeF8l+Q2wW8nof3U+8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tp+7BUwkMZAYgQWX7bZXwdGSisD00o0klTfrnX9I7CF5TCvABXMjwYCyG4hiC83JdyEXamJrEKHq4iyt28t3Ngpr5WfRxqEb8apJLvS2GWRHf6Ind2Jsu/WXnKbD3rn0iAeDBQdkRI0qflGhr452PfiTrhUcVAQfbQhSYSv7Gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29WwdYMj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="29WwdYMj"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6dbcdfde0c5so596486b3a.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 12:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705782321; x=1706387121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfwBan/2xIUFRHbO7LpsCZE7Olbe57ei2B2P2UJfWNs=;
        b=29WwdYMjLIrAa9d4iovJK+WhHVWtF2BPQ2Ee6yEgf2+NbI2cillFLyOGixfJo4dK2m
         exa4SfUodvASiiNwa7iEREJIDuBMo4qIBJfI6QMeTzXMSw7VzX0LeqPL6dI+whRxdU34
         Y0/s7w6oAz91skkLd6aQ4z3G90gy09rZULYNgFgCP9/3d3Rs7aDZTv4j+azmi92uzEoz
         RGltORviQ/iWoAP+f98w/CYrTahbfh1kGbq7QyMNV/NjJ2g1q1fQcD3IUQ+XGaBkAdFW
         kdKQwi9wMyqfWvYVRqspHROIkb1ETBfxyg4qttAx39uM7fAvB0XgSttfprsYT38dQGKL
         qWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705782321; x=1706387121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfwBan/2xIUFRHbO7LpsCZE7Olbe57ei2B2P2UJfWNs=;
        b=Zvmg22DfrXYSp6Pnc5jwEP4CTwqXqTHJ4bppgygCw2RF76ZfqXNtqLr0/hGPWdYGIj
         bcdewhjfXttlMLIIaifcaO0feCqWQruPGOH9iZK12+MFydibn6xhjdZueTWkfuhvJViU
         f5wehlSf+QYbxbXS3n1YnsgSTyvwAl0PmoUh7O/IV7lHrP8c5/kblatyUvjwNtlpfnKi
         ti5gWVP//J3FnTrOCxZrLVJoOoxEnomrPen3PKJDfMx9ugtobD9L4TvJTabnQeOHVv/D
         KctfG97jOeQg0y+K8ZVl+x0kg6X9Ht61sda3aiVyAxgL77OfSidbvi+TcYpbFnXmrtZ9
         Izxg==
X-Gm-Message-State: AOJu0YwEU8vvvXlAjGSGoKdB5pnKVfw+hyAbqfOTBWT+Q0lCZBB4Jcxh
	t53jTG03EpvIQFB5dAo2HhjUDShkpb2wA00b7PkNUikF9OCMWAmoDWuoYJLaWC8/jJuQ31MXTb2
	BBw==
X-Google-Smtp-Source: AGHT+IGoiE+t9rOL2irDwBW10mvU5DTSYRfXzkqX4kihxYau6HQ/IOjE4yr92gYxOJJ7O+3koYDH7S1PlA4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:2c8b:b0:6db:a0e5:5423 with SMTP id
 ef11-20020a056a002c8b00b006dba0e55423mr54632pfb.2.1705782321269; Sat, 20 Jan
 2024 12:25:21 -0800 (PST)
Date: Sat, 20 Jan 2024 12:25:19 -0800
In-Reply-To: <CANYiYbGy-APMD7Cw=m-=8dkMcXCp9c+x_6OCoBhWBfvUUWm2ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <d343585cb5e696f521c2ee1dd6c0f0c2d86de113.1702562879.git.zhiyou.jx@alibaba-inc.com>
 <owlyy1cvhua5.fsf@fine.c.googlers.com> <CANYiYbFOa-E8Pivhgn_nmy982fn7VPtb803bewnC_UV7qY3xcw@mail.gmail.com>
 <owly1qaei8hw.fsf@fine.c.googlers.com> <CANYiYbGy-APMD7Cw=m-=8dkMcXCp9c+x_6OCoBhWBfvUUWm2ow@mail.gmail.com>
Message-ID: <owlycytvhhw0.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 1/4] transport-helper: no connection restriction in connect_helper
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"

Jiang Xin <worldhello.net@gmail.com> writes:

> If both data->connect and data->stateless_connect are false,
> process_connect_service() will return 0 instead of making a connection
> and returning 1. The return value will be checked in the function
> connect_helper() as follows:
>
>         if (!process_connect_service(transport, name, exec))
>                 die(_("can't connect to subservice %s"), name);
>
> So I think it's not necessary to make double check in connect_helper().

Ah, thank you for the clarification.

> The best position to address the bug that both data->connect and
> data->stateless_connect are enabled is in the function get_helper() as
> below:
>
>         } else if (!strcmp(capname, "connect")) {
>                 data->connect = 1;
>         } else if (!strcmp(capname, "stateless-connect")) {
>                 data->stateless_connect = 1;
>         }
>         ... ...
>         if (data->connect && data->stateless_connect)
>                 die("cannot have both connect and stateless_connect enabled");
>
> I consider this change to be off-topic and it will not be introduced
> in this series.

SG.
