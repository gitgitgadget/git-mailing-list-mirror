Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D316FF3B
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653925; cv=none; b=QuO6+UNuTnoGqI79H128zGYnY5Pjp6+L7htIQ9QjoYmLrwPtiF/eOD7VhsWAoBbCbmFAHRbUUNfTCAe3i6SbbKxDY3MecM+e+TBsjnd3t944PLL5ZnGQ9bnvPAxWAQ44uSRTGPLDnt4g5pWuF6Q1gEBb8cPCxk56qIZBR+2aW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653925; c=relaxed/simple;
	bh=EYpKRoKiee1CK7j1gKOuOR0YMwvvxpCpkLdjExic7no=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U62NJ52bUNSYyQel8YP/rCEwi8CmpH7rwvW5AafhJ2n5GYCJLKpKI2ny8EVHHnqVsVQI/7Xz326o+oMXn+sIj8XWsiM27g11fbHpKWOjhpzR29fHUJZlh/xk0dGz56L8vlL0XqU3cOL76/g3CRPPAhAiUSjH77lPIrMLoGK6Alw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYHL8zzr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYHL8zzr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso3680495e9.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726653922; x=1727258722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lLuwZSgAu6pMtHuenleEklT8Kqimtq8OfSZPcHjUbAQ=;
        b=gYHL8zzr1mZ1I0eZaCDyQteB1amXKeOCBDtyZPPusSa7IfCeHF+s1xX2eJjXCe4YXd
         N2bb8zQscXjr8EgL5t0ubg8W0h8vo208vWjBUBhvZLf776aF3m7yF3PGOjpWIWKrkSZL
         sY9qs8rSFqS0LZkLw2AuhKNNBp8PUsMCh/yWH4efUJDMfeKmTwA/e2jId2DfE5guRB4U
         zHK62r6KU3/1lruLShBciAGOQ80TfuNPpBcewUiYVo5Y3M60GMbr/KpnP8hI1hBE/QxX
         gD1GWUrmEZXWsT/rxYC5uXWLLYQRVyAZI+xJtrB3YFwb+BSTWJDlR1SPHJkFJ/5tAKA2
         Gg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653922; x=1727258722;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLuwZSgAu6pMtHuenleEklT8Kqimtq8OfSZPcHjUbAQ=;
        b=AhbOVA9NBhEHx22f3GbWOhjuMRjY0i5Saj6esEjOBGf9KzLLACcfDzq36B4VNSkAdB
         TAlqdcK4d0ib86OP7OHxJrWhZc0KdujgKfN3KspQATi33e8Hgjjnobzp+OxIyjP22hSI
         q+X6I/gfjD9p0v9Wsz49IgHymT+x5fxEfeCdLfnQrtt5q0srY6lBeiptFIUQDlVd+6nf
         yeJwC5Fb1LPPf3EsR3k1FtQByd5YuCPlBCajyVPylp0c74IYxYVSqj2mOBbVs7VY8hFl
         Mw8HODaa4ZmeM9iXhcNYvF4FaSz+QdY9jkiIFWwm8Xsz1H6g9jM6MFZuxNkI664E346v
         Y/lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHllpVJUcsm9UXD3Ut35/5wwBmBjeuxDPVEBVa3YG4PbLwjbofK53juJQ4rTR8dfXlpxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR60JM9xX8NWGuINzjCtNu7uaMgrqULzvhroqioFApEQwDy+Cy
	uJVhpFWyIKtbnNVzbjdBfdwU3eRb6txjkmrd47jQD0aAep1AclteMHh1qw==
X-Google-Smtp-Source: AGHT+IG/ZzZg4tnd/otz1GX11+5QNcT922rn/9MpO6UIWTK1e418sFDMZG0V6pgD2uqVOkSUyUDQAg==
X-Received: by 2002:a05:600c:1908:b0:42c:b697:a62c with SMTP id 5b1f17b1804b1-42cbddce6b9mr183262655e9.5.1726653922341;
        Wed, 18 Sep 2024 03:05:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ba:6501:244f:f1e2:145d:427a? ([2a0a:ef40:6ba:6501:244f:f1e2:145d:427a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e704ed30asm12514295e9.18.2024.09.18.03.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 03:05:21 -0700 (PDT)
Message-ID: <c7d85f17-d9ad-464b-8cd5-e6d214f2fd06@gmail.com>
Date: Wed, 18 Sep 2024 11:05:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Suggestion to Enhance Submodule Initialization Behavior During
 git clone
To: Ryan Barker <rcbarke@clemson.edu>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <SA1PR06MB80085741B5856945AAED1027BB612@SA1PR06MB8008.namprd06.prod.outlook.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <SA1PR06MB80085741B5856945AAED1027BB612@SA1PR06MB8008.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ryan

On 17/09/2024 19:14, Ryan Barker wrote:
> Currently, when a user clones a Git repository with submodules, the 
> submodules defined in the |.gitmodules| file are not automatically 
> initialized in the local |.git/config| of the cloned repository.

One can pass '--recurse-submodules' when cloning which will recursively 
clone the submodules used by the repository and sets 'submodule.active'.

Best Wishes

Phillip

> While I 
> understand there may be edge cases where this behavior is desirable, it 
> would significantly improve usability if there were an option to 
> automatically initialize submodules during |git clone|. I believe this 
> could be accomplished by adding a flag, or perhaps enabling 
> auto-initialization by default, with an optional flag to disable it when 
> necessary.
> To mitigate this issue in my project, I created defensive scripts to 
> ensure that submodules are initialized before interacting with them, but 
> this was a point of confusion for many users who were unfamiliar with 
> submodules. In my opinion, auto-initializing submodules during the clone 
> process would be a more intuitive default behavior for most users, 
> especially those in educational environments, like students using GitHub 
> Classroom.
> I have attached my source code for further context, and my repository 
> can be found here: https://github.com/rcbarke/clemson-ece-2230-grading/ 
> <https://github.com/rcbarke/clemson-ece-2230-grading/>, though it is 
> private due to the grading scripts it contains.
> I would appreciate your thoughts on this suggestion and whether this 
> behavior could be incorporated into future Git releases.
> Thank you for your time!
> Best,
> *
> *
> *Ryan Barker*
> *
> *
> *Graduate Assistant*
> *IS-WiN Laboratory*
> M.S. Computer Engineering, Intelligent Systems, Class of 2026
> B.S. Computer Engineering, Communication Systems & Networks, Class of 2016
> 
> Logos | Clemson University, South Carolina <https://www.clemson.edu/>
> 
> 
