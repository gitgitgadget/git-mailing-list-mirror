Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE5346A1C
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401340; cv=none; b=fmZSA8oXyWmMY3TsM/Kxsjw3XpwcNSdc4JyUx6uqa5JED/s+j3myfRWq2ueE+jt2VL+j9tvDpYtj7mhQMr4yy5YtLnPXgFhv/15ObQHouWsGrw/XlmUF3hpwTklbqgiNf7odKpq61ZvnIXt9ZmGpq4M5V8LXfRNqt0XVqTUsK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401340; c=relaxed/simple;
	bh=iYllHKPcNhaj3DvalJgLicqcabqDo3inDneAxcGibyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okbBM3Qa6ydRTtI4X8uhOvRPEPVDqeBjD7QAt9aNuUmzOUbqOB194gQMskCJXwlhTkLo0gL3B4Qbl2snZpD+2msVBuMxaSAsNfMmHT6tTXUfoLbMHIjfnV16Vua2qyvTJrYBIJz8wCQSjXui2lvG/m2aBZMCZ2WEip5+7LEl8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTYExzBy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTYExzBy"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47dec32798aso9128383f8f.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784401325; x=1785006125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTxDCa1vE6jUbbFKmnlSEYF3J9xfhulrDekb52Iloco=;
        b=XTYExzBymAZcwEKrTZixH9nZcJc33B8+aF1tHmjjOeVKmncEnwI61DmY8dI3TbRXso
         v6uh24RLBRxKzg/6WDxEhT7Ux2jfcFREXgfx5gq+aZl+CYn/cQ+AFbp/BTNGRAUvYM5T
         kFFObpeJIsROCFycvC2r4eONdHS5ygXDfGQCdjhxhOx16Wzllh80x+99EfZGg8+XY6m8
         d+QfDi5Wwgeynrq1PxIB66YAhgdsrFKGO2MNpDxVq/P3g3wOYMPTsLCu62rOmkbnjLSH
         FzLT/NsmX0tvRWdAW6gR5SLZyNunET3ugBBYLZyxGSUoh2OjSksDI/h2Cn3pRS0lQod1
         Irtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784401325; x=1785006125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XTxDCa1vE6jUbbFKmnlSEYF3J9xfhulrDekb52Iloco=;
        b=Kb/hMtWKo4J8eFchtblFFckAKcvqm4X6JJjxjM1s+GNoSTN271CLbhTq3Y5Puuzlkj
         PMur6ty41yDx5Q6dVDg8TtJXlE0ltj6s8XJgTU7suCUkRP3IDFfV6vxDCYWH9T6scoKD
         zQnZynvkdRlex/FCjKrgFfxutt2XUyYu6CN6qBoN+Wurjb9oHPVU6tDi8ImVI55xRrMe
         ph5U++zPw4mgizRAr+CU/MMJoC7fvMmGqSBOJMf/61tXzFTx4QQIxX2aCNY/f/wpBUgs
         eE9jKZn9sDUQ87n1BnFXYxC75olqBc9ZBUppGIgcNU2/T9nTnKmyi7tZX1WQytueXBfg
         T0Vg==
X-Gm-Message-State: AOJu0YwLYnbMmEyFoKiQUGvqeOnntPNO5Q/zGfIKaAcgi3D+BTlMyvi4
	ZH4AULq2MkDKTpEhnopOJBQijOTHH7Xhj7GybBpMaoaFTLdWEuGTOFlo
X-Gm-Gg: AfdE7cn5fg8Ury0ID0tTGIotar8KSAucskkg+wx7AUbX8g/1cHz0vpcrZG2Dgjo181D
	VMo8vD9sDOprCT81Pkh+utnYXYNzXxKKhvhpaE/WWBybZTeFYNerrdQjDxA4llL0lsnpB4prn+I
	ZZO0cOhv386LkNQeEhwgsxWGOl+g57xnMv7jJ6MlcSdfV5qKx3Za9beKOywX6mvbYBBiyHLnc99
	aHWJi07J8AGljxYcJ7bpqczIAMcFInsOhPdoab1X0eVYH3W3QcWE9qeme5VL2lq4RRbxcARWSXR
	QS8SDt8ONFmxDlGXh1X1V2JGOoYWCEjgqW1CG9X5JEjfRqzn/+C9rJi3plmYuN1x+YKknsyVn0z
	UZqDxu3V675jlhbGoyewXMvzBAyrfn5HFxvT6mIBqdSxrOV1utZubYABXgt2i7Sj3XT7c27J6Kq
	Sh1WN0eVrJNNrAQp6VvvkagDOIaQzG
X-Received: by 2002:a5d:5d0a:0:b0:475:f0d1:eb6b with SMTP id ffacd0b85a97d-47f62343e6bmr9622521f8f.56.1784401325179;
        Sat, 18 Jul 2026 12:02:05 -0700 (PDT)
Received: from localhost (94-21-29-149.pool.digikabel.hu. [94.21.29.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e496ffsm14956794f8f.3.2026.07.18.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 12:02:04 -0700 (PDT)
Date: Sat, 18 Jul 2026 21:02:03 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, ps@pks.im,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v7 2/4] read-cache: pass 'repo' to 'ce_mode_from_stat()'
Message-ID: <alvNq8rXF/jofqUc@szeder.dev>
References: <20260716084941.1101918-1-cat@malon.dev>
 <20260717063559.1633567-1-cat@malon.dev>
 <20260717063559.1633567-3-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717063559.1633567-3-cat@malon.dev>

On Fri, Jul 17, 2026 at 02:35:57PM +0800, Tian Yuchen wrote:
> The ce_mode_from_stat() function is a performance-critical static
> inline helper in 'read-cache.h'. As we migrate configuration
> variables into the repository struct, this helper needs access
> to the repository context.
> 
> Update the signature of ce_mode_from_stat() to take a 'struct
> repository *' parameter, and update all callers to pass the
> appropriate repository instance.
> 
> To prepare for the overhead of replacing cheap global variable
> accesses with getter functions, the boolean expressions are
> reordered to evaluate 'S_ISREG(mode)' first.
> 
> While at it, add a comment for ce_mode_from_stat().
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---

> diff --git a/read-cache.h b/read-cache.h
> index 043da1f1aa..94b8d3e547 100644
> --- a/read-cache.h
> +++ b/read-cache.h
> @@ -4,15 +4,24 @@
>  #include "read-cache-ll.h"
>  #include "object.h"
>  #include "pathspec.h"
> +#include "environment.h"
>  
> -static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
> +/*
> + * Determine the appropriate index mode for a file based on its stat()
> + * information and the existing cache entry (if any).
> + *
> + * This function handles degradation for filesystems that lack
> + * symlink support or reliable executable bits.
> + */
> +static inline unsigned int ce_mode_from_stat(struct repository *repo,

This new parameter is not yet used in this function, which causes
compilation errors in all source files which include "read-cache.h"
when trying to build this commit using DEVELOPER=1, e.g.:

      CC pathspec.o
  In file included from pathspec.c:11:
  read-cache.h: In function ‘ce_mode_from_stat’:
  read-cache.h:16:65: error: unused parameter ‘repo’ [-Werror=unused-parameter]
     16 | static inline unsigned int ce_mode_from_stat(struct repository *repo,
        |                                              ~~~~~~~~~~~~~~~~~~~^~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2921: pathspec.o] Error 1
      CC preload-index.o
  In file included from preload-index.c:16:
  read-cache.h: In function ‘ce_mode_from_stat’:
  read-cache.h:16:65: error: unused parameter ‘repo’ [-Werror=unused-parameter]
     16 | static inline unsigned int ce_mode_from_stat(struct repository *repo,
        |                                              ~~~~~~~~~~~~~~~~~~~^~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2921: preload-index.o] Error 1
      CC read-cache.o
  In file included from read-cache.c:34:
  read-cache.h: In function ‘ce_mode_from_stat’:
  read-cache.h:16:65: error: unused parameter ‘repo’ [-Werror=unused-parameter]
     16 | static inline unsigned int ce_mode_from_stat(struct repository *repo,
        |                                              ~~~~~~~~~~~~~~~~~~~^~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2921: read-cache.o] Error 1

I think the new parameter should be marked as UNUSED in this patch,
and then the UNUSED should be dropped in the next, where you start
using the parameter.

> +					     const struct cache_entry *ce,
>  					     unsigned int mode)
>  {
>  	extern int trust_executable_bit, has_symlinks;
> -	if (!has_symlinks && S_ISREG(mode) &&
> +	if (S_ISREG(mode) && !has_symlinks &&
>  	    ce && S_ISLNK(ce->ce_mode))
>  		return ce->ce_mode;
> -	if (!trust_executable_bit && S_ISREG(mode)) {
> +	if (S_ISREG(mode) && !trust_executable_bit) {
>  		if (ce && S_ISREG(ce->ce_mode))
>  			return ce->ce_mode;
>  		return create_ce_mode(0666);
> -- 
> 2.43.0
> 
