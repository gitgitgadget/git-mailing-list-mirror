Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2B8BF9
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712624898; cv=none; b=eO6vXDjQPckgiKFZcf5Ju9xQMNpN1s9ejI9hsi9Afi1QAvtR4m2CZQ3WhfNzrtdE8jpHUfPJpPZoxa3+LskFx5uC+dvwedYF78Fh6d0sqzw3qA5BYLm//RZxin/vz0XGhpOstVYXjqibsY+iKFs+i9rTOiWtHRC4RRhD8IWvZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712624898; c=relaxed/simple;
	bh=QA9DLuVzXk1EqmlBRwBjy7XzW8/mzL2afAMbP7BRY0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=swnRYwPTqd/3GRIqNUTmcNFxkULgGakPg1FnwIP5Y03TfPfkyJVXUxcBsnMagr0E5+QBPLWGM1YwhUP90Z06D5qWKdC77tHqZXSwZ67SZ7iK1ir4gZx1NzWc2Qk8IOD9QTWWPX8gMrbva6yNolRKXI6p6lhsWj4gdrX7EMYePco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xRierA4q; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xRierA4q"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61814249649so21337487b3.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 18:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712624895; x=1713229695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oeVfY4XPF+j4K8MxAquU+wYljrS0ouTSCrrspiXry8=;
        b=xRierA4q1RAXA1znTYlWkux+bhLXIu3A7Kdlqt5gBg9HIM3aSz956BzzFPPOhVTdoI
         gC/74J3r3BdUzqIHQ1Lp6JwBsceglOG4jm2uytqOJfdUv6DzUwSxnA3vzet0aaY3E3zv
         8z90MCL3M3nGE8zsbQnkxWMFpBWvHA3BtxcF5P3r7P+IiPLkn9upf2q+XSewZJuc4J9C
         WdirVYX1NoXwAe+7rVqOYTWSv9U+JUNsgDjivKErmo1P1EbWGCGiK7DhkDWfJTsqO8/9
         CX/ckRuUFU7+kugA6Zo6amZ2GDaB5uQ9T48B5pOGkDDv+411TZEYk53CTu2ZaoxB6T/A
         X13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712624895; x=1713229695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oeVfY4XPF+j4K8MxAquU+wYljrS0ouTSCrrspiXry8=;
        b=bkaOBkmlu47CBkRL4AqBlrJfiteiJhkrtDTyyhp3dxshgf3DJEr97owYygV7B1rjvT
         qgDK9yRL50Ra1bh3omWjm57PhF2FmarCpvO3PtUxDWBTowcAhW8+H9cgtfHYxmgdEQrh
         63zg1Sq5jdlB2mw+B9/yhC3GOqsD4ljRTwa442/KXeFFFR9wG4QqwjeZ1KBN22R+89Wd
         OCJyxozY3kv8tOpzCQrYTYA7iuVjwF46nsrXw48Dv1AcpBzK3X3XmSYk0nfeLxyEJi1u
         or0j6AVdH5fbjO0QF5OMcJrKaZ9a/qqQ27DqVUetlfMgpiMYmGBqwcKAd75luPdaCZMR
         xJsQ==
X-Gm-Message-State: AOJu0YycmzrcEogQHlSJd76GlmMkosSXf1ro5UUe8y6wDJlg2VJfrTXj
	jqmH8Ug8ytHyYCRyGACLTFuyD0UEyMLsmu13DE8Oy4izQdR5CJEu0nhJLyylMN7ccvYzWCSu/m5
	Isw==
X-Google-Smtp-Source: AGHT+IHAUnBk4mnOZufciPwEBhErrNZhqdJj4SmeytN6jnkLIjts/f58mba2E2O/2+1zZAvD9yRPUIi2miU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:c346:0:b0:615:3f29:c4c0 with SMTP id
 f67-20020a0dc346000000b006153f29c4c0mr2472984ywd.0.1712624895495; Mon, 08 Apr
 2024 18:08:15 -0700 (PDT)
Date: Mon, 08 Apr 2024 18:08:13 -0700
In-Reply-To: <xmqq8r1rqlgn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
 <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com> <3817e7f3cd007fe26b8bfdec6babed1c17ec3795.1712366536.git.gitgitgadget@gmail.com>
 <xmqq8r1rqlgn.fsf@gitster.g>
Message-ID: <owlypluzs5qa.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 1/8] MyFirstContribution: mention contrib/contacts/git-contacts
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Jonathan Tan <jonathantanmy@google.com>, Emily Shaffer <nasamuffin@google.com>, 
	Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Although we've had this script since 4d06402b1b (contrib: add
>> git-contacts helper, 2013-07-21), we don't mention it in our
>> introductory docs. Do so now.
>>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>  Documentation/MyFirstContribution.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
>> index f06563e9817..ad3989f53e5 100644
>> --- a/Documentation/MyFirstContribution.txt
>> +++ b/Documentation/MyFirstContribution.txt
>> @@ -1116,6 +1116,11 @@ $ git send-email --to=target@example.com psuh/*.patch
>>  NOTE: Check `git help send-email` for some other options which you may find
>>  valuable, such as changing the Reply-to address or adding more CC and BCC lines.
>>  
>> +NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you should
>> +include in the CC list. In addition, you can do `git send-email --cc-cmd='git
>> +contacts' feature/*.patch` to automatically pass this list of emails to
>> +`send-email`.
>> +
>>  NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
>>  please don't send your patchset from the tutorial to the real mailing list! For
>>  now, you can send it to yourself, to make sure you understand how it will look.
>
> Nice.  
>
> I personally find "you should" a bit too strong and authoritative,
> though.  Is the tool precise enough that we are confident that we do
> not end up spamming those who are not actively helping others?

TBH I had the same question, but brushed it off because I figured that
getting people to still use the tool would help make it better (find
additional areas of improvement, etc).

> As I prefer not to be too assertive, something like
>
>     The `contrib/contacts/git-contacts` script may help you coming
>     up people you may want to ask to review your patch by adding
>     them to the Cc: header.
>
> is as far as I would go, but for those who are not familiar enough
> with the project, perhaps it would be OK to assume that the script
> would do a much better job than these contributors would do
> themselves, I guess.

Yeah for newcomers the tool would probably do a better job. Perhaps
wording it like "If you're not sure who to CC, use
`contrib/contacts/git-contacts` to ..."  would be better?

