Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F01D9A54
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771807357; cv=none; b=Zjc+vlU3pOUlk4XN6GRsP7voR8nHvciUdD5Hysx/e539fau1pEstWduyvl3rLuQjIu1Wrc3GITK1NoLuAJtthPYVsLE3shH9r2AiREtXoGQBpYULhR4wOu66Szj0wHRI2gTRgB5oxKIRBLUJktIDb3x1XXqzCkUV7X6rCQ/zBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771807357; c=relaxed/simple;
	bh=b2RYiLL3FOWbvPW2bXqcbWfZj8x2WfqJ7nj6Oce8NnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3TRY7QrTyWmxvHe0+70m3xvTWi8gveYHPqa3sD2ZlshgGYdGKbWUMwBhCkAd176+opyBoyF67t/3lG0PbpDv7OslyuoT/8A3TqVoT2IFQrIarChNedP5AnWfhU65NY6VR5CQENvSA7iJq24xl3w+z5XRAVqfAU4c1V8HDU3QFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDBQjfQZ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDBQjfQZ"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6f21c2d81so367207485a.2
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 16:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771807355; x=1772412155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsoyujc1nSaQXA0ecaiOu2K7ChERdNWtCYzVXmk/sNI=;
        b=SDBQjfQZJQ8upY85n47audqCxsHfVO9eG03cHEL3R2ucSopMwNsOqC9lP5q4LqttEU
         bG7LuAdLH3KyLUDQq/GC7+zB9YAE6DVnFOfxv7y9gOJthWb+TbBcNqjuXi5DCFJIxe8a
         un20MvUn47pe3GtEgh29whsQtI0NT0wCcdFGZc9IMn/LpnD8hxVt5/xdCWipXZ4rH923
         HsRXQ9w5YoSeDTIKJGzoIdy6Pe0kjcGAH+/wvFv+AjLiVB2NfvI1RSWhjjtUBnzVWV21
         qs9FkNMREwOYpdVhkw5LlVLUHjeJyIbMPXc1AFZ4Us9hulBf1f2CWet2Pmc9Xi9vTkBp
         qnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771807355; x=1772412155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsoyujc1nSaQXA0ecaiOu2K7ChERdNWtCYzVXmk/sNI=;
        b=AP0Ntlt6CTmdp0fv3mtLo0uDcAKi8PdHox1M2S/SnxV5ib3UHxtBhCVFc5trGPQ2Nd
         SQ6ESzuejEfVOkdzdrmut+hgk3IBMzPTGiIhyue6FuiRVKt9/Nz8tgXZBLqlsXgupxuf
         w0rWmTyN3C/HMHV0baJCkKgCC/QepqriJ3Tnf70PlsvUjCItE8jbyksNePtf+hFAtDYw
         Nlpfw/hOgYIx/TV8PcWgStNVPx/Cyl92q0kfvTdkCcLRpYJnKWO5q0vCmKUMQisqafhG
         lHx8ov4NS6ag+RjUSOM5dFwuH//O2wObSfFMzqtCXvWChrGmJ4ZCBHfeoyxJdKKUlioE
         aGvw==
X-Forwarded-Encrypted: i=1; AJvYcCXYOlWMnuS6DtmsMgw2r8wr8p5BKuHxHDOrsVUtCbgNGqcC4xGhOJPSasryk9JR6VPg2gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvXIfRJMVpBvyBdHjs4L/5wsrt3a+BI+OZWnQ5TsgZQcMlOUn
	C03fjTEgxvQ7FWqcm+0qGfUtK+DOi6H4FUDpJj8Z+6d2M1qiyepWIj+s
X-Gm-Gg: AZuq6aLgJbfvifXNL96YG1p3f0qrioB4snalsyi9VJbS4CjcUReOK1K9AHXUe2IS+w+
	8BVshszFQ3Wf4288gnNXELFLxvORtqOfA2M81nkLsDl48OFEfHx4vOuA0Zgral0RgVEKPN+PV8s
	R0X3HAyhH1PC/xyWgDb0Q5LbzJyi7ScekBB4Ezq3ezdMV8VjkbFlN2bQ+iVKZhLAGqzzqxPCmIx
	pP2/es0ATvV7GlfKcVnLyZX/SiAxF7rxkAgotdRQm7jGxljay+5gk8C5k7oRpMeWVq13ciIPJuz
	SV44FTXoFCRlrNsOWp1I+XA6MIDbUuGqcenPvuI93z5aEvIQJwKxvIuskvIQbBTCahVBymZhjHq
	KCn9BzhAQVXcxbvDV8hny0RjbDw+4D3Oc/YdxDiBhf2ZehqnuuIkZu/bYArEBzFD3DPzzfYVmT1
	mYDB+OOekq8gsECUwDj6DTx66/my28mlrmpO71b0Hd0qvrcF2hofZYbqIZJeY0fYkbEErAXnsac
	5f1EWM8+pRGXFX/uItHkk2fOgkn1ToGZ135D0CZFQWvp7OJyvSlTwASrf0=
X-Received: by 2002:a05:620a:280c:b0:8c6:ff8f:58af with SMTP id af79cd13be357-8cb8ca674bcmr768741485a.51.1771807355431;
        Sun, 22 Feb 2026 16:42:35 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a2299sm53843311cf.19.2026.02.22.16.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 16:42:34 -0800 (PST)
Message-ID: <143ab1c8-9f07-4df7-8200-69b5a78a0351@gmail.com>
Date: Sun, 22 Feb 2026 19:42:33 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Avoid the_repository in merge-ort and replay
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
 <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/26 6:59 PM, Elijah Newren via GitGitGadget wrote:
> Changes since v2:
> 
>   * In first patch, actually avoid the_repository when attempting to remove
>     check against the_repository
>   * Fix commit message of patch 3 due to the new patch 1.
>   * Slight tweak to commit message of patch 6.
> 
> Changes since v1:
> 
>   * Add a preparatory patch removing the_repository check from blob
>     prefetching in both merge-ort and diff*; it's no longer necessary
>   * Fix casing mismatch
>   * Simplify the hammer a bit based on the new first patch, but add some
>     simple comments explaining it
> 
> Remove explicit uses of the_repository and the_hash_algo from merge-ort, and
> since this has now been done multiple times for both merge-ort and replay,
> implement a small measure to prevent them from returning to either merge-ort
> or replay.
> 

I reviewed this version (plus patch 6 from v2) and think it is good to go
as-is. I went back to check the v1 feedback and thought it all valuable and
resolved by this version.

Thanks,
-Stolee

