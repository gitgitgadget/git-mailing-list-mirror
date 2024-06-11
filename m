Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D1417C7A9
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110678; cv=none; b=cig5B9bbKbQ3kDys/f0uREBf/i9eBeCX5h13syISo0yrUZTP3q+WE3tftRyWM2lSkJVS0xB1tPkEQtBMAkeP/UHmFPgZzLtMpwLFl/4WLNCfV+nL8M7EoZwSSVI8NIErhf+T4kxfXRWHF0ZqgUOPO9VOllokPfcAZpXYI9FRhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110678; c=relaxed/simple;
	bh=QDxpCnPaA3/4rezHvGhvlgJXFjxN4tzRzjsuqHritJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4KHqQVZYrGEaElLVD8braf6OSZ3ku+n6lEjGqy8dDaOWpEe46qGkPDZzyf5QqbsBNRpH2q1sg6CGxzRZzF3HmwDC36YNC3ZMtrovqjBwy343+pAIQbGISX1oR8JalL2+tk2pyRFAwj57RJpKZx0ZwHo+dNfda8sH2N6foCMVhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNGhsJJc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNGhsJJc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f692d6e990so52438565ad.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718110677; x=1718715477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VS9VEHRLO/WeKxzMzIrz1Tp94EmmZIuEL/sXdC78VWs=;
        b=GNGhsJJcG0MsXhUCJl1x4MrGF6oLQj+3zFKD/a7jEoGek1dOoK9jxe4jE1ze0NX/pE
         un3UQyxpfOGOUL929RPUFMGZ0FrMCqFlaL8hLoij5tSEQK6vaY6qK8jbFzCkgF6K/HHg
         PvQMMyoODq5q4TNgSGSuBZUcKwLUeyt8PQOdiIHLsw77RrDBCnkAbXm/lDwHy7b67y+s
         A+BEwGYaBTB2uh19djllNmWNWbvJJuikWomBfui7kI5dYQaAxyHR0ivdCO9pGiIaq55U
         kj4zu7cmXvK59d4A8Cn22bFDXlZhzFM296W2A+z4anq9goi1+/Z2ZQpkBS/80o6RRJFa
         nQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718110677; x=1718715477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS9VEHRLO/WeKxzMzIrz1Tp94EmmZIuEL/sXdC78VWs=;
        b=NH90o4kF2mfuaOjmqw8AJKwN1jg3bhLOji/nmQlvD41cqyKjq6f8H7txdMZtO/cGTr
         QqENUMLeSb17cnellvxc1Q8v4FBza1yYypvv92nmkcr8pvKAOMliGmAb2QZV3Pt9dJdp
         WCwKlIkpA4nVWF3YxNegZ7lj2cxuN2llpJohJ5hqaHDl/HgpX4knRsTjCX63UnVzxRDe
         H5ota3Tkz8gjgXTb06T9G4bQuZHTqD1dERqFBeMxAbitsLApFEZQVY5ien4rb30g3VL4
         oLdaekKg66LwVuucZqrgxc9OzLVMleZehtDH+pmvT0lVTprbSRF3xTwc44ea+NycKv98
         rYHQ==
X-Gm-Message-State: AOJu0YyQHMwLT7h6ZaGcH4wy8+8amWrjMGJXYNA1UCgx/Xc81dXNwuo7
	Nesf6Qrcs/tD+0p2b7LjNVaIL5sWpScwdsqV0LCdly9iMQBWxR1z
X-Google-Smtp-Source: AGHT+IEG7LKFh3IpcFQ9m+eeURG6FUMcaU/ua9TU/i91GKBzbhrllPV7EIteWu5Kgc57e0b4kLqrkQ==
X-Received: by 2002:a17:902:d4cc:b0:1f6:d368:7dd7 with SMTP id d9443c01a7336-1f6d36896ddmr150002855ad.45.1718110676588;
        Tue, 11 Jun 2024 05:57:56 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ee3f30e7sm65747875ad.173.2024.06.11.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:57:56 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:27:51 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 19/21] t/helper: remove dependency on `the_repository` in
 "oidtree"
Message-ID: <3xu573xqbhfb3epktusqdxujal5ibkapnngiyzonae7edhu24p@fdajnz4imrbf>
References: <cover.1718106284.git.ps@pks.im>
 <339d668da837ab5b4b11399ece4efaf5bc27d313.1718106285.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339d668da837ab5b4b11399ece4efaf5bc27d313.1718106285.git.ps@pks.im>

On Tue, 11 Jun 2024, Patrick Steinhardt <ps@pks.im> wrote:
> The "oidtree" test helper sets up a Git repository, but this is really
> only used such that `get_oid_hex()` can parse both SHA1 and SHA256
> object hashes. The `struct oidtree` interface itself does not care at
> all about the object hash of `the_repository`, and always asserts that
> inserted object IDs have their hash algorithm set.
> 
> Stop initializing the repository and instead use `get_oid_hex_any()` to
> parse object IDs for the "contains" action, like we already do when
> parsing the "insert" action.

I think the motive of this patch is already achieved in
'gt/unit-test-oidtree'[1], if this is to be merged after that.

Thanks.

[1]: https://github.com/git/git/commit/79d9e08db3a08c5a06e2633a39cd38b980e654f4
mailing list: https://lore.kernel.org/git/20240608165731.29467-1-shyamthakkar001@gmail.com/

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/helper/test-oidtree.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
> index c7a1d4c642..04ec24cc84 100644
> --- a/t/helper/test-oidtree.c
> +++ b/t/helper/test-oidtree.c
> @@ -1,7 +1,6 @@
>  #include "test-tool.h"
>  #include "hex.h"
>  #include "oidtree.h"
> -#include "setup.h"
>  #include "strbuf.h"
>  
>  static enum cb_next print_oid(const struct object_id *oid, void *data UNUSED)
> @@ -14,11 +13,9 @@ int cmd__oidtree(int argc UNUSED, const char **argv UNUSED)
>  {
>  	struct oidtree ot;
>  	struct strbuf line = STRBUF_INIT;
> -	int nongit_ok;
>  	int algo = GIT_HASH_UNKNOWN;
>  
>  	oidtree_init(&ot);
> -	setup_git_directory_gently(&nongit_ok);
>  
>  	while (strbuf_getline(&line, stdin) != EOF) {
>  		const char *arg;
> @@ -30,7 +27,7 @@ int cmd__oidtree(int argc UNUSED, const char **argv UNUSED)
>  			algo = oid.algo;
>  			oidtree_insert(&ot, &oid);
>  		} else if (skip_prefix(line.buf, "contains ", &arg)) {
> -			if (get_oid_hex(arg, &oid))
> +			if (get_oid_hex_any(arg, &oid) == GIT_HASH_UNKNOWN)
>  				die("contains not a hexadecimal oid: %s", arg);
>  			printf("%d\n", oidtree_contains(&ot, &oid));
>  		} else if (skip_prefix(line.buf, "each ", &arg)) {
> -- 
> 2.45.2.436.gcd77e87115.dirty
> 


