Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A6218AD2
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197859; cv=none; b=cjJ0myhQ5uZiR3gk6Q2FHoPBPR+2g4qbDHM8GIdHe6Mh0MJET2i8nK1YQRxS8XtWxbPuEXwy6AhSeANwpgNTrJrv9acpJ4JIyavZKSp+b+RLmLd8l42QiSjWT8j0x7KR9z5CATkmhp/fOeOTkBsPOAs/2hwsXNXqoMVBHhDiNiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197859; c=relaxed/simple;
	bh=sI5e8D7ajA7dvuqj9WhgQEYhvDPCxYZKeA8bduBlBGY=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RfYryCAUmxLsW8bDzmNmI70FlkerPZP4FGI+7p/nqaZRfyjoIZlq++gdm1admbeYwP20bRaVNn9rWQcJf9/mcQdXvY9QyhVHBhqg8yIQ46dRVNYdfKwtwZJKtDX6r6X9DmmVXr6sjCksAKPCiEmOAWg5XhgSNO3OL0l0QrJ3GhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmv+qkph; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmv+qkph"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecf99dd567so73918746d6.0
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744197856; x=1744802656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iciPvNGk46RX1GhbuFezS5nOeIh7ojbdHQcgPeIuc+c=;
        b=Nmv+qkphJ2ifwoLeqp6f+ZirMOJQ6KYzYLbLvL9nAywlycuf8ncUJUWBmU2y0KyL/7
         gB/ATfqKjdBzSnJpOqFkJq7nfv6wyNmE/NCwybo4pFSeB8+o3HlSAP4iKIdvmdKpkWF2
         bde3AWiSyI+aelqSM8BvRyqRNsT5q3i9CjpsqoMd/itzawbWGai1sZzzk16swK+dQ5GD
         JFKUN5bqDC9MTri6Ad5stfWpTTvdavPEceGM8RMqSIjV6SI+M0ZmwsFWCT5PROSY3cE9
         wk3TsygGRJHEk6pCtwYKTIfBopZT90Akjqps9fZlfoX3xI0EQmePrTFXo970PLZTMCJg
         KY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744197856; x=1744802656;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iciPvNGk46RX1GhbuFezS5nOeIh7ojbdHQcgPeIuc+c=;
        b=MJdWu5EIG+0vqno6ePQjrmD4F+n8SEccwx3g4OucR6SD45aPl2U6hm/ZAof8W87YAB
         yljrygr655BSELgexf2P2Ml5BWSvEB/KKKRJFLCHBBH74Jn2MHnLsu8ANlBY3KrJN5dM
         TlGHGywDSxsBnmnGfYcTDwuUi0xncyLZBkkRDQZzlkepKtrIJllbnIDHftXdHmQk1hqA
         AXbA2SDE7hzRz0qC3u6ehX6w6IM1Wx2+xdYOnx8kQDhpiB874MMXAv6gHcktowg29nuO
         crwv6ri+xYiF8m9tFJsnp+yckeKCnd3uNEw7dByXQvLJg0uhbLSyDUIntScny6/kp8oU
         weVw==
X-Forwarded-Encrypted: i=1; AJvYcCWLdrYWgt4kP3t6103uvxsytxeOzWg9pdt1Zlv7DmbjKZIHDoU6q3L1aJ2Q8mj/uQb8dZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgm2Mz3TEFxdIpqx1gw/ApAVuO6RmSsmnlZcv1dpttpbUCDZLK
	glK8i3ox283OoF2DkVidIankzI+UFjsisRHlTKCMYFzt56MbVLUj2A5Oeg==
X-Gm-Gg: ASbGnctnBab3oMLUra/8lfZehnOPe06HjHHuJ7grR9y/3nqo5urrxj2YA7SRLT8vZiw
	8yj8b1aKjO0zq8kuXZ8etEr2VQeJajO/QlmM1Ptzzk9+jzDXDxTgQ9X063zk1t128THsgrezB7R
	fNZr3SQk7lFl6eUcnebpVhlDFbsfRmNqZgrIuplZGrSA/zhUEt/pGCxZkeRCii70E+tYkIYgd1x
	dzvFi4/HvD2aauuux/hhQ0vcfjqLfWlXVxzwzJ+ffs+Mg+Nn7l6V2n6Ag1u3oWfGVIMdUFDniJr
	7HdQXScL9+3WJ2dJ5TUxYC1Av+VMDQ9ENZLiSCcf2X3LgO1Rtc1IzRy1fRZtCxzX0q+j3jgwJs6
	QLgLdlPHbPXFCIZRGgvaX/krirGZcNOP2h5Y6vC8JzrgLuhOfhHg=
X-Google-Smtp-Source: AGHT+IEoved8Wc8gh5N/zk492Gxu0HFi7c0fAoVE+j8mxUYz5sqUsk4Q3mit0H/mkMDW/+6j0tdrtQ==
X-Received: by 2002:ac8:7f88:0:b0:476:6599:3e29 with SMTP id d75a77b69052e-4795f3876bdmr40931081cf.43.1744197855831;
        Wed, 09 Apr 2025 04:24:15 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:958c:6d13:6245:a622:b272? ([2606:6d00:11:958c:6d13:6245:a622:b272])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964ef6e9esm5729801cf.72.2025.04.09.04.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 04:24:15 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtt6znch3.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e9700234-324d-dc63-d91e-9b8f36fabc79@gmail.com>
Date: Wed, 9 Apr 2025 07:24:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqtt6znch3.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2025-04-07 à 12:49, Junio C Hamano a écrit :

> * pb/status-rebase-fixes (2025-03-28) 4 commits
>  - wt-status: suggest 'git rebase --continue' to conclude 'merge' instruction
>  - wt-status: also abbreviate 'merge' and 'fixup -C' lines during rebase
>  - SQUASH??? - <CAPig+cS92W_gYuNsaTvQxiP3xBK7Wpg0__uVkgAU1x0OFJUZgQ@mail.gmail.com>
>  - rebase -r: do create merge commit after empty resolution
> 
>  A few fixes around "git status" while "git rebase" is running.

Note: the first commit is really a 'git rebase' fix, and does not concern
'git status' at all. I think this should be mentioned in the release notes,
or if you prefer I could split it into a separate series.

>  Comments?  It probably deserves a clarifying reroll.
>  cf. <c2f93d99-2f4d-ee6d-7087-42320c6df0f2@gmx.de>
>  source: <pull.1897.git.1743181401.gitgitgadget@gmail.com>

Yes, I will address the reviewer feedback and send a new version.

Thanks,
Philippe.
