Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA6171CD
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921661; cv=none; b=DQvZaaaS5Zjdr07YdrB9RyVPdj8TVvbgkdhLDkkREm/mc5LjtS3hOY/poPlgMb7v8VzZSoqb5LqxkSC7rAcOXbPHmr5Nbd8KFjBDV0lut8WunNa/KWEZZvv6qbln8MHgaF/oTbCN4Ks3Gm+tQ2TNAdXfapw/6HIkZNlk3zkxSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921661; c=relaxed/simple;
	bh=ScdRZ5ziCSobHv5f4+DtHNk4XbYz+KePFHXCTxY+Avo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GI9+GfxozA6Q299qbhagNb5B+Z7ErIs5xmEw2KNEhvijXAlSlvWYAUuuHcqkeh7cgcRVqwpy2m2y98lrcxjrMjYUA8e1pOr5HDL+ns2gMj9wm69VZKgSMpSdCx9JuQue/m6RoGjZw9aUB6kWQ7C95mAJGg7++CsceifEYUHc8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns6H5Jen; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns6H5Jen"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5078fa7e974so14511e0c.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 19:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921659; x=1728526459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScdRZ5ziCSobHv5f4+DtHNk4XbYz+KePFHXCTxY+Avo=;
        b=ns6H5Jen4i1ULKOZAfDEsUYVw8AiUquUIN0QFm5bILGKHJoAfwCsdLkFXVJn3b3Isr
         xtIiBW8KItA9+KCnsnFxYwa6mSTla/Sb298lMLsXCmO/wvCl+WivQqOaKH4LQPVKs7RL
         CgIvjJvFWIOUaLLXp+q3uKRxMRzynbFrAYUuBC1zETgEZsfH6kqh3eO33jaExIAaCKsm
         HmuPQRHNz45c3Nt7QEDGn0kWkw2cjzUN8YZMDChl6d9U/DUj1zJBYZjxSRq+JMLjVO8S
         aE6sUfEPUMQb+IhV7B1Q+4pzbP8Qw9vQwbPx99OVyfQpOrBMftO3BTkxd8IYoIPX+Z8C
         779A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921659; x=1728526459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScdRZ5ziCSobHv5f4+DtHNk4XbYz+KePFHXCTxY+Avo=;
        b=TFRb2+wX97ZlUDvnT/rdxYRkxIaaAPD39FQ+VznIHcqah8fGVRIJ4GirXuGCzEkEhB
         RDwk8cLz9y4bXAdD1MfB2x43aZNcVuESnzeyFVtQAZQvVfF8qkCqLfTqBqrVqKsnYYlo
         3YWDkTZeNeanNTQvvB6y5VUSHYgJCHHv4K+5XqcR3mU3oxdDicvv2hnRIw7mro2QaCOS
         8R7P+22zFa0KCAzdIeSvmpcFYXxYzANet5GM/7hEC27DaqY/ERhjYKqcbkCoeuZrqrRr
         d992D7al6a7NQUt2Yn0k7SZqzbLbMesqS2mI/ZCWH/9ByCmRc6+6+Tfvz35EJmvvQuO8
         3XEg==
X-Gm-Message-State: AOJu0Ywx4rosaOas1lMSpRaKUnhMDrwXpuK6IzEaT6GppSCUjCsZ9cHw
	JiZxTylFeti8po5DYNpGk/veoFVe5fwiZbuYNwS3lAnLawzvxsHBQMZosiy6eJ4NR1wwGwS+RhM
	ADoNNRPRnfidKJ0lGUsd5JsUAX4oeDlpk1B3zoA==
X-Google-Smtp-Source: AGHT+IHfWs3P9lPVPfbeBzHCRvWrX+48O636u2VlqbKi/+2JJw17eUxDiHTt2PbfOfA0+q2RCHOiJv0KAJKmvKfsLKg=
X-Received: by 2002:a05:6122:250e:b0:507:8a46:b60a with SMTP id
 71dfb90a1353d-50c58218690mr1578468e0c.2.1727921658745; Wed, 02 Oct 2024
 19:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO1n884e13_9FZDBtcFrwU8oCyv+0_WUT-c16qN0W9c+D6k2PQ@mail.gmail.com>
 <834250ef-46ec-4667-8e41-e427472fd623@gmail.com>
In-Reply-To: <834250ef-46ec-4667-8e41-e427472fd623@gmail.com>
From: Abraham Samuel <sammymore50@gmail.com>
Date: Thu, 3 Oct 2024 03:14:08 +0100
Message-ID: <CAO1n887uu5qUcqLcdKfh8FBKJAQUCGqVOnAzX7WWiFEnuuMF3A@mail.gmail.com>
Subject: Re: [Outreachy]
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philip, thanks for your prompt response. As regards your
request, I want to work on the project description 'Convert unit tests
to use the clar testing framework'.

On Wed, Oct 2, 2024 at 3:04=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Abraham
>
> On 02/10/2024 04:04, Abraham Samuel wrote:
> > Hello, I'm Adekunle an Outreachy 2024 intern. I am most excited and
> > eager to start making valuable contributions to this project. Thanks
>
> Happy to hear that you are interested in contributing to Git as part of
> the Outreachy projet. To help us mentors, could you please clarify which
> of the two approved projects you are interested in?
>
> Other than that I would strongly recommend reading through [1] and [2],
> if you haven't already done so. They should give you some ideas for how
> the Outreachy application process is designed to work in the Git project
> and lays out the expectation of us mentors.
>
> Let me know in case you have any additional questions.
>
> Phillip
>
> [1]: https://git.github.io/Mentoring-Program-Guide/
> [2]: https://git.github.io/General-Microproject-Information/
>
