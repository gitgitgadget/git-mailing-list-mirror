Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8585008C2
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418297; cv=none; b=EkEhtuYStSPW1jqer1oELTphSJtU6QVhX+UlfboKJNtwfjgGcgl1f7Mfwlss1pJ9yKMBNnc8isrOA9r59a6ZqScPehNZRIo9VL0NpDLhswI/keBUTeQ8UZJv0u8bSSoguvOw0isbK2/LpJ7o5aMTGj+OBocJMUhU7CkYYYPzvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418297; c=relaxed/simple;
	bh=ZXhDba0J2DEYWGl30O7YU1UmgR5JR6Lbk8V3aX66qIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZXe90I9T39RjPeglmYpC3J4D3/smrVu6Dx/CcqjhFeNVqi04Hb0odghXu9HkoLpinlJDL6Vsvhg0kmcfSj6bBbAO8jR41y+njjbV/7UaUHWHE/K/60OnouSnDMqKyDzJQ/jw75bVZX3ZntdBPU6VmkTHB2p6j2cDqxOblF+I48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdPOJls0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdPOJls0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dee593f18so1580471f8f.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792418292; x=1793023092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M21jaqlOYpnVmhCz0Ep3UFuWxcBbuCacpoVNWcecCNY=;
        b=VdPOJls09W+pqIyQaB2onY0rMgsGNXoRgXZrh39SZtolWO+8egOag6F2x8OWdaCpSH
         VyXefE1nV0inRnoteV4bCGhSENtz9ja1GSOEn425JOw0TIwu5bRcH5XzhoQfl8nrSGo0
         xiSyTbYLs8BDNpBc5ACLBVR8n2pgehBH+YEQPqQgGLU/Qjr3xs2PRT70X+A8AlkfmotM
         DhW+7w16GPBjgxgH4Wc3B3tXmxiZXebTMp0344PsgpJqnyJsrh3xtmtBrC57gBOXKFHn
         CDDK+NJxOSIknJa1v7Bp/7YqvhL+J+d5trZPz9twKSdhycrELIB85dmkSnMCA6RJ1Oz5
         5P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418292; x=1793023092;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M21jaqlOYpnVmhCz0Ep3UFuWxcBbuCacpoVNWcecCNY=;
        b=sO6N/sDxwHi0yQAgKQvspe2wjUsqHEfCQfprdlzh0GkoVbIR+h7Z76mCVqdgeKTaxo
         Hn+rkXVjvrrHJhBKrod+kOHCFwpEkYdgWHTHz+MOojUB89oujceytNG/pPQdtdr5DQWN
         52gvEwcsPzwLiPj+AIjG6MGyXL4I5TmWEU3UY589IIlFvS1Nm+yGYizGgO5JgluA2CIO
         mvJfI6Zhjr7U9w2pLjiW1k+MGVcpijlauhJ7V/QGybPb6jOpUOjcFIMZapMjSfn8aHqa
         r3PPGtfcHZVhkZFDfc5c4MAhvWOBA+oQazdDn5INCAngoAwStsRmF+6NA/XsrD4Oe5sO
         DKeA==
X-Forwarded-Encrypted: i=1; AKwUvBzOmX+fgPs5iiUbFT7XYkKvxN1XoR8A7OTNpwdwCh0IDdDtNrsCjWEfQIVtjSkSeElLN5Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXzhQNygEWE0QbpiiFwSJHIOfKWv4rYngUUrq6GWsWihBRD1d0
	vqin7knpNXpxKNteUSaEcAHa6nKdJ1kS+lfpBMkzydyQTNxtBCl5d9u1
X-Gm-Gg: AYBFou2smXTQ/Basb0mD4Q1P9IGiNvLNT9jRfhMiwqMHOV3PEdSCM5v+DLXa//TrdBr
	DG/QyDIM/5ZH8zjb2JXyOFNMbXjG9WMxMeLbXcBheWqQCCZRxJvIF5QzN6wPtG9bYf+mMsH8kv5
	q1HjWo4RzTZ+TYb+4v/TG1h7zwyD01fhRsoIgZZOudgIL1pHMIkK/9jL7rNdXiYnrDc58cZ3NuQ
	AdhmQLoPsrxHwRIwNE5Zn8FsqovzGYy1JqsZnFKswamC4bNj/rx3mwXGYIi78SUEvMYB/sW1fFj
	qbUZwa0Xo2dBRYwa444uL1NyvCP/xv9fMxkxUmT9FHrrOJVV93u8A0n9kyXtqKWMze3W225RoAU
	b6ox3+Rpqd7huSwb1JVSV5zPYTJSTY7nc+ilVk5i692xsAfVsOiPkWgOvG9siNIibHfSkunQG21
	q9+0niS7MTwgDlg2DPNMszd06FoaaSVT6tP9YW37KNbDWvFQihNmX/WVRh9+Y2YeRH7bsC1haI1
	3WsmkK5S0kNtCSuuG4U2ZvRgcf8BUx1hdRRfTG2hDdApjmV/Mfb
X-Received: by 2002:a05:6000:260d:b0:48c:7f18:c85e with SMTP id ffacd0b85a97d-48e07fabbb0mr16224795f8f.45.1792418292341;
        Mon, 19 Oct 2026 06:58:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c0894sm21337907f8f.12.2026.10.19.06.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:58:11 -0700 (PDT)
Message-ID: <96187a3b-411c-42bd-8979-fb45006daa34@gmail.com>
Date: Mon, 19 Oct 2026 14:58:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] archive-zip: refactor 'path too long' error message to
 use Q_()
To: kerylefondji7@gmail.com, git@vger.kernel.org
Cc: gitster@pobox.com, christiancouder@gmail.com, siddharthasthana31@gmail.com
References: <20261019084427.1879-1-kerylefondji7@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261019084427.1879-1-kerylefondji7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keryle

On 19/10/2026 09:44, kerylefondji7@gmail.com wrote:
> From: Keryle Fondji <kerylefondji7@gmail.com>
> 
> The error message used "chars" even when pathlen was 1.

Looking at the code below, pathlen has to be longer than 0xffff to 
trigger this message. However there can be more than one form of the 
plural string though. The gettext manual has the following example of 
the Polish translation of "file" for different numbers of files [1]

	1 plik
	2,3,4 pliki
	5-21 plików
	22-24 pliki
	25-31 plików

so using Q_() is correct, but we should explain that it is to 
accommodate different plural forms, rather than because pathlen can be 1.

Thanks

Phillip

[1] 
https://www.gnu.org/software/gettext/manual/gettext.html#Additional-functions-for-plural-forms

> 
> Replace _() with Q_() to handle both singular and plural forms
> correctly depending on the value of pathlen.
> 
> Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
> ---
>   archive-zip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/archive-zip.c b/archive-zip.c
> index 6f73ca6d58..e4f8ef5a36 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -328,7 +328,7 @@ static int write_zip_entry(struct archiver_args *args,
>   	}
>   
>   	if (pathlen > 0xffff) {
> -		return error(_("path too long (%d chars, SHA1: %s): %s"),
> +		return error(Q_("path too long (%d char, SHA1: %s): %s", "path too long (%d chars, SHA1: %s): %s", pathlen),
>   				(int)pathlen, oid_to_hex(oid), path);
>   	}
>   

