Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A927FB34
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742869; cv=none; b=oqMNDst8ojS9NX+rWmAZiPJHOiEcdNt4CEjGxmGuR4NYfR2oZGIvtHx/LB1NfHCfilKD1R9hXPuQb4mJitr0UdIebQtcPUY8yzU5UaQSzNxvSc3u+hUr5gW8orbg5rbSAimjoBJCQWtCNOgRZs4eraYCavtBE7S5fBl2hJeD42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742869; c=relaxed/simple;
	bh=RoNM+ywKTNQSwjdR/QSIkpWmG5EdF84JzNXqwBDNI/c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX3lYJiWfuYtqOk660vbLyaf5roTkshWrr8DmDv/q8CjHmZcSjTMabfJE4Ymf+TC4flsw5f6EGBw3ieJ7IsupwQ7xRCRmVc5P/5mJUkRyxDKP2xgGTDi4e2KeJXMxOgfOQAXPvO+9Oi5oID9YpB+vtG5/MJWYKwdVSG5NCSVXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBMLw4ve; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBMLw4ve"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87ecac3e17cso344459241.3
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752742867; x=1753347667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=leH6XQeH5f1Brg9YSHaV1zzP1Ph0XetAkBKGcemtEmA=;
        b=ZBMLw4veEVqHfGezKR82F3lzGoXNS+5L3OCkmwEBglStAX1GFqYs4j67lY3G0Anj1U
         ytvKqTozjXFhOM/ySK4RxRnQQxpewlkm4y2y1CE4gFiNDlTgVl9VY5j/25O1YiDp8hpf
         8LbjvkwVKJlmEhxyULdyPhIGUeF1chG4ObtrclTW0M2zDoWKGPx3+E2oVc7q/2Ui3zWT
         morRGgtw+9PGqmd9TuhsPJcWfrnJq8NrIJsRXTfWhrzPXHrdMiURzvWUzaIa2nby4I4z
         FvmtksawANUOdUq2qVBUnrJH9iJAdy0L0z6nFSll7yelqxCLUrKFa4/8k7U/RXTDwqrI
         VMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752742867; x=1753347667;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leH6XQeH5f1Brg9YSHaV1zzP1Ph0XetAkBKGcemtEmA=;
        b=KW1bJtU80Q/HP5HT7BdfxXrTLKskWjP6kKRdnNbNDFA5G+rq8MxccktDjn0rlpWMnP
         6wwUNycbh8HZ9tHuOSWAegcJNRpu8cRsHSwPyA59X/3Jh/Vd8FIHmQ5YEysU7e6A68gT
         ossFi+pKRLBV24qGlt5dbQ8S8bsQQOUwUHANxZ1VVWjBgfrwL+dSkiDrDSug35/3ECeK
         +Aa/b3+b6cvvexROW0/rox71sacpDtRQHOBCSekL1XJOW6xZyI7IfXaDKjK6PG+GZUXq
         +KI4ZK4kxX8B3TgQLKZIahlkn655kWyw9fvwxnWQ4Ass/H2O7kUkzUWVgPz7BtQst/8V
         NA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgEvCvtSm0oSY9KQFChBTzEuycrFO/fqs0yBJNP5AdpYQNl9qWlmc1XGZ4BpQ+skPHTHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXXLHHJJD//bOFsIYLw8TLigB5e1YYYNSmNljeDOXwtpDojxL
	FaLI4eMxzVlF8JbnzPmjRU7To8Z3j87tlHtg3byDk/oWCIhCjAtLpuZyEDFK2HKZgkh1O3SEgmU
	G6p4pCHWvTaU2fXwGqoU1Bh9nKgYiLt0gsdCg
X-Gm-Gg: ASbGnctvoNhuITKS3R5K+A6TtkMBXy5F8axTvuIkuih19ZZjGQV01l/W8lZ22qIpUtE
	z8hfkb4BtydDvuNJcJv70Qwp39iG0nRN31xWh9cgILHl0C+8bXqyMRHtx5at9yvKfRly1FvkjtS
	J+Bkp3leYGrnlUw7tFz0YRzX2QUlGWPkmUnOcAZKBN7Q3foRGd76pUMlokDZgVTMX/neLdY4qg4
	8Ghiwch1bu97GrY
X-Google-Smtp-Source: AGHT+IHHxcsim0+Mxe12sX6afqlvK9Q5TLvBp0ASIWp6uwwht0TjdDN2mbwncSUP8V8Dcf1nq7W5srN+0I8lKAfQPh4=
X-Received: by 2002:a05:6102:32d0:b0:4e1:48ee:6f36 with SMTP id
 ada2fe7eead31-4f95f41a546mr2737155137.19.1752742866744; Thu, 17 Jul 2025
 02:01:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Jul 2025 02:01:05 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Jul 2025 02:01:05 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqfrevc3b6.fsf@gitster.g>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
 <20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
 <aG9hMP9gEFLhVgJL@pks.im> <xmqq8qkqvjnu.fsf@gitster.g> <CAOLa=ZS6ASf1+nbUnCTeeH1Di=kgmhQUEQ5UXPZu051rfqx9Pw@mail.gmail.com>
 <xmqqms95if8e.fsf@gitster.g> <CAOLa=ZTc2_g3+8MM8whW+eZAj-+36HNsnUFDoLgnN42ytFLwAw@mail.gmail.com>
 <xmqqfrevc3b6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Jul 2025 02:01:05 -0700
X-Gm-Features: Ac12FXx2A9Xoh-Cp5JUoi2stjiOin9FMdHsmq2J5fvEhAVonLna91qJAouUU3Lk
Message-ID: <CAOLa=ZSKsdGDERNS_1hJrBMn0muSOJ46SZz2bn8OHZndJ2Hu3g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000f48f7f063a1c3f0c"

--000000000000f48f7f063a1c3f0c
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Let's say a user is iterating with a prefix set to 'refs/heads/', this
>> would iterate over all the refs with that prefix. But mid-way the user
>> realizes that they only care about 'refs/heads/feature/' prefix and they
>> ask the iterator to set that as the prefix.
>>
>> In such a situation, the iterator seeks to 'refs/heads/feature/' and
>> will only yield references with that prefix. In short, the previous
>> prefix state was reset.
>
> Yes, even though I wouldn't call such an operation "seek", "Ah, I do
> not need the entire refs/heads/ walked, only refs/heads/feature/ is
> enough" is an operation mode that makes sense.
>
> But not for paging, though.
>
> If your web application is showing all branches, one pageful at a
> time, and the first page ended at refs/heads/feature/something and
> you ended up "seeking" to refs/heads/feature/ to start the second
> page, you do not want your second page to end when the iteration
> goes out of refs/heads/feature/ hierarchy, no?
>

Yup and this (we show all references beyond the seek) is the current
implementation. I was talking about the internal implementation of
'refs_iteration_seek()' which is the function used for seek and setting
the prefix.

To clarify, this is the current implementation:

$ git for-each-ref
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/heads/bar
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/heads/feature/x
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/heads/feature/y
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/heads/foo
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/heads/goo/x
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/heads/goo/y
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/heads/master
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/tags/tagged/2
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/tags/tagged/3
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/tags/v1
6f4b58c4968eb82277cf5b1cf8775117e5b83de0 commit	refs/tags/v2

$ git for-each-ref --format="%(refname)" --start-after=refs/heads/goo
refs/heads/goo/x
refs/heads/goo/y
refs/heads/master
refs/tags/tagged/2
refs/tags/tagged/3
refs/tags/v1
refs/tags/v2

$ git for-each-ref --format="%(refname)" --start-after=refs/heads/master
refs/tags/tagged/2
refs/tags/tagged/3
refs/tags/v1
refs/tags/v2

$ git for-each-ref --format="%(refname)" --start-after=refs/heads/goo/x
refs/heads/goo/y
refs/heads/master
refs/tags/tagged/2
refs/tags/tagged/3
refs/tags/v1
refs/tags/v2

$ git for-each-ref --format="%(refname)" refs/heads/feature
refs/heads/feature/x
refs/heads/feature/y

You can see we list all references beyond the seek.

> It seems to me that the root cause of the confusion is because
> prefix, which is to let iteration finish way before the data runs
> out (instead finish when the iteration steps out of a given
> subhierarchy denoted by the prefix), is somehow abused as the
> current position of the cursor.  Shouldn't they be two separate
> concepts?  The cursor needs to fall within the prefix while the
> iterator is active, so they are not two totally independent things,
> but prefix is pretty much static while the cursor position is very
> dynamic.
>

The prefix setup in 'ref_iteration_seek' does two things, let's consider
prefix: 'refs/heads/feature'
1. It sets the cursor to seek to 'refs/heads/feature'
2. It also sets the internal prefix matching to 'refs/heads/feature'

In Contrast seeking via 'ref_iteration_seek' only sets the cursor to
'refs/heads/feature'.

To make this simpler, we've changed 'ref_iteration_seek' to do:
1. seek the cursor to the requested reference
2. Set prefix if the REF_ITERATOR_SEEK_SET_PREFIX is set, and unset the
prefix otherwise.

The state reset I was talking about in my previous emails refers to step
#2 here, where when no 'REF_ITERATOR_SEEK_SET_PREFIX' is set, we remove
any previous prefix set.

>> This series did start out that way around, so ease of implementation
>> isn't it. It was more of a side-effect of not clearing state.
>
> I am even more worried about usability and correctness aspect of
> what was described here now.  After seeking to refs/heads/feature/,
> do we continue to iterate and step out of refs/heads/feature/
> hierarchy or can we cut off a particular page that started with a
> ref within refs/heads/feature/ subhierarchy when we exhaust refs in
> refs/heads/feature/ and have to wait for getting asked for the next
> page before we show refs/heads/gsomething that is outside
> refs/heads/feature/ and sorts after?  The "I reset to iterate over
> refs/heads/feature/ because the entire refs/heads/ is not what I
> care about" example makes me worried about this.
>
> Thanks.

I think we're crossing paths and talking different things. I hope the
examples above clarify things. The current implementation doesn't
support '--start-after' and prefix setting at the same time:

$ git for-each-ref --format="%(refname)"
--start-after=refs/heads/master refs/heads
fatal: cannot use --start-after with patterns

Happy to clarify if this doesn't make sense.

Thanks

--000000000000f48f7f063a1c3f0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7e464c5d3cbeb575_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oNHU4OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWtOQy93TEdHZDJUaTRvSmtiUWtxTHRnS3FMOXlyTQpESnhSK2wrOGpR
RWlnbGFCNFp4Q0pxTWhhNjNyMWZoVmNzelVvZWlUcEh5NFRZRVhJZTF1YlY4Q3dUSWdtclBEClpo
ZzgwVVNqSDdYVmVPZHFmOUlvb0pDR1d0NmtUSXhGcnhGclNReWVmK1gwWTJXOVFlcjVxRmI4TDVj
SVBTY1EKUUJmQ0Y2U1FUc0RnUU1lSzJXQUlXc0tTd1R1aXlLRXRiSkt2aGYwWmh1V0JmWUJXZGxM
dDRuRVZXUkRQYXZQYwpRUjBZWkRDVEphbllCTmpjRko0Yk0vSXFOdDNQdm80eTg3OERWSFpxT0lu
aTdoVVp3akZ5R2VqOTZlSVNxWm9TCmZhaEJCUC9vOGd1K1o5TytKQ2J5RFp3UDRwMTE1eGZVa2h5
VjR2emJDbTBzN0NPQnVzR2htbG5JNFUxbWkzcU4KRkhPZTNXcllxTURSU1ZNSmcwRHVyQXdhMURD
bys0NTVvMUcyUUdrd1J4cFYwZmZFbURXbEplaUxOemdDblpDegpOVCt3MzF6djJjRjlIMEJxZklN
UTlwNkRwV0hnQ1Q0NFZkK0cyVWdaL3BpdDE3RlhwWE5aSmFHSDF6d2R1aDhlCjZBb2RzeDdQMURh
RWlHU1ErTmFoZVBITDFMenprS3l0MFpUT0EwND0KPW9aaFIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f48f7f063a1c3f0c--
