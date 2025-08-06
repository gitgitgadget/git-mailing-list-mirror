Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B41F9F73
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486418; cv=none; b=HonjfEfpjq1nEBVvUGAI7k/wTFGLJssL2mEV4PU4t5y4E0ngL58igcOBArZoETcEmsG3K71dULT3bTKCPwYj0tE0wEqHbezjiOyk7qjfI0D9Wjnrn9HZCmsqjVIEan8a9dH8B0pm5aIBrx6VdMu0oXKMaCKzITnt6GZaaxgFxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486418; c=relaxed/simple;
	bh=q1j2Qbf+aN0fxl31n92so+y8yDhjmBpts3LYsRYMFF4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=LCbSWZ/a4xm9/ApJ73Mkao0ST5nbT3Vsy7gibspyrtvOQy/iRjxydZUNY5J26MytRqGhq8e/sU5NA9rWDQBHYbDWvgh9AQ3vacz2Vyb6Pkp/rsnnfwbHTK+eezNlqr7fW5it70dqwxOicUWTg3VsOxQ6eQr7QKIwLjqzrARzwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5dkj/vm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5dkj/vm"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so3465450f8f.2
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754486415; x=1755091215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzPNfAA5UltyQsoH887zsTVM3BMpqiqH0Gt9NpsmZMA=;
        b=S5dkj/vmhg1H2PvLZGT+jQG8ZirfzsVifY//V1mHRSzEUYnBhMS1M60qX3MGRiLSwE
         C/nlu+zuZsDSJah2/COViBQZxu5GJvZHB5AoFrOzbzlqH97Zvze2qTEOktCF3Q8T+KhP
         /A4wuaTUAETz1DGJAYHcOlzgtFhRf0NFpM+8Lpvq0hx1tnVZsiwsLUHXSYNHXTaWAttI
         LejPKgtAvcviSm5RUg6EwSMlP3JimMqo4h/f6jBeNI5PTJVWJUlC2m/P2a8hVFpmY6IM
         ZlZ402jKUfA/PBxM0zUqlzolCdO/ft1GA+TGyxXQAg2+GwkG1o46A6pWJA5xqtWQVEUX
         M6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754486415; x=1755091215;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzPNfAA5UltyQsoH887zsTVM3BMpqiqH0Gt9NpsmZMA=;
        b=Vf7ejllt8IuEBx1Lw/dy4n1xCHVf/P3VfwkPXMBiAB24OTNdX87E4CXkVyd5iRr9t4
         ec2w/P+hDewvLCo+XrOj/qVV8iE/NkiLe1ps4v9HXsxWqGVRMi6cetM0IsACXDq06ADr
         a5MILDiiar0jKS9FHiv3EcCbECAGCZk1mC/K7oUg7ljYziAXdNQ6/gqnwrfYFvsXkhKr
         mSPc/uzeKjZfo2f4t+c0ND0ttHR4UnBkqjKV1sJ9WV2vhqRIFQH54KI/Xzlkfv7aqsnc
         lx/6h6p5PwHjDJ3izYV8gw5fJfmHgWXp/bfI8KFHuCWaU+Pr3FaSH/BxUKQmSVfvFxsh
         CDIg==
X-Forwarded-Encrypted: i=1; AJvYcCVz7Drb4GjMI52H2IczPIcxLef1fHqN/1+w61o9712ZbClLquNPeybyY9pC3HDYz2Pke0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxagfAEpyy9t74WnAY9bTcw2vDvZZ4c+nJBmsKBF7WhJHxkfdOq
	ChFaDEpzs0kp5iWdSOUtS0UKGkR+vPFcMFbP7zgZTLQW63VbZGQiOPEM
X-Gm-Gg: ASbGncs9/rGsqUwD6NLlwJ97xAm3W0dNoLgQyuywqGrveCMbUKg/PuiSuFeNW3xdSKS
	IyXldUfloroSSdQVNx8icqUqDjCu2VvG4Tl1ORMRDP7+ihXsHHMxWxbA9QFBpjr47qj3NMGa6lz
	r23sADJ0V9vurMrppt1guz769Y26zPRN/42Sms4B4oOdhURTe/bCcA603ydIAh42RrhIggxqyNX
	NJSIs9qUrEN44ynvGz6iGa5dqkSJjrKohLiTW/GLMpyQSqhrC0DFMI+IWd1aWBM1QPYNiiirnNT
	JBoETa6bwhUa6Yg1SPZ594Chsoyhh4/ONJTGlOS2v7CSo0prWsMy+c471wvQng0aNcmLQhOsvCS
	t26+8EJppekVFvSLpsyvtQdEcxrEGswPlMqpWNbvBlYHLYJhg4YFGeKK3HQ==
X-Google-Smtp-Source: AGHT+IEF4JwukCzFJz4ZAJSz9x4FhAhr4skCDB8rkugCvYy+XFdK45KohjsRWM4njhSjPq4Ak9ZyBw==
X-Received: by 2002:a05:6000:310c:b0:3a5:8934:493a with SMTP id ffacd0b85a97d-3b8f41f30e5mr2399924f8f.44.1754486414744;
        Wed, 06 Aug 2025 06:20:14 -0700 (PDT)
Received: from [192.168.1.194] ([90.254.76.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e87487fcsm28218455e9.3.2025.08.06.06.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 06:20:14 -0700 (PDT)
Message-ID: <499da566-66a8-4c38-a2b3-13c06092568f@gmail.com>
Date: Wed, 6 Aug 2025 14:19:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] rebase: support --trailer
From: Phillip Wood <phillip.wood123@gmail.com>
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Reply-To: phillip.wood@dunelm.org.uk
References: <20250803150059.402017-1-me@linux.beauty>
 <20250803150059.402017-3-me@linux.beauty>
 <e911d897-8664-40a7-b7a9-8eb9f71a8735@gmail.com>
Content-Language: en-US
In-Reply-To: <e911d897-8664-40a7-b7a9-8eb9f71a8735@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Li

I had a couple more thoughts about the tests ...

On 06/08/2025 11:28, Phillip Wood wrote:
> On 03/08/2025 16:00, Li Chen wrote:
>> +create_expect() {
>> +    cat >"$1" <<-EOF
>> +        $2
>> +
>> +        Reviewed-by: Dev <dev@example.com>
>> +    EOF
>> +}
>> +
>> +test_expect_success 'setup repo with a small history' '
>> [...]
 >> +    create_expect third-signed    "third"                 &&>> +    
create_expect conflict-signed "conflict"
> 
> Normally we create the "expect" file in the test where it is used.

Thinking about this some more, if we want to use test_commit_message 
then I think we can change create_expect to write to stdout and do

	test_commit_message HEAD <<-EOF
	$(create_expect first)
	EOF

rather than having to create a file.

>> +
>> +test_expect_success 'reject empty --trailer argument' '
>> [...]
>> +test_expect_success 'reject trailer with missing key before separator' '

Should we also test for a missing value or are trailers without a value 
allowed?

>> +        git rebase -m \
>> +            --trailer "Signed-off-by: Dev A <a@ex.com>" \
>> +            --trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 &&

Lets use example.com here rather than some random domain that might 
actually exist.

>> +test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
>> +    git reset --hard third &&
>> +    test_must_fail git rebase -m \
>> +        --trailer "Reviewed-by: Dev <dev@example.com>" \
>> +        second third &&
>> +    git checkout --theirs file &&
>> +    git add file &&
>> +    git rebase --continue &&

This checks that the commit with conflicts has a trailer added but it 
does not check that the commits picked by "git rebase --continue" do. To 
check that we actually save the trailers and use them when continuing we 
need to add a fourth commit on top of third and check that has a trailer 
add here as well.

A couple more thoughts:

  - We should check that
      git -c trailer.review.key=Reviewed-by rebase \
          --trailer=review="Dev <dev@example.com>"
    adds a "Reviewed-by:" trailer. We can do that by changing one of the
    tests in this patch rather than adding a new one. This checks that we
    accept '=' as a separator as well a respecting the config.

  - We should check that the todo list
      pick first
      fixup second
    adds the trailer as expected and that
      pick first
      fixup -C second
    also works. To do that we will need to source lib-rebase.sh at the
    start of the test file and add a test that uses set_replace_editor()
    which should be called in a subshell.


Do please ask if you have any questions about these suggestions

Thanks

Phillip

