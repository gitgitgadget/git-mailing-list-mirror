Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7CB42AA3
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076934; cv=none; b=VEY9Omwed93nxv6DGjADPTcmrvEPSXZ7RVHNryIfdXac1GWJ0B50GDXizzYL8MGbwDYsUrvLDPO3i/h8ZGzcNf+ENq5q7CFceT9xhwQvKGkFPBxGgfcfQBiMeUuvHQ8JX2kZyqdKPj03HCYKJorv65/zSm9RFv3QGr0GUIMFCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076934; c=relaxed/simple;
	bh=ggZgMadSAKdh7usy07F6Sdg68leJAOzcc4LBCsehTJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IptBoSEL3hSB6+TTRxNoYP6MvYitilZTMDVog3GpjxeUEjvpGb2MZWvk3H8a8bSUm4fZLiZLfhC+A2Z1/LLZebqFDbUMD05pCMMQg6xeBDdwYn39t45cnB8fktzMMjmD2Bb/RaxzaKi7h3N/QA456GXokBZesp1dSvvsEJVu/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ7UNiJi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ7UNiJi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso41076345e9.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 07:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738076930; x=1738681730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C8bYkeSksXh2fh+NDH2VfdfeWG0urrPLKJOh53cZxJU=;
        b=DQ7UNiJi7+viJ0vn6fH64HHVri9upnhAG6onWXw/SE8anz+SFZhZsqNE73AI6ooJMN
         M/I/wQ5IokKOkmEAHUQ3YIk49nGjgdm+rutwCJyiLXgOnINrzWVPvn1OZHhPDB2L3Hzu
         Uw0MIvy4LaQJe1o8okVQzSY0uBcpJDMRB3ZjfexDjSifCsz/bypPupsE39gIpcs0cuwZ
         D/4lOSuJSF3n0NDQTvP6Y4lxt0eTf+8Jf+vuRD0mWVdXo+jL25BCuUUd9PNbB2H2Zi5t
         wNuJaa33Kuh9XfX5/T+yuhMH6rLm1nPjEyLfOGY0Zcvhdr3o+RtTAuI6EL7uTS247f8e
         P8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738076930; x=1738681730;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8bYkeSksXh2fh+NDH2VfdfeWG0urrPLKJOh53cZxJU=;
        b=fA42IyvQl291fdKCZyl2zQ7avCCl1o45bMgFpdjdHfPYqj9VWO/z+ZmZR2BA2bIC8r
         0iDnidhbb1jPKxdBYC8vDpVhwd4J4UPHdBUavqiDfLd1Wi6VdNsiJc9tPpjRuUJ+t6UU
         QcuXh5DZ0Eu/cXSuF85jvb34b6haDI+8uxGlXE34iQEJ6qxI67rnX6fR19+GuzNknooT
         y7Jxb7g/eYRUY2Wfir4BG77KpvtoHLQFIYMrd27DE/Bo8TEAN9JFP+PETPpaz3xlrjja
         wy20U6dioSblck6jWZ4fCBbrYoystZbDBuLhTco3LbzWGYKokHk01qfINEKP5iOYE59x
         6lTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLTg0lbgNKwpSpibneFcwos1ZV0Lqn3mbUlSSkJLxv0tO6YvWN1Psyb5XBKWdeLhCZa84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnobQ8UMl8YopS1vZvEhsay0yQkCAvh1gKdXfl8PdVQj55auj
	eOm8x6VeMoccbwwer9Iyk7P2NeM4viZciOOygnIzt7x3XRi+zFgg
X-Gm-Gg: ASbGncsFvtbku92nlWJeS+A2QhJ0+WQ+1XP5ZHYnD6xSbq+75tWfQdb5lirOH63MMXx
	upfhiotIBRIARK7f9/O5uVwTiGkNfE2Zqv7RKQ/FINWS84npKyWskiHR5l2xiLyHsT/gI1LWwqU
	e91i9VQwAaER9WJ1ROgRhwmZMwKlAr4cds0AfG9IaB5iWYPRnlEr3kJoF8BFskQpTzgqd+/uLLA
	y1E+w/BkNQC2iJK+r78EVtEj86wrATM6cj/+I5JOOuTbR6sx6sdb3WA8F/nXr4bsf4vOy2ywsEv
	ye7PZnQRqssSJDga0BxLWAWNZZnX84yTt9tO7Hprr3BghxhwzjeyXQzb0DIb2rUmpdeRmQ==
X-Google-Smtp-Source: AGHT+IGMt56KSdDWCB618RTcFcvUhOlMJu98j0S5NVMaDn4SDiA1cWvuchIC4kyPWrrn1r9apsEU4Q==
X-Received: by 2002:a05:600c:3114:b0:436:1aa6:b8ee with SMTP id 5b1f17b1804b1-438913bfe72mr432914205e9.2.1738076930017;
        Tue, 28 Jan 2025 07:08:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa3efsm174354555e9.2.2025.01.28.07.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 07:08:49 -0800 (PST)
Message-ID: <3559a70c-7ed3-41cd-a45f-390134218c52@gmail.com>
Date: Tue, 28 Jan 2025 15:08:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 2/4] libgit-sys: introduce Rust wrapper for libgit.a
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com,
 gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1738023208.git.steadmon@google.com>
 <f1502b85901d81889d86597f31eca40e1965d56f.1738023208.git.steadmon@google.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <f1502b85901d81889d86597f31eca40e1965d56f.1738023208.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/01/2025 00:19, Josh Steadmon wrote:
> Introduce libgit-sys, a Rust wrapper crate that allows Rust code to call
> functions in libgit.a. This initial patch defines build rules and an
> interface that exposes user agent string getter functions as a proof of
> concept. This library can be tested with `cargo test`. 

It's great to see some tests. This is looking good, I've left a couple 
of small comments below.

> +contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
> +	$(LD) -r $^ -o $@

This is a very long line and the ones below are pretty long - perhaps we 
could put the list of sources in a variable?

> +contrib/libgit-sys/hidden_symbol_export.o: contrib/libgit-sys/partial_symbol_export.o
> +	$(OBJCOPY) --localize-hidden $^ $@
> +
> +contrib/libgit-sys/libgitpub.a: contrib/libgit-sys/hidden_symbol_export.o
> +	$(AR) $(ARFLAGS) $@ $^
 > [...]
> diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
> new file mode 100644
> index 0000000000..cd1602206e
> --- /dev/null
> +++ b/contrib/libgit-sys/public_symbol_export.c
> @@ -0,0 +1,22 @@
> +/* Shim to publicly export Git symbols. These must be renamed so that the

Style: Multiline comments start with an empty "/*" so this should be

/*
  * Shim ...

> + * original symbols can be hidden. Renaming these with a "libgit_" prefix also
> + * avoids conflicts with other libraries such as libgit2.
> + */

Best Wishes

Phillip

> +#include "git-compat-util.h"
> +#include "contrib/libgit-sys/public_symbol_export.h"
> +#include "version.h"
> +
> +#pragma GCC visibility push(default)
> +
> +const char *libgit_user_agent(void)
> +{
> +	return git_user_agent();
> +}
> +
> +const char *libgit_user_agent_sanitized(void)
> +{
> +	return git_user_agent_sanitized();
> +}
> +
> +#pragma GCC visibility pop
> diff --git a/contrib/libgit-sys/public_symbol_export.h b/contrib/libgit-sys/public_symbol_export.h
> new file mode 100644
> index 0000000000..a3372f93fa
> --- /dev/null
> +++ b/contrib/libgit-sys/public_symbol_export.h
> @@ -0,0 +1,8 @@
> +#ifndef PUBLIC_SYMBOL_EXPORT_H
> +#define PUBLIC_SYMBOL_EXPORT_H
> +
> +const char *libgit_user_agent(void);
> +
> +const char *libgit_user_agent_sanitized(void);
> +
> +#endif /* PUBLIC_SYMBOL_EXPORT_H */
> diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
> new file mode 100644
> index 0000000000..d4853f3074
> --- /dev/null
> +++ b/contrib/libgit-sys/src/lib.rs
> @@ -0,0 +1,46 @@
> +#[cfg(has_std__ffi__c_char)]
> +use std::ffi::c_char;
> +
> +#[cfg(not(has_std__ffi__c_char))]
> +#[allow(non_camel_case_types)]
> +pub type c_char = i8;
> +
> +extern crate libz_sys;
> +
> +extern "C" {
> +    pub fn libgit_user_agent() -> *const c_char;
> +    pub fn libgit_user_agent_sanitized() -> *const c_char;
> +}
> +
> +#[cfg(test)]
> +mod tests {
> +    use std::ffi::CStr;
> +
> +    use super::*;
> +
> +    #[test]
> +    fn user_agent_starts_with_git() {
> +        let c_str = unsafe { CStr::from_ptr(libgit_user_agent()) };
> +        let agent = c_str
> +            .to_str()
> +            .expect("User agent contains invalid UTF-8 data");
> +        assert!(
> +            agent.starts_with("git/"),
> +            r#"Expected user agent to start with "git/", got: {}"#,
> +            agent
> +        );
> +    }
> +
> +    #[test]
> +    fn sanitized_user_agent_starts_with_git() {
> +        let c_str = unsafe { CStr::from_ptr(libgit_user_agent_sanitized()) };
> +        let agent = c_str
> +            .to_str()
> +            .expect("Sanitized user agent contains invalid UTF-8 data");
> +        assert!(
> +            agent.starts_with("git/"),
> +            r#"Expected user agent to start with "git/", got: {}"#,
> +            agent
> +        );
> +    }
> +}
> diff --git a/t/Makefile b/t/Makefile
> index daa5fcae86..53ba01c21b 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -177,3 +177,13 @@ perf:
>   
>   .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
>   	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
> +
> +.PHONY: libgit-sys-test
> +libgit-sys-test:
> +	$(QUIET)(\
> +		cd ../contrib/libgit-sys && \
> +		cargo test \
> +	)
> +ifdef INCLUDE_LIBGIT_RS
> +all:: libgit-sys-test
> +endif

