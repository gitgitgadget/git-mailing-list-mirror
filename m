Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C102EB5A6
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773286379; cv=pass; b=RjTyyzOjIv4MKkQSsWoVN4XImnigS88q/cNl+qMrWwfJclPoAoKN2gmDsuMRX6VCYIvO+tUrnpWmjU46zqwDmmdv9C8AAF0sAYV6Q5wh8IF7PMJZNxNOFZMUWHAZVGAJzYipcxILiePDhfFbabkKOBhY32HaPHf/qKD5FPdIpew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773286379; c=relaxed/simple;
	bh=6AZ8CRmXK4MZvee0/s0Tu7ts023l1wvZaTF/6NRtNVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iER4EQ3N90GePDUBKlIA3362aY+TxmJ7DGB4LtIFnm9a5VcYN3Vjy+lpcaqJccL5GgNzrgETptg+rZcCGxE5pPDDMHKiqZmL/opTl3bhbbqG5XsJOm3h8YIjsRCscmpEAfIY2Al6q7hiVqyXcQChdyDCH0Uj6XCbn2nTd+br93U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7A+RNFQ; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7A+RNFQ"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5fff13d5a19so1256252137.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 20:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773286377; cv=none;
        d=google.com; s=arc-20240605;
        b=IHzQ6DVf6zGYD5NkXSS0RANF0b9nDdFyjVnvbUpoYyYUvpUwG5FB0DA8I0M11cwBCa
         1Tcl3Z4HBHr++SZgcFMFS959wvxh3VxSQ43hVUdORgCC8j7C9+KfYemb0Syla063WObg
         1RdKhK0lAjw9EOdIE36Pz2mXJg6S7ZUDhQ3iifrstx7+I047i9wDKtdi9nNPCTVWW/se
         yKp9QmTIkbmd9L2+OO5AzpT6vIsLoJQKho41Mb5p0RzVNnSJGxr1dfFPBxRH1Be+te6w
         HKvSHE64zZbMHWeN2AuuxOHEgLSgnLoBJsR5+nXf1kwOu9dGOpgol4jhc5Sj3QaRRalr
         m/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TaslESBC2k+gV4XmdQ1/VAGU/0mJJr14wwUgaLHbT7M=;
        fh=IkijlkcuQnzpXE+fN1h0mr2NVoSmL5s2b/iOgqlWumA=;
        b=NFhsb309FbCqwQqssebN+WJWCZG4otIerjv3a88sUUpq/9a2XysiaT2Gc5jA1N2XSU
         wE2L8qrSQesUybmSlU8M7HwWWXyc8Fdu0iPk2UPHbRTJ6LjvmqHkDbyxgls9ie1TG50g
         SUaWb5vO9q1BBrmIfkms7zS+Z1QAiJ6cmovhj71gDkAbe6BWesRsYF+yreNI4NyhcbHv
         6lEGtUw67uSxfIknxAXuLuqIkqh7mBQv8caepSks54d+AX6wAumkKQrrYqXskxd1ZmMK
         cc24d+jg1oBtP+Lg9Ks2+nMBOf5csIpHFsGH1hJWQEkKEqQdh/oUan0saZGCATk6FA0X
         wTDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773286377; x=1773891177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TaslESBC2k+gV4XmdQ1/VAGU/0mJJr14wwUgaLHbT7M=;
        b=f7A+RNFQ74FqHLzhjWmoOOEvZhyN5/ClkrE3vUXHgJ2xvfcCPRpUtwnQeErAIjOzxA
         cVqssR7iT4Q0Xh/0X5QSM+mLlJ2LrP4CZgiBKJms0dDcDIscRdKZIw2ID9wkgpJPeDb4
         dWg8NPy+ocfiBt36rrK+ZnYXVvpy0GqroUNoD8WBseMTK/r5o/O1xHmu/9YT1t653izi
         80y82dymvMCfZbg6/Mb4h+Spu8u7OhflSpbt6WEg3Pldl6VGC3NtMzVeqYT5ITXIUJGk
         8DJj4YyCuUnZ/jLZu1TUazhdF9gMWbpeatMsxEm0aduPezZ10qUaDtwfiWqXJF9b1YMk
         d03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773286377; x=1773891177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaslESBC2k+gV4XmdQ1/VAGU/0mJJr14wwUgaLHbT7M=;
        b=Fl1kWoBUllG4oCq1ac1eSUtX/z7JicDqhrVuyqWh/33H+GKQSKOWRvMIC6pPv4t28h
         ZyNXGsTlJ0/297YHJPMjfPEF7bqhSLkrc752jR77f+qrP4kFqCcULW+aGiyqEnZaj1G/
         frYYVgo7701cR0RFug621C0Uf2gcu8bisbXeWfllegRCtKOFBUwXu1AZoSnWiNC5cxsC
         QN8ICXlETbBLvzBdGncfmV2iYPlHYeNI7COwPKNhW6H04EoBVLIuSxWaoGEAdO8df3X1
         GNQ8cDeVUd1aEdRvA2Cby90xI4PUqIz9WAdfo7DfcOuIYUVAv3MJqGCarVzIinRi8ZcI
         L+yg==
X-Forwarded-Encrypted: i=1; AJvYcCWbOR/d+7dgubwu95/+ZT9jiJL4kedHA21cU6pdft+te+Xf+fzJMy5A00Q5X57HA8U+S8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0D4kIQUiuamox0AVZ8OZFmnNNzhyaQMLMK4oDhqFtHw9Sr3m
	UwKbR1Yi+5iHUs/wDbLVL4OzZH1RUbloIasbs3+fRbkeTv2+ShhF/+Bk8Gh111SVLQs4JWXGnuD
	IhnCxUrn+/6CNYSxUtwW28zfpBx1/tCk=
X-Gm-Gg: ATEYQzzpafIgzGg0zfE139FgJUf9LoXjG20rjtXIxZ6FFM7u+dBmAv0by7saphsi43b
	Aa6UM6Gwmav/vagm3dtXQYKtjQxHmgHpb4l3ZWzwW6EP+5U6GEJvAji+B7ryrMexp2vjbaX152C
	kSfF56SjqENx97M/kjE2vfEmyI1yHcZkRbyvS9V3t5XA9UtCvdqvui7zdJTLdyhhcbMzfRADMCo
	F3Kg9ZvhNcsSdQMhTFdo3TExdRIB2weYzlKTlniQKcDa1fXEy+StSOHlptGtqu8Ej+TPEC732+z
	bJ8U4ClNNaDBLteSXAqH96vh5bFRDb5YWwGZsYA332xQp5mzEurTI0PjvrlQZU6zgz44CrvKrBg
	efPrx4GICFc35WH3GFik=
X-Received: by 2002:a05:6102:304c:b0:600:57d:2203 with SMTP id
 ada2fe7eead31-601f478d524mr982454137.8.1773286377501; Wed, 11 Mar 2026
 20:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
 <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com> <xmqqjyvhkggf.fsf@gitster.g>
In-Reply-To: <xmqqjyvhkggf.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Thu, 12 Mar 2026 09:02:45 +0530
X-Gm-Features: AaiRm51wbtv54sCfWPVYHerx6p9Q5EVDzAV-gYPAgLeG4v8iAxKj41MaBmVZDMs
Message-ID: <CAOAgETMrx5b0qc2Tsy+f=Bk3HKFaayeXXFvc_1=HwoxixH+WMQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Advice on checkout dirty files
To: Junio C Hamano <gitster@pobox.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes :

> He still see 3 patches for a work that can be done by one.
> That is what "perfect logical progression without detours, change of
> plans, and fixes earlier mistake" is about.
> please do not throw a drunken-man's-walk series at
> us.  Pretend to be a perfect developer

I understand now sorry for the inconvenience.
Your mail also specified the same thing but I was not able to truly
grasp the essence of that mail.
Thank you for explaining it again to me, I now have clear
understanding of what is expected from me.
I will create one single commit :) .
I also saw that git via git gadget forwards all my commits making it
messy and not ideal.
I will make a clean single commit that will look perfect and wouldn't
make such a messy commit history.

On Thu, 12 Mar 2026 at 06:32, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes:
> >
> >> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
> >> "stashBeforeCheckout" to advice_setting[] and implement
> >> advise_on_checkout_dirty_files() function
> >> Documentation/config/advice.adoc: document the new advice key
> >
> > Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
> >
> > Arsh Srivastava (3):
> >   advice: add stashBeforeCheckout advice for dirty branch switches
> >   advice: add stashBeforeCheckout advice for dirty branch switches
> >     [GSOC]
> >   unpack-trees: suggesting 'git checkout -m <branch>' with its
> >     repercussions
>
> I still see that [PATCH 3/3] literally removes what was added by
> earlier patches.  ADVICE_STASH_BEFORE_CHECKOUT is added to
> advice.[ch] and stashBeforeCheckOut is added to
> Documentation/config/adivce.adoc in [1/3], and then they are removed
> in [3/3].  If your final solution does not involve such an advice,
> then do not even add it in an earlier patch, only to retract it and
> replace it with something else in a later patch.  If the reason why
> that "something else" replaces the advice is because it is a better
> solution to the problem you initially started to solve than the
> advice message added in [1/3], then just go straight to that
> "something else", without adding and removing the advice mechanism.
>
> That is what "perfect logical progression without detours, change of
> plans, and fixes earlier mistake" is about.
>
> In other words, please do not throw a drunken-man's-walk series at
> us.  Pretend to be a perfect developer.
>
> The final series accepted by the project will have to stay in our
> history for later developers to see in "git log" output to learn
> from, and a series being clean logical progression is a must for
> that to happen.
>
