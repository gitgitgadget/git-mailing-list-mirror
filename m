Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266FF170855
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792155; cv=none; b=I7lbG87eWUX9bNOX1bKV2NcGesa7mM9P3p1J6/QUJCL5bfXWAoPgSSzEfwyoS13D4AW65iXEGsxY8kxI7qsbNWPeccxlB8wOFHznPgRGWnRkfUAm2aHOSkm0JMAQAoHESWN753T/TE433IlDjcc9VVqCyvoDAsjf1VgCdLzkvBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792155; c=relaxed/simple;
	bh=gpS3YwbzZ3FAHfg5PeNJToYrhm06JP+aIe2r2SMR6ps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jrIpRIQdusUoYXnU1voBuAMtNPHw4npskA124lVYZL9foitfxY3p7v/J52BOi9FjyBPjuHyAGjR/xsPEVm9yCzVVxJOqHLyTJ+jPcr+Dk9bDgynrHU1qgm02Vr0AXp+GmMVe16XTgf/ZPWEvn4pfJNv4arz12hIyln23hxv/Khw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIrXI4kD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIrXI4kD"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367b6e5ffbfso1169147f8f.0
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720792152; x=1721396952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/VqDb5+YKNWZHPqlgVVYiH7HRmIdi+2BOF4joKIPn0=;
        b=TIrXI4kDCdSz6qF/HW7sWMcSiSz/Jf6714jU2k2Li896da00RND5t706cQqxiwcjWs
         FWoVp6zJeL/jfemBlK4TjxM9S/++kMQeSthwwKYcWc3ndVhTaxtHD742j9VEHU95i2yd
         L0Vx8yRrbg1dXiqRRSo/hphEfEWPtOp8mRrxZyJjulmmy6oyz21StUfPu8H62wYrI1Ti
         8S125TfZjFpvtfhT3FhkhENR9N5G3m9retHHrCMBTkns+qQFCtoFXdipc2GVqT48nqeV
         MyODDYuhKCQgJFd218yNXRQBBwa384KBgdozCfUT40sRfuPBahMEEWWnRS4G7M/+qxOU
         WBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720792152; x=1721396952;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/VqDb5+YKNWZHPqlgVVYiH7HRmIdi+2BOF4joKIPn0=;
        b=unLAU0XnX0Ozw+P50VgUpksM5ZEfkhD7nLlN7osMatGCWalxXNvHiyqrxhHVT6zSHI
         5rXvt6wVfoHnEU2AnddjUTP4badyWZOpu38sN5Zwy0m+0DoCvOcsk+pC3TZ+LAJmEUm4
         QAoX+pI74p3axBygwUEHJLc0eQeXNAU5kHcKvgzq5sJAss1WuxfeZbSqA+jBZ1Bcizgq
         r+RKe4N+E343MtEa01O++XmeC8pOS7iUXvbXEoCgmxyTGzmEgkrtwelRbINu00+T5wnf
         X/aGBMxryVB56prCm5Q9+23klQ5UOM3xl5wCHshS7M7xy53Hz0fPIdwB2ko6ooJVHm4M
         AnXg==
X-Forwarded-Encrypted: i=1; AJvYcCXqqq8WBbYlrwlLzQo4hHmnL3XsG5IAxyUD0BEE6iV8cTZW+m+IOkNqQ3HmQ4iI5gjsGiBJ2a2J2XgU5MNbCZsdogfD
X-Gm-Message-State: AOJu0Yx4iTej3aePSUvAhE89b63K9pMOGE8q6xLtdaaOFj2ZGUaoUjfb
	wUAh4vofgEFzfJMSLWb4ZqXZNxqCRHyDM+0jATn6feh2xHP4aQqv
X-Google-Smtp-Source: AGHT+IEB+PjbBknlTnHREZUW5D+uBhY/g9YpCtrbKAfELyc4a7zUiA3xapIch4E269a5D3ZoVf+ahQ==
X-Received: by 2002:adf:cf11:0:b0:367:911b:ff6f with SMTP id ffacd0b85a97d-367cea73787mr7383502f8f.18.1720792152421;
        Fri, 12 Jul 2024 06:49:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0650sm10311280f8f.69.2024.07.12.06.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 06:49:11 -0700 (PDT)
Message-ID: <ba8c96ce-4249-4000-8efd-3db73cf10001@gmail.com>
Date: Fri, 12 Jul 2024 14:49:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/7] mingw(is_msys2_sh): handle forward slashes in the
 `sh.exe` path, too
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
 <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
 <f04cfd91bd9a3a462294ea9125e72b3e6bb64865.1720739496.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <f04cfd91bd9a3a462294ea9125e72b3e6bb64865.1720739496.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/07/2024 00:11, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Whether the full path to the MSYS2 Bash is specified using backslashes
> or forward slashes, in either case the command-line arguments need to be
> quoted in the MSYS2-specific manner instead of using regular Win32
> command-line quoting rules.
> 
> In preparation for `prepare_shell_cmd()` to use the full path to
> `sh.exe` (with forward slashes for consistency), let's teach the
> `is_msys2_sh()` function about this; Otherwise 5580.4 'clone with
> backslashed path' would fail once `prepare_shell_cmd()` uses the full
> path instead of merely `sh`.

Makes sense

> This patch relies on the just-introduced fix where `fspathcmp()` handles
> backslashes and forward slashes as equivalent on Windows.

That dependency isn't obvious from the patch but there is a call to 
fspathcmp() a couple of lines below the last context line.

Thanks

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   compat/mingw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 6097b8f9e60..29d3f09768c 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1546,7 +1546,7 @@ static int is_msys2_sh(const char *cmd)
>   		return ret;
>   	}
>   
> -	if (ends_with(cmd, "\\sh.exe")) {
> +	if (ends_with(cmd, "\\sh.exe") || ends_with(cmd, "/sh.exe")) {
>   		static char *sh;
>   
>   		if (!sh)
