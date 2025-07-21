Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3C288CBC
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108069; cv=none; b=eqPKz/HPVXwRQiVcTpkJAhA3lwuLwRS02drIO6164ZMrJ4aId3SO2pZwP589zZihjcw9xVByFvAULf8PCoXDh7cNZzFcv9bclbmycxIwJEEcf1KHBnrx+eKyQRYZHP5zdnOoVIjRQVj86GznJyTxVd0h3CkjBQGTOyKqqDWzHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108069; c=relaxed/simple;
	bh=Vpi3Iq+ZvhScQ1dgcrvfYbpZ14ED/qm5nccdQrTypj8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEfoJ77WkeNcVdKpwQy8/A9YV4f/bcJjJj9Y2BhSgNdf3+BO3HunioytC3YMDPX5lu6jbWiV0xaAknkmhBCn+Oo06pifovVhmH+gnzpN+Elex8yiLPfHDd0Uh7HQvPXIzNKA1DYB8d0psXRp6vCq7x7JI/obebNjKFQriPJ03uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox17xJYW; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox17xJYW"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87f161d450aso2321865241.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753108066; x=1753712866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KpGhitcFIZB23pM3OIFHBuQCGl91GWMM44z8QlJeFvQ=;
        b=Ox17xJYWJClaCKv7ZNWS32VpslwT3e6M6Dc3rAdocqpBpKTYD9e9VItTG3VnUqSQ58
         +J5nYCPcmwzds+CtZZOkx8djGYNslB874oOras4nTm96cmPSPx28tO3rTnEJhSHUv0Kd
         1TtkWcjKLnjB1VNPeUMS3on5Mdnnq7EcR7IIruQM49fbEnfEsou7kIhX1YYIxQgDGBfT
         8FIkhNbRAkw3Fi6gSXP5TU34Kujv028rej4sZC4WbF6et68RoEX443sooh7pU5as3v2z
         NmNSjemV2auirR+JebJJIMMbv75jaSinjdifntFPk6B/9yvTlgrRoJFI8IOUe4wK6rYP
         uS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108066; x=1753712866;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpGhitcFIZB23pM3OIFHBuQCGl91GWMM44z8QlJeFvQ=;
        b=on9nKESCO3clyMeecdp5/NQzK4Rj69fn6xAjmm0BloqiJrL/wXV5MEyYAmO89NeMhV
         8HMsNby/wh6u0OP7jIcBX5CLDlYlDdRDxCW7v3zJub4XYyS37DlxUGzlzbGXQnxs+gUV
         AlTrvdHJWArwwUYuiJ1+ovpRzUJmP/5tImWBeZwMrrHGHPZCahqXeHWtCryskVGdGPYl
         1aeL3v7a/qtRjsd+2mZKWtNOV+WizsN4/kUCn3fPunHo8+Ifwbr+m58Bg2YC66q4SFc4
         KCyLWQrohtmHETLSExsVq+Zhj8aYUsVy68ZkVgaBKpx5j+bs76S4Q72p3IKCFZrxWzAk
         sITA==
X-Forwarded-Encrypted: i=1; AJvYcCXV6itkBnevbStxEOHofqhl4jgHdvOAADjp3Pih9sfbw/flSGAT4v3lPaWMk3mN5Zcssng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8527EmfYj4aAYlqLht6dKh4J/b70/u4HvCRnO9OPjCKpOm4q
	8D8icnlmfFFfxMchgYJSbq6VOJNAa3UPBDU0hmiX9zy3IKRmUwJGzhSxiakhzXiu8jqOtGFRZ1G
	W9uV0oG82q7WUP5i0y7zt3580sJFnSY79ifBG
X-Gm-Gg: ASbGncsYBNA3nInbjHwUErFwV7hZB9+ZUPbObCIl+laUaturY1UqJVIkRFoLyVNkv/n
	qzgH3RZO3ogUI8pWA2p0X5jqPTwvk97QzxkY5Gzyoei8S+v6iotV44FwjVS/C/tRvN3DqNI56gg
	ucspD82RALzgt+8Jq1UiRlLYoZwvZiw5G1tz9VZ+aVcraCeRrU7NSMCNvDyC5hohFA2QDusnwrr
	cDm82IrVNBrRB7pyEyA/2ASZpXr/oHkSGL7I5eFM+DrWpRzsfGD
X-Google-Smtp-Source: AGHT+IExyp9Liqlo503+CzvmJG19TH9htF4AMW4OUImwCDIA4nVKEP+ZuZuvoRvKdX/dfW//UHWnX0Ofqu0pJgYYKSA=
X-Received: by 2002:a05:6122:923:b0:531:4041:c4c7 with SMTP id
 71dfb90a1353d-5373e2f322bmr8535378e0c.7.1753108066181; Mon, 21 Jul 2025
 07:27:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Jul 2025 14:27:45 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Jul 2025 14:27:45 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250717220929.GB2244266@coredump.intra.peff.net>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqple1gtyg.fsf@gitster.g> <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
 <20250717015402.GA2127425@coredump.intra.peff.net> <CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
 <CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
 <CAO_smVj4e0XOQyQr5sDyMZ8WPvqcBe2Y33DFHrED7C=VJnm4eg@mail.gmail.com> <20250717220929.GB2244266@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Jul 2025 14:27:45 +0000
X-Gm-Features: Ac12FXyc2NmZy_dOU13sd2VnIuZF982jivov2z-QcZXSyM7JfKsetWgA_dhSjVo
Message-ID: <CAOLa=ZR==xihNsZcNkFPtqb1JbC+EbMHtgF-RUzdwOQp55+MOw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via '--start-after'
To: Jeff King <peff@peff.net>, Kyle Lippincott <spectral@google.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	schwab@linux-m68k.org, phillip.wood123@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000089db7d063a714715"

--00000000000089db7d063a714715
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Thu, Jul 17, 2025 at 12:35:58PM -0700, Kyle Lippincott wrote:
>
>> > ==3275333==WARNING: MemorySanitizer: use-of-uninitialized-value
>> >     #0 0x557bd886f4bb in git_mkstemps_mode ../wrapper.c:487:27
>> >     #1 0x557bd886fb55 in git_mkstemp_mode ../wrapper.c:509:9
>> >     #2 0x557bd8100d1a in create_tmpfile ../object-file.c:736:7
>> >     #3 0x557bd80f1630 in start_loose_object_common ../object-file.c:781:7
>> >     #4 0x557bd80f5203 in write_loose_object ../object-file.c:881:7
>> >     #5 0x557bd80f4875 in write_object_file_flags ../object-file.c:1086:6
>> >     #6 0x557bd80f9f65 in write_object_file ../object-file.h:181:9
>> >     #7 0x557bd8101eb8 in index_mem ../object-file.c:1177:9
>> >     #8 0x557bd80f8bd5 in index_core ../object-file.c:1247:10
>> >     #9 0x557bd80f731d in index_fd ../object-file.c:1274:9
>> >     #10 0x557bd80f95e4 in index_path ../object-file.c:1295:7
>> >     #11 0x557bd831132d in add_to_index ../read-cache.c:771:7
>> >     #12 0x557bd8313cb1 in add_file_to_index ../read-cache.c:804:9
>> >     #13 0x557bd73f892c in add_files ../builtin/add.c:355:7
>> >     #14 0x557bd73f4752 in cmd_add ../builtin/add.c:578:18
>> >     #15 0x557bd7a38b6f in run_builtin ../git.c:480:11
>> >     #16 0x557bd7a31d54 in handle_builtin ../git.c:746:9
>> >     #17 0x557bd7a36644 in run_argv ../git.c:813:4
>> >     #18 0x557bd7a30e09 in cmd_main ../git.c:953:19
>> >     #19 0x557bd7a3ca01 in main ../common-main.c:9:11
>> >     #20 0x7f7e3f02a4d7 in __libc_start_call_main
>> > (/nix/store/g2jzxk3s7cnkhh8yq55l4fbvf639zy37-glibc-2.40-66/lib/libc.so.6+0x2a4d7)
>> > (BuildId: f117ee0f586dfa828cbdd08e37393c8f04f6480a)
>> >     #21 0x7f7e3f02a59a in __libc_start_main@GLIBC_2.2.5
>> > (/nix/store/g2jzxk3s7cnkhh8yq55l4fbvf639zy37-glibc-2.40-66/lib/libc.so.6+0x2a59a)
>> > (BuildId: f117ee0f586dfa828cbdd08e37393c8f04f6480a)
>> >     #22 0x557bd7352b34 in _start (git+0x5db34)
>> >
>> > Possibly something we need to look into cleaning up.
>>
>> I also saw those msan issues when trying `make
>> CFLAGS=-fsanitize=memory CC=clang`, but not with Google's internal
>> msan build. I don't know which variable in wrapper.c:487 it's
>> complaining about - you'd think it'd be `letters`, but if it's `v`,
>> then that potentially comes from OpenSSL or some other library, and
>> that library would also need to be built with msan (which is why it's
>> such a pain to get msan builds working - EVERY library needs to be
>> built with memory sanitizer).
>
> Yeah, presumably it is "v" from csprng_bytes(). If there are only a few
> such spots, we can manually "unpoison" memory coming from libraries. On
> my system, I didn't hit the case shown above but do have trouble with
> bytes coming back from zlib.
>
> Applying this ancient patch:
>
>   https://lore.kernel.org/git/20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net/
>
> and building with "make SANITIZE=memory CC=clang" let me run t6302 to
> completion, modulo the bug that started this thread (and which I
> confirmed goes away both with MSan and valgrind with the fix Karthik
> posted).
>
> Probably:
>
> diff --git a/wrapper.c b/wrapper.c
> index 2f00d2ac87..6a4c1c1c29 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -482,6 +482,8 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  		if (csprng_bytes(&v, sizeof(v), 0) < 0)
>  			return error_errno("unable to get random bytes for temporary file");
>
> +		msan_unpoison(&v, sizeof(v));
> +
>  		/* Fill in the random bits. */
>  		for (i = 0; i < num_x; i++) {
>  			filename_template[i] = letters[v % num_letters];
>
>
> on top of that would fix the problem you guys are seeing. I don't know
> if that path leads to insanity, though. Using MSan-enabled libraries is
> probably a better direction (should increase accuracy, and we don't have
> to carry these manual annotations around).
>

I wonder if an alternate is to use '-fsanitize-ignorelist', since the
MemorySanitizer is supposed to work with that too [1].

[1]: https://clang.llvm.org/docs/MemorySanitizer.html#ignorelist

> -Peff

--00000000000089db7d063a714715
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7dab5002a20d30b6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oK1RsOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVUwQy85N0ZoWUxrQVdkdHlEZS9qZlpSQytKQk9YWApFcnZSR2J5cXVJ
ZGlqM05GK0JGSGI4di9WS00vM0RRbDlTMXM3a0xLdERtRHFXSkNLQWRNRHErTTBKMkhyVkg2Citw
RDZPcGNYS1MrdVVhaDBnMURQd2UvSFZPYUFXNmlsenlDTEdDdEJOZTVkR0hhbUc0UHp6Und5angx
M2RmVlMKcTk1SitCNXU0Y2ZtampVa0JQeHI4TE5CcVZ4MENtaEVqNnVjdmpVWEdTd0k0VFZ4eVdO
ZmJwaVpHaDZIMzVveQpyMFJWaVRHY3ZoTWQrK0lMZk5LQnlEL0c3bkVTSkFRQ0EzMHcrWlhnN2Z2
SkFZVThOSW9YQi9PYm1oTEk1QjlRCmxxY3MrMWNOeEpDdG4vTS9JVllPaXNtVDV4dXhmTmdyMXFI
TVAxeCt5emtkZ1ZFMkJvMDhFQkF3M2dyVlVEc1YKU3pmQ3d3WjJNNWxZV214TGE1MThkeDF5NXlZ
OW50RE15UG9TWkJobzlLd3plR1JoTE1KSFVZTDJ6bERDdXlnYwo3OVZlSG1rbTluRm1FL0M0b21T
UXF5aFZ3V1JUVFd4U2MzMzY0dlExaDB3N3BwLzcyTlFZeXZDalpGTTV3QXZtCiszVDBuTDNWZElT
OFZnNDFJY0dUQ1VzWWRNVldXOXRrWmc0a2E2bz0KPStXRDAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000089db7d063a714715--
