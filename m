Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AB1D1E60
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034951; cv=none; b=KiQF62lfYcG0f/DVFwDa8dhykhcntNDw3yutvAbjqi3ckF8NvkLPIdKIW8/BeoAFmC4ys+A00uxMS7hw6SzJjEt3+KcFoqc/0Q3hDpntXRzWTNPMw8Rpwvvoo9LrMvh2xmpUCTEYjDuHgNrE0EpXAwOvv5aFpRM7j1F9G8XoYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034951; c=relaxed/simple;
	bh=mwoU90zXz4TOH6LwXobdNIH8H2hLZfg+Lw7owGvoklw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lcSC8FIGmnMZbfCNf2DvArQJnLxr8VX4+efoSGIIom9HpS8M78hBNCNOj7HquUuWdRcjZ0u6pZr3vgv/ixRUejpnSv7ioTyTaDQeAzGenhjx2KCeqxOGKc4TiOWDeS7+TWwRgnAl5/1CPFDQq/MCZxtcrBDy5QJz9Fel2t+QCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFOrwE1U; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFOrwE1U"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e63c8678so3825147e87.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 08:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732034947; x=1732639747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrRmbXKOp0QpqLr1QTAmyPfkoECnhpE+1TSse/Pa1uU=;
        b=aFOrwE1U5QKpwqiNWbKNzEcC4SvR8grrs7Kil4eVcfcivVi8s1djm6fWH5kao10baB
         7WUVmcTQK62CvHUrOuCd3RpESHg+KZpk++sb1gJsiDT8AKPlXiyxVTAVjN/rgiIrlxd9
         PG681oYf7t3im8RDyXgx3MpNb8F2FX0m0hjs7O/H/PrsXnJN8xH1FrGuF+W6+gIJif42
         LcQ/TM5Fe+ITfLT4KnMvjzn4uFX3/4CbfqKj4nYIXcA2q5BvI92K44nIYKkrHxg/GTmF
         TFzTdpDdTPwo60sVVK93RKhMcZrbZvEWNnxgVMK8pPtLdJadq6mkhUb1ft7c6vM3l+g7
         tE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034947; x=1732639747;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrRmbXKOp0QpqLr1QTAmyPfkoECnhpE+1TSse/Pa1uU=;
        b=Wp6HYOgC1hsjhUz2BbUireDgT3zq43c/LTftJFKQYBHjIZHkGufmPaK+PVLAFtq079
         6PkwhO7rBS26dtglJrrVqJY7E0AulrTKDGXUbIA0tGFlHj7DOGscGlHEB0G8L45+8VhC
         4WoRFZngc9qWnXORc9/n6ZhDd3X+fjz83CVfLzsulP/d/5gbJhRLyGBsr2rh51RV4RA6
         q+wUQk//pf4nKO3Dcaqbz5LnNzYdjWE8K8hkuXIOhSsrhvGOzKAGdTJc944vsC05+D4o
         VWA5KQ0ihdcLnkXGjm3JfvvA0z9IjRyNrAYNDuYoOKX0xw0MQwqkDdiAaUH51RidMcsH
         1f+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqX8HKZXVPdOEBIlu7bC1czgmWPFNmtUdkqYROHOlndtt6qZYuHRxGMwbgvz4XMeowXtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5aAusWTv1LcNm1QqSEXbd+2y5gZTlFTre4ZUYvsJxRRsXT/UD
	GQh1LCewQUkYs6Fmtb1EliDc3755MvkhdIRJOmbqpSc0qf8ECzLD
X-Google-Smtp-Source: AGHT+IE7hciXXAsqeC2kbDJeoUJBUXcKO8IJwvjUGpYaVND22QIppYIPMCN5JOwyrCLTAhpFGJkeqA==
X-Received: by 2002:a05:6512:230a:b0:537:a855:7d6f with SMTP id 2adb3069b0e04-53dab2a2eb5mr7145513e87.34.1732034947103;
        Tue, 19 Nov 2024 08:49:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28bc11sm200159855e9.31.2024.11.19.08.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 08:49:06 -0800 (PST)
Message-ID: <dc092d9e-d95c-4635-b4f9-85cf1802e571@gmail.com>
Date: Tue, 19 Nov 2024 16:49:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] diff: update conflict handling for whitespace to issue
 a warning
To: Junio C Hamano <gitster@pobox.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
 <pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
 <xmqq4j4a8srw.fsf@gitster.g> <29c81cbc-3678-4b70-9e0e-c500186d159f@gmail.com>
 <xmqqbjyh5pa5.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqbjyh5pa5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/11/2024 00:11, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Usman - when you're writing a commit message it is important to
>> explain the reason for making the changes contained in the patch so
>> others can understand why it is a good idea. In this case the idea is
>> to avoid breaking "git diff" for everyone who clones a repository
>> containing a .gitattributes file with bad whitespace attributes
>> [1].
> 
> Hmph, it would certainly be a problem, but the right solution is not
> to butcher Git, but to make it easier for the participants of such a
> project to know what is broken *and* what needs to be updated, to let
> them move forward, no?

Arguably yes, but that's not the approach we take when the attributes 
file is too large, a line in the file is is too long or the file 
contains a negative filename pattern. For those cases we print a warning 
and continue. The recently merged e36f009e69b (merge: replace atoi() 
with strtol_i() for marker size validation, 2024-10-24) followed suit 
and warns rather than dies for an invalid marker size. It would be nice 
to be consistent in the way we treat invalid attributes. Consistently 
dying and telling the user how to fix the problem would be a reasonable 
approach on the client side but I wonder if it could cause problems for 
forges running "git diff" and "git merge-tree" on a server though.

> [...]
> If we were to fix anything, it is to make sure that we die() before
> producing a single line of output.

That would certainly be a good idea

Best Wishes

Phillip

