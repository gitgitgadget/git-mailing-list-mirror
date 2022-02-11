Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03546C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 09:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348745AbiBKJ4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:56:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348753AbiBKJ4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 04:56:34 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F1E78
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 01:56:33 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id ay7so8950002oib.8
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 01:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5dX8o4cxKWS3InyVbT0529CSbS2hF8u/bjOYn89ZcQ=;
        b=m4k6k7gyw3J8kENhfvlseYeddViZ0nSg4hE67iADikgi3raUF90Gq01+uz3ewBrwH3
         YjiznVqdZQS4cyq1dNgaRuvDwAgV1VJBKgMLcMzZZfky1hDxXzhiErjLk9NCTEmp/H50
         Lhe4bwWfaKQ2JAZHg1eQt1Tm9Os+Yo7TbG6lXCTTjkg+5JOGnS2nRiXRleDlfLGWxBbq
         fjjKHcc6Tqq4wAuy++dDiP59oofNgej7Pixm7AJXRF1v28xH9+awNobSGooh6gA9h3WW
         JSbUgfzt30AUA466uYUunSTYYxE9vPJorbQ/OOoTE6VarpxT9QTMODgXWzEYxdNgNzfI
         ZCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5dX8o4cxKWS3InyVbT0529CSbS2hF8u/bjOYn89ZcQ=;
        b=XUBcfJ/bDak5+HhHROwqCShSqyNggE/I5E794iYPpsyFQFFD6/jtp7mczfMMIT6Y7z
         0TKzsjqT9Jp+/GmpK+BcSkdS9WBVny641J+4IQ/zs7r+9RT2b+clRAO7tEut3zpn2m4L
         y0p0ee0TmKc34roPMz7XJwfxT45+1BgeHGO4ouNzZvQsgAH2PQM1mvT2SPDVsUgtuUFC
         hqnKtkDetl3xi4dlA/gF2WDHcRFhDLUT5X0g+Rdp5A8WFiG6MQEogv78ZbJVyBveprq8
         WSjxjf5Lm0LQQpqf/ID750aMFLRE1suWL3XGqFNhlbLfSQeNPQH71epJBFmb9Fo/TbUy
         HqBg==
X-Gm-Message-State: AOAM530bbMBbCoADQCibJl2Osd4/2SJKtVaQC+wlLTlrK++jFAuw86qu
        fNQPVNNtBvxRe1tHDiRrKWMk0zFYAFN9sT39MMU=
X-Google-Smtp-Source: ABdhPJwpy08h2nWzErAtwYXvDytsat1FbrEY20bHmHOhJOOND/9dnUmmYYoFDHuVi7cbgJrXwixSWFpHiEqoBsSoAVM=
X-Received: by 2002:a05:6808:170d:: with SMTP id bc13mr644632oib.109.1644573392769;
 Fri, 11 Feb 2022 01:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
 <20220121102109.433457-2-shaoxuan.yuan02@gmail.com> <Yer/oEZK6TBFSsde@nand.local>
 <xmqqr190g6gd.fsf@gitster.g> <CAJyCBORHE2+UMKYFfKArgK68fAT=pKVabVmfifzg--rHAFkaqg@mail.gmail.com>
 <xmqqo83fw5yc.fsf@gitster.g> <CAJyCBOTBcvgAcSaQ4xs-V=M-im_Umf3ymsWzCAGEmrj6b38pEA@mail.gmail.com>
 <xmqqv8xmvdoa.fsf@gitster.g>
In-Reply-To: <xmqqv8xmvdoa.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 11 Feb 2022 17:56:21 +0800
Message-ID: <CAJyCBOR7KbRxuXJUJ2TrffAjj=rwB3H-Ys9tVUuWGjUKf_LHsw@mail.gmail.com>
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Feb 11, 2022 at 1:23 AM Junio C Hamano <gitster@pobox.com> wrote:
> FWIW, I have the posted patch plus the following SQUASH??? fix-up

I'm not so sure what does "SQUASH???" mean especially the three
question marks, i.e. is it just an incidental text or a commit message
convention?
Is it for the convenience of grepping through the
"git log" outputs (cause I found the commit 50d631c71c right away by
grepping through the "git log" output)?

> parked in the 'seen' branch.  As the script is quiescent right now,
> I do not mind merging it down, now we spent more time on it ;-)
>
>  t/t0001-init.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index c72a28d3a5..d479303efa 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -6,7 +6,8 @@ TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>
>  check_config () {
> -       if test_path_is_dir "$1" && test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
> +       if test_path_is_dir "$1" &&
> +          test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
>         then
>                 : happy
>         else

Yeah, I think wrapping it around is a good idea :-)

> --
> 2.35.1-102-g2b9c120970
>

-- 
Thanks & Regards,
Shaoxuan
