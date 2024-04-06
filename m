Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B752914
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413470; cv=none; b=Q3k1esVxuX9ywSESoRkiVmpdqIQAnkaLf0dkMB5aaAyktaFhDJzThAWg9vRgs91cBE+P3eqmVu/2uq7ovzLJ1nMn7ZRnwsN7YmhscwtMExASPmNvtzkvH7oBRvKa2riGdVQ+JgT/gga7hmYglfZhAvpdHv6CfllnzqYcAs16lCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413470; c=relaxed/simple;
	bh=YAiU8R6CEA3FNfDe+N37JTn5psIR/yxtjhVKoDN4JhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjmQaTyIo3MkIyHDuV6Ia14DZRLPQwTiLlcKPQKLJNgb3wGwlFBtza+nv2vKkVlfip1+QCn+X1fxG7Ty2vcNbDy9fyUYxcKESuOf8t1e7FEv1vXFjYWevSMmtvLTeQl9e8qjFPBbMiaFjt+LH/aAiHaxPkJGz9cijLWgFm6xH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMW3bM04; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMW3bM04"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343d6b55c42so1719347f8f.2
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712413467; x=1713018267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cX0/OsZbv72WxvmRmSSprjwTOmTFTGCNEiyukCWMyM=;
        b=eMW3bM04mIX4OyAdXAElWdPGZn1IVZsYYGcBE5oTayJK0DoMeY2KQnrftJsPrsJiuz
         BA3UoEkXJLcu6jpQQVsRKeTlePgS/fQq8eg+/EByeHbcpl49zy+BlD45YsujlZGdwxtz
         pNp6VOYoTLFYNwRcsKJZMeDJyDwsK5LTxlwKEvI7JRIX1MFPvdXM3UP2RL0yMr4/J4Xz
         VSJHHVX5fPBA89TuAugxT0+pfAfxte8+m8Jxu4llOKsEiUR5jQvtYWWtIFFGD2AOIOb1
         p9bIF7V9AR9LK0svwODehEG+QPzRWX9T7GV0ORtSCLQCGBmcXTWcVsZSfoJcaTPN6uGg
         qoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712413467; x=1713018267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cX0/OsZbv72WxvmRmSSprjwTOmTFTGCNEiyukCWMyM=;
        b=k8YUrVjaGQx6dLujAdqiUM0fxQ8Y31poalDpFLtk5HcJEKkMT4bMATi7n8Dv7CNq+x
         EGsZZPeSNRSMW/2wKKdeoSWsUdoEw/szljJc+W/vm+LsFj1jCpwMvDGnQ14ZjAUhcI1F
         onv+XQLltIZxJWHTRis5kR3WvNQYJhZM3BfXuPha1DSnRVD9yCQNieNu4ILQQMFXfOJb
         HSXRfcXkPA/slKVIXZhC8jjeyISUE3t+J9DnJK8pqoH+gCZwVA+PivbOXWC0/I4XtbCo
         TeouCURHTFDQhbYCBzKVS1a0ZPF7wG4Ec1MnUUQ2CLP9n67cixA+oyl+dKoHfEfNR9Y/
         q8sA==
X-Forwarded-Encrypted: i=1; AJvYcCVGTPnQozT9zQI9MkJyPJO01pL5dPHF69SgOUj4k3PTkfHZqGTAoUmKgRkSynTMq+N4CKVwbZRFf1AU2BxpJx5nwIlj
X-Gm-Message-State: AOJu0YzJ6B3urFATPxJVA/T7NK6E4NdvGkOJkux7y8Tmizv1lrQTm+N0
	L9M8kJa0+DB+P+uq6hglSkjrOm6kDo0u6qVS7gGyxDC/5pPqyX5R
X-Google-Smtp-Source: AGHT+IGD46rn5wjmN6b+SOWDgLvK7AiwcAXSpm/lwXuY8DFuOcWaC5MZpSQkv9WTPbve0Sih9K4//Q==
X-Received: by 2002:adf:ee46:0:b0:343:81ea:c539 with SMTP id w6-20020adfee46000000b0034381eac539mr3870877wro.28.1712413466768;
        Sat, 06 Apr 2024 07:24:26 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id q1-20020adfb181000000b00341c3071c93sm4628509wra.73.2024.04.06.07.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 07:24:26 -0700 (PDT)
Message-ID: <7e4eae67-8db9-4be3-8b96-e2e89fa82abf@gmail.com>
Date: Sat, 6 Apr 2024 16:24:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase -i: improve error message when picking merge
Content-Language: en-US
To: phillip.wood@dunelm.org.uk,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <57462d2e-e255-4d35-b778-176f03675df0@gmail.com>
 <dbb4615c-443f-474f-a33c-cfb4486d436b@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <dbb4615c-443f-474f-a33c-cfb4486d436b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Apr 05, 2024 at 10:30:37AM +0100, phillip.wood123@gmail.com wrote:
> Hi Rubén
> 
> Thanks for trying this out.
> 
> On 04/04/2024 20:44, Rubén Justo wrote:
> > On Mon, Feb 26, 2024 at 10:58:07AM +0000, Phillip Wood via GitGitGadget wrote:
> > The change makes sense, but this is confusing to me:
> > 
> > With this ...
> > 
> > 	$ GIT_EDITOR='echo pick 17381ab62a >' ./git rebase -i HEAD
> > 	error: 'pick' does not accept merge commits, please use 'merge -C'
> > 	error: invalid line 1: pick 17381ab62a
> > 	You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> > 	Or you can abort the rebase with 'git rebase --abort'.
> > 
> > ... I find these repeated messages confusing:
> > 
> > 	$ GIT_EDITOR=: ./git rebase --edit-todo
> > 	error: 'pick' does not accept merge commits, please use 'merge -C'
> > 	error: invalid line 1: pick 17381ab62a
> 
> The two lines above are printed when "rebase --edit-todo" loads the todo
> list for the user to edit. With a real editor rather than ":" we would then
> print
> 
>     hint: Waiting for your editor to close the file ...
> 
> Then hopefully the user would fix the errors. If not then when the editor
> had finished we'd print the remaining errors  as below.
> 
> > 	error: 'pick' does not accept merge commits, please use 'merge -C'
> > 	error: invalid line 1: pick 17381ab62a
> > 	You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> > 	Or you can abort the rebase with 'git rebase --abort'.
> 
> I think that printing the error messages when the todo list is parsed before
> it is given to the user to edit is helpful as it reminds the user what the
> problem is. Your test looks confusing because it doesn't really simulate the
> user editing the todo list.

Certainly, the test was not clear to express my confusion.

The ones that are printed _before_ the editor is run are the ones that
confuse me, because when the user exits the editor we leave those
lines there:

	$ GIT_EDITOR='sed -i s/pick/merge/' ./git rebase --edit
	error: 'pick' does not accept merge commits, please use 'merge -C'
	error: invalid line 1: pick 17381ab62a

But maybe it is my interpretation.  Your reasoning of giving it as a
help to the user makes sense.

Thank you for your explanations.

> Best Wishes
> 
> Phillip
