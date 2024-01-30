Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D41552E0
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638458; cv=none; b=hITA2TYFddXlMM5w2Pq4zMn6NEes81o06hqkoHu7nnirnR3obUyjqatlQ3xIJZaqPAX8NlDH6hSdc+pvXxJTkp2Va7ovg02V3c6wrPb5jFC931mqkOQXDUGO8dIuFsZiHVj+ARt2pwM34lTQrc7tS1uSuzk/0BWPhSPGM4slRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638458; c=relaxed/simple;
	bh=INDcoqKUS7syylXpOYjh2fgu6Iuw6LmuWX4+Azx8Yc0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tgEz+2i9QgnPXlJZXH3+f+gOrjRQNBYLLPq/BQ4guIaDaqRJXYOvBLe/uqcrn3bRgkC697ku86wtuILTst9rkWNmDiUH0Ep3fKuYaM3k5J0+c/L0QI/ewa2d4buftz/6ZUUfKYyTIVRR16BoBEho6lCmFF/uKoq56pyNlTquoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJm/p04Z; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJm/p04Z"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5edfcba97e3so47117267b3.2
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638456; x=1707243256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aaPXdwpqKVH1JxVhINpJRl9zbbRowOO5NUDI2wy29pI=;
        b=lJm/p04ZgohvDAMUxJvrQDiPy98ytEjze7OUm1l429s8wU2njn8ObxreDwkR3JdHlo
         zM+qS2BaofWNMJtn7VK5g/UNc2GfaGMl/THlLH5WgBvFrFcqv0VBzoqe2DLvpgbFzpxa
         HNdXDTdW5Nq+/7SsRUdIgsErxHJrG1W76TMzJkZ1+8YToRf3fzhNfHEkWyztwBto8IcH
         QqSkH1RZkFfvB5M5RdGOf2jRbISYiAVu+zOzodt+FCkACeGIiayB9fbBWMClWFOPPA0/
         4UXPtRFIWCEkkiMOs2fXuXBuFpJHpKGyqyD95xWsM0elnF+LGhRfT8zBa4CwmlNneqhc
         6x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638456; x=1707243256;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaPXdwpqKVH1JxVhINpJRl9zbbRowOO5NUDI2wy29pI=;
        b=wT8rlXOJTiT3Qe7Sk9T6R4s+3ToGfVQfV7b6oW7rZMXmg9EwZFH8m/D+0RAFe47RtN
         CIjNtcEuKxfVuiPv07Vw6A6CNXD+JAmpFQDk4Vfvh+WDDEPPBhdfsaMwcUdfkC8yqB1h
         CfZafyZC7niv2qNvk7FHghj6leQ3Xu9vOpdmG+Zyd7lwKS0Wv8rJ3HPGRH4GWpNJDLTo
         qPc1kN5AwFFVYM2QBpLoEP0jwVfCcHHW8yetOxWmj0fT7toyVajDquOgbnt2wCzXMv6k
         qppHh/TTiL+cJBSt4n1/qkIevymD4BP89hin5PAaWMCl7HgYdgqEv0x0xeGYAggZyzmC
         xDeQ==
X-Gm-Message-State: AOJu0Yz1jk5sXA/L6ThDIg8OT+j6p1TRR4deDZ8lRWj0LSTWlAGQgQYY
	s7Tc0unh5JgtcdsY0/U3byJM5pYpIOMSrAHk+sHqE2mcjEcwqcE+fXIwGOGE
X-Google-Smtp-Source: AGHT+IHyoRjUkCg7JH+Shm+Jya20s4YqTYcrSBKFFLrIh/l0RzNmUTSrAAh78uX6rxxCq3xozTwNBQ==
X-Received: by 2002:a81:ae67:0:b0:5ff:a09d:b3d5 with SMTP id g39-20020a81ae67000000b005ffa09db3d5mr6849609ywk.45.1706638455895;
        Tue, 30 Jan 2024 10:14:15 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id g81-20020a0ddd54000000b005ff7cda85c5sm3309170ywe.69.2024.01.30.10.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 10:14:15 -0800 (PST)
Message-ID: <f3a84780-de59-421a-b4a7-2e33b4fd2d97@gmail.com>
Date: Tue, 30 Jan 2024 19:14:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: Re: [PATCH 1/4] t0080: mark as leak-free
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
 <4adfcba4-0f2b-44f5-a312-97f00f979435@gmail.com> <xmqqa5onhjm4.fsf@gitster.g>
 <c932fbfc-f14f-4403-bfc5-cf1d616b22de@gmail.com> <xmqqwmrrg0l6.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqwmrrg0l6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29-ene-2024 15:51:33, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >> The point of the t-basic tests is to ensure the lightweight unit
> >> test framework that requires nothing from Git behaves (and keeps
> >> behaving) sensibly.  The point of running t[0-9][0-9][0-9][0-9]
> >> tests under leak sanitizer is to exercise production Git code to
> >> catch leaks in Git code.
> >> 
> >> So it is not quite clear if we even want to run this t0080 under
> >> leak sanitizer to begin with.  t0080 is a relatively tiny test, but
> >> do we even want to spend leak sanitizer cycles on it?  I dunno.
> >
> > IIUC, that would imply building test-tool with a different set of flags
> > than Git, new artifacts ...  or running test-tool with some LSAN_OPTIONS
> > options, to disable it ...  or both ... or ...
> >
> > And that is assuming that with test-tool we won't catch a leak in Git
> > that we're not seeing in the other tests ...
> 
> But t0080 does not even run test-tool, does it?  The t-basic unit
> test is about testing the unit test framework and does not even
> trigger any of the half-libified Git code.  So I am not sure why
> you are bringing up test-tool into the picture.

Of course, test-tool has nothing to do here.  I think I got distracted
because:

  $ ( cd t; ./t0080-unit-test-output.sh )
  Bail out! You need to build test-tool; Run "make t/helper/test-tool" in the source (toplevel) directory

My reasoning was about t/unit-test/bin/t-basic (though also applies to
test-tool), due to:

  $ make SANITIZE=leak -n t/unit-tests/bin/t-basic 
  ...
  echo '   ' LINK t/unit-tests/bin/t-basic;cc   -g -O2 -Wall -I. \
  -DHAVE_SYSINFO -fsanitize=leak -fno-sanitize-recover=leak \
  -fno-omit-frame-pointer -DSUPPRESS_ANNOTATED_LEAKS -O0 \
  -DGIT_HOST_CPU="\"x86_64\"" -DHAVE_ALLOCA_H  -DUSE_CURL_FOR_IMAP_SEND \
  -DSUPPORTS_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES \
  -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 \
  -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"git-compat-util.h\"" \
  -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK \
  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME \
  -DHAVE_CLOCK_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM \
  '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"' -DFREAD_READS_DIRECTORIES \
  -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -o t/unit-tests/bin/t-basic   \
  t/unit-tests/t-basic.o t/unit-tests/test-lib.o common-main.o libgit.a \
  xdiff/lib.a reftable/libreftable.a libgit.a xdiff/lib.a \
  reftable/libreftable.a libgit.a -lz -lpthread -lrt

Note that we inject this flags:
  -fsanitize=leak -fno-sanitize-recover=leak -fno-omit-frame-pointer \
  -DSUPPRESS_ANNOTATED_LEAKS -O0

> 
> > Maybe this is tangential to this series but,  while a decision is being
> > made, annotating the test makes GIT_TEST_PASSING_SANITIZE_LEAK=check
> > pass, which is the objective in this series. 
> 
> One major reason why we want to set TEST_PASSES_SANITIZE_LEAK to
> true is because that way the marked test will be run under the leak
> sanitizer in the CI.
> 
> What do we expect to gain by running t0080, which is to run the
> t-basic unit test, under the leak sanitizer?  Unlike other
> t[0-9][0-9][0-9][0-9] tests that exercise Git production code, would
> we care about a new leak found in t-basic run from t0080 in the
> first place?
> 
> Annotating with TEST_PASSES_SANITIZE_LEAK is not a goal by itself.

Indeed.  It points to a horizon.

> Annotating the tests that we want to run under the sanitizer and see
> them passing with it is.

Maybe this is also a horizon (not reachable by definition), and
expecting "make test" to be leak-free (including t0080) a good path
towards that horizon, IMHO.  But you are right, those leak sanitizer
cycles may not be worth it.

> And obviously these tests that exercise
> Git production code are very good candidates for us to do so.  It is
> unclear if t0080 falls into the same category.  That is why I asked
> what we expect to gain by running it.
> 
> Thanks.

Thank you for bringing up a good question.

I see you queued this as 4/4.  OK.  I'll consider that if a re-roll for
this series is needed.
