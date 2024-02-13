Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F75FEE0
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844890; cv=none; b=GkAygqou1T5kWvUCY//EIvwd5GUy9vhcg9PWJetprRuH7l4RIqPUgb36KZ15DKlASE0PSahA2dlHBU8bSKxntiIv40Pd2P2/6OOT/wiDGd6SgYTuvZiKTo1aclD0MBgFYPqsxVXaWqX0OAlYp7TRMIaFenYS01YNqz89WYvIFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844890; c=relaxed/simple;
	bh=Tm9e5Ak44vfbaUgjob0M12Btoxtr7TItkSoBYtwbHbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIvsMcxytihXyUaJJDsA7V6xmzNxGWbLR5BDSESB2lcprFCKuVyrKFn+ab43+EaVUg65l79cBjV8SR8rNliiO1Ed5zGmxW6oxyty6od77S3xl8IvSkkLKX+dqCqV0XhAMF9quiYtI8gjffTsOq1uzSOzRQ9GvkSQB52u2+mQ/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx+4vk0Y; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx+4vk0Y"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e09015f862so1680476b3a.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707844889; x=1708449689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZgSBQgvLapbxyO8sLO9Rl6mlatdm1V/Cfmv/ioIOu0=;
        b=Mx+4vk0YnOWbW1apoQekc+YJHuHXG7qWisu7Z6HkQiCm9ofXyBgTCwWvVBQbEbxBn7
         IOiI84NhvFd7EK+sHKDlATCp9kZ/EnIrRdI8E+/j9QZZljNw35mS5ruyc8EpDiFe4O6/
         PpM8cHejx94JSNUysreSGt+hvxiKjs8KZEkL/q9NaJGdwvZzQoNC4pdkrb9X0WVmaYzQ
         Pz9RZZTZjbhe5AKWzutfvy3yJiQap3r9nxr5/rIfCmStbgjCVD0NIepVNfxuHr2qsjIj
         R7bgKxo3kDRPaJcLd8hhPAuj1nfV7f/0TA0HYEblyz+Rou0eQVjF0zBLuAA1LX/GP0BD
         FHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844889; x=1708449689;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IZgSBQgvLapbxyO8sLO9Rl6mlatdm1V/Cfmv/ioIOu0=;
        b=n0/XI3b3/8sEPBWA/8FAvyIhkjbP1zWco6D9IhRlHRkXIPzzOCRPY1u+M4HkTP+6ax
         hbLC9HtWAe3ddiJ+2cJbF27OSh/MSPmFWej2XCXiQIGpussWIR+Q0yNY9Y/JbThvOA8u
         837dPSCjPXKo7PkgKg5IzyXuKTGsbhYdJmt/s3sdRjm+jTYQtzu5XUjUTYnguhBN7NxO
         LjFGtTCUHHzJSaIGk7NUuFv2qT7n85PMfjAlIaMjsCjx30q6k+lIhwbbNkQSu6fAzy9S
         nOx5eoGMeNtTBpCsVAbI3AdB1jU1UtGIWje+NJOR+QihlsQrTcJjhwwQ8mulL4AHJ4f9
         txEA==
X-Gm-Message-State: AOJu0YziIBQoG/s5TreG95AVzPJziYubjWxSpZzxycVfij11kl29h7bw
	BoULEmZgzsln0xuaU/md3uFPxiB5mqREjVvwKPo/AdX/gYTud6NyFxuCkyqCIeedz0sX4UVvdAr
	u+A==
X-Google-Smtp-Source: AGHT+IG6LWDAMGp1c9aqNDdL+ZdgBpsEn3mNWHRSCl6HjOZMqDwbe5tIzj+XidihyBPzpbMDBitOI2jqhcI=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:61cc:b0:6e0:e2f8:cf4c with SMTP id
 fw12-20020a056a0061cc00b006e0e2f8cf4cmr357078pfb.3.1707844888806; Tue, 13 Feb
 2024 09:21:28 -0800 (PST)
Date: Tue, 13 Feb 2024 09:21:27 -0800
In-Reply-To: <CAP8UFD3u+QDx2LqpO2ZpeHQszwjMAsQ90qqbE7Om=t1vPRQ==w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <ba1f387747b08a7270f7387beddd75dc4a8eddfe.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD3u+QDx2LqpO2ZpeHQszwjMAsQ90qqbE7Om=t1vPRQ==w@mail.gmail.com>
Message-ID: <owlyr0hgb7qg.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 15/28] format_trailer_info(): avoid double-printing the separator
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
>> Do not hardcode the printing of ": " as the separator and space (which
>> can result in double-printing these characters); instead only
>> print the separator and space if we cannot find any recognized separator
>> somewhere in the key (yes, keys may have a trailing separator in it ---
>> we will eventually fix this design but not now). Do so by copying the
>> code out of print_tok_val(), and deleting the same function.
>>
>> The test suite passes again with this change.
>
> I think it should be clearer above that this fixes a bug that was
> introduced earlier in the series.

Ack, will add something like

    This double printing is from a bug introduced earlier when we
    started using format_trailer_info() everywhere.

to this patch's description, but also add explicit language in
"trailer: begin formatting unification" to say that the change is
introducing temporary bugs (and that this is why the tests break).

> Also I wonder why it was not possible to modify format_trailer_info()
> like it is done in this patch before using it to replace
> format_trailers().

The artificial organization apparent in this patch was deliberate, in
order to make it painfully obvious exactly what was being replaced and
how. See https://lore.kernel.org/git/xmqqjzno13ev.fsf@gitster.g/
