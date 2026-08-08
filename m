Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B8416D17
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200958; cv=none; b=I543dyzVsj8uIS6DtTlWhGxtamlbOzMoSe3qsoBigzNGWSC/1gIzYyo74D4zen/o8onuQMwi9wScMclJdsHqkNR4w6HkJdK/4ygDLd21WkDxFvtbcFN0Oc0yWSmGouN4r+YjUopK+hcM+eWt8f5oyJgQ3zQ+sCIh/zKihg60Zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200958; c=relaxed/simple;
	bh=NaQ1yMZXnfuUqQTJaoGl/wfxre+TxQ/J9mtRO21luBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLH5NqlOzMQ5jfkc+MfYwt751Mh40zo2u+6YYHl2m09aidlDzC20sgw8/oG3izpEccUVOclDocaSIX9FrLgzSAtRtUB0QjTiiMNqENIqgI1edDYydplYqg93jYCz6Ied43a/jFEtHso05EaSQ7PhTc9J34Ivd7xy+5dp+Y0yQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=paqHcRVu; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paqHcRVu"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9087fb771d3so2121116d6.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786200956; x=1786805756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IzXA101kV4dfw4oL7R1WM4TKM0V9FzNZy8DJk44PSxE=;
        b=paqHcRVuPyLcHSsOzahh91o2WpHBZB8wTP4NqZC5LR/zf/MDo+xpA4qPylY6fi/UID
         8/xrFnmj3N9mQaABGhaL/emrh7JBdOvOXfRtV7uQdLuGFUwNMRheNMLOouwH5r5gcRff
         2XaIK87gf+lI3K1RyTod8gA3KItCWhrknG5fW4h4ohhDu3yWhxOvIm69FPP1ZpQdOW/F
         3rtrecA5lZ4K7EDA0am57DzPWGmMTblX3YJW/tgXr6aen10k56Cmn7RdRrrGxz2u1ELj
         1Q3AZE4tjc/Yi7STvGXGBns4P/w5t7ZNAPGOk8IP5DQ66PhjFZ7BS9IDEAdJolcEUBnK
         fM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786200956; x=1786805756;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IzXA101kV4dfw4oL7R1WM4TKM0V9FzNZy8DJk44PSxE=;
        b=EbdIMWe+uwBB4znrdZuh9QA4u2uhsIQEA+vOBCjPkO3V+qNKl35enaVw7hc9xfmtsU
         4klTkwPxpeQVqn+eMBcUP2eOEaJQk78ElYAHTuaySWUs7/NXHEYQ78oG0otnmdsAQuxp
         4aIlAcJMSlzjKHXXxp5yLLwKf5u/hraf5tUjyLNHN7APLbUAaHuuHOlXkXQUzBeExhHi
         GrGwJX5zXnkllVeKI9oshOmhFr3CAbnkXaQOYOjPZig03hVpnOm5fXb2LopsDFOg89s7
         YtAX6smJ326/+dGpWSZ6uvdJC7U9MNZz+nDXoNtQaIpGxrUa1WrfYT4vF68DYEAxoZCT
         ZIpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjkXb5G9FzGb81hyWSD/2Qup2mWr428gyO+tKpndmnJ0NuaKItryllFr5e5PJT+iWOl/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNlRdBLFOlRwZCwp2QLuqqxaA0fF/mh047+Ze5yRfMt2naMj8
	Dgky74yO2fbe9MNkPPUe1x2hKpbQOtl76cOdZetO3Wn06+5GebiKdCEI6nixdg==
X-Gm-Gg: AR+sD10EoEB20PXLPj2+/GXmT7FChwy25LH/z3B2puyh5HXVeFynJSlyeR0Xx4j0BGf
	okY29jQVIchuFsIVunmvY7jBhFh4no3w6bPjC0dLwHMBOlBuxz3cNz3gQesBKHyQdO9G9M0Fleh
	Vgnsk+6wOwRNOBfA1fuYxZgxV2VofIfIEqzVi1TS9xjr9is3s3QA9/fNGv7xs6XoIafKV8hEEXd
	uDr5o2E+xq90DHGzZBEj+3byidhIsPdygp2K/XqW/hFoqEC+jCKCUMaUTqWT9NDmIs+8iPyXgs7
	q3oQYszo7Z1rwSmWj31ttfN+N6d+Zbfl9u6s11r4LBWI8DDoCSnY94qbcqTdCr4d6VBeBgKoezf
	kXMmnaZzGWPSFqwAOvv4dOjsq22coTxT3FnjU/Fc4lpccd5ZVh1BjyJrZwjngY5LpSNCn9UUhoZ
	okGCl+BaMhMUrIDUQX3/dSfJTRz+5jChtO/ix3UoKlloIRoOMpfJNXrPCxMhrbWjkvgmWkIV60U
	rWlT/wKew2+NVvilCW/DJlR3NvqP9u1zztd
X-Received: by 2002:a05:6214:3012:b0:8f0:6a92:b90e with SMTP id 6a1803df08f44-90881381835mr344820076d6.25.1786200955891;
        Sat, 08 Aug 2026 07:55:55 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a934e2fasm31914746d6.46.2026.08.08.07.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 07:55:55 -0700 (PDT)
Message-ID: <433a3e74-c66e-40a3-9971-c8cb9692967d@gmail.com>
Date: Sat, 8 Aug 2026 10:55:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] gitk: avoid constructing dialog titles from text
 pieces
To: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <1e1bcfaf5bbe66fac364d5b7d3a7ebdc5f37531c.1785998419.git.gitgitgadget@gmail.com>
 <f25e5fe8-cf6a-4d87-9c46-bf5b7490434d@gmail.com>
 <b1d397e1-ab2d-439e-ba45-0ade2c216afa@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <b1d397e1-ab2d-439e-ba45-0ade2c216afa@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/8/26 6:00 AM, Johannes Sixt wrote:
> Am 07.08.26 um 16:37 schrieb mark:
>> This with the prior patch should help translation due to use of more common idioms and
>> complete phrases rather than jargon. Good.
> "Complete phrases" and "jargon" are words I need for the commit
> messages! Thank you :-)
>
> Now, with a fresh eye, I see that we have text like this:
>
> 	Diff: old lines background
>
> This looks more like an assemblement of words and jargon than a phrase
> in natural language. Any suggestions for improvement? How about
>
> 	Background of old lines in diffs
>
> Sounds a bit clumsy.
>
> (In this case I prefer to say "diffs" rather than e.g. "patch text",
> because we are looking at differences between versions, "diffs", and not
> patches. Also, we already have "diff" in multiple other places in the UI.)
>
> -- Hannes
>

I'm ok with using "Diff" as a common identifier for this here. gitk is parsing commit
diffs from git, showing each hunk separately. I'd also rather not use patch. The UI
already shows "new version" and "old version", so using new lines and old lines is consistent.

But, one thing missing, hinted at by your suggestion "Background of ..." is that the clear
definition of what is being affected is poorly expressed. A complete description of each
item would require a paragraph, probably with an example image. Trying to compress into a
few words will always exploit context and presume some common language we expect a
git/gitk user to understand or be able to learn in context.

Maybe some extra words and categorization would help. Consider using a longer category
description to provide common information, for instance:

  -General Canvas Area
                           Background
       Marked Lines Background
                              Main Text
                        Selected Text
                              Link Text
    -Commit Differences
                          old line text
                        new line text
             -old line background
       etc.

etc, where the lines beginning with "-" are just separators and do not have an associated
color selection button.

Mark

Mark

