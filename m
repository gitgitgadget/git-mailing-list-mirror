Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8E67690E
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462695; cv=none; b=AGks13+3kiEt4T4SD2r/2xEQqv8FBhy4bukjI39yZDX6vvwA+43s+V3jgUr6/DHviREDYSdcPCZl3qMZMWuyw7V2ZRtVXdWCIAGNRfMfYZuTONhBh2wyxhP1mMPk/GWQ1j+scdH1VELTl4Qm4Ll0etvTdnnI33qZ/oVCIV9lblk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462695; c=relaxed/simple;
	bh=oP7jYawIvGkorsqsbjz6oBRczrvSP0n4zB/rWfEm6D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlqvQAjz7GI/4EYsqDla4EeGYEQuYSsdPSHk8dz6FWNhesFkI26Hgv6be/hQj5vbD5lMH5n0//PaDpGNcQMbjo1848sjqLf2ts+sDpH/WRccjXgPyWmmnk8h/H3AWcQ7ZzoUp//nvwx13oVBZk593oCqWSZB5qXHnWpJb4HTieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgKIV/YF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgKIV/YF"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5157af37806so6631328e87.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711462691; x=1712067491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xLt+w+aUcEoRIX/w5zhh+NhjrLzqpeQpN0E9F+i3fyU=;
        b=KgKIV/YFhxOBDvTR6B3O78uT3V7D5e4MuhwK1TaZYoQMQ3ZJAz+I0144Yfh1/6yXTG
         Z8XxXJTvSkFNVXL6L9djya+TkZ0vmmrGe80DgivbmfC8en7IzF7KFmU/LjluIrMJVuKE
         qNoxcR2RtEkNCdzn/RohQv3e431vrEf0jaLh9FYz3KiiV/cvII2gFpZnUyIWXRbyw/w1
         FEs5mdTWjm3wuigxTqaq/JXHfMCRHW4uXdcl8FiiaiLSYL9r6r9x9VqxHQUgtTn2HWnG
         ung/uqe00E6sDEeSHu+E8t6DffGe2pKtZLj3iuf8uJVvq9i3GOfgJJ+2bxwS6bjolAzj
         NIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462691; x=1712067491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLt+w+aUcEoRIX/w5zhh+NhjrLzqpeQpN0E9F+i3fyU=;
        b=moN1SvnmANCAM70DGaeYJKi5U+RhNUxNyuj7xBq0R5WE9nIaCOOM2gG6wcshgNv5xg
         wE3RQbFecOg7hpVGbmruy7xG6LM4mTGwrpRLE4636eSd957xM0F/D+zApuELDcP66sIv
         KsQ92/tGLQ2Ql/YpJtWuRm1HiBo87m8MsOYbKA+ZseQen9AdjIBwnF0yM//cfsDE7srQ
         7mnrxUzlLXM6/9SXvwSiAYZUN0RJ0pF9buTUqV53SUDrqh8SM10f6Yt9hyWQNxn7i2uF
         nkoDXdwJNpMYK7wAqEp+fa/xen3R3TeueXkmij5Kza7DqtRYjEUd5jUDlg1xlqBgW8/m
         n3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpNc72rHajixsenGd/6quDfZRi4ODP94A38a+RRIZtJ8G+UWMnSdhRlTou6Nesdo4wj9eihj9T7Fd02d1bs+U9E9Qn
X-Gm-Message-State: AOJu0YyFXv5lZy2hLRPR0QLeX8I7Dv6zfku8HUaOTYwu9Els7xnxpqQA
	fH5qgczX2Tuju4lCT8z1IB7E1S0gAR98Yh6CopiQDLvC9V3FUJWsKKPHrnNg
X-Google-Smtp-Source: AGHT+IFYwtHg7qYXcjPdFBLZTeDA0VNk6yi8jAkOqV1pYkCsPqxvGQDHDlc8HXId7zHHgkmd0yr6kA==
X-Received: by 2002:a05:6512:3d24:b0:515:b998:22f1 with SMTP id d36-20020a0565123d2400b00515b99822f1mr1427284lfv.5.1711462691240;
        Tue, 26 Mar 2024 07:18:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id j11-20020ac253ab000000b005158558022bsm1539511lfh.288.2024.03.26.07.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:18:10 -0700 (PDT)
Message-ID: <dda1ba52-7b43-4017-96e7-10080618d4e7@gmail.com>
Date: Tue, 26 Mar 2024 14:18:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] SubmittingPatches: release-notes entry experiment
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?=
 <jn.avila@free.fr>
References: <xmqq8r26eyva.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8r26eyva.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 25/03/2024 22:21, Junio C Hamano wrote:
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index e734a3f0f1..e29a3d9a5b 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -459,6 +459,17 @@ an explanation of changes between each iteration can be kept in
>   Git-notes and inserted automatically following the three-dash
>   line via `git format-patch --notes`.
>   
> +[[a-paragraph-summary]]
> +
> +*This is EXPERIMENTAL*.  When sending a topic, you can propose one
> +paragraph summary that appears in the "What's cooking" report when it
> +is picked up to explain the topic.  If you choose to do so, please
> +write 2-5 lines of a paragraph that will fit well in our release notes

Maybe "please write a 2-5 line paragraph"?

> +(see Documentation/RelNotes/* directory for examples), and make it
> +the first paragraph of the cover letter.  For a single-patch series,
> +use the space between the three-dash line and the diffstat, as
> +described earlier.

I think this is a good idea - one question though, how do you want patch 
authors to indicate that the first paragraph should be used as the summary?

Best Wishes

Phillip
