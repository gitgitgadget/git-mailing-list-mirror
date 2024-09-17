Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC1150990
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564365; cv=none; b=gcS/mWe3B4qp0PZr7lR97ZyEIadX30vpeHztlzCF2yU4if2MZnLVcRtqYuuJ61aiRD0prfbpOhlkiTEENjbpL3VaZ88I+pwvRksmgXFBr2FjPXMzjjf/rJncUeO+Kxcpr8D6E2R4DzD2KVJRCIeN45K5XYBowal1643H+/vFMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564365; c=relaxed/simple;
	bh=nleg41Uqpzaj03U/3l71beUQY52xcukMlmAnMz3tDNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRoTYSLB8cInG1KTaruGhDsrvqcE94RyWSaoyVyBmsOBrOS6lyZ0pd+1/VR9Cqg3V1STSO96qzK74hYrCLgcaU7zDJBVbEWxJ4HVhP7gvbEW/0X7Kr12NVYwFqV8ydk5mV9BXh1q8v+6Lzze/gqWIJ3tTY/qAHoIqBlrdkl0Ij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bNQZjYYE; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bNQZjYYE"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a08ca8d45aso23248135ab.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726564363; x=1727169163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1hOxJv6V8fha/DEKpc7T8uV/4WXP33HPD6taa7MdqA=;
        b=bNQZjYYE316uoSrO7UQQoKRpzE+SMzXQopVx6L0hcHB0FtI9awrfy2sKO/IwLD/7zz
         P4GVEHxso2rIpHiz1+yVgXkzS1cKLvJv1qTc1aBrmKoG7/5yI6aJZBzyi3w4VKQN4y3D
         jmX26cL/ZQneRRZh3dXHBWd1l+l1+O97iUThYd6Hc4vFghbkGhbpQSQ7jdf82gaSrDDW
         WxnHhgNrlnep1+jEuUh0B0rWK7fQXEJHHk5hzJQsZuOMHxojIV2203/7PmkAgAvO4FRH
         PRu8ZA02g5LRBh5p53ZoKyOKk6elDqImYjxw41swLj8daod8cv/SIwXAFJZvBHkLNNPd
         Avdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726564363; x=1727169163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1hOxJv6V8fha/DEKpc7T8uV/4WXP33HPD6taa7MdqA=;
        b=srjiDUn7m+93JdjyJpp56IHkBJi6w2eFKhJHQgu/eZVMG+J4G4VHOq07BOUi8vhJIv
         A1RHvQIp0UfiuGoVGm+/FgYxA0hxrUpM5UX2/D9z/Bz66IrWl0eTlUAF/OEoKAosmP5u
         01EW3nqWkpAjPkGFT11sMDhOT7Duz7Qo1h3Yq2hog7yFO5f/M9F1YpPWEQ2jicCWGfgR
         3mfErFeGbHZOuaMuP4XxZIiijMG5gsWStbcYf9oSg+XCechC4EGl6j+fOqH34mqynmUo
         g+rr7zAaEJOnRAn2tCPdCYn5hgC6eKlSPY3yoNZ4vmCeJI4AP60yPR5DIheYN3/1SI8V
         PYyQ==
X-Gm-Message-State: AOJu0Yyr2TJJ5hJz5HzoNaHu7hsVnb/xGhhIUpTZn0KMU9ANBaw3CIJX
	7gZzSZ/wQODDuj20Rnri0m2M42CHFBiCmkwMe3EiwNswBvJS8fHn9Jbdtj4FfjQ=
X-Google-Smtp-Source: AGHT+IGaKUFJrFoSPo6S+/Bia+xpJHMAUzT8phdnIkRQ6q6srZiklyoUpQYJ8FRT5Cf2eIe67P7Ptg==
X-Received: by 2002:a05:6e02:13ae:b0:3a0:b5d4:1fb7 with SMTP id e9e14a558f8ab-3a0b5d426d4mr738275ab.11.1726564363015;
        Tue, 17 Sep 2024 02:12:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e10605sm21261385ab.32.2024.09.17.02.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:12:42 -0700 (PDT)
Date: Tue, 17 Sep 2024 05:12:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/6] refs: properly apply exclude patterns to
 namespaced refs
Message-ID: <ZulIB7k18+4CzwZb@nand.local>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <7497166422ea702aabdf4159b0d7780f1422ba13.1726476401.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7497166422ea702aabdf4159b0d7780f1422ba13.1726476401.git.ps@pks.im>

On Mon, Sep 16, 2024 at 10:50:03AM +0200, Patrick Steinhardt wrote:
> This only surfaces when:
>
>   - A repository uses reference namespaces.
>
>   - "transfer.hideRefs" is active.
>
>   - The namespaced references are packed into the "packed-refs" file.
>
> None of our tests exercise this scenario, and thus we haven't ever hit
> it. While t5509 exercises both (1) and (2), it does not happen to hit
> (3). It is trivial to demonstrate the bug though by explicitly packing
> refs in the tests, and then we indeed surface the breakage.
>
> Fix this bug by prefixing exclude patterns with the namespace in the
> generic layer. The newly introduced function will be used outside of
> "refs.c" in the next patch, so we add a declaration to "refs.h".

Thanks for finding and fixing this bug!

> diff --git a/refs.c b/refs.c
> index ceb72d4bd74..b3a367ea12c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1517,6 +1517,19 @@ const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
>  	return hide_refs->v;
>  }
>
> +const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
> +					     const char *namespace,
> +					     struct strvec *out)
> +{
> +	if (!namespace || !*namespace || !exclude_patterns || !*exclude_patterns)
> +		return exclude_patterns;
> +
> +	for (size_t i = 0; exclude_patterns[i]; i++)
> +		strvec_pushf(out, "%s%s", namespace, exclude_patterns[i]);
> +
> +	return out->v;
> +}
> +

Is it safe to concatenate each exclude pattern with the specified
namespace? If I'm reading this correctly, I think we silently do the
wrong thing for exclude patterns that start with '^'.

I guess we reject such patterns in the hidden_refs_to_excludes()
function, but perhaps we wouldn't have to if this function stripped
those prefixes for us when the caller does or doesn't specify exclude
patterns with a '^'?

Thanks,
Taylor
