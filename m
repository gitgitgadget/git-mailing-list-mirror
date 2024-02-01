Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD244403
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751298; cv=none; b=diBx6W1qpQllwlKIMfpTRPOdULwqCx93GIofoALN8U2tck2wC/DSqwOEREOWgs46V9LEWYVCrUTM/Yl0HGAXfKrsGQ9wo3Z2KvxjxDaMPrR7NhvSN9CXsK7CM5CSG/bRBMUnE4bEg9vdhF2WMCv+DFdlFrApu+gg9aoBYw1B2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751298; c=relaxed/simple;
	bh=9cHhTfBACLfNrIGZNcSP1/Xb9BIqQu16GUEDolvCmvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlyLYB4PEpkzE6oKlrhd32vWP3ak1sA0xfQdfwbM5zVJONxEYSHlV+IUoUUZ1dRk4u9/fJpjzo3VbcVcr/WleLg1dqDsumvl/5qavfr4uXcyRctTiek6A5fcEf1dBXYqvuHDaKg8TM/h6onQUEtVG5zB3bPD4XHzEC1S6opTki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdU4cGLi; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdU4cGLi"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68c3de3eabbso804926d6.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751295; x=1707356095; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=asRF5wOO7P/onwgvA+0Q+tnHpmheoNtf349KH/zx4O0=;
        b=kdU4cGLinEMdeVTtHdqKOdn5fidyKUQRdD0chRiIFN0TtyO3gb8tan6V/gU+X3VwPe
         ma0HMWiBqQlaCMPWXd1pP/7OcKXSfwhLO6YYueQQmftjInKbgeArQn1yNHtp4o/Fxwft
         KNfzx5PpjXlwfSiwjMWhuIktx6SNKd/j/IjoTsSvrfgWg97YSAWqDCowm8SRY4sJ22wn
         hKZiaG2ZNyKVxienKWAwnM9yiRIgaaWStXCi6WXnSvgQqyDtA1nTWIV6b/at2CJKFvmH
         hYA48hwaorIIRIAOykL+sr+5KQWb2pWU4ZlDnueo1O+YjVZnHSByuxRqi4BDBNttHebO
         vJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751295; x=1707356095;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asRF5wOO7P/onwgvA+0Q+tnHpmheoNtf349KH/zx4O0=;
        b=pPc/5Rdq/70ywzkWn4RIaWf3ocYXQpNQ4RCBpatn4jQPIS6Kx+WOL8TSuaM7zi4kgz
         7PAHNGEYAaqgnxFZTO+3eilcoAf+at+ICYcbOuQC75VTHYwiSVOMF4iS1+H0FbAkoPYn
         Qt+NStAsGHkq83SnVQI2YS35f+3by8PrBv+zjCeVZwWQMo0VC4Uq91OG+QmijZnWwXv+
         JoExDPYDTba2B8L9i1uoX+8NNx2yAhBQZ8mxqIM3fPxFhEz4837mneluBx+grhu1Ferk
         CIkeUFZuTBhGTOoWi07f4UrzPYtL97HmW5mLZulOzWN/kAyP1di/5dNkzrpNEjQJTQ4b
         8TUg==
X-Gm-Message-State: AOJu0Yz0e7bumiIH2tHpB3/6nVVzJvk/CEqNd0Lk1d6hDpfgH3irA5P3
	llUroHZZaJD4nPSaHY9XkcZtjn8qK7HaoqzMMcQyYBXXaFp0ky1v
X-Google-Smtp-Source: AGHT+IG5Jek7dhe55j8zUbnKVbGsggslnUOIHyDhrsYDhRqaHQjN01vkmve/vOUl374wo4Ea33dqwg==
X-Received: by 2002:a05:622a:1487:b0:42b:eb09:c80 with SMTP id t7-20020a05622a148700b0042beb090c80mr1236056qtx.2.1706751295146;
        Wed, 31 Jan 2024 17:34:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXpcODlQw6kwKK3rTdKUmx8MDhNmQZLlf5CAPExNL5k2DHP4mXwZYTThcK5pyCZUAem38ZxpJczmZ9NkvSWp1VRAwANvBbe8PtQhKcMvaiKxCp56bs9YoGy+A1c
Received: from [192.168.1.239] (ool-4570b665.dyn.optonline.net. [69.112.182.101])
        by smtp.gmail.com with ESMTPSA id bc6-20020a05622a1cc600b00427f1fa87e6sm4268331qtb.56.2024.01.31.17.34.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2024 17:34:54 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] index-pack: fsck honor checks
Date: Wed, 31 Jan 2024 20:34:54 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <222CEC85-73B0-49CC-BB81-D6E6F36018B3@gmail.com>
In-Reply-To: <20240131223032.4065897-1-jonathantanmy@google.com>
References: <20240131223032.4065897-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jonathan,

On 31 Jan 2024, at 17:30, Jonathan Tan wrote:

> John Cai <johncai86@gmail.com> writes:
>> Hi Jonathan,
>>
>> On 26 Jan 2024, at 17:13, Jonathan Tan wrote:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>>      ++--fsck-objects[=<msg-id>=<severity>...]::
>>>>>      ++	Die if the pack contains broken objects. If the pack contains a tree
>>>>>      ++	pointing to a .gitmodules blob that does not exist, prints the hash of
>>>>>      ++	that blob (for the caller to check) after the hash that goes into the
>>>>>      ++	name of the pack/idx file (see "Notes").
>
>> Thanks for clarifying! Would you mind providing a patch to revise the wording
>> here to make it clearer? I would try but I feel like I might get the wording
>> wrong.
>
> I think the wording there is already mostly correct, except maybe make
> everything plural (a tree -> trees, a .gitmodules blob -> .gitmodules
> blobs, hash of that blob -> hashes of those blobs). We might also need
> to modify a test to show that the current code indeed handles the plural
> situation correctly. I don't have time right now to get to this, so
> hopefully someone could pick this up.

Thanks! It sounds like we may want to tackle this as part of another patch.

John
