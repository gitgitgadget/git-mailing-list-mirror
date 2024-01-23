Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF6A3D563
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046138; cv=none; b=aNRO5SQg5szL654TMH7udF7G1q2fcDHdyNhRrQrpXlzS+SCJ7V1lzS4HgzYYJ+n4JFLuyA6T1Fzt81xaTRO90FyAu0q88sXUHOFKVEnMKIAZdxoL/k4flEEcifuzQSs+Ffn6UvSj7tGa0a0zWiQbyLrXMpy+1wSqDPYbM3ba6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046138; c=relaxed/simple;
	bh=3zR/sN48WOoVfwoyLe+AhGT16f7g053Bd1ZVge6qsYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4tJ/g+0cbOg5NQcUxQuL0q8Ty4RTM3KjWbQoS9LA0iaAcKUP6s/lubeEzFMIN4Dghxo1IiXBdu6cGn4N2HXiPLoCpIN2jDxL/yo4gTW83B4KLsHVYGTBY8ETowCuPVuSrBGx/q3HUI4FPPCqgsIYSlXynfaZAf0nQfMfn2IBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1DAOHUE; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1DAOHUE"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5f215553595so8308367b3.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 13:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046136; x=1706650936; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UbylW904YOqs5wQFzDYAD3pn1A5tIW3iSEo2C76l1k=;
        b=S1DAOHUETfbkuTbPfgLwdD5djHF0Za3W6xCejoz0HZsu4kUNd/ZJ0VD7FWzDZgtfut
         F+ipgHkqkPkB1fA95OosErre5BBOGWvNPtVAVbYiiE4w7t1Pf1ZXyOdUa/Q38juWkdQw
         dJFlbKHSF3kqI2Z+t3fBxgHYEF/+V3tg6OARVOZgi7f4brix1i58ryXmZYQQYsXXkXlI
         ZT5pjEUpZAGx6aTccAqLvtcJdvo7oGIqRrwmpM41ea/T8aInZIwg3arGs6AOjwrmtJM2
         qOJUYl9M6yV2GESTaTxE2J0/Cnc8BY3jggm81lKi3eZ1ozWHFaIKFrl4Cu/74lgINCjL
         L48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046136; x=1706650936;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UbylW904YOqs5wQFzDYAD3pn1A5tIW3iSEo2C76l1k=;
        b=Shlif5t3Sb2BBvZ0NIopvE/iGv5iVdbKJlM91PNBPFtRjhWahPKRRmePwu1Arb0owl
         0TtJW2ufsGzRwnTmyJc504xfj8mAUMEZgRlRwyJgrCZrFiwgPWY3GOurmQBIPn8YFJbg
         uO8Ey99Oq3zABoaYxJtGyWHnAk9tmDjq4yaH/bvTtfM4UQar/kzTZ/2ATvNhZrCEtPnT
         TLA2OJzS7WhS/fbn0IMnua0rdBkp1mvAohbETXfMPbs5JuaywCOPeQb/CGHjhiD+4r5W
         lFeuiJWWLsWf1tUKZb7/wbr3iq3UQE2G/QsK+bEoo0ZbT7WEz6tLSKuYWROgkV3606uV
         97Pw==
X-Gm-Message-State: AOJu0Yyw56d3xN4b1uz7jAQ+LAyYC8RdfUu1pGru9hsht5lRKWupeZKi
	ME9N8Col7hF4SnqAJglsUw5JnmLxvgEqNjKDt2W2hDTtECnHGwGeIyG5ehUc
X-Google-Smtp-Source: AGHT+IFxkYRPUcvFN3savu1PB+MDIVLyLngs8tNTqOIwBZPYCLxl+TgC/X3PJQQiJmdRKPrGylr/BQ==
X-Received: by 2002:a81:4fce:0:b0:5fa:f8b7:80df with SMTP id d197-20020a814fce000000b005faf8b780dfmr335327ywb.0.1706046135827;
        Tue, 23 Jan 2024 13:42:15 -0800 (PST)
Received: from [192.168.1.160] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id j19-20020a37ef13000000b0078322dc4f97sm3448612qkk.26.2024.01.23.13.42.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 13:42:15 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] reftable: honor core.fsync
Date: Tue, 23 Jan 2024 16:42:15 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <0F4C94D3-B81E-4E88-B5F7-7A3746A6DB79@gmail.com>
In-Reply-To: <xmqq34unn8x4.fsf@gitster.g>
References: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
 <xmqq34unn8x4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Junio,

On 23 Jan 2024, at 14:31, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This commits adds a flush function pointer as a new member of
>> reftable_writer because we are not sure that the first argument to the
>> *write function pointer always contains a file descriptor. In the case of
>> strbuf_add_void, the first argument is a buffer. This way, we can pass
>> in a corresponding flush function that knows how to flush depending on
>> which writer is being used.
>
> A comment and a half.
>
>  * Can't the new "how to flush" go to the write-option structure?
>    If you represent "no flush" as a NULL pointer in the flush member,
>    most of the changes to the _test files can go, no?

That's a good option and cuts down on code changes. Thanks for the suggestion.

>
>  * For a function
>
> 	int func(int ac, char **av);
>
>    a literal pointer to it can legally be written as either
>
> 	int (*funcp)(int, char **) = &func;
> 	int (*funcp)(int, char **) = func;
>
>    but it is my understanding that this codebase prefers the latter,
>    a tradition which goes back to 2005 when Linus was still writing
>    a lot of code, i.e. the identifier that is the name of the
>    function, without & in front.

good to know, thanks

John
