Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F4221723
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043883; cv=none; b=fqPZPFOeLqstLwwQoURveGY7AFmJb4LmWqLD0Awr2LCzsHadBhX293jUB92Im5LKJq56BS3wPzN/ui1gMlvJJ/vNtSjGKySeIbRLumpiGgc8t0U6JESJBipliMwHozX+sD7wTS4gQM3y2rgvXCQ0O4zPfy2WCzT4fJxQHfkYm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043883; c=relaxed/simple;
	bh=rKRWOvL5011slrd+qdGKCcJ7+fyYFbxAinCZc7/E0FQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c7rHa8kxUFB4vP34z5cR2k1dwDIooAogpeeuyPp2PczDY3wPQJfsUie8/QOhOeFsm72Z/eEngclmHAyd31T1qQSCdXRyQrfGNrSxfVcu10lflOJ8rsAIReLlyqYKJCBx87/g5SYHZg95N7UVtsh3QmFU2Q2Y+/+bwQmzpcsfql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st; spf=pass smtp.mailfrom=martin.st; dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b=CfV+PkdA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b="CfV+PkdA"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3322e4ac12cso5568371fa.2
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martin-st.20230601.gappssmtp.com; s=20230601; t=1754043877; x=1754648677; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l899v5KgbbS1TnRf5Us24N+3xIdHFsSd1OZ1z0oPW9Y=;
        b=CfV+PkdA5U8fveTA/OsHX7oCZhLjitf4lC0XLaDImL8hXsJaklF7oHaZCPyublym+i
         L6czPg60kMbAR509XYh0/zciz/+GyUUNs7jRyT2AAFEDGjeSlhXWl3ViTpZNfbHG+D5v
         FyNfUeaJ+ODGHH7/c3/2Cq+sBz8sRrUK9keQBo8v6tg2AmKj3CMzpomfP4ce009jWj2a
         iHu2PPRQtx6fsR5ipGggvGLWl2rNCcXgkLkwmfjSkRIn+XU+TTv6c7caHgRg00ba3HTL
         /P251SOcq7LzarUishzwAMUWdAqRcR37VEc7g3vOu2CnAoPpGhFYv55PYOpKeGPfOYs1
         YTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754043877; x=1754648677;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l899v5KgbbS1TnRf5Us24N+3xIdHFsSd1OZ1z0oPW9Y=;
        b=Q19MTLZr6893hUb367gimDDSBuT86eTkC8ZwQaB284uEnhlmiQHaIsJ83ISnjl8D24
         Dp2iafY3T98VDalHHioBv5f5bnLtcISnr0FEj1erAAnC7v4N1j3vWkPpC0G6YJzsdffb
         gKSmI2r2A76IpLS2JPRt2V/2CdB668Ga+BPd8Kyg1bXma/g2EolpRAe6qhWY5eYseJVK
         vWfgvNLjkNMThQibWm1GqByLbWNXrU3pWcnJzhy3sEZZOt4gCnCfI1SpeYwn/G3Se2si
         T2vWnKBTYkyiLX2jCQK7KygVXDY6Wii/imKsHXVq+OjOmJo7mOVesWloANvqjvsnv+uf
         y8fw==
X-Gm-Message-State: AOJu0YyhpkePFzxMpO4m0nr8ZpLG0VOqu652B07xPA+/D+lGqZRtVEF8
	pv8T+2rmPx/Pson3Z4PGHXhAYwIjCqm/MHfytfdMUaYE9h2OKXpHKKSEpDLNUa6r+A==
X-Gm-Gg: ASbGncsfb4frY0LYetDHmr85xJMcL0tW7QQdu3jkF93tUqVtw20+kVAtUO2LOzzqt1W
	wEQ2/ld7nDPC2vY3MXekuYsFbs4iHd782GdruW9wli3heQgmzG0rbnAhJUBd0KJLRQ4sZ4bIVRH
	oPBh9LmgTkemar66yeIuHKNcrcNKOcT5x6lTsEGKKzLAonDPXBkt5RRCXrCeOx7DbsGE1ObX4sy
	S2ZL+9WVXzhzTpRdx6VhHy79OnjUXoTBQmxB/ULcjHx7fpGVLU+J8LjeViO5A6RR5AS0zpN0zj/
	jx5R5W2mwdM4IKIGGUGTlTMqN6+HZnbfby5nR3IHtsgwVsZxZ6WEyTh8oXX7aDX0DDZuKUavrzg
	8TUrC+4lAdP1rH6KBRXjuyX2qUOh8jobQQ2vx2HfyIixM1AQj3glnAnp25Wq78i3N7Vt65MkGAd
	YdzHRQbxifwW6bmYlHcg==
X-Google-Smtp-Source: AGHT+IEbOMyAyl5YGIEHsJ+1x733VPTg+/pMsQxs1CUQWvBc1YG6vLUIblsuT3TY3F/yOiCom5jRsQ==
X-Received: by 2002:a05:651c:506:b0:332:4528:c0e0 with SMTP id 38308e7fff4ca-3324528ccd6mr10571841fa.32.1754043872732;
        Fri, 01 Aug 2025 03:24:32 -0700 (PDT)
Received: from tunnel335574-pt.tunnel.tserv24.sto1.ipv6.he.net (tunnel335574-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:11::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238941e2esm5451661fa.81.2025.08.01.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:24:32 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:24:31 +0300 (EEST)
From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: [PATCH v2] meson: Tolerate errors from git ls-files
 --deduplicate
In-Reply-To: <aIyMuUZaARaTpmOh@pks.im>
Message-ID: <dff715f2-9d26-148-5046-6b7190b9414f@martin.st>
References: <69faab5-43d4-812c-90f-c518ff7f618@martin.st> <20250801075649.1796238-1-martin@martin.st> <aIyHoF70z0jV-sj8@pks.im> <226b2a31-6220-4a4e-d0bf-3ad80c3be9a@martin.st> <aIyMuUZaARaTpmOh@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1002994103-1754043872=:2936788"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1002994103-1754043872=:2936788
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 1 Aug 2025, Patrick Steinhardt wrote:

> On Fri, Aug 01, 2025 at 12:42:52PM +0300, Martin Storsjö wrote:
>> On Fri, 1 Aug 2025, Patrick Steinhardt wrote:
>>
>>> On Fri, Aug 01, 2025 at 10:56:22AM +0300, Martin Storsjö wrote:
>>>> index 9bc1826cb6..9b519e6eed 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -694,9 +694,12 @@ third_party_excludes = [
>>>>
>>>>  headers_to_check = []
>>>>  if git.found() and fs.exists(meson.project_source_root() / '.git')
>>>> -  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
>>>> -    headers_to_check += header
>>>> -  endforeach
>>>> +  ls_headers = run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: false)
>>>> +  if ls_headers.returncode() == 0
>>>> +    foreach header : ls_headers.stdout().split()
>>>> +      headers_to_check += header
>>>> +    endforeach
>>>> +  endif
>>>>  endif
>>>
>>> Yup, this looks reasonable to me. We could have an `else` branch that
>>> warns about the command failing, for example like this:
>>>
>>>    warning("could not find headers: " + ls_headers.stderr())
>>
>> This would work - however the output from ls_headers.stderr() is fairly long
>> (if you try running e.g. "git ls-files --foobar", you'll get a 37 line
>> listing of potential options); it's rather distracting for what's otherwise
>> a fairly minor build configuration issue.
>>
>> Using ls_headers.stderr().split('\n')[0] works and just gets us this:
>>
>>     ../meson.build:703: WARNING: could not find headers: error: unknown option `deduplicate'
>>
>> However I wonder if it's worth it, or if it just makes the meson file
>> potentially more brittle? (E.g. what if split() returns an array of 0
>> elements? Not sure if that's possible though...)
>
> True. Maybe we can just not include stderr at all but say:
>
>    could not list headers, disabling static analysis targets
>
> That's probably sufficient.

Thanks, that sounds reasonable!

// Martin

--8323329-1002994103-1754043872=:2936788--
