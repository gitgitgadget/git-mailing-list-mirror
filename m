Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909B64E
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920755; cv=none; b=nXBVsD2FgMZyXTFMNqjhnBJgvNxLjyfxrB14yWauupCLvJdvqzQGX6VJyoxgzuqHulhz1Zlzc4JNZUHJB+w/iC9mb9l6pWfpsYW2NJjlOoxNo81exyI+9P7P209H8uao2NPa8EW0gwpuZ/X9Fobf1wWHN/C9aD6kK8Czc7ALmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920755; c=relaxed/simple;
	bh=H4h/plEu1ob6pioPgjbHamBggmivJe59w+m0IPfUjLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xa0ltJQ749AYV6ye/zflkEBqHU3RhP/RA2os9QQkBSUVWMs5UkXPWBGYc3635VnxJgPunA7cZqg88AMDr8oJKaKA4IEujHLVJQkl3f8L6wfJAh0BjW2thVYMwGQ84U8fShh2U+nbuaEKdKB1dFusUHh164RyxUpCMD6H7/NB5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlaMAlHx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlaMAlHx"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6c2643a07so4812905276.3
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 16:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706920753; x=1707525553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kA6K79ymk+KMizOTXjsHSkyc8PFMzrJBENbiQKddsYY=;
        b=qlaMAlHxKcnxkuLk4J3yMMuQV5UZW9+kZ8rtlamICvQ19eAbKUZ0e/bXPQygStHXPw
         ggCcqcLx+z4rKbh749NwJ3AqTKaT5+r5665AG6z54GeS0coy7phGdaZHtBWz3dWIGSk3
         0FZ2+f5RXi1QpOtvgsP4TL1ZRPXBvpNHz6q5G0yxvvU//zlaFblHlJ9WnlpRt3T+Qvm4
         JUpc/tQYwTYYeRib2dVl9D0Gz241WhsUo7O7K/9rUr8lHay+v1S34lGVMucAg+YudkuA
         hbZ6mOzcLK/nCodF3l/Fbuc/t791sIEgIUdyJFK0BNQNS4jjKsCEdhoquLPSmxxW5gs0
         gVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706920753; x=1707525553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA6K79ymk+KMizOTXjsHSkyc8PFMzrJBENbiQKddsYY=;
        b=rgQYWG1VgOtt5FOGyg+SjlHQvF1Do4JJRUkVqR4R6gjgWOSMvzcMktJBFbN9P1vKEY
         HIaU/Yhw3qPM7WZb82GuVjr5XKpsiG5gBK2QKZGPtSbjjsBjV+Y0E3LRDXysfR9mbenH
         x3DuXJJpDTKK0nCRwWy6yeaDOu5XMV8aYzjeTH+H3KLb+fyAMNZl+ozh+/wbXbxulRac
         78SKVwh5ioUGYtoIU/EPzNauDErQEWajJbi9YkpalIwYEihIMVU++XCV9STo487Wqja9
         K9isdlAT398qYQsbAO/kp9YfK2T4vbwbTeXp68Exrjd+4a2UFOAk7GAs0FhGY+QXeNGp
         ANhQ==
X-Gm-Message-State: AOJu0Yxt4JYPG0oBJRXo0FH9qq30sSSc9pLi53BHe2+J9jN55czexOKk
	mimvrsQc7EeuiYOoaSnRR9TJ5USksROQJ3pZaUbVKtgcxIAS5WNFO5MM18Fm2PjNDqi1ERf7mD4
	vIg==
X-Google-Smtp-Source: AGHT+IE0vaL7730/e4EhaVa9N/ZuCz1yjQdodOdRvth6m84rFGvAiDk+gKL1qexbNNJLcJhzwW3uCLC8CnQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1085:b0:dc6:e5e9:f3af with SMTP id
 v5-20020a056902108500b00dc6e5e9f3afmr1254813ybu.9.1706920753183; Fri, 02 Feb
 2024 16:39:13 -0800 (PST)
Date: Fri, 02 Feb 2024 16:39:11 -0800
In-Reply-To: <owlyle840zfo.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <bf2b8e1a3c4bc77022fab1ebaa0fc89a7813b4c4.1706664145.git.gitgitgadget@gmail.com>
 <xmqqa5ok12lt.fsf@gitster.g> <owlyle840zfo.fsf@fine.c.googlers.com>
Message-ID: <owlyfrya1ivk.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 04/10] sequencer: use the trailer iterator
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Linus Arver <linusa@google.com>
>>>
>>> Also, teach the iterator about non-trailer lines, by adding a new field
>>> called "raw" to hold both trailer and non-trailer lines. This is
>>> necessary because a "trailer block" is a list of trailer lines of at
>>> least 25% trailers (see 146245063e (trailer: allow non-trailers in
>>> trailer block, 2016-10-21)), such that it may hold non-trailer lines.
>>
>> That sounds like a task larger than something we would want in a
>> patch that focuses on another task (e.g. update sequencer not to
>> call trailer_info_get()) while at it.  It seems from a casual glance
>> that the change to shortlog.c is to accomodate this change in the
>> semantics of what the iterator could return?  It smells that this
>> patch does two more or less unrelated things at the same time?
>
> I think you're correct. Hopefully breaking this up will make things
> easier to review.

And now that I've broken it up locally, I can say that the change I made
to shortlog was unnecessary (shortlog already has a check to see if the
trailer key is empty) which makes the "is_trailer" check I added to it
here redundant (because non-trailer lines, which the new iterator can
iterate over, have empty keys).

Will remove the shortlog change in v4. Thanks.
