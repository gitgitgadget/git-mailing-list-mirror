Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31D137C3B
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132226; cv=none; b=tNQOUaUJRGanpF6ThYy3QvaZzD35ZhWTNKpzrAQ8DLL4ENSvX870tsqiOJauAN+KahqnjoCDA/PtHTJ8hn43F2rqMbnCw1DIZiGl8y1gl8RuCFx1T7V/woyShnMGvV3PviZNEe540Hd+su2b24Y9Tk4OASj/ljUEEapQz1iGP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132226; c=relaxed/simple;
	bh=0BQHMM7LsZ/A6/AUTCkIhmaRVYGQxcprkLaZWqZkJ44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCWPPHDRmNM7ffoi/PnrgtP3ECKPZDoHzhEgl8JvNtd6iezK2Zx8osR3Iv1WXkg63tLjG1NEbZNuVu0P329liMOyTkZ7NHcqCG26HEFIeazE/BIAcxebD4l7pbcwNsqUDzJDpTm9/RiCihjKQdwYMGJFwcACgq615TbAkSiSI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYoknsI7; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYoknsI7"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-46b0921ff3cso149192137.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706132223; x=1706737023; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXvL/chZFqfRBBQFDmKORTK9WkKMETP6dt2bFSYQ79I=;
        b=XYoknsI7WJGJUXyXIYZ7Z8ORM3pEO9J9EBd82Yqpv+X1IOtClGCaw1wncgDFbV7Cm1
         nR2VrG35Lma/HzEfgWGK0an8sglB+3oeLpy+wsiGDofWJ6kL8CrHBQbL5YrwSVKDdkcw
         FZu6dUnriQwQk3ylWBwhsbtli1TKrNkNsUQHGAmXQ8orUL4JwJ8yGPgQDf5wCiR/DLMN
         jyIIEDrrTJ11rDzOO3hC55ERQsbUoTf3oS/zimP2PHcP2bBUwJ/uyQiWk+s+kYXrnBln
         IED7QluqcJNS5UpQ2f92Gd+dCUuT3QLW2yuGBsZe26gY8AyKIfCHUjFzO2QlMoPx2eOO
         QLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132223; x=1706737023;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXvL/chZFqfRBBQFDmKORTK9WkKMETP6dt2bFSYQ79I=;
        b=jDZ1yIx0wkVOB7eqU33+GTOt4RYb7OQ82CCsvzSWE2WMjpN4himLSDeO4rFKo1URwE
         CFeII+Ih2g+xr8O6f1lCq6ZHfibie2XQUhihYlUUEZ9T41XDvlxYVnYhDVbeaIiyaLAs
         BBjUsamWxv+6zqRsf0VcACoz1AZPGEhOk11aqEBqDBCPPI/k7xpau0Vfhuewwr31gi0/
         mXjyoJjyGhzYu+WcRu3aMyNJKLUhozVlesfMscwSfAlmNIwitNcKyETJehBrE4lJ0CAc
         4KBFoG/CsMibxvfukci6hKOZdP16LWQEO6S2hOxB545IG2a95KIKPRf6bAuBLJyNS79p
         zlkg==
X-Gm-Message-State: AOJu0YzFMkHPYn+WKDkC388OSOPanmnvv9fL2DtqQ9ag7JVHtPxaUYVr
	kL9Ok3BZz0UVq8e0Z3Zzt2w4Dc2d56RKpF9TtB5qWKXuf2i+ahG+
X-Google-Smtp-Source: AGHT+IGsBuTLnHUUoVgsJ+20cOftXJgnIpCsj7rBn5XabIrLkYIyzAcoXmLx0Wc/r5n315RN34o6kg==
X-Received: by 2002:a05:6102:1257:b0:46b:1641:80a2 with SMTP id p23-20020a056102125700b0046b164180a2mr52176vsg.3.1706132223514;
        Wed, 24 Jan 2024 13:37:03 -0800 (PST)
Received: from [10.37.129.2] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id v14-20020a0ced4e000000b006819adbc9f1sm4861408qvq.43.2024.01.24.13.37.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2024 13:37:03 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Group reffiles tests
Date: Wed, 24 Jan 2024 16:37:02 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <76D54E67-543E-4093-8D1F-3D5E208FE683@gmail.com>
In-Reply-To: <xmqqplxsrk8n.fsf@gitster.g>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
 <Za5TW-q4cKS8pNNc@tanuki> <xmqqplxsrk8n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Junio,

On 22 Jan 2024, at 19:01, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> I've got two minor nits, but other than that this looks good to me. I've
>> also verified that all tests continue to pass with the current version
>> of the reftable backend.
>
> OK.  I've squashed all the nits from you and Karthik into the copy
> in my tree.  If there is nothing else, let's declare a victory and
> merge the topic down to 'next' soonish.

Thank you for doing these tedious corrections!
>
>> There's a minor merge conflict with db4192c364 (t: mark tests regarding
>> git-pack-refs(1) to be backend specific, 2024-01-10). This conflict
>> comes from the fact that both patch series add the REFFILES prereq to
>> t3210, semantically the changes are the same. So it doesn't quite matter
>> which of both versions we retain as they both do the same.
>
> Yup, that is what I've been resolving them.
>
> Thanks.

thanks
John
