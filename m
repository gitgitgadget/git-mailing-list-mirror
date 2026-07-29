Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150F3AAF52
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338747; cv=none; b=aQAwV5pBtz9onInExO8G9597dKBqTErCz3Wy1R6JVYULjvwgHOQgFnncKyyUyqn/v4jktorp1Q43X9xWbX7fwDcCr6DkL6/NgfAqARIqq6DXsc+lctzPgVetm+hu/krGzKNpWyixAFzaR4fvgqa9gpHf46Q/KNzO2fj3DIItoiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338747; c=relaxed/simple;
	bh=mrem6RSpKG+3gmu5Bj1mR29aOwI1U7XmFngo6xX2/uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTmKuc90lCN6LT+ghWWdzGnbQZ86YUXlK+VzrpYnXr94P06oiRW3K8PVGi59csZ18sXLjRvPcQid5mBnjH48vjhUzOWg92Igx3kZQz0NvsSLXt5dsuPa8P8+jtmo0eBd5k8c1PEmycOSYOC44nLqQhsuy7oKhleDHzApWCAR3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/aZK8nG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/aZK8nG"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so1602895a12.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785338744; x=1785943544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iGVV7Re5IL6V09DHsi57TGzuLhseG7HhpAmuWJv/ceU=;
        b=Q/aZK8nGYJTHy72uA0Mst7E5dqQUqwqszUvfVXtJbmPQLfYtD5eFuAGyBNxI5Yj76l
         odqnO/82DRyV6/o1UwdQA+Xj9mf6Gzw/swvze+ZN8geamU6W4OztDDd/TjG5GezIQ/O1
         Lhfrd4UPLyR//tpVb100VqUHBHecbFo9f3HUobucRQoCKy5WvicjXBVGkOGPPpbi/6AI
         p5rktFimmwK5Bi4HZZBqXKktjzARwOvd6B6CVJGjzaRo6BRy4qjkYmu8ML/7T19w7MI8
         9ymxEWtap1f5QwlxaHNS59YOwmbAtCp21wX7tP+E3EMywXawiKrA4qwXe6qJCW/EraFG
         zCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338744; x=1785943544;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iGVV7Re5IL6V09DHsi57TGzuLhseG7HhpAmuWJv/ceU=;
        b=kqvCeBDgHXyPiYM8BGzt2ftVhm/i6s1rT5s0z+ZHZKACHhGoN3nPc5k3b1XKdyiIce
         GNz4JMmHCxARoS5UfWI4rPP7PQVae3NtFajGLUfxuz0iAo3z/ReUkGElFtfTfTdw2b7I
         wNvRJyE960EUFnhtmdclMww4L3YpnAgc7MhIwk6CbqkPzLUR69wQM96fis70HqcKccs0
         edmge+tbhZC3viwOlsF9Eo1tBYcU/k/STN9Tz+2NeGqH1UxyprDzlJgxo3fPjaJhmNib
         k8VYlWrzYhiyJSwM6X5x5W4QhRUW4BigyLZ84tf0xHA/cLRyR7QvoqS1lLuXl04u78VH
         It3w==
X-Forwarded-Encrypted: i=1; AHgh+Rr0lJM9yP8Wn68rN3OK+0aYzv5GqvqatkU8QNH8vgpkwZoieQXBKWHl2AV0NreIcMeXNek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+OCPwe+Cc1bALs51tCG6u8gfz3ebs+hOtBMWSBPsR6McdbUD
	93U9xWyXwvYuvvJVYd+QjNscpvmCu7u7uL6CxONm3LmkSA1kgWKy5ie3
X-Gm-Gg: AR+sD10mAp/O8TRoJQsn1Bysl0eq5jcThENt7A/sjyMVtjLXnDLlc71qguwOP5Tuwca
	flohBCd81gwKzlPafQTc+01iRYb0ql/SnMGTse4zAvFcCZoH3ZkyarU8gTyRJCq9/jIRcz90VUv
	2hlQp3VZl9lpc6MdnH20es9LrnTUkYvWb+pfhppkudTrvDqhwzDknruEih/EFTE9dve9U5tSYEO
	880IrJxP7twgcLBaNoU5Iu3Cy9cU+JoLC2M3SKb249+bOVLuyH+I0HbZ+lQyVyeWjaK1trggyd+
	Iwpg8MwsXeiCKIlzgOtUJK0mJQt5LTXUN4e4IkpRMKvWoSm6vo4oF2oy8RaeClpqkQlfHgrxZ7C
	LE+Dcap6O/vdAe3yw4mTdWuxPHVS50gnZwMDQJd6DJJrkkTFEAacf5wNVwCcnMqOEBDYwJ9Id1s
	sy6rgVbpkD5f/3EuMEzjiUMo9jx1ytNEqNiaYHngFXhduZa8QX63Fqc69IyxDFfX9FRzrjl1anT
	W7j5FK6irWtAyedEl5V62SpheibiVjL7ThL5ci6xuohgixIOWSVklg=
X-Received: by 2002:a17:906:7312:b0:c1c:5eb7:2ff0 with SMTP id a640c23a62f3a-c1f72154d2bmr399033766b.48.1785338743802;
        Wed, 29 Jul 2026 08:25:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cdf521sm136107666b.17.2026.07.29.08.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:25:43 -0700 (PDT)
Message-ID: <1ee46199-b895-4f5e-ba2b-030fb2e47852@gmail.com>
Date: Wed, 29 Jul 2026 16:25:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Failing tests with WITH_BREAKING_CHANGES
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <amf76F4wxlboLz_A@fruit.crustytoothpaste.net>
 <758dbec3-7657-4342-8b74-7e59cdf88b5e@gmail.com>
 <20260728135532.GA11894@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260728135532.GA11894@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2026 14:55, Jeff King wrote:
> On Tue, Jul 28, 2026 at 02:31:03PM +0100, Phillip Wood wrote:
> 
>> I find t1517 fails quite often for me due to cruft from a previous build
>> when a different branch was checked out. I wonder if there is a command that
>> is no-longer built by WITH_BREAKING_CHANGES whose executable still exists in
>> the build directory from a previous build. Its not clear to me why the alias
>> tests might be failing though.
> 
> It's the same reason. We test looping through deprecated aliases using
> whatchanged and pack-redundant. When those are builtin but deprecated
> (like now) we allow aliases. After the breaking-changes split, those
> names are not special at all, and they are subject to the usual alias
> rules. If there is crufty git-whatchanged in your build directory, then
> that is an "external command" unknown to Git and you are not allowed to
> alias over it.

Oh, of course - thanks for explaining that. Thanks for fixing the tests 
as well, I've only skimmed them but they seemed to make sense.

Phillip

> The test in t0014 that covers this should be removed after the breaking
> changes actually land (those commands won't handled specially, so it's
> not different than the normal alias loop detection).
> 
> But we are in a funny limbo now for WITH_BREAKING_CHANGES. Possibly we
> could pull the value out of GIT-BUILD-OPTIONS (which I guess happens
> already via the environment) and use a prereq to skip the test.
> 
> -Peff
> 

