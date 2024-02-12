Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECA4F895
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781200; cv=none; b=o/5Tl7/Pg1MBqBi86w3n61IgSjA+aByow1m29gxUIAG6XTFz+5EfF1nFZYXMSCtCEnt+eUScYjjXbBDMK//5ED68/C5h4Bf+Mz+M5QUAQTOugzyqTTsF+BZnLe8LaqOGCQtIREUOQt8D6o1ZiGTjjPrnfOR8BK9WabXI8Z+PxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781200; c=relaxed/simple;
	bh=Bi7AEbLJz3X32rg6foP7Ba9QlzCCS0lDcw9P8im+aQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTDuUOKb6wQC/T9XbKCOgmbnRM+XK+kxg3koTjEQP34LsSU+o+SqRaREaTIUiSeuv3mG0HQT/r8z+oFv8Wpf9WZwfKy0H1gmvDle8eYv1DIeCqzT4oTWKkHXQI81RbRTumLnvEctRqZS2b4Ode5fhnMehghx/GhJDB8vohhTcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQFXnJ45; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQFXnJ45"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so656503566b.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781197; x=1708385997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi7AEbLJz3X32rg6foP7Ba9QlzCCS0lDcw9P8im+aQ0=;
        b=XQFXnJ45JqCnjvhZ6zzkv4j6kE8jeEOabDjtrnLM2f4uFLZj1m7xlQmANAjb1lRfQM
         0T63BqtcdwmCwPUHRf4y8YA0+Wnn81YcGgwbiJEBqlrS8rksRTbqZr64z+nvL0c5Y4oW
         Fwjzy85JSdFA/3SZxvaX35jANK1Ch25rqf883g4fsvoFuVg0nGymELQwS5KS6Xh/kiIj
         8gyzCUnlEwhBaDxCijORQSgo7TRd2W7tF5VW5XgmpDR6e55QGi2t8qNtynUq5f8CAyUu
         pqyNq32/tL3xoLGS1Xg5VUKFRvjb2BqyBwTxR5uwbsBqr4FdD6wtRN2lqp/sUpYHW34k
         k8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781197; x=1708385997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi7AEbLJz3X32rg6foP7Ba9QlzCCS0lDcw9P8im+aQ0=;
        b=lR0YImMhEsa6RReg2pJRo3gY5wpBtc5NIS8w8k0KyqOL0WopDT9bzIB1oDFsgaZfbH
         kZZ+DJhqlkCUeno/I31DAimh32IrkrE6MtL1aiX2yGFzpH7aPn1XyaLfdPWELyYzjvYo
         I6qFx9zkQHZQFYkZOK3dRDGSSWXMZFu7BdGWk6LboWIONYKu9vKOfNE4DQvFFIpb1wzu
         qixXIbyyGT11TUTUIUhHzN89F2Z+/XLoHzAO2gObXzPG7z4jUQj08Ui3XL7sN82Z0eC2
         JpOycBy9Va8yHSxJ5VxoOMhIMf1B6eRbVrLTN0k8FpJ9VWqhrSU4777xV7JN2nZBU1eb
         JskA==
X-Gm-Message-State: AOJu0YyrR92lJzyyOUKVed1MIXtDkKF8OINplDQLUpYnATMJr9up4BQ6
	2OoD4K9r6xRudI/34ApvVTcEuIV0ARQVw7FCKhtGZfZ20c38cB0wELJnng+i53Kf1e8LKu6yeqI
	cTMjKKLOBqYE3FaEcmKMNZywlg58eHLyV
X-Google-Smtp-Source: AGHT+IFmQwHifJbr6weAIlNvttkpXLCYcIP3FSr/hV28+CLyKdmwYxdQTItrZYcG33K654wxVWWQFuXNA6nU797thgk=
X-Received: by 2002:a17:906:4450:b0:a3c:1e4d:725a with SMTP id
 i16-20020a170906445000b00a3c1e4d725amr750560ejp.37.1707781196479; Mon, 12 Feb
 2024 15:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <26df2514acbf4d51f40f4b1b9f33a357fa424ac7.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <26df2514acbf4d51f40f4b1b9f33a357fa424ac7.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:39:44 +0100
Message-ID: <CAP8UFD2-M20uuo4G8HykRL=1g9634wKUT9R6DBG6nmLBqGpxzw@mail.gmail.com>
Subject: Re: [PATCH v4 27/28] trailer_set_*(): put out parameter at the end
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
> The new trailer_config_set_*() functions which were introduced a few
> patches ago put the out parameter (the variable being mutated) at the
> end of the parameter list.
>
> Put the out parameter at the end for these functions for these existing

s/for these functions for these/for the/


> trailer_set_*() functions for consistency. This also avoids confusion
> for API users because otherwise these two sets of functions look rather
> similar in <trailer.h> even though they have completely different out
> parameters.
