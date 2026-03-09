Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F7202C29
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070428; cv=none; b=h+PxrAjwwCvCiNsvYQ7XUZ1lOdAuMECIpZ+htZnzFJxGfUAaD26A7kZ/Qv2c/2l/eC3k1RLpyFGKecLnQEu5cwEjut7m4FxncefGm0cjKu4zPMwcHjkQd6HmFyvq3FUsNIUDV+U0Fq0ZIQZD5in1mT0LJSohQgYLB0aYpWpqsag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070428; c=relaxed/simple;
	bh=AIFpw5CuxpzlWclv8fujWivQyJ/cHcihdBZznS09US4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShOwV+FYaDk+efubv9YkNfNiKMkcbG85q80bwql6JJO32llwsxTtgYb2qF8flrk2iAaezH/Q1iJai3BLjvxOOGA0zZGW1o04Nvt9PdHk3mpJY4itIagMPoH+dm1we4+y867W/njMEH6HPK+Z3hjYOnpcbY43sLgg4CuKbXPlegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXJk36xq; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXJk36xq"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-466f935a82fso1114565b6e.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070426; x=1773675226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sK0vXA+gxyo4OstNP4zt4K9pEixrtLeNYZxIqMO2mHg=;
        b=SXJk36xq+v0broQSX/o4xqvhlMiootYnYlhUabXFFZ5d6ZvfadB8vR4jK7VFPJuelO
         juOhRiA4Q2P9jS6ZzCnAHsXIXc6RAS72QJjjFdrm+Vnb0zrsAHqjT5YiZEUkNV+/Np/b
         qQeN/wj3nUAk/x7wptuZ8Kr+AP219YFA5IrDqbXetj0kvtPNzsEXHcZr1gzLjXX4vt+4
         U3dSefHSNv8BF74hqIFwk3mhLcZE6CCi0bHu2/zxCEFG1wOQngTTwvFmlts3wH0Zo4RM
         PYOedkPxvnR42ZxqSrvVPR2wJPNdngPTKRqqqVFMq8xzattydgDxmPfx0evffTZ684rN
         hA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070426; x=1773675226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sK0vXA+gxyo4OstNP4zt4K9pEixrtLeNYZxIqMO2mHg=;
        b=KKSdc8MJ56TznFk5EJc4hMjbkHEF3Sitz8ZdzxNfvcNnMOZsvAZOylZ/ZdJixb032W
         iMAxsC3b0+gwW5xiCNUxYrtndjujAwGmQJKskEOoSO3cq0G8HyDFEa5ymH5Xj7kOzgd2
         Nvp51xsTK11zouQIKvvzUFDJ56/qjM44MyRtV1qiMnqxDapCRTFsa571yztGf86YgZWJ
         YhAQV/F06vwSfdrOt+ejA3Fv/sahJvWLqjWYnWdMr5iPUtH+6EyWq5v9xIiFOnfT1tXJ
         2c7v78Wz+IAM3trUi5xOvVz4AUlNvOAHTxgcwlFPV4J+QpdtEAVSSa4RhLdXKMX8BnYq
         t8Pw==
X-Gm-Message-State: AOJu0YznHPHQ66NDpPsILclAB7zcAtet4NH6WFEcE1H6lu0/1G1oyTvC
	sJy7LVZrG/snoAO99UTH0DsczDILCzKMwlXb87M+f4D7cO9pVw9jIzVVjBqjdA==
X-Gm-Gg: ATEYQzzVzpiak3sYesn9gC4XuWuoN9z9hU3wgg4HaGbX8rbYdu6rBhWJLP+65KEM+5Y
	QkP71n/Gh37ZOQYH+e42nRhyW4idCAZph/O9kfSqbUXaap6fS/cBbU9DfLCWb+07UeUc9qiK8OV
	rySelVdDYo0negSuwW0TiN5kDa6ajyw4fO/QSlY+ppEMUlTrosoIzifJuQBV8xVXsJZrk34dafb
	sSaFkDWVmkesSYSI0gNmOwCMYLx95wODen6SZO2kl1a5G3B7+JtzTF3arjSm5FmMLuU7R+q9NUU
	YgboPiwZWCHrfcm8qpIotQk2ExqS231shT69oyA+c4ZwPgeib3/zL9zh5aepnFYwDJptHb19aUk
	0ASxi0mlgbVxkl1XDcB0Rp5boNE+LVafxA1WDlWs+sGbzVeL8fCoId+aV20Feij0nIevrd71GD6
	4BZ2IeiXClcVdQHrKQ
X-Received: by 2002:a05:6808:11c5:b0:450:b249:718c with SMTP id 5614622812f47-466dcb46471mr5587745b6e.31.1773070426191;
        Mon, 09 Mar 2026 08:33:46 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfb14177sm5509096b6e.19.2026.03.09.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:33:45 -0700 (PDT)
Date: Mon, 9 Mar 2026 10:33:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] meson: simplify iconv-emits-BOM check
Message-ID: <aa7nk37z9VkaiEyt@denethor>
References: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
 <20260305-pks-gitlab-ci-macos-16-v1-1-ce8da0ff29c2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-pks-gitlab-ci-macos-16-v1-1-ce8da0ff29c2@pks.im>

On 26/03/05 12:20PM, Patrick Steinhardt wrote:
> Simplify the iconv-emits-BOM check that we have in Meson a bit by:
> 
>   - Dropping useless variables.
> 
>   - Casting the `inpos` pointer to `void *` instead of using a typedef
>     that depends on whether or not we use an old iconv library.
> 
> This overall condenses the code signficantly and makes it easier to
> follow.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 56 ++++++++++++++++++++------------------------------------
>  1 file changed, 20 insertions(+), 36 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 4b536e0124..ee3d9ced92 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1040,42 +1040,26 @@ if iconv.found()
>      have_old_iconv = true
>    endif
>  
> -  iconv_omits_bom_source = '''#
> -    #include <iconv.h>
> -
> -    int main(int argc, const char **argv)
> -    {
> -  '''
> -  if have_old_iconv
> -    iconv_omits_bom_source += '''
> -      typedef const char *iconv_ibp;
> -    '''
> -  else
> -    iconv_omits_bom_source += '''
> -      typedef char *iconv_ibp;
> -    '''
> -  endif
> -  iconv_omits_bom_source += '''
> -      int v;
> -      iconv_t conv;
> -      char in[] = "a"; iconv_ibp pin = in;
> -      char out[20] = ""; char *pout = out;
> -      size_t isz = sizeof in;
> -      size_t osz = sizeof out;
> -
> -      conv = iconv_open("UTF-16", "UTF-8");
> -      iconv(conv, &pin, &isz, &pout, &osz);
> -      iconv_close(conv);
> -      v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
> -      return v != 0xfe + 0xff;
> -    }
> -  '''
> -
> -  if meson.can_run_host_binaries() and compiler.run(iconv_omits_bom_source,
> -    dependencies: iconv,
> -    name: 'iconv omits BOM',
> -  ).returncode() != 0
> -    libgit_c_args += '-DICONV_OMITS_BOM'
> +  if meson.can_run_host_binaries()
> +    if compiler.run('''
> +      #include <iconv.h>
> +
> +      int main(int argc, const char **argv)
> +      {
> +        char in[] = "a", *inpos = in;
> +        char out[20] = "", *outpos = out;
> +        size_t insz = sizeof(in), outsz = sizeof(out);
> +        iconv_t conv = iconv_open("UTF-16", "UTF-8");
> +        iconv(conv, (void *) &inpos, &insz, &outpos, &outsz);

Ok, we are able to avoid the typedefs used for pin/inpos by simply
casting to void *. This does indeed simplify how the program is
constructed while remaining functionally the same. Looks good.

-Justin
