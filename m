Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3E17BA0
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610813; cv=none; b=rwgsKJzvGJzBOcuSb6bQHqi/nZKxsHm4v7XDqTx6ffjD5DQisHl8VkWadeeLzIx17R9bjiru+1zVlI+kfYOatJPaUYZ0sjjAHVEinUrPefmBehzZGEFJX89P4T9oHc/yWCE+zNiLVMj5t22lZDeVkvFlI4HrSDVwbC1rmMRAvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610813; c=relaxed/simple;
	bh=glJ/HYN7M9VGiLuo7W7PnxlkwG0Atx6WvRM0t9Vhy4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQgpuN0ran6C+maCBeSnE4YbNdQlDP4Mp+1hThvrJiv7UN1WOvtGtkyGeoNGPz1GbV72G+Ce05hE/9INLUV6L47Z6T1IF8B8mI6actwQvgmDc14eSdW8KKEX2Nk/2jGyZ6zCbq7TJ7KPskyUCD/vpDKBzaub/kLipweca9XWBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTf3tCBR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTf3tCBR"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfbaf3d88dso2898266a12.3
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 00:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732610810; x=1733215610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glJ/HYN7M9VGiLuo7W7PnxlkwG0Atx6WvRM0t9Vhy4Q=;
        b=TTf3tCBRx/Sn35cLMc6HodMaJHIyfisoK0ppLVXd089HQtaZxZDghPzmlRDyAIbFp4
         YYQCebGG6vANAZQKBhPiW6OFM9Q18ZX8fMlNiLQF0jFr6AOGo2TlawYjjWbm/g5/zWnB
         pPrHmq4eSx+iUUG0hDkrKYDkBeigo5cRXi2YxHi6dLOvy3tJ1jYYoDrAn6pqvXP9RP3x
         SFNUJU9EpB9A2oeh60O7PpBSXG99EnS5K6FDe+QXmPlqnYtOkmv1LPwbfL3AwqglAgDu
         mIh3hW8O8SR393VNw6y73t3W7dArBnhny5U0mEJrKHm+LvIGNE7mZnWCCgbc28d3EzvC
         ul1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732610810; x=1733215610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glJ/HYN7M9VGiLuo7W7PnxlkwG0Atx6WvRM0t9Vhy4Q=;
        b=qVAlMiJogluoo+bdhd7Lqg1grHRyMzg0pwuAmjY9K6AaFrDxoV348lMQ0JkXDsL6V8
         9Vm5iHTNVDfyc2yoba8Aqvk1ecXBR2hIeCQNXnV7OUbx+UkXfBog9IXuvkzxZP6GnzVg
         xBElrsJT4si7OPVDToFcwIIyIW8rjcbAiuiX1HTeWer/XT2FsChEHkK/yHU5y+ohc4jV
         CBHbXgL4l1gEpIaHli1Ysws0+hltqyXSyy+CJFOnVJy72LD4I5tNb33it7/sFDPw0Du+
         PnAQUeEp3yoOQmV/3yYZPkoiZqXcAGsjlE6pdu0HaNwZz8+6XTB1Waxk/1fZv/cuzCcb
         ghkA==
X-Gm-Message-State: AOJu0YxSLVRlN8NLAT/05KovU1KWKOGoRhONf+e6WkdhC03/pM41KAQQ
	cfnDHYA4fiFj5s1pgkEctp8MwKx0HRDWvjFcXble+CMcVDne3ANG5h+47OMdo4HN6WbHLshkKEM
	18psfr5FgRDAVhCGXY81BzeYZxJs=
X-Gm-Gg: ASbGnctxJpf4Di79aVS1aed7qHus+W7gSmkZaAny/wJP45uFpAA4sVxv1SdTYu+0pbD
	9vqRxfuhAKMCWx72aerqDG7Oi5Ra08gmvmg==
X-Google-Smtp-Source: AGHT+IElOTYxl1a27IzG/yoVkej5L8ynihCNEL+HrRZ5vxN+l5SGi7WuaPvDWEQp8OJza1eFcA/x3IWVviu7o6GIjYs=
X-Received: by 2002:a05:6402:13d0:b0:5cf:14fa:d24d with SMTP id
 4fb4d7f45d1cf-5d0207c45acmr19795028a12.22.1732610810389; Tue, 26 Nov 2024
 00:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
In-Reply-To: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 26 Nov 2024 09:46:38 +0100
Message-ID: <CAP8UFD0=OycMAaDi_92-Go2Mt4q-s7cfmBaZD_kWBnZsvYpiPA@mail.gmail.com>
Subject: Re: [PATCH] builtin: pass repository to sub commands
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 3:56=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> In 9b1cb5070f (builtin: add a repository parameter for builtin
> functions, 2024-09-13) the repository was passed down to all builtin
> commands. This allowed the repository to be passed down to lower layers
> without depending on the global `the_repository` variable.
>
> Continue this work by also passing down the repository parameter from
> the command to sub-commands. This will help pass down the repository to
> other subsystems and cleanup usage of global variables like
> 'the_repository' and 'the_hash_algo'.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

Yeah, this is definitely needed to cleanup usage of global variables,
and looks well done to me. Ack.

Thanks.
