Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6B53E304
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176754; cv=none; b=qweSEuUsYU/Hui+YrHfgCb4Sf9H7yCkpfuszzWZ+aCb2PIXShohqXcQpW9Gd+sv1WJl0wJwjCsN3b73Zy8LDSlEIek/0DwI4o5Cm5KGAbuHvWNAFFS5UtHO9E8PR9wCTzDd8CjjcWbC+obTW+WYxFWKhomBYY35IPe/fp8LZNx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176754; c=relaxed/simple;
	bh=2KIT3R5+eqrmc29y2Dvxq/IFwq/Ze8g6JSnsAAvce1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuN2qF3Yx6Ue13NQSL10bc2+lKhUvzWjLiGcVUwgBk2WA5lQ8DE413D7RYjvRiChpzV1uPdUMMV+bNED17SrwqUwVchH51moEvS7qPjSz6b6TcYZ/jS3UsDCX1wMPbar6Yf0PAm5YH36F7ub6PbfkdQh5JGzo2CbXd5XO9OGhG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxPZporp; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxPZporp"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so699675f8f.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790176750; x=1790781550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C2jXr1eXFZYgHVXK93hbfOJavBlf5HRlq9XozS/8zMY=;
        b=pxPZporp42XeNB6FTXuHHGNh3vZDiEAr49ZKDwgzWmsQwkO6WEY42cRgIZnljadO2+
         ryJzxbIGhVrHm46OdGoygAxH1J+XtAG8JW6GVct1dGvYjFcCZWbJADgbdj9sReMsOdim
         TATEoh17wTVBK6NA7wK7+BexyLynVg6aXLIUmobWxVWEG6cSKJR6tZfCQudFjY4tKlsj
         0efYqtqh+C9V9dIsz/mcMHTrABmhPa/toK5xzm0t/x7zdmqns/zw0NCR6GOMwDcn3X61
         nZqbh7jWG+TRoN6A7Ie3a0lLwp6tP2Pdm0X7rpzumGkKLqCN8mwpNNo6infcI+tM3gPy
         j2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176750; x=1790781550;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C2jXr1eXFZYgHVXK93hbfOJavBlf5HRlq9XozS/8zMY=;
        b=1Wf60yom3ayhRgvLsoHQ62VN3wRGDAE7XhnspN1DZK1eqg0FobpMXBmsPigk1gvYcU
         Kn++/hzHaTFy5AKJQu8PC9o+z/8aTWYSp4B1ttM79H7cU5ahvLTRg7SVdnuyNB76TTpZ
         S1p40rR340IVXObpRRM+qvzYlKX+2Srff+u/R15rLEoWu6MSj6sXbw+e7y+ofsiNZ0f7
         GYIU0KArP2OSYIhtm4l/7jkxLB9wESvKt4I8mSxw6k+zbq+zX7QToZQ6+feG4OzBk5q7
         njmMPR+G3EhXq/DNM6UA3Dt6JxQ0HIAWaeKU0qrqBJzIkg99yE6Gm3abKze0Zl36WyxO
         M6/w==
X-Forwarded-Encrypted: i=1; AKwUvByylYqfRy6t1VsvfLPmygZ03Y6KyHUae9GiayIFSoqzXnUmMWSTDw+WT26hlQyIPBnwn94=@vger.kernel.org
X-Gm-Message-State: AFuF++n7m2k4pn27nnm2KySvrJseTg3TIkSXzm0Vrw+pgYg/oDx4jFTd
	v5AhKd4IZCYtDDV7iVw/UqhlJFUdl+2/CvIM7DLoogwFzCM4KZYW6TX7
X-Gm-Gg: AYBFou0V0GM6PkajWQ+oS0N/pN3uc8puN9esRyAS7u6E9kV2Yu2U2ZLfSuLoh4a3ff9
	+Ahpfj9+D+FIbyhaNLXj/ZCPz6XsuCnaSQeXJPM+RMxnAdMvSmgeDVRtaaw6jW/J+cUVmY0spm/
	xScsdk4rAPrtEgUM1go0SieHwWJ0gJRm83myWYqg9ruRbgYPeeIE2RgZ46Y3Sxe/ibKjU3X7bXi
	V/h39lR3bajhc4rqNrhVMyBP6OQvQFCDMslg0WoAO1b8kpD/f7L+IPA16LO1eQl1CsWRT/S7no7
	cNx8eMg/JjyVDWhJCpkHGf+dSdY6HH8rZ843b11Y01qgb/pDBG1KX3E7hI2nTpd94WAEGYDnKzs
	IpVql1Vh5Yj7NlXA3nP8078uPM2ubW+tmcN5Sd+mipWGMa/YtxUzTURC4+LvZVP8NngF3TW2sI1
	8xRbwBYfeV39pHSP9YVJOyFwqels1+wlylIYKF1lo2lLdG10XwQv75/ZvPNyC3Tj/KsJFBX4geY
	Qwisgv4oPcayhSkrQhC/N9cDOb/e26zNNiyoJajrBi08CNNeK45LrpW254FUpbr
X-Received: by 2002:a05:6000:2888:b0:487:27f6:a4d9 with SMTP id ffacd0b85a97d-48867090fe0mr5577385f8f.41.1790176749962;
        Wed, 23 Sep 2026 08:19:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868886e45sm7854921f8f.31.2026.09.23.08.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 08:19:09 -0700 (PDT)
Message-ID: <05d0e6e0-e156-4a2a-95a0-4986ab18ef49@gmail.com>
Date: Wed, 23 Sep 2026 16:19:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com> <xmqqh5jhfbyw.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqh5jhfbyw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/09/2026 18:11, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I think the sparse checkout is irrelevant? It is unclear to me if this
>> is talking about a case where there are many branches in the remote
>> repository and only one of them was cloned, then adding a second remote
>> created a wildcard fetch refspec; or if there are intentionally lots of
>> remote tracking branches in the local repository and you don't want to
>> wait for them all to update. If it is the former then we should think
>> how we can improve the behavior of "git remote add" in a sparse
>> repository to prevent it adding a wildcard fetch refspec and instead
>> setup the new remote to fetch only the branch(es) we're interested in.
> 
> Very good suggestions.  "Avoid wildcards" is easy, but designing a
> suitable alternative ("only the ones we are interested in") may be
> harder.
> 
> Perhaps we want to have something similar in spirit to the
> "matching" mode 'git push' has, where the set of local branches we
> have defines the set of branches we are interested in?  That is,
> when 'remote.*.fetch' is configured to signal that special mode,
> 'git fetch' would:
> 
>   - Find each local branch that has its '@{upstream}' set to a branch
>     at the remote we are fetching from.
> 
>   - Fetch these branches at the remote that our local branches care
>     about.

I can see that being useful fetch mode for a remote that we've already 
fetched from, but for a newly added remote there will be no local 
branches with their upstream set to it because "git branch 
--set-upstream-to" fails if the upstream does not already exist. So I 
like the idea for fetching from existing remotes, but it leaves us with 
a chicken-and-egg problem when adding new remotes, so I'm not sure how 
it would work in practice.

Thanks

Phillip
  > I said "in spirit" above, and I find it tempting to use ':' and '+:'
> as the special '<refspec>' to trigger this mode, to mimic what 'git
> push' does when using the local branches we have as the set of
> branches we care about.  But there are important differences:
> 
>   (1) The correspondence between local and remote-tracking branches
>       is not one-to-one, as you can fork multiple local topics out
>       of the same upstream branch.  Maybe our 7 local branches build
>       on top of only 2 branches we fetch from the remote, for
>       example.
> 
>   (2) Corollary.  Unlike the matching mode in 'git push' where local
>       branch 'B' is used to update branch 'B' at the remote (if it
>       exists), this new mode in 'git fetch' only uses local branches
>       as a guide to determine which branches to fetch from the
>       remote.  If our local branch 'B' builds on top of branch 'U' at
>       the remote, it is branch 'U' we fetch and store as the
>       'refs/remotes/R/U' remote-tracking branch, where 'R' is the
>       remote, and 'B' as the name does not get anywhere in the
>       picture.
> 
> In other words, this is not "matching" at all, even though it takes
> inspiration from it.  I do not know what it should be called, but I
> think it would be a useful addition.
> 
> Thanks.

