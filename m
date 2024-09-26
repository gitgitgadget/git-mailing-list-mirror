Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AC33C9
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727375318; cv=none; b=iB5H0VB7bDQ6HDwJHQmnQbJ5CN+1cJdoOuX0aYGtiU6q0kO+7hnzI5PKGXIo1VjaudTghq9rsKTxU8BOcZfVE7WBta1dI5Og79MNb/Jfu0WAmUjykbcjwjm30sBSHRCmLmwLu+jSUUgS3wCh0mDPhsczv8UzUbporVIf69/CJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727375318; c=relaxed/simple;
	bh=9/EkrAnKFwHAzj5S+DISraXXBiOMCKR2XdBrxXDUNAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eoIBEEMPZCLODk4UEmmDJAEdMkU5vYJCS64/zGpoBMz/aRwWORasFPXNVsizUlwcM3iBpWvz2OEZCCR9Q9mAKsiBKuBmj9EJVm5buBo3SOJaeM+zxyBEEX7QBl/3XJqIyqG0Zwatczi5mOdoHSCJ1DrOb22JBhB0uWrpkLzMiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOsxoAGe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOsxoAGe"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053616fa36so15731205ad.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727375316; x=1727980116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4gKSAj/QA9zIXIhnBOpqtsIt8zz8EB13v/jrOULriZY=;
        b=KOsxoAGeoKxTtPDZae9G5+KNrnAJRFtNE+wAAK/ym7x1tnsEbIUxh0uP87J3Xt9oC7
         71y6xHfk8WZ4j7nikRajBOV21Zse2+sFuGlrHtycYM06b365PVdTsPnSKcOdz//0yPSW
         HmemE+G6DLSn/lHhTNlvMlrePUOZjLWIyBNYzVcUbpJq3ZhuGMwTXCSYdnUZrHlW9iY+
         LPnm/utdMBgI0zWoWFZlllmsYtUULOTlr2ItqRzgzmYR2fjpUjqLNcModthlbpJChMIX
         tLq/cirjkQdy5wwZlcZF04c4lHpdSxZhjMyxKen4Wjf1LLD/xxwkfcDQ6CBkw2la4aUf
         K7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727375316; x=1727980116;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gKSAj/QA9zIXIhnBOpqtsIt8zz8EB13v/jrOULriZY=;
        b=eUbByQ0fSuyXWxQJvCAYt+H4+XsbnpGXQfu32tDEx5LEIMitH+aYEKjD2olpvOKqXj
         gDPwHF1lJQbJW77Kv2/dXHS8mzqi2AjDeRpUw3uKsbc1bC3BarcxgMwLVVxbk+yMqcVV
         ul7C8zkmGuFf1wy6Q/ip8B9elQv4cJp00qQvi/Nt9LeikjKx/GuIwP7lW7DsFAqVMqRq
         94Z16aVK5S+BrmROPwFnKWL3U6jRju+AlphcTkOJx0+CAPx0TU+G6ajqBhGwVua7jB5U
         ibEqSDsczvZCEvCfuWYzP3MxhqEDoSIpJlm7HeZKvU3tBGHgI/t3m0fiSbOojdi2eoTU
         MDdA==
X-Forwarded-Encrypted: i=1; AJvYcCWL3in4YzXUbKthXWmQlSG//Pb5YHbF0OT9QDpk3TfX/p4y1AJJEZdpM3W7mcqHTjsbILE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnoX65cneXIygx9CU8a/9C7GiXsFAmJmRU18FJmn5N9a2wh6SL
	C88HUJyXx9Cw2zOh6yGiwCIk2JsGs5C78RgRIi91rDYYFRSUd8fN
X-Google-Smtp-Source: AGHT+IHmCLq02g49WtiGVG2EWyNEMy1rkUmPM/tglvAFtPmjHj6RI7BlNFTsuh0dHv+/09SOIGGSfA==
X-Received: by 2002:a17:902:ec8b:b0:206:ac4b:8157 with SMTP id d9443c01a7336-20b3776db50mr9214925ad.31.1727375315616;
        Thu, 26 Sep 2024 11:28:35 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da8971sm1510185ad.103.2024.09.26.11.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:28:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
In-Reply-To: <CAP8UFD2yTMNmx0n1jhOu7dz_4XeOyTy1iLmRWYmuf9QJf75hsQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 26 Aug 2024 11:31:22 +0200")
References: <20240824172028.39419-1-shyamthakkar001@gmail.com>
	<CAP8UFD2yTMNmx0n1jhOu7dz_4XeOyTy1iLmRWYmuf9QJf75hsQ@mail.gmail.com>
Date: Thu, 26 Sep 2024 11:28:34 -0700
Message-ID: <xmqqy13ei819.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Aug 24, 2024 at 7:20 PM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
>>
>> Add tests for oidset.h library, which were not previously present using
>> the unit testing framework.
>
> It might be interesting to also say if there are tests for oidset in
> the end-to-end tests, not just in the unit test framework. Also I
> think oidset.h is more an API than a library.
> ...
> If initializing the hash algo fails here, it is likely because it
> already failed when get_oid_arbitrary_hex() (which initializes it) was
> called in the tests before this one. So I think it might be even
> better to move the above hash algo initialization code to setup() and
> make setup() error out in case the initialization fails. Then setup()
> could pass 'hash_algo' to all the functions it calls, even if some of
> them don't use it.
> ...
>
> Thanks.

While reviewing the "What's cooking" list of topics after tagging
-rc0 of this development cycle, I noticed that this topic from late
August has been expecting but not yet seeing an update.

As discussed elsewhere on the "Project Tracking" thread, I am in
favor of formally adopting a policy to discard a topic from 'seen'
after being inactive for 3 weeks, without having seen a clear
consensus that it is good enough to be moved to 'next'.  Interested
parties are still free to revive the topic even after such a discard
event.

    Side note: The definition of being "inactive" for the purpose of
    the policy is that nobody has discussed the topic, no new
    iteration of the topic was posted, and no responses to the
    review comments were given.

I'll discard this one by the end of this week unless the topic sees
any activity.  It looks to me that the project decided that a longer
term direction to adopt "clar" as the unit-tests framework, so this
patch would need to be written even if it were perfect in the old
world order anyway.

Thanks.

