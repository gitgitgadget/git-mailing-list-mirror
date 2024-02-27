Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C852F70
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060805; cv=none; b=pP+OQF9NoCa23drC40KwRxFnLy9IawlH+odrtnr7Yp7BEeOnueVbyXp4Dz1DlHKfB0NGH9Lgk1yQ9JJn6OdL0uSzYXzDJTqhVEseThqkbQdggQ7pDEgzynzE+uI1C0V+fVoLcRqZHFOVURRx+B+QNOJ/cl5znWG+jraMrJUxx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060805; c=relaxed/simple;
	bh=fY1IKyZVLqT8Cds3K7CcbyclTv+/fIewATC7Prn/ggs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=fTh4bzoCbwM90BMTKL8UE5+546mzV5fhz68Zo/QsP3Cs98aT6sF2lp8rpJUBjRUJlDBjZ9CrWpVQQrPASNG+yAafEBE9qYmOzE4R/KHnHd6EiGPkkcCVGBslzxA6WXz8O/pW4LrZpfvDlT8Litz9U2ubXzbg1TJxGPCh7jFTsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wnf4NhLg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnf4NhLg"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so91969a12.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 11:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060803; x=1709665603; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPodJc4JsOmY4UD3vbd+sTo7slBzdmEUOJrj+d7b00c=;
        b=Wnf4NhLgl/n7XLFL5Fwcm5Ixog/6CVQUZDqk3D0mmnpA7uko2JI8QJM8aI9/s26Njl
         S+qOHTWtFxkFjSofwIKB4S2PoDzKEVl+B8GA3D99EErtPFErf1YybfLoi1tNUseZeS57
         zlInteF/AZRCvABpZH36cwlNC7P7gpTf5jFBhRIfW1mTtkmuTF+2HV+/lzm9FKSoBF7h
         JJdI5YOyE0mNITRO69dqI/4RyMhdSBJaYx/SSDY1Snow9YLyyonMZKl4+W2EErXrY/qn
         5jcle7q7JqWQ9njpiZ/fqymJYNk43DYHoPJoO+ZvC1C2L7SLSLaHgbyd6Xy4HlBHGPtb
         qKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060803; x=1709665603;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PPodJc4JsOmY4UD3vbd+sTo7slBzdmEUOJrj+d7b00c=;
        b=jldztgah6G4f+jRyxfB2bf1+fwxCXcwuZ+YoFrjb3pNpfBqjD8R8CSstsZJ06XNCa9
         itVUeqxOzL1CHuyRYrUdCiUCTxtU2SQC2cq2cSuRTybMpQe3gkQgffbIr6cALbLn/QQz
         C07ZxC4falJ+7udCLSsQ6u4CP55EjP7086OjcHZQd9GsssT6+yNjKYDRpcdVcbmDO4VP
         R/INpy6FXyQ+W5OVZaSpHZSx7PT7/xyiNTrqAvR+N79iZt2fX1hFKcCR9MGgPrc6+Q+X
         En5jCgUcJ/Jl1BjX5fLkXbCYgHcen/YrZxwJ0ullMDTUIwgqMJElIJS7gH82vdJFp35r
         J34w==
X-Gm-Message-State: AOJu0Yz6w+39NcIC4RWTwJm29qyko4uCaFYVzHgVSQq9rcN1duXVXf4L
	MuIOfzQy3rJRYRRRgb0/b1ism/KW54NmTd0F2wRpX8D6bOO0SRbVJ2RMmI02cIk=
X-Google-Smtp-Source: AGHT+IFI31Ygp0OWpu9CVTesuzmKrDzevPvx8x9pYaGPVhNpn4q/5dEGUCHo1lRCg+/8L/cwIeHqOA==
X-Received: by 2002:a17:90b:1190:b0:299:4649:13cb with SMTP id gk16-20020a17090b119000b00299464913cbmr318925pjb.9.1709060802521;
        Tue, 27 Feb 2024 11:06:42 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id bb9-20020a17090b008900b002998dbcf570sm6764997pjb.8.2024.02.27.11.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 00:36:38 +0530
Message-Id: <CZG3HO25QLAG.3Q9V03SCO99HL@gmail.com>
To: "Sergius Nyah" <sergiusnyah@gmail.com>, <christian.couder@gmail.com>,
 <pk@pks.im>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] Subject: [GSOC][RFC PATCH 1/2] Add builtin patterns
 for JavaScript function detection in userdiff.
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
X-Mailer: aerc 0.15.2
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com> <20240227160253.104011-1-sergiusnyah@gmail.com> <20240227160253.104011-2-sergiusnyah@gmail.com>
In-Reply-To: <20240227160253.104011-2-sergiusnyah@gmail.com>

On Tue Feb 27, 2024 at 9:32 PM IST, Sergius Nyah wrote:
> [PATCH 1/2] Subject: [GSOC][RFC PATCH 1/2] Add builtin patterns for JavaS=
cript function detection in userdiff.

I think these prefixes somehow got added twice. In any case, this makes
it so that "Subject: [GSOC][RFC PATCH 1/2]" is part of the commit log,
which shoud not be. And the subject can be better written as:

    userdiff: add builtin patterns for Javascript

> This patch adds the regular expression for detecting JavaScript functions=
 and expressions in Git diffs. The pattern accurately identifies function d=
eclerations, expressions, and definitions inside blocks.

commit message should be wrapped at 72 characters.
> ---
>  userdiff.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index e399543823..12e31ff14d 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -1,7 +1,7 @@
>  #include "git-compat-util.h"
>  #include "config.h"
>  #include "userdiff.h"
> -#include "attr.h"
> +#include "attr.h"=20

This change adds trailing whitespace which is not desired.

>  #include "strbuf.h"
> =20
>  static struct userdiff_driver *drivers;
> @@ -183,6 +183,19 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=3D!]=3D"
>  	 "|--|\\+\\+|<<=3D?|>>>?=3D?|&&|\\|\\|"),
> +PATTERNS("javascript",
> +     /*=20
> +	  * Looks for lines that start with optional whitespace, followed=20
> +	  * by 'function'* and any characters (for function declarations),=20
> +      * or valid JavaScript identifiers, equals sign '=3D', 'function' k=
eyword
> +	  * and any characters (for function expressions).
> +      * Also considers functions defined inside blocks with '{...}'.
> +	  */=20
> +	 "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=3D[ \t]*funct=
ion[ \t]*.*|(\\{[ \t]*)?)\n",
> +     /* This pattern matches JavaScript identifiers */
> +     "[a-zA-Z_$][0-9a-zA-Z_$]*"
> +     "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"=20
> +     "|[-+*/<>%&^|=3D!:]=3D|--|\\+\\+|<<=3D?|>>=3D?|&&|\\|\\|"),=20

Majority of the lines above (including comment) have trailing whitespace.
Consider removing them. Also, tabs should be used for indentation instead
of spaces. (cf. Documentation/CodingGuidelines)

>  PATTERNS("kotlin",
>  	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
>  	 /* -- */
> @@ -192,7 +205,7 @@ PATTERNS("kotlin",
>  	 /* integers and floats */
>  	 "|[0-9][0-9_]*([.][0-9_]*)?([Ee][-+]?[0-9]+)?[fFlLuU]*"
>  	 /* floating point numbers beginning with decimal point */
> -	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
> +	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+ )?[fFlLuU]?"

This adds extra whitespace in the middle. Changes not related to the patch
topic should be avoided.

Also this was attempted before, see [1]. I think you can take some
inspiration and inputs from that also. Aside from that I think the
separate patch which adds tests for this can be squashed into this
one.

[1]:
https://lore.kernel.org/git/20220403132508.28196-1-a97410985new@gmail.com/

Thanks.
