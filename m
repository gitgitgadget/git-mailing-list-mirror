Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142B1D9D6B
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458387; cv=none; b=EG+6smRlm5YzORZr/jVXlgSl67ZplNzuXO6zXT+i5cTFEIgXc0oCh1Q68pDWVTu7p2++bZWcmOW8/ah9FZGYr3g5B9GkQuGZQwr1bsONilJfm/l1ihqDAqMFTvHlh0ixDSqS8d/3XxY5dx4IQbIFwv8twCmjtNywtVV82mpQ2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458387; c=relaxed/simple;
	bh=4HQyCh4tmhzK+d7QHEwxRl7ql3jnNh+K5sxPsmX/54A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAql2boPCGsFtFTUY/X4tbS/PwZecQkEu/6fYsUOjA5KXAGRjW+isj6CNRSXE+yudLSGnBxDM9/ilZRuD54WpSmXBqd7uHkQJEfLiUyNYwWxtJim2psQwQAre+330ec7AxpWXAIkTofTTjNINWmurD3rW0cRSPTFFpQ1TKAjh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmBfX5q8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmBfX5q8"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d892997913so2960678a91.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725458385; x=1726063185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4HQyCh4tmhzK+d7QHEwxRl7ql3jnNh+K5sxPsmX/54A=;
        b=HmBfX5q8DL0NkC5C3o198rqocjkJZ0yWO1a0wskimP0LyPFU0LrK9MFAYC8/8oTFEN
         PKVnhhAo1wsLDkmNoDGue2ZxpFQqTDOFnalUgdJpAjmJ/UxC5ry6q1kFWxAN4m7/2ZH0
         XdQjxMLv28pcs2Cic2347wRmach+SIAF2qjlGsQ5SbSEjnqBqCo71+RGWeMgnmavfRFp
         It+6ylS5L3JXUDMfthltdOvFg0v1/Ez0XZN/Vmc8Lpcq9/goCc1EQIXQ7Fy98zcv3M7P
         zzd6qP27l8XwwAC6rI6CgqhpDJGgHQkUZcf+mayAGgBOII1CdwTUCsaMOzjlG12vmofB
         llLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458385; x=1726063185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HQyCh4tmhzK+d7QHEwxRl7ql3jnNh+K5sxPsmX/54A=;
        b=MVoliVxRYJlNkdbmnPAnHM0RQOCME64nWZrv7uj6/b1XpNZlBycpTYEPlsAOuP+sjP
         fNhKNt7/kyKYvyNtcyYPqTxoxZ1MCR+dPqI9vCvJz7uiKVhVbrFF1HCnru/TvLAn7x1f
         RPXVKwEzS7PAMswfA/vj+nK4IQCNwCp8dVeNVmMpUWRPs5jhtRILUa2CV/YR77cowuqq
         OtuCaDPftSlZ5qdr3o81luUVCVR+6GoV/FFZsNUdAhFMmOFvDgVTYdmUrNV/ozNx7nJK
         IjQZEfCuV0KLCkdVG2z0iqoY+W0jnw3O39RkR1qcqneLXlrTqQJjQ5uR9W4ZCTIvmU3I
         1AnQ==
X-Gm-Message-State: AOJu0YyyViuRb/wSl7gQXt7cLvmT45JHspMEEgJaWrHQBqwylfgl/200
	42gmJ2BTgl3xp8W8+DafgyYzi7uruejtphPIRhcCeNLspwlpskFf2bl5ZT0+z/oPbOvZn2Z76pi
	oq7K/ENb0v8sQg6Zgq7qAtZHEBOE=
X-Google-Smtp-Source: AGHT+IGMowtJB/QTKqh1prGcnXsc6UCHWmU9GdNnkNeddJ8+IOgXWs4QuJS88q85LIivN3yxioZLFqy7X8ufV6y+98U=
X-Received: by 2002:a17:90a:b898:b0:2c9:a3ca:cc98 with SMTP id
 98e67ed59e1d1-2d8904c6ed8mr12431699a91.7.1725458384999; Wed, 04 Sep 2024
 06:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEO06G+SLu-LAe0mkR3ZbaL0MZpBm9PhntQjF-YwVPMtnuH=rQ@mail.gmail.com>
 <20240903170438.nhcnojx6upsxsj6d@carbon>
In-Reply-To: <20240903170438.nhcnojx6upsxsj6d@carbon>
From: Loredana Tralli <loredana.tralli@gmail.com>
Date: Wed, 4 Sep 2024 15:59:33 +0200
Message-ID: <CAEO06GKzQTfm9z8ODCAYdHsWwgfHau0kuFA7WFkVqkPHbsm_1g@mail.gmail.com>
Subject: Re: Ask for feature on git
To: Loredana Tralli <loredana.tralli@gmail.com>, Simon.Richter@hogyros.de, kostix@bswap.ru
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
Thank you both for your answers.

I was wondering if exists a bash/cli command to find out from with
branch a created the new branch.
Usually we can see it with graph or something like in this answers
https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs,
nand I'd like to know if there is a command through bash to check
directly "you created branch test from branch release".

Thanks in advance for your help,
Regards

Loredana Tralli

Il giorno mar 3 set 2024 alle ore 19:04 Konstantin Khomoutov
<kostix@bswap.ru> ha scritto:
>
> On 9/3/24 17:18, Loredana Tralli wrote:
>
> > Is it possible to have a git command to find out which is the parent branch?
>
> Please try to specify what you consider to be a "parent branch" in your
> workflow. The problem is that there are multiple things in Git which may match
> what you are asking for. Even better would be to try to explain your original
> problem you're struggling with - which made you want the feature being
> discussed.
>
> Still, please consider that in Git, commits do not belong to any
> branch: each commit has metadata but that metadata do not record the name of
> the branch (if any!) which was checked out at the time the commit was created
> (on someone's computer).
>
