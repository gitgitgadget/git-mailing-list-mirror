Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D481991BF
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612174; cv=none; b=VESve3uVJxvWXNXzp9jjemwtQTNoslGLPzOi9ypQc8G9Ogpk6ENSjBaMBPJg5hF5ryb90/DcUYjgUCaCSKy/kqgJBYtX3KAJAsd6VMtV0Yzl8tTBsewTFVRpq/rooQx8z7ULkZji3D/L2aSUG+8gNGXgEOjhz1gDWBDDoO7Mz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612174; c=relaxed/simple;
	bh=RDW+JTm5RRxmnnLVd6grMwYxT2GKBeeqLeI3NKjxrUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7roW9dzWkT6v1/zhs18Tk1XJmIdNWh8hiWOiO3BAHe142e9+JoVeq18b+D7RMRxP16KKZU39qicz5X46O5/cHD9sWEIlX5DPaahRg9Qd/Dw4AsjkC2R/PNsLIlo5GrObfbz495FjJtuCEUsxDrpLet9WYfnc/i4s7merPBBO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amHEqUNy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amHEqUNy"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2056aa5cefcso75325ad.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726612171; x=1727216971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDA8aVwUL9JhgfFbaNRDE4jj/sVHAq6O00stj5AMgnk=;
        b=amHEqUNyPhFFELEhP6GZkJtyCd56ru7GCyMzZy4nCtXSmMDs8MNXltBsZ9g12dx0fh
         wtyKCdSmtMgIbKrW/rAe76OFCCLfMeWcjNEgwcUXmAkMxgEItsL+fBlNZgeWsWskMApT
         2HTuQj9n9jaItHBaUJBZAxJJ0NNFnH3GFCYXUhDddsHk0KPHyhcGcTtRZP+g8GbClqk8
         QrqoKJIcWJvN0ZkQNz9BHMOUP9kmjpJSz12P05y9M0x+9uldXtAEN0rba1YhbFIHSw6D
         2AmZlzSJhi+9BKsy5yi1VCD2penLE4LxD4hbHsFcteuqBkL/GJuB13LW0dihPJdv+eK0
         Tibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726612171; x=1727216971;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDA8aVwUL9JhgfFbaNRDE4jj/sVHAq6O00stj5AMgnk=;
        b=TVoKN/piqVXjDSZFPkU20FINGqEF6cDvh1WXIFuiKodGnaJVMgDly2TnEkqbIM8u29
         +eoGsdxI7tfMZhy9LKmcfUlwN8qo9f0f8O2IkKNs/oHftCD/Woqsd//7cUVof2pUTCtx
         TovzaGdpWMYeEKqG7wZijlz2ggXpIkfDjFxHzwitOIyNGTfX4VqcN02mTvUoG+ZqDzg7
         KRWMyNeD0lJAiEuoRjjYgOC9fCdDqpB1Wjg51WvB85+eurGlD2yDGUTEyqAgAfHoidz9
         /40ELN2L9a1r38fevs7sbQD6kDYidMjzaVGR07xI178mzlC2Qjl71c/YaZTe6KezhzzR
         w+5g==
X-Forwarded-Encrypted: i=1; AJvYcCUIfYL4E/yoc9a34dOSwsbjHasNmumsc5bllou+gDnVyTNEggHKF4OX8oQdiOUUoEiHE1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4sBfNNxFQKWSICASHeotdKXr9Qx6Ujqh23G0ipuCkJSYV/cK
	8tQhOYKFU2OxV/HR6b5yvJx6Ht8a+UbY1jnV2JDEOnwQNiHbXXdVO4519R4BoQ==
X-Google-Smtp-Source: AGHT+IFAbDUY0dUNI8aPzClE8LgC+35cbpAP9aw8MD5iF22xx1vSsGy2uBQrv2rZ56GJluzjwe8zwA==
X-Received: by 2002:a17:903:192:b0:1fb:19fb:a1f0 with SMTP id d9443c01a7336-208c252abf6mr1068585ad.4.1726612170911;
        Tue, 17 Sep 2024 15:29:30 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c551:a3ba:4741:7226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498f9e75sm5437439a12.26.2024.09.17.15.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 15:29:30 -0700 (PDT)
Date: Tue, 17 Sep 2024 15:29:25 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/6] libgit: add higher-level libgit crate
Message-ID: <honvpowfa6zze7p56pcefrzokjjawcc43du7vuxbdbjbv2vzlv@eskr2npegzxd>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org, phillip.wood@dunelm.org.uk
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-5-calvinwan@google.com>
 <xmqqv7z8tjd7.fsf@gitster.g>
 <xmqqcylcpnah.fsf@gitster.g>
 <CAFySSZBECCQafaLEv80WoK6SMovwC97-tf9gh_btPc+8OuP4NA@mail.gmail.com>
 <xmqqttene2ya.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttene2ya.fsf@gitster.g>

On 2024.09.10 12:14, Junio C Hamano wrote:
> Calvin Wan <calvinwan@google.com> writes:
> 
> > However, I agree that the public interface should pass the
> > compilation test and your approach does that -- will reroll with those
> > changes and I believe that we should also fix the build.rs so that
> > warnings also show up during cargo build.
> 
> Thanks.  I couldn't quite tell if *.c was supposed to be compilable
> into *.o directly (if not, then Makefile needs fixing), and I am OK,
> if the shim layer is only internally used, if the public.h defined
> all pointers as "void *".
> 
> I wasn't happy to cast "struct config_set *" between "struct
> libgit_config_set *" merely because one embeds the other without
> adding any other member.  If they have to be bit-for-bit identical,
> shouldn't we just use the real name of the struct everywhere?

We want to namespace types as well as functions, as Phillip pointed out
in 47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com.

Is there a reason why we need the shim struct from your
xmqqcylcpnah.fsf@gitster.g and can't just cast directly like so:

 contrib/libgit-rs/libgit-sys/public_symbol_export.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
index 07d6bfdd84..c96fa15ab6 100644
--- a/contrib/libgit-rs/libgit-sys/public_symbol_export.c
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
@@ -3,12 +3,13 @@
 // avoid conflicts with other libraries such as libgit2.

 #include "git-compat-util.h"
-#include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
 #include "common-init.h"
 #include "config.h"
 #include "setup.h"
 #include "version.h"

+#include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
+
 extern struct repository *the_repository;

 #pragma GCC visibility push(default)
@@ -35,32 +36,32 @@ int libgit_parse_maybe_bool(const char *val)

 struct libgit_config_set *libgit_configset_alloc(void)
 {
-       return git_configset_alloc();
+       return (struct libgit_config_set *) git_configset_alloc();
 }

 void libgit_configset_clear_and_free(struct libgit_config_set *cs)
 {
-       git_configset_clear_and_free(cs);
+       git_configset_clear_and_free((struct config_set *) cs);
 }

 void libgit_configset_init(struct libgit_config_set *cs)
 {
-       git_configset_init(cs);
+       git_configset_init((struct config_set *) cs);
 }

 int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
 {
-       return git_configset_add_file(cs, filename);
+       return git_configset_add_file((struct config_set *) cs, filename);
 }

 int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)
 {
-       return git_configset_get_int(cs, key, dest);
+       return git_configset_get_int((struct config_set *) cs, key, dest);
 }

 int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
 {
-       return git_configset_get_string(cs, key, dest);
+       return git_configset_get_string((struct config_set *) cs, key, dest);
 }

 const char *libgit_user_agent(void)
