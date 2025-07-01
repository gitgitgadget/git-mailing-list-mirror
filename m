Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06218D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398324; cv=none; b=m9SuVJYPwsus28spjxT1hO4+zAtXo/SUAb4HGuXMRsDW7YgG2H6tltZr3I3dGRN6THEH7+c7XWfCGxUdoCof6hh2by0RXkG6wwM+qcx9n6nvZ7ThlNebQfl6UqHuKmJ3CrBH2cPjHhkujeejbgTkaPFp7QfAveV0sIrw8FEIj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398324; c=relaxed/simple;
	bh=arQzGJELFjmn5szHwUoSmjnRVX9OgbcrFLiX8K+BgB8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tHe4vj0wTouHi5PWBjx2IvcAGU1Atyfj189+x4bTaXhIqgOED5uRfT1yWL8gQdqfBaKwG2m+j4eNuJAWUimn3HmlZP3d/NmlYhZ3Rvnl2mhiyX4vCkqZ5LAMPlppHPjyUb1/PmD/r6fhjdWf3hkrvJvYxshTE2i7hauCiZNMKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpRmXVSF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpRmXVSF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso6448765f8f.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 12:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751398321; x=1752003121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KjxIIQmVpIIhTwwgbwBxBfV+A4QmOHtPIMEYu/0DSek=;
        b=cpRmXVSFOdIMEbHdE+kwqTxcjHY5DbdTihO1UNzkeakW1+75D8HepRcRu5i81Bfvzk
         C0+mE30SpFc+N/6KqhxlkLiSy98x/liXvMeqaVUmMEG4Enzw3cNBKnJ8zKyNpxt+5Cfe
         91Bz4xc0a58nqEMg/Ua/B6Dh5b3GNie5kShqqa1tmrRvKJGwRgTgWHZyff1a4Vdz//gR
         1dCgzcrekR6RSyXhkHIH7Why3G8VNnkK7IuN5nOhARnZ/f+omCpiku/YdrWtcRiD6x9Z
         HzRqrAB2C8Gvn0pWWY6WGdt9v0+myuD5Rn3sXHAw81EDYMi0bfO7GaC/f/sP5Lbo+N+1
         GBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398321; x=1752003121;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjxIIQmVpIIhTwwgbwBxBfV+A4QmOHtPIMEYu/0DSek=;
        b=SrV1N1455iVfAUeVbOFx8o4va3pRT7qnKJojYjJ7JwUtQ1J77QR+YrvG6JROIayKrp
         2LdJhDzrTjhAtF/0hLXiNSp9+o/Fi6ZQnUWon0Pxoe+nsG2bLe90YGycBMZe8uyS/7HK
         3HU7vcKaEpiv2gLd05fMUeWxjGmFoKRKfaCzmJBf62TTp16HRo2dm25iDvnjzXaBfT+y
         2fXoxCSTjIw+YtqY8JVqYsyQKI6qBnLqlvXewfCj59v414xC3KFtUzIUErZ/kxmo04ll
         HFKbhz44rWLDJUWbTu9wsZ8LO5mcBa8CDX9qmOQaSfoVVIUiw+6LImamlzJww6Gc951s
         GcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWTdXcHgSqYbxMR0BPGF1AJHdTTTW9Mi5CH+VmyR4iYoxc2SS11E4DmE7HN8O4wEJB2HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzztLRtVhB1MewUtNpJNVBZFH9OhE0F9Muf72ooS+5aie+bTPaU
	HXPUoszhSuNGItMjRJgkB7hd04maxytc4wK+qFntyVy64tO5WxWBMGHB
X-Gm-Gg: ASbGnct5JdOV/O2ldViAg9d3zOk6ewKYuOIRPolblSnFxDGXLgU28HcSqdQSHEQFuRc
	ZQjEDdcOW0j0vd1Ds9HlqG8GMrXYReXhAObbZvbJ5+wuTCy/tnTWH3NMkwus2unrcOd7UFdDLw/
	Mqw+qqIB3rOtZZKvSIpAD701lIEjVCFzETNRD2rZtAqvQlRoCTeHkK60I6NVBDmNbw/8ubl0MtU
	ifJYro77BaAYTht6rldrZnP6U1GegQ8Rw5JmjLt67fIffYoWkaf+s/2vA/y+0OG3FzMCns+pjQD
	OQR5OKEq/KsBrQRaG87ZUSk5qE+W0AAsdpG9DiKpqLgi41sziHShZQ3NVC9U4OuziBotj54nfgJ
	UG+nBfxBJiDZZ2ZQIkzpp4Wfys5/Bxx/IMkyRlg==
X-Google-Smtp-Source: AGHT+IFNKgCq97A9LMdPz2hTFkqFOuvNaHD4pLOIylU/j+ZR3Zmp/ntZBFVj3Z2A53rUv72LnIuWtw==
X-Received: by 2002:a05:6000:481c:b0:3a6:f2a7:d0bb with SMTP id ffacd0b85a97d-3a90d0d6cd6mr15767785f8f.12.1751398320518;
        Tue, 01 Jul 2025 12:32:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e528a9sm14307165f8f.60.2025.07.01.12.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:31:59 -0700 (PDT)
Message-ID: <9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com>
Date: Tue, 1 Jul 2025 20:31:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v3] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Ayush Chandekar <ayu.chandekar@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com,
 gitster@pobox.com
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250630182527.69167-1-ayu.chandekar@gmail.com>
 <f22e864e-669d-457c-838e-961bbc977c4b@gmail.com>
 <CAE7as+Z7GXMB4LJGwESK3Pj63ppfFMKDq-xw46YCELJ7E3p+DA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE7as+Z7GXMB4LJGwESK3Pj63ppfFMKDq-xw46YCELJ7E3p+DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ayush

On 01/07/2025 19:33, Ayush Chandekar wrote:
> On Tue, Jul 1, 2025 at 6:47 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> The changes here look good but I think we want to update the config
>> parsing as well so that comment_line_str is reset to '#' when
>> core.commentString=auto. We probably want to do that in its own commit.
> 
> maybe something like this?
> 
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -912,8 +912,10 @@ static int prepare_to_commit(const char
> *index_file, const char *prefix,
>          if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
>                  die_errno(_("could not write commit template"));
> 
> -       if (auto_comment_line_char)
> +       if (auto_comment_line_char){
> +               comment_line_str = "#";
>                  adjust_comment_line_char(&sb);
> +       }
>          strbuf_release(&sb);
> 
> or we can do it inside the `adjust_comment_line()` function.

We need to do it when we parse the config so that 
append_conflicts_comment() uses '#' as the comment char. See the 
(whitespace damaged) diff below

Thanks

Phillip

diff --git a/config.c b/config.c
index eb60c293ab3..bb75bdc65d3 100644
--- a/config.c
+++ b/config.c
@@ -1537,9 +1537,11 @@ static int git_default_core_config(const char 
*var, const char *value,
              !strcmp(var, "core.commentstring")) {
                  if (!value)
                          return config_error_nonbool(var);
-                else if (!strcasecmp(value, "auto"))
+                else if (!strcasecmp(value, "auto")) {
                          auto_comment_line_char = 1;
-                else if (value[0]) {
+                        FREE_AND_NULL(comment_line_str_to_free);
+                        comment_line_str = "#";
+                } else if (value[0]) {
                          if (strchr(value, '\n'))
                                  return error(_("%s cannot contain 
newline"), var);
                          comment_line_str = value;

