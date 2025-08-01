Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7D1F4181
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041383; cv=none; b=TwrnBadQoiWiBEj4vzMmumyQ9SyKxvgaLEe20xtNGHsodRr3dHgLH31Z5kDRVApnYwoFxQ6YIMS5VVlxr9Q+X60kBy5ZP3n/s+CTnoyzxk9Kf6imGB4fdlqvzb/3zvR3bT7jxJwmH1XSwxHeXXAUklf3ZZrNcEApbSsUXLJLJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041383; c=relaxed/simple;
	bh=yxpDOj5X/B+sFeRYep9ZMZIgUMGIixdI59W3dlvtliE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i12XDO6LEcKR61urB9S3G7og3/7tNNEB3nejy3UitBtsGEzik4FsPdQbOCAyOwn6Gh8NkZrTDmLiBCj0TdGrhxv0ooEZtmjdh0FaYYZU/QnoHY1fnixVfALUdHedDAhoBOMOg951sQEgCD7Qqxr5gryOlDKMqv+NP5J7LAWpmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st; spf=pass smtp.mailfrom=martin.st; dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b=MlfRRzua; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b="MlfRRzua"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55b8bf653dfso902114e87.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martin-st.20230601.gappssmtp.com; s=20230601; t=1754041375; x=1754646175; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y31qKjIyTq55ys9jSXcB2/zAoMrOfWAaOtK8R3XQwY=;
        b=MlfRRzuaCBCWPw0qNucRvOuQr5gqydGtt8W24XWNSC5z2i9bSf0KXs3CmglagmeOAV
         GCFGYG86EdGHSPsaQmn3LQ+30NKne/eBOAE5cF7WqKNVYqy7q3i77YFrVIoeIeP3BP5f
         nM42dkviCkHLdnI6I67O2LdQSQickWgoVrkQZmlYu44fJMetzPp0NA4h8GbMKhnaz5Vq
         QHtLfyMDmZGrOfRJVPNKmRtvHiKiO8P9s+obXf7nxHzX7cHC5qCh3LXdZfXz3hB8gUmT
         UNkitVy5sIvinSra4iCIJTZ2kI6Ym+4XsczRBb3K/74GElLqG/0XEXh2gCgq+uhIiPKc
         WSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754041375; x=1754646175;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y31qKjIyTq55ys9jSXcB2/zAoMrOfWAaOtK8R3XQwY=;
        b=ruIKpDTp5XxYmA1Lp58TWQbtG7HhcTB7StFoyZb/SH5vcsFmtjDN7L3ouiZKRlmafH
         0cQKLhstovpvXjmFNA6sxSLBGJdiSp2eWQd/yDWcgm5qLPxYrEhGv8h1o2L/wFuJEFxg
         0ge+fV0Y9/eTCQdh4oYYGUzhQsILW0q//lBBuSH59wNWKsBEYNe6HTYbqAJx5Oz0zvJs
         xqpd/6Gf6jWxni/rZSQsWodNLINMol/ohSFmHGa4VW/AJ8E1zYcQq5hs6XsVCJqc4R2W
         1XTs+l/xeFPPVBuMA4m28tPga87pJagcNLPrXkTAuL+dSw6mrnpbcSN21k4BgS31xGP+
         5QZg==
X-Gm-Message-State: AOJu0Yxnwh5Gu8WZCOzMbbYJYwKRBa9l383fPwE8I1C/fL0eNiMg47ql
	j6Gf6oANnbMYrL1essPLLeiDZWvB9Keg5clmBkjokwHmixuxT8EL/fIzO4+/ziPOa2ebjyoJ4oW
	HwjvTuwF2
X-Gm-Gg: ASbGncshbUiwBss0HQ4A9Z1tX9QkG17swhQKJuW7BkCOFimtug4lhYWoHCZCNjE2t7z
	H5mzLQDoMWx8HiPQHqHLlp1lfEqrx7IaIG5LTyqCap1UOCUGfEI4bC1rhn/vsgBsLmJseCZY0ld
	8MOWVNbIO6G537aUzy+gj9jhMZOPGiRCl0zgFGlP4PzxdeMjuZxdqTyIRwN7sQMePT54sPEvzUH
	dUNkM8raj2b5MqK7o2Xlqfjy587tinITQJWedVn5g8sfESzFPGJN8duxfKfv1f6Hlc6akxxKktg
	oPg03+5JBTnmjXMVVBwmCatKydZ1TYFC2ZY3ADe6f2MKRxx1qUO2usJOA4tg1CNACZft/ugF/GS
	ySWsRu8mxA/7W8xYbfgKV4P9zVGLTrP/nu/XqPegw8lIlWZeU70RnxCYR8+JADJf+t54LPHFPvI
	G809J+zKDRIEJqwgeWWQ==
X-Google-Smtp-Source: AGHT+IFnqVWyudKwHj/lzfMTItTgoebocf9DSx4DMwki1ccTs0+8bAVx1ctDJmfhBpGwFXrIdj/eug==
X-Received: by 2002:a05:6512:3f14:b0:55a:301d:7df4 with SMTP id 2adb3069b0e04-55b7c03328emr3566406e87.21.1754041375375;
        Fri, 01 Aug 2025 02:42:55 -0700 (PDT)
Received: from tunnel335574-pt.tunnel.tserv24.sto1.ipv6.he.net (tunnel335574-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:11::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c990dbsm516085e87.104.2025.08.01.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:42:55 -0700 (PDT)
Date: Fri, 1 Aug 2025 12:42:52 +0300 (EEST)
From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: [PATCH v2] meson: Tolerate errors from git ls-files
 --deduplicate
In-Reply-To: <aIyHoF70z0jV-sj8@pks.im>
Message-ID: <226b2a31-6220-4a4e-d0bf-3ad80c3be9a@martin.st>
References: <69faab5-43d4-812c-90f-c518ff7f618@martin.st> <20250801075649.1796238-1-martin@martin.st> <aIyHoF70z0jV-sj8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1673102919-1754041374=:2936788"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1673102919-1754041374=:2936788
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 1 Aug 2025, Patrick Steinhardt wrote:

> On Fri, Aug 01, 2025 at 10:56:22AM +0300, Martin Storsjö wrote:
>> index 9bc1826cb6..9b519e6eed 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -694,9 +694,12 @@ third_party_excludes = [
>>
>>  headers_to_check = []
>>  if git.found() and fs.exists(meson.project_source_root() / '.git')
>> -  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
>> -    headers_to_check += header
>> -  endforeach
>> +  ls_headers = run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: false)
>> +  if ls_headers.returncode() == 0
>> +    foreach header : ls_headers.stdout().split()
>> +      headers_to_check += header
>> +    endforeach
>> +  endif
>>  endif
>
> Yup, this looks reasonable to me. We could have an `else` branch that
> warns about the command failing, for example like this:
>
>    warning("could not find headers: " + ls_headers.stderr())

This would work - however the output from ls_headers.stderr() is fairly 
long (if you try running e.g. "git ls-files --foobar", you'll get a 37 
line listing of potential options); it's rather distracting for what's 
otherwise a fairly minor build configuration issue.

Using ls_headers.stderr().split('\n')[0] works and just gets us this:

     ../meson.build:703: WARNING: could not find headers: error: unknown option `deduplicate'

However I wonder if it's worth it, or if it just makes the meson file 
potentially more brittle? (E.g. what if split() returns an array of 0 
elements? Not sure if that's possible though...)

// Martin

--8323329-1673102919-1754041374=:2936788--
