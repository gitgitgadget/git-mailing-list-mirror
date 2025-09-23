Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594A1A294
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619299; cv=none; b=V0cN4nfcRNLFYCv/3hUQxzcN91mEnIVfP8mYnAznxNCBDPEkOfdgiKp33LkddshcVQQ+2ZBFeLde7wZgr/StCInl5lF9AgrA6WyoEFswrl47cMcvSbKzNuqoUyNWIZzPhz/9eOCjT6Wyq1uxaIbt4MR7D+OQJhuga+BY6C/ddoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619299; c=relaxed/simple;
	bh=QKRXHdjrKiXZ57CUaqM+t0ruRup8rNgW7FChNiAkos8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQSPnDoRS5673Y0JFb9cw50CvRf4BBG7dXVT7wOfsf8BGoqIIGnLUF0VT61p+rkOdubymqoIHHW+QyVSGjsFCamgZktn0AlWR6dJREP6jQRv3lExMRUvXhk52XK3M++WfrzYvGs4/B9ATNiQZDjTk/UPwbzQxE/vhsi+9dj5dhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPxa324Q; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPxa324Q"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8e401b11bfaso1879883241.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619296; x=1759224096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xI8h14tjQxUW6HQD81D49LyblvlCazYTCdEJkbLtuBo=;
        b=fPxa324Q2eK2+OUo58cqfyKB5I4MggCo+f3GD3vE9MulvT7eTEJFPmYmGIl6LtrTe4
         lv2nm+l6MBsz4m70eeGkUFndzcAxvrYUHgE5fy8VV0FzOHUK+Has8SrLqtwE277IdvVw
         1imIf/PrAajVFMN/6yTvb1tOJiDXz6b5MuDtYH9N6JRTcCrvSYsrvWvo3cCM6jhKWpx4
         wuzYUKBhhoVDc3dLjV8KBE3uoXnnDpPMidVys5S/q2YQ9eRomApqJ2LFkv4JR3/XfRyS
         R/Fq1LILRQ/8dVLst7aCnq87XEyIEHpuE2Zu6Ti6iMHR8jPekT2glx1aQ/nK7s9pyynR
         QWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619296; x=1759224096;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xI8h14tjQxUW6HQD81D49LyblvlCazYTCdEJkbLtuBo=;
        b=o/Q629+4V6hPInkR2/ft00XRSBUgymjxi9vj9xkTzCnkpuTRAFfk5b0qPWWIhithA/
         uhGOw1t48pQTs+iGb47BNFI2lhOaTJ4SxHnl0I5iM8+OvFF8BCaV9siOiXe3q4TISkrD
         IcEl3s8M/cZHjECQn9ywPfwDQuGdeKw5M9j9ckx8vnAheK9RlsTKYnY4fLysBpCy03aq
         DwkgVWhtUgRDcwYBW2mbwgTGNnE8vllqdfoaI5sjom7hXjPWlbHu0xk7Hnxe6SzPEuUu
         jNGNVadbH5dQ4galt0Lku9EIYcUrLWiaLFai8sNo94Peb9e6LahfR2+hmtEWNehA21K/
         9AQA==
X-Forwarded-Encrypted: i=1; AJvYcCUknnAXWff+i1mD21fYVO1wx5Hk5Sb9pdhLNCfFc4slCtopgYuqVVYAMPes94Jb43MKXis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfi1T2OgpgPq3ZUsLCPpGvtPjJewBA91e64MJ2ckCbjyQR/JKi
	Qtzt9VoPMC25EDSiIETW5LEo712rxS2p4A6Qhv0GqBInR3fiPfGvqjNTnuv4SZP9fmL7+sT5lei
	8ZzycbCbEjYgKFVNQe+rEH5Ov03zZq/4=
X-Gm-Gg: ASbGncszbD9kKUq0e0bgkp5GL5aa72uZGfUOLKJYJ2DXiEFfPUdvngKrZWFnTRpQ7AF
	sEWMm4CKUEZD2lVhc/BkDk8GWBRRgKxqJgnZn8rMr14+fmhhscDIxGfT6hJdqPkFbr07xoQigj0
	IssuZhQ6gDQ/TembR4lWfz7W3cvUvD/NQvsUd0fBWDFY+zkEMbTQupzRt2IylgnZzm2N3WOrMn3
	g5LKXKWcxs96WKHJQcw9hwRbLGTdKwmPNidKCO6ja0S4j9pz6mJ
X-Google-Smtp-Source: AGHT+IEIp6Yk5xw8ealF+u8po0MdqL0LHBu1jbQRrFR41TpAC2UW1v1GbTpYxVFPSi5blh9Zdn+66pdHk9+wBVI5gx4=
X-Received: by 2002:a05:6122:3d04:b0:541:2e11:674c with SMTP id
 71dfb90a1353d-54bcaf34b1fmr550975e0c.12.1758619296389; Tue, 23 Sep 2025
 02:21:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 05:21:34 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 05:21:34 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 05:21:34 -0400
X-Gm-Features: AS18NWCNoSMAPLljEz6Pg5Y8MJyIo3sDwj8AGxUL3nNCJSBZxmdekcZYsbvOdlM
Message-ID: <CAOLa=ZTuJU47DhUE4ix7f17bsspMXnZJWggfgf6WXoOoas+NFw@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
To: Mathias Rav <m@git.strova.dk>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000752501063f7476af"

--000000000000752501063f7476af
Content-Type: text/plain; charset="UTF-8"

"Mathias Rav" <m@git.strova.dk> writes:

> In `git rebase -i` with the fixup command, the -C flag controls whether
> the commit message is taken from the previous or current commit,
> but currently the author name, email and date are always taken from the
> previous commit. The fixup command is used to squash two commits where
> one commit has a good message and the other's message does not matter,
> and it is usually also the case that the commit with the good message
> is the one that has the good authorship information; the other is a
> fixup commit that was presumably made by the user moments ago, whereas
> the commit with the good message is the one whose date should be kept.
>

Seems fair, and without much insight, this is what I'd assume that the
implementation would be.

> Most of the time, a fixup commit is made on top of the commit to be
> fixed up, in which case the rebase -i fixup command is used without -C.
> The fixup -C case arises when an earlier commit in the branch is split,
> leaving part of the commit to be squashed into a later commit, in which
> case fixup -C would be expected to keep the date on the later commit,
> and discard the author date of the ephemeral newly split commit.
>
> Change the behavior so that fixup with -C takes both message and author
> from the current commit, instead of taking the author from the previous.
>

Well explained and makes sense.

> Tweak try_to_commit to allow specifying author in addition to AMEND_MSG,
> and pass author from the current commit in do_pick_commit in `f -C`.
>
> Tweak the help text in `git rebase -i` to reflect the changed behavior.
>
> Add a test that ensures that the author metadata for the second current
> commit is kept, and remove some author metadata checks from other tests
> that now fail since the author metadata is different (as intended).
>
> Signed-off-by: Mathias Rav <m@git.strova.dk>
> ---
>
> I described my own workflow for fixup -C above,
> and it's the only use of fixup -C I'm aware of.
>
> If the current behavior of keeping message from one
> and author from another is useful in someone else's
> workflow, then I'm happy to be enlightened.
>
> Correct author dates are certainly more nice-to-have
> than need-to-have in most git workflows, but I think
> it's worthwhile to have git go the extra mile here.
>
>  rebase-interactive.c            |  4 ++--
>  sequencer.c                     |  5 +++--
>  t/t3437-rebase-fixup-options.sh | 15 ++++++++++-----
>  3 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 809f76a87b..dd303168c2 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -53,8 +53,8 @@ void append_todo_help(int command_count,
>  "s, squash <commit> = use commit, but meld into previous commit\n"
>  "f, fixup [-C | -c] <commit> = like \"squash\" but keep only the previous\n"
>  "                   commit's log message, unless -C is used, in which case\n"
> -"                   keep only this commit's message; -c is same as -C but\n"
> -"                   opens the editor\n"
> +"                   keep this commit's message and date; -c is same as -C\n"

I would still keep the `only` word, since that confirms exclusivity.

> +"                   but opens the editor\n"
>  "x, exec <command> = run command (the rest of the line) using shell\n"
>  "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
>  "d, drop <commit> = remove commit\n"
> diff --git a/sequencer.c b/sequencer.c
> index aaf2e4df64..80209b6b07 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1560,7 +1560,8 @@ static int try_to_commit(struct repository *r,
>  			strbuf_addstr(msg, orig_message);
>  			hook_commit = "HEAD";
>  		}
> -		author = amend_author = get_author(message);
> +		if (!author)
> +			author = amend_author = get_author(message);
>  		repo_unuse_commit_buffer(r, current_head,
>  					 message);
>  		if (!author) {
> @@ -2419,7 +2420,7 @@ static int do_pick_commit(struct repository *r,
>  			strbuf_addstr(&ctx->message, oid_to_hex(&commit->object.oid));
>  			strbuf_addstr(&ctx->message, ")\n");
>  		}
> -		if (!is_fixup(command))
> +		if (is_fixup_flag(command, item->flags) || !is_fixup(command))
>  			author = get_author(msg.message);

If it is not a fixup command or if it is a 'fixup -C', we obtain the
author and pass it on. This makes sense. But what about the commit date?
Don't we have to do something similar there too?

>  	}
>  	ctx->have_message = 1;
> diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
> index 5d306a4769..2361d3fb78 100755
> --- a/t/t3437-rebase-fixup-options.sh
> +++ b/t/t3437-rebase-fixup-options.sh
> @@ -85,6 +85,15 @@ test_expect_success 'simple fixup -C works' '
>  	test_commit_message HEAD -m "A2"
>  '
>
> +test_expect_success 'fixup -C keeps second commit date' '
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	git checkout --detach A2 &&
> +	get_author HEAD >expect &&
> +	FAKE_LINES="1 fixup_-C 2" git rebase -i B &&
> +	get_author HEAD >actual &&
> +	test_cmp expect actual
> +'

Okay, so `get_author` here prints the author name, author email and
author date. Looks good.

> +
>  test_expect_success 'simple fixup -c works' '
>  	test_when_finished "test_might_fail git rebase --abort" &&
>  	git checkout --detach A2 &&
> @@ -105,9 +114,7 @@ test_expect_success 'fixup -C removes amend! from message' '
>  	FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
>  	test_cmp_rev HEAD^ A &&
>  	test_cmp_rev HEAD^{tree} A1^{tree} &&
> -	test_commit_message HEAD expected-message &&
> -	get_author HEAD >actual-author &&
> -	test_cmp expected-author actual-author
> +	test_commit_message HEAD expected-message
>  '
>
>  test_expect_success 'fixup -C with conflicts gives correct message' '
> @@ -181,8 +188,6 @@ test_expect_success 'multiple fixup -c opens editor once' '
>  		EXPECT_HEADER_COUNT=4 \
>  		git rebase -i A &&
>  	test_cmp_rev HEAD^ A &&
> -	get_author HEAD >actual-author &&
> -	test_cmp expected-author actual-author &&
>  	test_commit_message HEAD expected-message
>  '
>
> --
> 2.51.0

--000000000000752501063f7476af
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: adc77e2ec4359b58_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qU1pwd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1B3Qy9zSGJEZ2k5cGRBL1VOaWxPOVByU3RJVnVUTQpNQUlUa2V2d0dD
K0VTUTBoVkc1emFSVTdHajYzYndONnc3aGkyeE81K3o2V1hGb2FVU1NEQlN0aS8xWnRVUzRuCi9M
UDh3QkxOQ0M2anVtRzJ3ZlhGQ1ZIUEF5OVRBWG1ST250NUF1WTAvVjhuN2pSN3E3WlAvNXYvVHBj
Mkp0ajQKNWFtSkhLSmhPWElNVWU0NFFTRDZnVVhVUDlrQzdWSEJRbURYTmNUV2laTm15S3dsMitv
cHJQeXZTRjJ4UkFPWgpIMVZ6cmg4VkZxQU1rV0ZZcXAvWUE3WFJ4LzJTZ3JMUWhWNXR3bmhpZjV6
V1NJdGZZZ0NhUVR1ZFJmcHc1UWU4CmNvMnY5SGRod1YwMUZlQXdZdWRBZDBPcDVwSE9wZllRbjlq
LytPMjNPOGE2a1lRMlltOTdXYWdvVFB3QlRpRW0KdENIMmtBZ1dONmVvc1R0Zm9aZEhJUEh1S3lq
MTB6K3FITXpTWmxxQkRNVTlaWkZxd1dlYTUwQUdyRjM1WUY3MQprOU1WVWxkMUZSOFFMQlhCSkpV
ZXB3WmpOQ3NTYUtpaVBNNkNjR3JxSnZLbDRhdzNKVklFaGU3dzVjblpvVTJPCnNqS0tmSGpLaExt
TkJta090RUd0M2FkMElhbFZOb2gzVk9rL1hvaz0KPStObzgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000752501063f7476af--
