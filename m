Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08CE2022A
	for <e@80x24.org>; Tue, 25 Oct 2016 10:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbcJYK0e (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 06:26:34 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33085 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753454AbcJYK0e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 06:26:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id i127so6269306oia.0
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g67v3Cg4ppY7ImxN1uIlaW08jAmibgH+14NiW85B89E=;
        b=vmG3jKyV7EQ+XEgSzYL0JWYRNHUkPKoHxCSR4tev4MZnZCvvx3RbEDXMEsDi7BtphU
         4Mk8kfxKHcKTTHOerlVr8VV8aab/kNeUF2L9sZ8MYgN/P+gWVaoF3RMR3U/Qt0Hf3dFk
         1DMNgfPREvPH/j9gMHLvNzRtSHNEGsz9NosmEyK/7wR67tmsZ0ByJZ5A8Ppyvh4BHMMB
         wsjcvoqL4cqxSMgnVoISNJraqmjpifaSG1TCwL6w7s8+0To7JkqL8biPMfandwudAdOt
         zSe7N1XD0jxmOT/elnYzAXsZXhy+Y1NZy0fwCMiNlv7YJpPHxk4lYHUhZFa5dA9sT+bb
         ob1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g67v3Cg4ppY7ImxN1uIlaW08jAmibgH+14NiW85B89E=;
        b=CxkisCHrfsosigptOYJmNJyu2wRdM2Jte1VXS76szukh2x3auFAsSyDE5YOXa2dmAy
         uvL4Oys6g00oxtZxWf/f9zcTAzhiaPZ/ORIgf5T4vmcrWJkHmcq53ArelYV66xydzBVb
         oLPMfz2zaWGWIg04H89dMEHCWRUNrReJ77kru4WhFHVEjVWeE9EWTu+pmiPnDgbZRud2
         8+UOOenzEAYHJ6rcKhHRCCib597m6j81pBV/7qz/WTDyTktBuTImGkfJF2xUJxdQkFZZ
         yjsvcG9b3C2SpDaAR59p8r7fMk3UeECVYd40azYnQksP6UXyLK+5/qXFXewR/JFiE+y2
         X2ZQ==
X-Gm-Message-State: ABUngve1mx+skKkWYpQBHhq27nnBiQxSk711OC4tUjM7w2E7hNJibz5f4CHcR1Pddb0Mg5EkhfYA/kcGD4U+2w==
X-Received: by 10.107.15.222 with SMTP id 91mr15503419iop.19.1477391193249;
 Tue, 25 Oct 2016 03:26:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 03:26:02 -0700 (PDT)
In-Reply-To: <20161023092648.12086-15-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org> <20161023092648.12086-15-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 17:26:02 +0700
Message-ID: <CACsJy8As2o-ZDXMRWeebpXiWUrDMLaXC2H1R+OMbhAMmM8V_wg@mail.gmail.com>
Subject: Re: [PATCH v1 14/19] read-cache: touch shared index files when used
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> @@ -2268,6 +2268,12 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,

Doing this in read_index_from() would keep the shared file even more
"fresher" since read happens a lot more often than write. But I think
our main concern is not the temporary index files created by the user
scripts, but $GIT_DIR/index.lock (make sure we don't accidentally
delete its shared file before it gets renamed to $GIT_DIR/index). For
this case, I think refreshing in write_locked_index is enough.

>                 int ret = write_shared_index(istate, lock, flags);
>                 if (ret)
>                         return ret;
> +       } else {
> +               /* Signal that the shared index is used */
> +               const char *shared_index = git_path("sharedindex.%s",
> +                                                   sha1_to_hex(si->base_sha1));
> +               if (!check_and_freshen_file(shared_index, 1))
> +                       warning("could not freshen '%s'", shared_index);

_()
-- 
Duy
