Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD672C235E
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613642; cv=none; b=gsONOL+CzaPWN3k198voFSyPc250OFhwEZp6litRT2l9AGYUN/YHM7qvunlR5jD4mIYkOvoYY/xKKVmfaBiFk+QSG1rR8SZsdmM0as/ZO4hyrjfnUZLra1LalkMIRM0sXkHcIeZb4yEOv62R6/w9rbeokVMgibCQ7laeOaCL5oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613642; c=relaxed/simple;
	bh=r+KO/b9UEzT66kFE6budq6RDdMuSG2phuKjTiWkN9TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVC0UeNLOKfvmc9DS2QVmG3sTY7LFpff8HMgk5W/SoqH9IsRUWHrnGqbBubRC3mJBdBosj8BkOYln8zTSMbDvG9T3/RjvPH2lW+PTvJmIDXHU3RwzfpPQdkarRFzJSZB4S3zzZ61ipBsrB+srCjRUUdp4wkbpvf88gGtLWSnoqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA831YAg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA831YAg"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c1e4a9033abso12395747a12.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 03:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767613636; x=1768218436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u/vQzJdE0TO2sXBRzGiolQltscgdZ20/WO4dOFgyt0M=;
        b=mA831YAgrrhMCINyVbjuaaj0rneNdTuyrsk1TDzGaMME86kMriXB9m5xP0QE5qNbKV
         afMjnjOen0Pra06TILDWvPUSm1r83hRyXRjG3sc8fuC6Q63A4Hnk3X+CL9wCI1K/OHWK
         T3G6q+KcBUF3RboOqiXbNaj8wB7s3nzMhTxjJAad1/7lUhesr8qXf7uv2hZESYF4d7Hp
         AnNcHi1u9XzUQDbcUS/973Ugn0hYT/6rM6FTyAtv2/p9M0LuLKgzEaZzxedvWTabqJzP
         3x7hanBS9SkDznI88lsGMAq2/H6ovZtoD/FFyrqm7GNm2Iy/nZEVa6JVe/x52gYyCbLc
         kPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767613636; x=1768218436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/vQzJdE0TO2sXBRzGiolQltscgdZ20/WO4dOFgyt0M=;
        b=W86EPgA2uRgcvAHzkZ3pWWr09jAY8BjR7c3R/GI9jjEDoC/NbcDrDVyfmecumQdfKI
         r9iO+WAA3641gMrCJ2JwlqxN+lzk1nQx3Mdr9yi1K0wS9klcp8BPjhiePIuC9V9pOg0p
         T1yHl0Uyz1iraxFvjsZuEja3upYNnOnI6vYppgB7Wdii3AWt+TepIIrzjMFfmsh7NxQU
         bSvy34Tb6Q6gaA+7pGvXC1vdGPO+91Zzqb6KrnyD8TM42In5B5kZA0I5Ylu/4zmYxuHY
         Rwg0hAuiRerbPNVjKgb0Xihc6ipn4QH2/cwgA9gnsRzV3S/MpG1s9Eq+GVhlFhrPKmMv
         Uoxg==
X-Gm-Message-State: AOJu0YxGWZP2B1/A6kpV7pq5pYyWD09dJqJthX7Gv1viClextY6RWpTN
	wh7OTX4HHCcg1cD2Rr+LGiT6qmZxIzQGIxEf2Aell5DPrmMS39RBVPFht63FNKd18HqKN1sndfy
	+tNkiA06LSBUVDUcM2majJmHYeJ3SUwE4HPDCYF8=
X-Gm-Gg: AY/fxX4Ebi/NeVgTFfOpEe9CUcpbxczjulempOzLsLt0L0MHwqwsTQ6XitARNyDSiXs
	sGlPXaXGPIC1lEwvlAQelFathQqNOaAwEGukNhqpJeP542hVrGY92sUbLTIW4M7IT7QuL4aRgp6
	BBLeQEXH7GtXEBUuep0c6aqwwAqu0UzRrBpuqzQhEagI9tU89O9/iw4AQvXTYxSCZ9dYyBdRht1
	W7H2t3kiAz1vgiV+KAbaJCN+qBWljUeM+c5yYt53Tkc3s1mdXecZuI4edQnqQwPTnhZ5L40hctx
	wNvOk3iH9OqkX16/zkTCNZySaAEywhd8i6ZS41/k2Kagkg7P5W7d1IqbQEA=
X-Google-Smtp-Source: AGHT+IHfsC3qaQmM94hkb3rqlBrezqUpqus7hS8Yq1VxxV7SonpOxPyJXoExWGwxWqhm3W1peOBg0Hnxa3H8fJsuaj4=
X-Received: by 2002:a05:7301:2aaf:b0:2ae:506b:4b05 with SMTP id
 5a478bee46e88-2b05ec6f3c4mr28531263eec.27.1767613635431; Mon, 05 Jan 2026
 03:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229185737.2328-1-deveshigurgaon@gmail.com>
 <xmqqjyy2dvni.fsf@gitster.g> <CAG7UgEQeOJq0S87btjy8TT9as10bCAJWKEUTfNafa811iM8qwA@mail.gmail.com>
 <xmqqpl7ol55o.fsf@gitster.g>
In-Reply-To: <xmqqpl7ol55o.fsf@gitster.g>
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Mon, 5 Jan 2026 17:17:02 +0530
X-Gm-Features: AQt7F2rKsho0gxzygzEemRj8z_6llmopnFgUXtT8po9ZSY2JkSeY1E4HC_HR1q8
Message-ID: <CAG7UgES1AETfjyhCG2BSTrch+YgVSquJz193rDvpb3cKBfBEkg@mail.gmail.com>
Subject: Re: [PATCH] [GSoC] t5403: use test_path_is_file instead of test -f
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The open-coded four command sequence above is repeatedly used
> throughout this test script.  I find them quite ugly but more
> importantly, they have exactly the same downside as your patch is
> trying to correct---it is almost impossible to tell where the test
> failed and how from its output, because these "test" will simply
> fail silently.
>
I understand, this does reintroduce the same debuggability issue.

> If I were in your position, I'd probably:
>
>  (1) first declare a victory with the current patch.
>
Agreed, I will keep the current patch as is.

>  (2) as a separate series, on top of (1), prepare a patch that
>      replaces these "read old new flag, then check $old, $new, and
>      $flag" sequence with a helper function that can be called like
>      so:
>
>         check_post_checkout clone3/.git/post-checkout.args \
>                 "$(test_oid zero)" "$(git rev-parse HEAD"  1
>
>      Leave the implementation of check_post_checkout just like the
>      original, i.e., "read old new flag, and then test these three
>      things, failing silently".  The point of this step is not about
>      improving the tests; the point is to make it easier to improve
>      in the next step, without changing what the tests do.
>
>  (3) then update the implementation of check_post_checkout, with the
>      implementation of the post-checkout hook also updated to match,
>      so that the helper now looks like this:
>
>         check_post_checkout () {
>                 test "$#" = 4 || BUG "check_post_checkout takes 4 args"
>                 echo "old=$2 new=$3 flag=$4" >expect &&
>                 test_cmp expect "$1"
>         }
>
> Hmm?

I understand, I will follow up with a separate series along these lines.

Thanks,
Deveshi
