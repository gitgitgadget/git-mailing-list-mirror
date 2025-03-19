Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F035972
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366160; cv=none; b=NtrZ+vJBzSKY9HHrc0U48XIjsqebd2bpGqLnK2AGuKz1XmDHRsI5OC2J+grxlwGPw7c4d0UGbHwtfcN4hNhZO2tjXRjQAS0OSUopJhq89sqywBwlzLEHrYfd1ssb9SO4gupbxWbIfe1iCxnBQoMa4970exdpnm14oR93ZwOKvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366160; c=relaxed/simple;
	bh=zkwW0bDExM1BH23zPj27vRqyAIsz9k7xToNXEg7Mm5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdCrIxXOK6QRiomKxDsR3SR62C8I7en+mloCdjbbg+3xnwvYvWk6IoqSIkhm/CyKWa5P6NViNjOzhui6Nm4DLZ1rcp/Cdk5oUTWTjHrjWf8ats1x/Pc6Y/jnOHnqFliU58KClvGMImEl0N7Nm803tZUQmEeziI261c7kV7iIlaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqCbCJrW; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqCbCJrW"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bae572157so64820371fa.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742366156; x=1742970956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ETEBblt7xSxTkVkttdzlUq7xc4h+tQJhAH11LfXgLlc=;
        b=VqCbCJrWJp5J3VSs1OCKY5lHNBgYWvriqsKXvVn3GTZeYBzy67r+PLSYdLpPliBuEs
         rSL+t6ibz0noUzFnUv+fM/dtDo82W1ouQ2tELJnnG8rt1SW+6nN1/p5+mzR26+ONch5k
         yxB3R1Uy10A/SH8fzAqzGST0V0W7OI+Y82UCUwkFcnCp9JCAgFBNp76oYsgOSS9n/5tR
         d6UD/Nck1FbszwxecOqOqQd171Y13y4OtdbP5yfBmPcd7jG6bILSsqK2fNFczgZBA4h3
         iKVgV9sEj5YhWSiCp5EF433uIAa7lbKjVLrff0dOXNKS5fnxKo2pv5EYnU/slr040Ww3
         xoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742366156; x=1742970956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETEBblt7xSxTkVkttdzlUq7xc4h+tQJhAH11LfXgLlc=;
        b=PYQSMWwEcxYXcxYU+DULWdN4eseJoI2D1eMprJ1UFSUiuSNLh4oZh7JqpO0pwvxKXS
         CMTS/gBbT2skQgPBiwWrE3x30QzVAv4yhCxgpy4k/Y+UqackNfpSyRebfzB82qGw5q9E
         pD17ORKoldHbjRu1FzzGl3iyxW7H0MoqvBvVIUqu00lz0YXZwnnvoPPG04oyHdEwKIPp
         k4h3vSFAjN+bUQBCCyhD/Feoxu46YEAdsVwzjRt6OpdLUbQQNyjgyk/nImgN4SPS2gtK
         0P5S7UXybOklivZO56tmeZlpqCQu/N5SGDB3YJT8p7CrL8QBtx0G8SyPFHmo7S/dOfmx
         ivLQ==
X-Gm-Message-State: AOJu0YyYv0K7/u1LL845obk/3toHqYVAIwLezD4eHJnPkHT/csy0DOoT
	tFEqb5MNQuwcoy0mS3qQgUJc4uYYQZoM6PmGz7o/6duDEfpoR39RTiGFWyQHmRJYl0N8w5DiXw/
	cG7oFH0DLbi/KKD8XsF8beBkFNMZgHQ==
X-Gm-Gg: ASbGncuYXFgjg/2MPohI6EKxGvcyLMgE4XzIfPyyalbBQ4POEhiY+nhk1/b3hDoH+aw
	wpndJ/arkBjgu1pBeXy/0de4aRdZhgt/szg+TREdZsa8eSsmBfDOSbCqGEJvONUQl/6dOmzTUfj
	wwwR2axiDju9uE8oout67Ipg6YWA==
X-Google-Smtp-Source: AGHT+IGIe1aT5ngtU+esHjlbfVnVLoe4xPuwwjXiQYGPA8NBSldt3Pr2xZrUxRuRcqoTOVRi6Z15zyiTgMeaFlEwqEU=
X-Received: by 2002:a05:6512:ac3:b0:545:2f5d:d5ab with SMTP id
 2adb3069b0e04-54acb2052d9mr458850e87.37.1742366156191; Tue, 18 Mar 2025
 23:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316050920.3264895-1-05ZYT30@gmail.com> <20250319020221.2160371-1-05ZYT30@gmail.com>
In-Reply-To: <20250319020221.2160371-1-05ZYT30@gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 19 Mar 2025 12:05:45 +0530
X-Gm-Features: AQ5f1Jq55xSGvaVF45lFp6f_paimKc3Z9Fi5ifDwQ3_O_b9Nu10j2063p3gjrbQ
Message-ID: <CAPhwyn0Sq0hDktPtf53Qs6LKwNsmn6yXuVyEfcYzyXK4yjd7HA@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 0/2] sendemail: improve error capture and status
 code handling
To: Zheng Yuting <05zyt30@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 07:32, Zheng Yuting <05zyt30@gmail.com> wrote:
>
> This patch series improves SMTP authentication error handling.
>
> Auth relied solely on return values without capturing exceptions,
> misjudging non-credential errors as authentication failures.
>
> Patch v5 1/2 wraps the auth process in an eval {} block to catch all
> exceptions, adds var error for future handling, and var result to return
> auth state.
>
> Patch v5 2/2 introduces finer-grained SMTP error handling, extracting
> status codes per RFC 5321 to differentiate between temporary (4yz) and
> permanent (5yz) errors. Unrecognized codes are treated as permanent
> failures. Otherwise return the authentication result.
>
>
> Zheng Yuting (2):
>   sendemail: capture errors in an eval {} block
>   sendemail: finer-grained SMTP error handling
>
I'm not sure if this is worth a re-roll but, `sendemail` should be `send-email`.
>  git-send-email.perl | 62 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 17 deletions(-)
>
> --
> 2.48.1
>
Thanks
