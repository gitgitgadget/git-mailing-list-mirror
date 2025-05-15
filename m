Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300010FD
	for <git@vger.kernel.org>; Thu, 15 May 2025 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295307; cv=none; b=Hd0A2Vnnr3PdJcFgDTFwPi2u2a142LrMq/Dk6V5b61lL8CyXvrz3II22L9dAT9hGb5FEqBKGyp52BUATbikwiC7/JlYthuVx+S0sMZPTypNUjIuwcYFsbg8FXMPigwJWFde4suxRQ63YLNQrueiaevFmzOp+kOvZQl8vsaetvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295307; c=relaxed/simple;
	bh=GpyrqRZSuQmOps1MMHin5YxuWfwdme2zbI4Vxp3w68Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=q6p4aEiAtGojzyQqvzPswcxVQvQQwuahATP5XXtP7NextwciWj71tApbT85+Ng5vt2kYvvYXK6mZulGzaqMOjXMiMjfr4ydTVM3sCHQsc/rtvhKRoQcTEjc8+uc+r0SRe96+zE3axHPwYB9GZLgBTcH4QsBJsn7czSZmh7lxrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW3GAF63; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW3GAF63"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so501546241.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 00:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747295305; x=1747900105; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YraQdMFWHeM93IxYSLlGIFOIhmU8LrHqjJkdHzMaM20=;
        b=eW3GAF630zUxMe4Ki2BOkp4Ykm8FL4ugtjy5gnHEySBHRem5wt2qjJ4cRwQQrbNqez
         NI5+fAdaxkVeOjWUC/79Vl4WGxfUA/PUA1CZ8SAOzzYTCy0sLFqmXvwBHtDDjOtcpv2v
         lhbRSrZaiRH854Ic5supqjwwdKyPr649NDUT8ITqABy3EnNMxyR9u3qaCrx0sWOr38z+
         TNawPvWAZHnx6BsqGGVv1pzJPCWU5OrBB+ALHKeZk9H6qxQJ2pOgrebAKoTu83Bo8CJI
         gE4DtpKWJNFCBQaHLsSCHRzYgO6vXNq/7Mgp/ae3SyFrid9z5MQVykQupo6l+v929IYl
         2mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747295305; x=1747900105;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YraQdMFWHeM93IxYSLlGIFOIhmU8LrHqjJkdHzMaM20=;
        b=dXyBek3+TAkIU1Y4u+KTSfjvi+IspEQ8jIFMD0kGjY/a+NdAt6Vwx+H1Ajz2J6KCSD
         OiE5b4ASEqSYN9gLxATaDQ8XgEKGfkJhPHWnRoW/FsQqnuzVQuRdaMXkHLrHrAGGkbPp
         wvBTVTjxKF6z7qf2VBadLnkRKmOPdJwJVl1I8O8w+YC9vXPL4PbwomUFjA2bM40tc2tq
         kaBIpHhll/0uQiZeWMJkfIW1ygOi5X1BtPcgKHfdJNiIu/xwx0Aej9AN2u54PSQhiM8o
         ncKoXNhnPvuU3IqUEOqNyTIBFq7u9xCQaEHUgAR0nRKqDl/cS/xguEcyUpB0HD2iExRh
         yd/A==
X-Forwarded-Encrypted: i=1; AJvYcCVDnHolreGGj+aP1JNblE2dwDuxg3ZYqO89Q5lv9d4g8XQU6qU4gDhpwZVTBErEmB3JKK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Nj/4auL6vEfqPim9pKyaW8FAPKUl5BZs6Vgyw3dX6Fi1pOC+
	f/qDUieTSZPJ7d93fyQ3lmP+wXEE0xIUZBlFqLcefqR4v+w41BwGhc4Zufiscwwr9irelBT0nZy
	fqrKS7Fmp610dlK934+EqCX5q27CwV6/LklMU
X-Gm-Gg: ASbGncsGh7p3p5bRIA2XInzufSszlAnRTMkX0umRDBxgQi1ybzhxvzrxeDUl4XHjqQl
	NDaBkbnw6AHjo5uBLqVkkfSP2uvDZw+Ky2qfKvVmQYLlymdcePFRJaZCO2bqQ6quHHbgFAEEPZZ
	H6dhYhZqT8RqoOUlg5qAdicW+2ZdndId0=
X-Google-Smtp-Source: AGHT+IFvn6fmjmGrHawMuK+YmxYRv7E2FOPgR0kpOdThqgH405TpaRrOew2fXtkBee+7KCo96IjrdylOkTr0aWb1fOs=
X-Received: by 2002:a67:ea10:0:b0:4df:9d88:4803 with SMTP id
 ada2fe7eead31-4df9d884975mr188103137.3.1747295304801; Thu, 15 May 2025
 00:48:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 00:48:23 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 00:48:23 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250506-pks-meson-tap-v1-4-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im> <20250506-pks-meson-tap-v1-4-5aaab2942a4c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 May 2025 00:48:23 -0700
X-Gm-Features: AX0GCFvcQdXxvOZV9Cd1D11F4P6J1zp5hPabqyH88y_YSBRxbgpO8-QpAb6WW4M
Message-ID: <CAOLa=ZSxPtMQdb8Hne6-WMEd9gKwWUC5hnCUCAaS2FfifqZHHA@mail.gmail.com>
Subject: Re: [PATCH 4/4] meson: parse TAP output generated by our tests
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f60805063527e3f1"

--000000000000f60805063527e3f1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> By default, Meson only knows to pay respect to the exit code of tests to
> judge whether or not it ran successfully. This can be changed though by
> specifying the "protocol" parameter. Next to the default "exitcode"
> protocol, Meson also supports the "tap" output that our tests already
> know to generate.
>
> Unfortunately, the "tap" protocol was incompatible with `meson test
> --interactive` and caused a hang. We have upstreamed a fix [1] though,
> so with the recent release of Meson 1.8 that fix is finally out and we
> can start using the "tap" protocol when running with a recent-enough
> version of this build tool.
>
> With this change in place, Meson now properly detects how many subtests
> ran and whether test suites have been skipped:
>
>     ```
>     $ meson test t002*
>     ninja: Entering directory `/home/pks/Development/git/build'
>      1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
>      2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
>      3/10 t0029-core-unsetenvvars             SKIP            0.15s
>      4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
>      5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
>      6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
>      7/10 t0020-crlf                          OK              0.81s   36 subtests passed
>      8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
>      9/10 t0021-conversion                    OK              3.45s   38 subtests passed
>     10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed
>
>     Ok:                9
>     Fail:              0
>     Skipped:           1
>     ```
>
> [1]: https://github.com/mesonbuild/meson/pull/13980
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 94bd525dd7b..cd8df189d79 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2031,6 +2031,14 @@ if get_option('tests')
>      'timeout': 0,
>    }
>
> +  # The TAP protocol was already understood by previous versions of Meson, but
> +  # it was incompatible with the `meson test --interactive` flag.
> +  if meson.version().version_compare('>=1.8.0')
> +    test_kwargs += {
> +      'protocol': 'tap',
> +    }
> +  endif
> +
>

The change itself looks good. But I do have a question about this:

  $ meson -version
  1.8.99

  $ meson test --interactive t3206-range-diff
  ninja: Entering directory `/home/karthik/code/git/build'
  [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by
meson to set env)
  1/1 t3206-range-diff RUNNING
  >>> MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
MESON_TEST_ITERATION=1 MALLOC_PERTURB_=119
GIT_BUILD_DIR=/home/karthik/code/git/build
ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
/nix/store/xg75pc4yyfd5n2fimhb98ps910q5lm5n-bash-5.2p37/bin/sh
t3206-range-diff.sh
  ok 1 - setup
  ok 2 - simple A..B A..C (unmodified)
  ok 3 - simple B...C (unmodified)
  ok 4 - simple A B C (unmodified)
  ok 5 - simple A..B A..C (unmodified) with --abbrev
  ok 6 - A^! and A^-<n> (unmodified)
  ok 7 - A^{/..} is not mistaken for a range
  ok 8 - trivial reordering
  ok 9 - removed a commit
  ok 10 - added a commit
  ok 11 - new base, A B C
  ok 12 - new base, B...C
  ok 13 - changed commit
  ok 14 - changed commit with --no-patch diff option
  ok 15 - changed commit with --stat diff option
  ok 16 - changed commit with sm config
  ok 17 - renamed file
  ok 18 - file with mode only change
  ok 19 - file added and later removed
  ok 20 - no commits on one side
  ok 21 - changed message
  ok 22 - dual-coloring
  ok 23 - format-patch --range-diff=topic
  ok 24 - format-patch --range-diff=main..topic
  ok 25 - --range-diff implies --cover-letter for multi-patch series
  ok 26 - explicit --no-cover-letter defeats implied --cover-letter
  ok 27 - format-patch --range-diff as commentary
  ok 28 - format-patch --range-diff reroll-count with a non-integer
  ok 29 - format-patch --range-diff reroll-count with a integer
  ok 30 - format-patch --range-diff with v0
  ok 31 - range-diff overrides diff.noprefix internally
  ok 32 - basic with modified format.pretty with suffix
  ok 33 - basic with modified format.pretty without "commit "
  ok 34 - range-diff compares notes by default
  ok 35 - range-diff with --no-notes
  ok 36 - range-diff with multiple --notes
  ok 37 - range-diff with --notes=custom does not show default notes
  ok 38 - format-patch --range-diff does not compare notes by default
  ok 39 - format-patch --notes=custom --range-diff only compares custom notes
  ok 40 - format-patch --range-diff with --no-notes
  ok 41 - format-patch --range-diff with --notes
  ok 42 - format-patch --range-diff with format.notes config
  ok 43 - format-patch --range-diff with multiple notes
  ok 44 - --left-only/--right-only
  ok 45 - ranges with pathspecs
  ok 46 - submodule changes are shown irrespective of diff.submodule
  ok 47 - --diff-merges
  # passed all 47 test(s)
  1..47
  1/1 t3206-range-diff IGNORED         1.76s


  Ok:                0
  Fail:              0
  Ignored:           1


  $ meson test t3206-range-diff
  ninja: Entering directory `/home/karthik/code/git/build'
  [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by
meson to set env)
  1/1 t3206-range-diff        OK              1.70s   47 subtests passed

  Ok:                1
  Fail:              0

  Full log written to
  /home/karthik/code/git/build/meson-logs/testlog.txt

Shouldn't the '--interactive' flag also produce 'Ok: 1'. Instead it is
printing out 'Ignored: 1'. This is while I was testing on your series.
Seems to be fine on master.

>    subdir('t')
>  endif
>
>
> --
> 2.49.0.1045.g170613ef41.dirty

--000000000000f60805063527e3f1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d20982a30a7eca5b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbG5FUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUMxQy80cmVEMEZHYTVCa3NoSXpEZStvRmpVaXFnNQpLazVjMDR1NlNi
OGFqRzdwd1Z5ZElPSU9IUFdlam9KdldHU045b29tWDEvL0pDc01RN1FtZzFJMFBWd1BGQ1k3Ckdh
SU9Ta0NkdmRRZzlmUEMyMXNXVWZVWUFQYUFIcmQ0SEhoN0hMam9XWXl2UWw1UFVZMmZEZ0lYaGZ4
ZmNHanIKMjN2SDBmc0R0TUlHNmttQUZBeng1MmMyMmk5ckpKREhxczlxRmQ5Rnp4Rm0zMEdmV29O
cVBzdkw0SWNMVnVySwpaZ3Y1M3F2cVcxeU1SL0NDd08vTFNvNmMrd0V6YlVqbC9lU2ZzZDlSOVVz
OTVrS2RaNGZ6b3dmMHYrb3FVRFkrCmRQZ0NXeTRNSEZ6SDZTYWtJREtGYTlhc3dZVnFIUE9LR3BQ
a3QxbnpWM2Zxam5WNThLRTkzRzZGWVNlL2h5OVcKVUloR3B4MVFYS0t2TUpIbXk0R2VjSjdjNFE5
dEZ3am11ZkZoVzI5L0FkM3ZPb256SkdxcFJnbVJnekgzZGhKSApsMEFFMGxQMXowall4dlZwQVRC
Qm5PZWVOd0Fqb2laOGJNS0Q1WjdVeTRXdW82eHBEL0ZPZEg2a00vajROZmc3CjQvWHcwTk9XQTB6
cnRqN0k4K01xclZ1aER3RW54N0xvSE9wZGlXST0KPXFxM08KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f60805063527e3f1--
