Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2A1EA7CE
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082223; cv=none; b=dIumIt8/NGjIyn6x55+q70CkVuZZPPLJ/fyQA2ATF7V5aIKi6q5NrlQy2ePr1BpMA2HI3nircHFSuXYHm1i8/ncsDVi/oAA0yAjNA8qFt58BsswxIJMxbWKn+zL9gz1YlMkjNLMmUXddGcOGp+xPLzJuuFwxSz0b9D8tELGyRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082223; c=relaxed/simple;
	bh=88dotDEB/ay+EtiuP+7vg9ztGPEuo4Jl7cs2YRiiF+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2ON/xuymqvjcJuK0If3Ms515VQ+29QgNXfrccUmmZ1iZdHd+C+65SufOZi1y/9wbUG8XVOfaJ/XQwRTybYnCC/IReybsqSlBgcTyO3X3rt9YHI/KMTuD1TWf0N+D4WC6GaVhbFb4qTrlSEG1Hwcpylm+eS0hJSC0jpy/VUNW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcQubpze; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcQubpze"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-521b84da5e9so1936493e0c.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 01:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741082221; x=1741687021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88dotDEB/ay+EtiuP+7vg9ztGPEuo4Jl7cs2YRiiF+o=;
        b=DcQubpzeMXevzfd+MdSRRuFuIBMANkWYUbk0qneCQ+c6FEUxBvIoXIamcMAyD/MNaM
         ybFdGx2cVcxVzh8WeKGtRDZMF1p5YMGOcOIFdSnh+FhQuo0IgRLWbISJgoYE+riL8rnA
         5sv5zDdrcoHe4x13+ual0xn1w04dCii20mklvONMftSA89RcjJgiDKMtPN6Dq6awqOAP
         IAuSfzX3wDwtUUBhIZRKJ4DE6VKdwSCCqGoZsscZj7ww9HmtKO7GNIF7gN7sC1V9sW8Q
         7PjWN1H43gXN4ZTtqEY9FON5+HawUIfXpOC77BpZEMkdSAKkryJdfvQue8bXx4oXM4AW
         ge7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741082221; x=1741687021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88dotDEB/ay+EtiuP+7vg9ztGPEuo4Jl7cs2YRiiF+o=;
        b=vjINYujgh0PNkX+UOBDSKk5g+XzBARie4vYtpFkvpCik6WRwt3zMuaman9AsOajhdg
         F5+QL1ZHS4OaaKtDNHuzsCqSvFxP6gyyLWVzhs6f65cbcGwXjgPG+DGdiRNVe/y0e51U
         VVE70xuYtP0mOnCkxeGNJByr4yliv2qrF9HBTHfMo+e34pRFb6NU2hxiEvoJJffKREEE
         7mSXigxCl/9lhHopa5893dFQidswDayI8vJZ8/EbgppgtkaA8w6dtYA38qLjoQHpl+4g
         kM/ldJ0v+zhP8p0mAgqnTIfW2uRJW0EZPYn2MDUuu4nvFD1GDwp1Zuzqip09xcUSvHTq
         iArw==
X-Gm-Message-State: AOJu0YxsNuai8ptUHL+j8Sc6TTRyZSNTBy0+9uIMTgEmLTO3Fqgya6cP
	R8tvBj1MHUqLSnNbmp/n1sDQ9ejWH7nKecsQIA6vxqI7fNhVUFP88LacxTwPb9lpK7D7xCFU4Q5
	XAbCBfUSSAEzweutT8Za4vTnsFS6gdB5smv0=
X-Gm-Gg: ASbGncvb18jgjlkRHOr7dG4ywEst408VDzmN01gWz/Y9tgc1NmEOQNNGPLWfRVz0pm7
	TxKIAaHIQdGjrEET050XuB8Mf7FsnWcXyUUWugRuKbWRmeCL358fw/AwSiKekbpPmc0GHH5U4gT
	HnsP5hA/+NLTqIng3ouGJQ9PXDiw==
X-Google-Smtp-Source: AGHT+IFqAEQQa1qMEw+0Hvf06TRLfiOYjC/cM1JomUMlJUB6Z/X5z3Bu6xICm5KvxKuslLPOY3q6YtLRW2iIYgtIJKA=
X-Received: by 2002:a05:6122:da9:b0:520:5f0a:b5a5 with SMTP id
 71dfb90a1353d-5235b84f651mr9159395e0c.6.1741082220983; Tue, 04 Mar 2025
 01:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPeA_SNEbXMJnz=-qAjNoJZFWxW1fV0yQFsZYzW9VcwEUOSjA@mail.gmail.com>
In-Reply-To: <CAPPeA_SNEbXMJnz=-qAjNoJZFWxW1fV0yQFsZYzW9VcwEUOSjA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 4 Mar 2025 15:26:50 +0530
X-Gm-Features: AQ5f1JqMaPaBnrElJm4nSTvRd5Jd3hlI1hg8REFuM62L7Z9tSTeJMuiDKKkSOWI
Message-ID: <CAPSxiM9JE_cKRSMec0t8m3Ev-xx9Pdk6_D7QqLodXJiU=_eGpg@mail.gmail.com>
Subject: Re: [GSoC] Introduction and dev environment setup help
To: Hisham Hasan <hishhasanstudent@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:12=E2=80=AFPM Hisham Hasan <hishhasanstudent@gmail=
.com> wrote:
>
> Hello all,
Hi Hisham,
>
> You may refer to me as Hisham (he/him). I am currently doing my BS in
> Computer Science.
> I meet all the eligibility requirements for the Google Summer of Code pro=
gram.
Welcome to Git community.
>
> To begin with, before I start working on a microproject, is it
> possible for me to contribute to an even smaller task (A
> nanoproject!?) that pertains mainly to something like a minor
> refactoring issue. This is mainly to ease myself into the codebase,
> meet with members of the community, and gain a better understanding of
> my capabilities here. If this option is not suitable and it is more
> preferable to start with a microproject, that's perfectly fine as
> well.

I do not think there is a nano project discussed in related to Git docs. Bu=
t,
I supposed you mean easier and more friendly. task

Actually, If you check the microproject, some of them are actually easy and
friendly.
>
> I have looked at the SoC 2025 Microprojects list and the SoC 2025
> Ideas list. I am currently setting up my development environment. I
> have cloned the git repository to my local machine. I would like to
> ask some clarifying questions about setting up my development
> environment as I couldn't find adequate answers in the docs.
This is mentioned in https://git-scm.com/docs/MyFirstContribution.

You could also check the git/INSTALL for the explanation
on how to install setup Git.

Thank you.
>
> Thanks all,
> Hisham
>
