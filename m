Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E718029
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711587797; cv=none; b=Ix00tnjGCzsCXj/cLffdH1WZPRgWL09vJ30bOCgLM61c4zahCJbFDAwQ515e5QQAKvPsl1YHfb63vqWXYW0pnn5XFANRZCkI6Rt8DBMMN3H+b201o/dajlVc+MikSLb0p4A6ZcbAiCkaBSRbynq7cAITU9+SOos9LF6Qrjgyhug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711587797; c=relaxed/simple;
	bh=C1pUze73Nlt/l8A2X4uLGToQSHcfafl19WulR8EDirw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNYuuhaZWje/KJyhp6lltxPHPzvAwUTXfSg/+EMw8FsL3Bwf3HS54C3qQTS1D2h7jq/rguzAoPjVJRkyfLNtNjkHb8HywS3jcWbg22Vgw9zSe50QnAz6W/Wc9SqQwXNzCsNmyElJwWKCZwnhrqWezIXYjDzi6Ij6PTNF7zmnZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN7RfiDE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN7RfiDE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-415447b16aaso880275e9.1
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 18:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711587794; x=1712192594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCkFN2j6Ny5GU+iuRkaeGnaLgrpEbHImaFDA/PFqQZ0=;
        b=VN7RfiDESlMTXXp1kqnAJ1DMRfSaoCYycqGoLmHRSEaxRmuZ0MEtvWLj8gyGcx9Tmm
         AJRAxgi6xXw7xK0FwzxocWJqfqj1Dhgkts6BdU61b3/gVwShz69eZJenEOVleR1ZU0rR
         Q7MLgshCUO1PZv7ef2V3vyHCwEsANeG1tpB30aBYC20XjbSgpnWoDYl8FZp9Pc/+1YqH
         pGdnyslE1zZH60ZHvnHiC94TL6k/6H3aF+8jnJ5+d0i3JwSwjR+gRwMR51QRY9rbyXQA
         uwCOOJhIudA5tDxfo0W+jE2VyTSDtzMrm8zYUFKvOX7W8d4LtD4VR2i7mWdTOVxJ5R20
         B4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711587794; x=1712192594;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCkFN2j6Ny5GU+iuRkaeGnaLgrpEbHImaFDA/PFqQZ0=;
        b=HZXtZ/lgmJri2vKoxb6t7WeVbTXza9J36ViUkYCQ6Z7ZgJELNw1kulIW8NIVkCdb+q
         TKDdPKy0Uoi68Q8BbCdoa1vev0fPwUcm8q3l8+STZHZuKwMq2mruuVeyXks+XK0jxi4W
         XLGAIIbb5OgcU0XLXqv6RlzEdxUh4P4axtqm0AnJtXmP6be+mqhzXB1vsL82bdqt4hSL
         3bqKW7YQxxGWV81TcOFbuOKul/ucfp/OCqzITMIyXlkS4m8Eg0ApgYHeInkmLn1CufHp
         yDUXm6Yvzuzia5ehizITYbkIUhA/ICGWiKkiHBQsRU0HZO4xgCyEqrEYDXcJl1l0lECi
         fHuA==
X-Gm-Message-State: AOJu0YyKOo9Sh06riW/V7/n5xxfEbQwccWfzjTdyJnU+ALIY8dxXIawi
	QNqysDkmRivjuUME0DJkN8u/PsfjhodGKm0U5jQQ3zt4lR8ngHam
X-Google-Smtp-Source: AGHT+IG//gg6zdx5dIvanlg0cfFKi+3Plrstn0eQprE+V93i3CmgFbtRqGryCaK7zNA8xa3KFKNBpQ==
X-Received: by 2002:a05:600c:358c:b0:414:8e7:cd60 with SMTP id p12-20020a05600c358c00b0041408e7cd60mr1254047wmq.8.1711587794273;
        Wed, 27 Mar 2024 18:03:14 -0700 (PDT)
Received: from gmail.com (200.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.200])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c154a00b004154596db0esm41676wmg.19.2024.03.27.18.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 18:03:13 -0700 (PDT)
Message-ID: <c656f3fe-5245-419b-a797-bdd76009e86a@gmail.com>
Date: Thu, 28 Mar 2024 02:03:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] improve interactive-patch
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com> <xmqq5xx9dn6q.fsf@gitster.g>
 <8a05d7f7-6d94-4228-9507-d3af44f100e7@gmail.com> <xmqqttkr3ckz.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqttkr3ckz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Mar 27, 2024 at 08:43:08AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > ... My
> > reasoning was that 'p' does not do anything useful for the user, if
> > they press it they end up with exactly the same content being printed
> > to the screen ...
> 
> Actually I do not agree that it necessarily is useless that the same
> content is shown.  Especially since we do not page, it is plausible
> for a user, who saw a huge hunk, to want to tweak terminal setting
> and raise scrollbuffer size (which may be set to 0 for usual
> sessions, like me), and say "please show it again".  Or even in a
> more primitive environment, just say "please show it again" and
> immediately type \C-s to stop while the early part of the hunk is
> shown ;-).
> 
> Thinking about the name of the option again, if we are omitting to
> show a hunk in some situations, the request to ask for the current
> hunk to be shown is "please show me", not "please reshow me", so the
> verb 'print' may apply to wider situations than the verb 'reprint',
> strictly speaking.

Thanks for saying it much better than me.

I would add that I see this series in terms of reducing verbosity rather
than repetition.  I'm not trying to stop showing a hunk because we've
just shown it.  In fact, maybe we can find a way to not show the hunk
until requested.
