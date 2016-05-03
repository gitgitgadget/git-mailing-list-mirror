From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Tue, 3 May 2016 09:09:20 +0530
Message-ID: <CAFZEwPOAWh48YCxA3B+kRxVpkwN32OHW7Qrb9ajs2Cy0S8sjLw@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 05:39:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axRBX-0005Bb-0U
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 05:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbcECDjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 23:39:24 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33463 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbcECDjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 23:39:21 -0400
Received: by mail-yw0-f193.google.com with SMTP id y6so618901ywe.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 20:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=6x6r/exmcSYIpy2kXslxgIx+bZlhfPOJchyJmDznfHg=;
        b=H5OgwPy1Ob1MGoge2c+vJHxSob59CBMaRwy2EmaJG/mPGdgkhofyKte9aWLF+M7EPz
         ej9f5jxf1U8Y2OG+OdwqpeR8ZT9Mb+9S+wSne7P2pAAvxcE/tY030BjRqYTxWHYJRypN
         0e/R+dR5je3g6Fvsk5Ut7QD92jv1yMi/G9KObvnorjtIZAiuJbuEAmqjLAQwUp8Pfnur
         YHWk1KCSYnZarphM3G2RAJLm7DErXs/vnyBsZeKNfQXZQ9bMTbE2KdHh5OTKNVpJxBA6
         OTHQABi92OGGKDFWOERv4gVwPqxdEhCReHzGYETowCfauaWDIclB/Ymad6MySWihC80C
         9E1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6x6r/exmcSYIpy2kXslxgIx+bZlhfPOJchyJmDznfHg=;
        b=AWXrcXiKGqH8oJEGktTLgZjxPP4kTj5dJJqCWcX8Orqy/F5ooj2tgTyAeeI5cHbvkf
         YsHzu4n+NbcLjHv9vD+F9OUycvjJQa9WVOgIs7AE1gmciN8MXx9FTvst9XeHwRxZejwI
         EYIZ00ymNn1SNPZwTJ1acYCd63SC8mpWaCDeO8snJeHnGvQnGWs7LjySoenAydyOKPf9
         vrdoAXMctw6TCK7XOjx4xiTD8uFh+6/1ZVev6ug5JM35gNHHQ7Sk4N4OcRok91LSEtcr
         FMnIm8ybN53I+JHjLcqLPuw0TcTD84dd4w98IxNvlO1yy76Ew3+I47/oGzJhSEeGUDFA
         LAew==
X-Gm-Message-State: AOPr4FVGuUbXy/34ieuDCDlTuT0Y78RUJj0SdfcdOLLgiybO6NkbcAuMcyJxqxDafmwz2QdtzWThh9kq3aNvsw==
X-Received: by 10.13.244.134 with SMTP id d128mr63478ywf.72.1462246760833;
 Mon, 02 May 2016 20:39:20 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Mon, 2 May 2016 20:39:20 -0700 (PDT)
In-Reply-To: <xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293317>

On Tue, May 3, 2016 at 4:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Variable named 'verbose' in builtin/commit.c is consumed by git-status
>> and git-commit so if a new verbose related behavior is introduced in
>> git-commit, then it should not affect the behavior of git-status.
>>
>> One previous commit (title: commit: add a commit.verbose config
>> variable) introduced a new config variable named commit.verbose,
>> so care should be taken that it would not affect the behavior of
>> status.
>>
>> Another previous commit (title: "parse-options.c: make OPTION_COUNTUP
>> respect "unspecified" values") changes the initial value of verbose
>> from 0 to -1. This can cause git-status to display a verbose output even
>> when it isn't supposed to.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>
>> ---
>> This is a split off from the previous patch 6/6 as suggested by Eric
>> Sunshine.
>
> If these are documenting what your previous patches broke, then
> there test body should describe what should happen, and then if it
> is broken, use test_expect_failure, no?
>
> Your first test does "run status with commit.verbose is set, and
> make sure the "diff --git" does not appear", which is correct, so if
> it does not work, test_expect_failure would be the right thing to
> use.
>
> These, especially the latter, look rather unpleasant regressions to
> me, and the main commit.verbose change would need to be held back
> before they are fixed.

I agree that using test_expect_failure would be a better way of going
with this thing. Thanks. Will send an updated patch for this.
