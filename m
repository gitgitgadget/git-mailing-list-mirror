Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E813D503
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894135; cv=none; b=UDoosu+rxUyIQuQPuyuQY+YbOqgUwBzirz3TkMkBvjIICvoa73/DX+PBf+MYho8O7XyShOnoiRi58Q8pQ0j1N9yCHVVLcdCDGXHR5LEdMBMwk3udG4l0koStOm71HRndApeLxdSxw5rEIPhjE4ofPKnKEPw6sO0lHXeu1IK+1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894135; c=relaxed/simple;
	bh=VEUlyknntXfuuNRR+kRGYZWpiOwD+ugpivjWYfZyb2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JSGGrvT2+dWiJzIzXTOMzQIZykNpKdIi/QFnm6jyFpg9v5IGDgqTB0Ce+0g8O2ZaNY306G5ggbBb+xwzvPDmYWHOa8PoLJKKP1wPfQT8dDpl5eP52MKC6vNVXSYBcqCKFF2rlF/bnC3Fb6bGJyyUYCeQb+2joUCCiUZpPKxF7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+rZlkzy; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+rZlkzy"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54aa30f4093so861849e0c.3
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758894132; x=1759498932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jiEzBtttd3ZG08gBgglKWx+m6TFIDRuMxViRrDcXM40=;
        b=D+rZlkzyOlJr3STKGoJlMHrjrgfO7lLM+bKYJ/sh0hXjxVDcOZ1F/9PeyjzD+kU3VF
         C1grVXgFGzoXsrTfUz8VEhBZ+39RplXqDWktyJJ9uCA1G0QUx4uiIJmifkkZqqr63bcP
         otsweSY0PL046mJt7z87ep58YHVYXMvFteYgFtzwQsu5kY5lM56LxvmGAmQcdLEIirgZ
         TkG0fwCOKvWzPcxPu4m3UGeg2J0a9ZW47xowYrS6ZHTGreT+T3g+wpqJ1ROhlVJ55/Pn
         UxCIu7HBdPbHDxk5NIz1ckCHqcgRo/zJ8eb/gMH+5U578M8kSPpMkQvBb+rZoOuiqsmL
         +qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894132; x=1759498932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiEzBtttd3ZG08gBgglKWx+m6TFIDRuMxViRrDcXM40=;
        b=avmzvZz80aPW+mYNy8W3N8wRhUpGEMvYjXFdQkzXWGHDVa7/CPD66Tmk4W+8fz8moP
         PRqm3GTZ8O5u5CTS25LHAqnTVIwo4+KfBazvbskEAYW4RNHe1pnh/7Oia9/mNg4VMMiW
         qFVb4LtvyR+ETi2rghzy98s961vKzZvYxOZ9sxQStbva6z2GGmOxoDhYnxwEpfaiF6Qj
         +zgBlJvbJdYL1M4b0VfVgNwZgyi26pNOUDN1si1H11U537g9jBCa6+CWeeRPh+s0HxY+
         +kb43IHKjXEScv2oOJo8YBE46eqsfhLqm6lsgm9oX89e9E6m4wQj8Va8Ceu4P8RFwh03
         TXbw==
X-Forwarded-Encrypted: i=1; AJvYcCXEIJMiu7jKz+gQXvQLG6FFXScNEdGNCW6BHixX9QGNxkCEeZNCyHS2BBz3QBCwIgB1P7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymj4iDLz3MYRtlfZvsiAWMPj+J9p5z/oU4HDc7mfnke9tRwFwq
	cxWI25jZ3yiC7287/mcSlLAQ+cuN31crc+8OX0ys9Sh7X5erqNzyhvIt
X-Gm-Gg: ASbGncvhldB81XKdEbV44ynIMpyhOL2tkUG/wufQYaTOV04e4BzsCYb/VBdycGn+RK3
	QmqFhp25mmvdaYXPpIrJh2aLU7QMe5xXdbPTaTUQU8zyMQ6kxLfaWn3qK8xQmqusCsHmdfBDzHu
	Vp+C9lCfUUpYRoUHsc/2bP+MtcO+k0PT5Ai4V1YTilVGTQV7MDfn0u6TFF4Q3Do7RYKhxfFdrRV
	MHSeRNeS6QBwhJ+O8Zxy/30dfDKNhdoWJi6WdtuZE11krFock01ribaHZlWalTiFH+14wi8hfpn
	MVdVRFfUzzbkRCNMbGBZvwEm41IocUX1WOMPOSfBGL9u5bxp8Dt8uadeqlDwa1WswNcgPtZXGzk
	bxSE3tnAD3AFWJCzpQAFlwELcrMKNEp6V1reEh/k+KbUE7lCfXqWbtQdhU9N9ec4SIUfzG+0Yx9
	pmrJAYHw==
X-Google-Smtp-Source: AGHT+IEqgCZoGgaIXLCPbzzZANdOjZLh8C3cpK18CiX10iCKXMK4wq8arpQQCzH2HQYgaSY3RSP/dw==
X-Received: by 2002:a05:6102:5488:b0:534:24ad:358a with SMTP id ada2fe7eead31-5acc33debcdmr2613898137.6.1758894131759;
        Fri, 26 Sep 2025 06:42:11 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:74ae:976a:4e3f:7fa? ([2605:a601:a6de:d300:74ae:976a:4e3f:7fa])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916d878c126sm914653241.11.2025.09.26.06.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:42:11 -0700 (PDT)
Message-ID: <3537e220-44b6-4e37-a568-cef34a2fddfd@gmail.com>
Date: Fri, 26 Sep 2025 09:42:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ds/sparse-checkout-clean (was: What's cooking in git.git (Sep 2025,
 #10; Thu, 25))
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Elijah Newren <newren@gmail.com>
References: <xmqqbjmydw5i.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqbjmydw5i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/2025 6:06 PM, Junio C Hamano wrote:

> * ds/sparse-checkout-clean (2025-09-12) 7 commits
>   (merged to 'next' on 2025-09-25 at 00b296f153)
>  + t: expand tests around sparse merges and clean
>  + sparse-index: point users to new 'clean' action
>  + sparse-checkout: add --verbose option to 'clean'
>  + dir: add generic "walk all files" helper
>  + sparse-checkout: match some 'clean' behavior
>  + sparse-checkout: add basics of 'clean' command
>  + sparse-checkout: remove use of the_repository
> 
>  "git sparse-checkout" subcommand learned a new "clean" action to
>  prune otherwise unused working-tree files that are outside the
>  areas of interest.
> 
>  Will merge to 'master'.
>  source: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
 
I should have checked here first, but I pinged the patch series
to see if Elijah wanted to give another round of review following
his careful review of v2. If there is minor feedback, then maybe
I can forward-fix on top of this branch.

Thanks,
-Stolee

