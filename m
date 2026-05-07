Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F5A305E10
	for <git@vger.kernel.org>; Thu,  7 May 2026 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180359; cv=none; b=AFOGAJquazySQ7JVCRw0LKEOqkmAwHrTT5rXrSxT3BFl2UcaL0d+VRrw5S095XzgFbJD+Amn7KTrXyO9YeOeDHk/V/HygOpDbUCAxxuC8IVIgJDPxFYLjYF6ffTZir50Yj0zzp1piDAJKSDgaVLK6UEK1wj+a+tEGiEOeHPZD5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180359; c=relaxed/simple;
	bh=BK3hUiXLdOxGH5ckDbeN5atmULVNRVbs1xbEliTS4aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEhsyG4wL0Aqkuw51yn6ql3OkI5QX0imQi+BObLZwxbcT901cqUgdVAjASNvjPK8+wjj7Qb8Xa+QsrpCEzyFKxH996hhkZWESEz5Prksgd6yu/NxREWYn4hlhTkiA2f+/iS4YeDl/c5BGEi782bOvwVojHraM1qbaPB7S/TvmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLysdP35; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLysdP35"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ec37d52c0dso169183285a.0
        for <git@vger.kernel.org>; Thu, 07 May 2026 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778180357; x=1778785157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1k5E9KC/ABXK7/e8h3DJHbMJNkXw0rBryjv64cY7uk=;
        b=MLysdP35EavE+xRpXHwQlQcSPy80dSkGASvbd3DzCCI5B8Pc/z+VI9qC2z2QYnh8c8
         HamPJ7hlxqbj3mWY6FiJ1RnSvQTUcQEVs5M7motLBwrtjGTnAtnlOjgKHyMvnFFEbb07
         p9ualC727ZZi9DCph31JKqj7Tg4TuZFdNuQLMPrm9OOc+NdDZHcEonNW+VbFR6adeRqo
         e6y3q0VGtf7XqcZqPChsEMn0QHripzareZQCREJ5qFJQCJ4ZvezUJJD4UtdX5b3so5m9
         vVSGcFzxAzMqzIJ2rtL3OignISIKoT7FNXb1H80AYU11e2H+43Ehp14+Cwrx2hpGEG17
         Ga9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778180357; x=1778785157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1k5E9KC/ABXK7/e8h3DJHbMJNkXw0rBryjv64cY7uk=;
        b=bbR128W2MlWDic/CfiLfpBkQJyVFACcIhKSkcL25LFcbsUWW4Ziqs4xDp7pyna8u59
         Tp4i4NsXSF5FXbYvVcTE1LDCqW2px3SsGqSDpMhT+x5o7EtpqQcJ0PtWrH5msa7QsltR
         znjuVxYw+7BClDy4Ocavo/ZcfbmSxki4X2/tJ/qpWHaElesNcGsVZybxpXls/86AWeQF
         VF9L/wiWjmjo6A3xI7rLhNkjP6XdwE162qrxe0ImKBpp2OZXfHpRoWNhoAylUdD+UT91
         rE1j2QhydfDqExKQBdp2AdYlY8kfHGH7ApJMOj8Jm4kOxGs2vNBM+1cn3Y6bwcr/d8kJ
         bXxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oMCnw+9XV6QSXLhqVIGd5MStCCU10LIveOTxYOW5Pp+LjfzJjczAW1gjVpgbK/0CaIZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWX6J6vgGPRECFy2wZNB+XJ4UqMtYDSj81fv63fVwdBai41j8
	68y58l1bQW9c7xzQmK5f/QNSwhaJfvYvMoBOIYIH8f16jtae5ih/5AuuaI9VYA+G
X-Gm-Gg: AeBDievjQc2NF32EOFxPJ+VFxXYXxo70abUPbuc8hXPQYQm8Vy1j/Iqv7uQRUq4b+O2
	6pa8+R0JtYf3jMG70SC9p2Vqqpfo0GHx/uG9i/WXAcXKthhaVkfKjvaZrxXPLM/ihFR0EplNZfD
	V0oerb1wk9pAeXubsQeXV/26591faJTO0yMgkcWmofCaJWlD6ShdnLAYW/k+/IgnbxbKJIDs/rU
	fCrzaaX+pAfZgCOBGAmy8aow1FMXYbATxwCMjK5iwXP/ohVjefdstsGHN2ju/Ri+4VvRebq3wuY
	1/GbCKC7KHBi0PwPERl/zdT3x11Jqubn702pbHSHYcvnala24YuEOh6t4tLKr6ixeGvVN1PuFn/
	qxCR4hSrRyk+cxaK1YJTZkkLZk5x0oUj1fGdTaAuUMI0OxY3TJX6NwFTDet1l3wIDl+ydZ4Ff6x
	BeI2RaoxMwhz9jytsoSgbDAlMykeRGyiopY9uWrYZODcI964NIO72fAX7mFeyqOGZrTNftKQ==
X-Received: by 2002:a05:620a:6ccc:b0:8eb:92a5:5c6c with SMTP id af79cd13be357-904d63e7a4amr1368026485a.33.1778180357273;
        Thu, 07 May 2026 11:59:17 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a7f4dbsm2033526685a.16.2026.05.07.11.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 11:59:16 -0700 (PDT)
Message-ID: <913c1338-7745-4229-83fc-cd7a03937d1f@gmail.com>
Date: Thu, 7 May 2026 14:59:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: add caveat about turning off commit-graph
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <caveat_commit-graph.671@msgid.xyz>
 <V2_caveat_commit-graph.68b@msgid.xyz>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <V2_caveat_commit-graph.68b@msgid.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/2026 2:20 PM, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> The doc `technical/commit-graph.adoc` says that replace objects and
> commit grafts turn off commit-graph:
> 
>     Commit grafts and replace objects can change the shape of the commit
>     history. The latter can also be enabled/disabled on the fly using
>     `--no-replace-objects`. This leads to difficulty storing both possible
>     interpretations of a commit id, especially when computing generation
>     numbers. The commit-graph will not be read or written when
>     replace-objects or grafts are present.
> 
> But this isn’t mentioned in the user-facing doc. Let’s mention it on
> git-replace(1) and git-commit-graph(1).
...
> Interdiff against v1:
>   diff --git a/Documentation/git-replace.adoc b/Documentation/git-replace.adoc
>   index 2c0ea07724d..436a0e58caf 100644
>   --- a/Documentation/git-replace.adoc
>   +++ b/Documentation/git-replace.adoc
>   @@ -149,7 +149,8 @@ CAVEATS
>    -------
>    
>    The existence of replace objects or commit grafts turns off reading or
>   -writing to the commit-graph. See linkgit:git-commit-graph[1].
>   +writing to the commit-graph, which can cause performance issues. See
>   +linkgit:git-commit-graph[1].
Thanks for the update! LGTM.

-Stolee
