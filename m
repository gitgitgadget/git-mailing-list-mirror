Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792183BC69C
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081045; cv=none; b=YDrQqOee4qgOgby1x8KRPN4L3X1MTd35YHNOJtExn2DyXUSxmx3vGQWYiuF4CrvcS0aU2WF3Cwd8CkWkwtNlDxPkX5QYOVYBOkvxXWNhB3/96lntrQ/boywSqrphmbkKhxn+eNoCc7/h6g3ngtsq3yqlW0N7pkiLyNcdMGioXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081045; c=relaxed/simple;
	bh=9tauSpgX4bR2fLlH4H1Cz8Z0D/vPSVJXQF/GHTMj8ME=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=oqgJJQXkOxf+Nnh3mhTjkBZFb/wUZXcb+H4zE9TTXf4uWqTGkB388Uq2VkfK9HK4iMUWmhaQls774ZwNOMd30LKOhCckoo5nBhcttpHY+HBY096azlutynZ2FOpXqWvuZoNmdEbYwFQTeQ3cJglCTt/3fhkcVv0RiSiqvLhbcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE4gQiIa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE4gQiIa"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c999f162c9aso1374078a12.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785081043; x=1785685843; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iviXX4nQyn2/qJZav8frE9N5O2n/Ap6LzStN1D9yim4=;
        b=nE4gQiIaJib8OxWaVvtQ3qpEJlfoPC1f/IzBm49UXrMHGCYwrUPo9EL/4EI18BemeY
         qzjnqEKz2PpcB4bC9+KKxDhKoUhn7iAFCdAto2eSFuMpBcX5sa0FB0PneXpKtMfTtMZv
         7MWsImxQUQZrwvT6TYNf9JHBLS4ZlkwREEwWX03/RnvWOZ4u4z79iVQLatsnfaP3lC7U
         34SR9E2f+EnH/7Ku4kS1RHSDlX3bhElSr0rT9p4i/LToLOHE5JVNeEva16Gj+KWBhNzX
         ZYN0OCNxmRY5z95ET59tfGm7DyvwkEfmy7jGFhl0zdlQ5mRqZEX8cyvmCMo+wsZD7GTo
         /NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785081043; x=1785685843;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iviXX4nQyn2/qJZav8frE9N5O2n/Ap6LzStN1D9yim4=;
        b=YtgjcX7JM4IbZuEsPUvn+BtYB9e4LN5njJyHFaDxPVWfcSomw7DcPaQEHgDkUkEg7+
         YYaA8MEsaOaPVnw1r6YhncKu/CMeWM9pNyHOxfaVx3xj1ku/0rpsMPc2G0Vvqueon576
         dmveoTI4kCgr56FGueaq99zVJYnLQHxep9DrCR7fGpQzlJay9/990TFgXLCgWSDYqBlE
         39DQfAtOqRV/vcrWfLhRfBhEr9U86B80mY+QTdYnbvOYoV8pGylYl7G5lh4Vsri94Yj6
         g84TDaQ5zmicthi1eV89yFOjm1JHmNoRFb3FzaPjKVn9MmSqFILPahCvoM9YL8ibjoOZ
         nn0w==
X-Forwarded-Encrypted: i=1; AHgh+RosaokCoJpN6AJ2HR2K1mU6t2rsQWnyYcwXhg9+XYaf+gN+Txt3EC+VdPWb5tx39z1n1jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdioxW47IT5naiytGWSf/VVnpmmoDXRd+xeZQEmVkAiZLgpU7
	93NcExqnDPC/7ByVIKkRp6CWx3ASfogMMcmD384XQ/A4bNqS8wvXTyH/
X-Gm-Gg: AR+sD12dbi8bL4OKiuufzOa0+aJsdRtNicLpCT1I+BdHqmExt3xbOMjkipxcvyp9Nci
	Ki9JXeYINPRrR6yukdIXXlSPbSXrbhOuzgZ53jMXAOsQfLhc2fdyzWjnpJzxkT2L+QFlREQw0EH
	Y78KIN2w1Q43K5CJeN1qGlRRE5eGs/QErPToCLuLMiQPHmGM9pJ7jAh6rxmGXFyYfH+KsAPg03v
	0jcc3DBDHWi8yd1K5k183ITbtqt/MUJU9uBJQpTPoAbwQZgbUTPnA2iBXm17wQ57ml4gcbF17+N
	LrDvjabh8oqCfHE+0vnzOQ8kT+XCy4oniPfrodirr3y5XPN+Qwj55dW3sHDe1RdEIj4ADNX2C4f
	Bdj2rSwIceNvF77TS/dLDhApBlR+jD5R3jtFUBAgINRVhKzO71J8IHZ2NJodvT6K2D3dRO9Cs4W
	8=
X-Received: by 2002:a05:6a21:700d:b0:3c3:8d86:9856 with SMTP id adf61e73a8af0-3c67dab1a1bmr5204443637.14.1785081042768;
        Sun, 26 Jul 2026 08:50:42 -0700 (PDT)
Received: from localhost ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13015052sm42666591c88.5.2026.07.26.08.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 08:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jul 2026 21:20:37 +0530
Message-Id: <DK8MEZUFXK0Q.RTW35IRY7R4@gmail.com>
Subject: Re: [PATCH] change utf8_strwidth() return type to size_t
From: "Hardik Kumar" <hardikxk@gmail.com>
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, "Hardik Kumar"
 <hardikxk@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260726123427.173877-1-hardikxk@gmail.com>
 <a85b5428-df17-447f-9d84-03fb433711a1@web.de>
In-Reply-To: <a85b5428-df17-447f-9d84-03fb433711a1@web.de>

On Sun Jul 26, 2026 at 7:11 PM IST, Ren=C3=A9 Scharfe wrote:
> On 7/26/26 2:34 PM, Hardik Kumar wrote:
>> The patch changes the return types of `utf8_strwidth()` and
>> `utf8_strnwidth()` to `size_t` (implementing a //TODO). Both functions
>> have been updated in the header file also.
>>=20
>> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
>> ---
>>  utf8.c | 13 ++++---------
>>  utf8.h |  4 ++--
>>  2 files changed, 6 insertions(+), 11 deletions(-)
>
> What about callers that still expect int?  Are they all safe without
> cast_size_t_to_int()?
>
The return type should be implicitly converted back to int for all the
locations its being called at. If implicit conversions are not
encouraged I could change the types of the variables at the call sites?

>>=20
>> diff --git a/utf8.c b/utf8.c
>> index 96460cc..1081573 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>> @@ -208,7 +208,7 @@ int utf8_width(const char **start, size_t *remainder=
_p)
>>   * string, assuming that the string is utf8.  Returns strlen() instead
>>   * if the string does not look like a valid utf8 string.
>>   */
>> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>>  {
>>  	const char *orig =3D string;
>>  	size_t width =3D 0;
>> @@ -225,15 +225,10 @@ int utf8_strnwidth(const char *string, size_t len,=
 int skip_ansi)
>>  		if (glyph_width > 0)
>>  			width +=3D glyph_width;
>>  	}
>> -
>> -	/*
>> -	 * TODO: fix the interface of this function and `utf8_strwidth()` to
>> -	 * return `size_t` instead of `int`.
>> -	 */
>> -	return cast_size_t_to_int(string ? width : len);
>> +	return (string) ? width : len;
>
> Nit: Why the parentheses around "string"?
>
Bad habit I'll drop them in v2. Makes it obvious we are expecting a bool
value here.

>>  }
>> =20
>> -int utf8_strwidth(const char *string)
>> +size_t utf8_strwidth(const char *string)
>>  {
>>  	return utf8_strnwidth(string, strlen(string), 0);
>>  }
>> @@ -821,7 +816,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_typ=
e position, unsigned int wid
>>  		       const char *s)
>>  {
>>  	size_t slen =3D strlen(s);
>> -	int display_len =3D utf8_strnwidth(s, slen, 0);
>> +	size_t display_len =3D utf8_strnwidth(s, slen, 0);
>>  	int utf8_compensation =3D slen - display_len;
>> =20
>>  	if (display_len >=3D width) {
>> diff --git a/utf8.h b/utf8.h
>> index cf8ecb0..531e968 100644
>> --- a/utf8.h
>> +++ b/utf8.h
>> @@ -7,8 +7,8 @@ typedef unsigned int ucs_char_t;  /* assuming 32bit int =
*/
>> =20
>>  size_t display_mode_esc_sequence_len(const char *s);
>>  int utf8_width(const char **start, size_t *remainder_p);
>> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
>> -int utf8_strwidth(const char *string);
>> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi);
>> +size_t utf8_strwidth(const char *string);
>>  int is_utf8(const char *text);
>>  int is_encoding_utf8(const char *name);
>>  int same_encoding(const char *, const char *);
>>=20
>> base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca

