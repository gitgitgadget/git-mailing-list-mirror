Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99F3A9626
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076208; cv=none; b=uv0yx+HhYwmhmcIx+BglFzD3yL09f8DqLmn/Y+xyjWOFrmaTA856xy3zQipv82v7fBGd8gGMILFXtr5zbTbJpXa4uD5oRotLLXBLV/QAO64fgnQ8TnLD0LsLOUVUdc6I4GtvUidcYNaiziF9dj+zlqvMBX8bJZi2Aq3X6Tps4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076208; c=relaxed/simple;
	bh=VIVmjRSceM9CNKl0k0IebFDrOX0PI2cXpls6+dtXy1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OqLDQnvqaD6BlJ4bykfeEdOUF+9C2Rdz2ZRaX5VltIyKV7LFJkx/Bu2hCozS04XofevG286HyDL3xoUbBd+lNVKtMSCGfZw0QVFmyqFs4EZ5fhgaFVaqgGqSBjnLEcFysIU9F+VkNhpoJr2EbLt5GpFtvbcHeu5gzcYPgDeehZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jnghxqrh; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jnghxqrh"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c73c2244022so1838a12.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773076207; x=1773681007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiJ9fhuRdCjHwged6kX3b+25l7Ppjg0U0hl2MslPYGw=;
        b=JnghxqrhGxyVtLxO5E3WqHMhn7okGj+8WQWJd92gst2xOKxRdtM5yZuUl8KMkhG4Vu
         TYs4fCjKnO9jT/dTlRqGi/FH3SBZLYAIcCTovy8Xc0+LOdPZrHXgG/U6gQ/s5oW9Aq48
         SAUbl0AwQc24vT3bjVaAbuU4h0wg5ZrmTW+N3oHNddKgys9C0UkYShpzvbod/DVkuzPA
         3y7631YO94/DNkhDRrbfLIp5xgwhQ0AWd0o+xKbZytbf/aFXzuthsLM7TKZacfjq/shI
         EDPDHZSuh/mbsCfakwEfaxyypxgxZTGQjPufCEHHQrC1F5KaQtUugYyL4Xlr0MM8W6Iv
         +ZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076207; x=1773681007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiJ9fhuRdCjHwged6kX3b+25l7Ppjg0U0hl2MslPYGw=;
        b=iAoqwmRIt+kQVM0xO7D0Omsr8NoHHv/LrvWd7z0aOCvd9esQtteeNCp/WhK6WAobyk
         CK+p1euu2rThRpK+JPt6M0vLDaFsT2Q8bTlOpO96j3mF4wDk9vD0UDhuepgMocAcjXoX
         RxmQ81vPQT8gSWel5zSzr3PVCRTZxTxOP70CAQtbOaDIHVEnVEc4n3zWJKgSz5jPj2Ie
         i0g8ntX8ABq8Uc17LeHsOhcVjl4WjSGb/GK7UamKOxpxlrRrdw0RMQ4DpgbopunyaZLj
         ckTsARZHFHBNXR1NqNn60vuyC7NX2ZP5sOogwyTqlSWZ2yW5P1HLPtpSfmj4QiGLHcGw
         u52A==
X-Forwarded-Encrypted: i=1; AJvYcCVdTNj6tIx+Ba7/8E57cZIp1jA+nk1u8dKQXlp0wa7DBGG5CnszE0BVFsRRvbZRdKof8L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6MXzmFxtiVe8lGWeZUR3yCAZG7Z/npVg+lVJFAN1XcHNxuKJ
	hBIDd+EYbtQcFNjCtA8RzCi66cmX2pX1IZCLlw91oT+w/mXlzV4FRzXB
X-Gm-Gg: ATEYQzzmRYo4FnnRhpI++egXyT+lhnN+7R/lTk8GhTI1oTnp5I5sFaHFBBnzptjBkwU
	i8snpYp5+UnuBGIK7GndCVIBwBuVwr3KtgZuQm86GzHAoPwjpYtLxUMDD//qmENsdyO+0LNG6Yw
	iav7KvpBAg/l71cyCHVnUOBZbiNAN8lyB9xGwarbAX2z29M/8qOUcb01zY9QHB5eIQPLiI/CaVi
	bHB7eyPDi1gh3IA40RDSRQ3Wz0G/AC2FH4TkScJ9ixyZdqL1znMP6C2txkiQRJIEslccdBVbloY
	W9E+ybB/uKqcWmn8RuI9vt17z+BzuL3rhH5m2WK6y6bLg6bsWbowvX290vBo1y+JBypH/Kc1a/o
	TNVEvXaDgOnh5YAB7aNpeHy3rgPoBtq6ADxgWaX/T1Aeh21u7rcuInIPqHLxXaVSR6NFDN9b/x1
	0rQnsPdE/ak2do2gY1DikRypXqHqNGJYhjpR1Ak2BGO7TKm5RhBisSAGlBtmwE25LGW2V8oid5l
	e+AkBJEkjsm
X-Received: by 2002:a05:6a00:be6:b0:827:2648:94f0 with SMTP id d2e1a72fcca58-829a2f397e1mr5259959b3a.7.1773076206674;
        Mon, 09 Mar 2026 10:10:06 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d3871sm10981790b3a.60.2026.03.09.10.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:10:06 -0700 (PDT)
Message-ID: <8d0ca4db-3745-49fd-8373-2d3d71aeea78@gmail.com>
Date: Tue, 10 Mar 2026 01:10:01 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: An annoying "Bug" that we would probably leave as-is
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh5qswo45.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqh5qswo45.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio,

On 3/7/26 07:10, Junio C Hamano wrote:
> "git show -U" does not complain.  In an ideal world, it should say
> "-U wants a number", just like "git show -Unan" does.
> 
> Unfortunately t/t4013/ actually has tests that break if we start
> tightening the command line parser for this.
> 
> This falls into the "if it hurts, do not do it" category that
> somebody might be taking advantage of out there that we might be
> better off leaving them broken.

Out of curiosity, I applied your patch and ran t4013 to see exactly what 
would break. It turns out it's 'not ok 157 - git diff -U initial..side'.

The suite explicitly relies on 'git diff -U' (without a number) to
implicitly default to 3 lines of context, behaving identically to '-u'.
With your patch, it correctly but fatally throws 'error: --unified
expects a numerical value' instead of generating the diff, causing the
test to fail.

I looked at diff-context-options.adoc, and it says:

`-U<n>`::
`--unified=<n>`::
	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
	or 3 if the config option is unset.

I believe this description needs revision, as in actual practice (as you 
described), the number following '-U' is not strictly required.

(I was taken aback, especially when you mentioned “somebody might be 
taking advantage of out there.” It made me realize how an inadvertent 
little bug or minor error can become a daily habit for many people, or 
even foundations of millions of scripts. Just a thought. ;)

Regards,

Yuchen


