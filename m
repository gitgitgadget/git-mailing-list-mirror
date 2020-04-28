Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A7FC83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCA7206A5
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvwFt+Tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgD1FKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726258AbgD1FKh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 01:10:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F69C03C1A9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 22:10:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k8so16170762ejv.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 22:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=maniZwA4x9cJluu6wGu8KyyMdcH5bcRjL5D+5mUlDYQ=;
        b=EvwFt+TuxDBbl1WB33bMtBzYtlZTKKlw3puaR0D8KpywpEO6co5kuvr7rXObwaO2d9
         YwWgrpnU6m10P8UjHYwt4BCebg8xm35Orogwf1HcbA4/h2n2nu6hooe7nv3yYl6Pk+86
         hYVIHjx+vOdVBHEtg9SjSblWfQoRXAdrKavbYrNMU+PAmtBejr2YTW97UTv2AN+x+Fkb
         4Rk5fh/fTMP5FfmRa7N4v2azExvcaljaa8HWbNMZ83cMPdYV/OLVw8zsUSKHWkRyrluB
         yMX+h0FGu18PZ5JXllz6Jprdke0ScVmj69Cn4wTpep6Nl8pEEyNzxY23kOBh6dQSrSvz
         fKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=maniZwA4x9cJluu6wGu8KyyMdcH5bcRjL5D+5mUlDYQ=;
        b=DZmVysOwMtSUIO5PnkIeqr4DUQdb/g+tZ96Sr67DzaY2HovcbLCeXQdccuAvyCcRak
         sF1hkI+Sll+rZf5RpGrzgxhWk0HDUTF24tixRG5TQcuD1evzqhqZi66YPdN2QPnw0qED
         BRWe8LeANXzlpNfhG5eq7R1uFaILfMSKXug3PZqBtlY8xrIPyY7x3FP+SbTWimqHKo0i
         InN7YyIsg7KXm4EDI0mfqDz03ogL9q/co/P5Ibt/LbaMptQ7sAEiHbMljkqW9msqqrCp
         XSb7LYFtRbsfY7qB8I0s/OG53ldyftYvyd8YnYEGA7nt05v+826m9DMEMLNTR8MVk8If
         en0w==
X-Gm-Message-State: AGi0PuaDQHxmWd/REsOZE73e0RVf93khVcbizZ3k5f6ji8sa7ppKjApn
        fBcAbwjfMfA7ipRGIdwpv/jD609YCOYvAfJQXEuUMdh7hEA=
X-Google-Smtp-Source: APiQypLcFGgN+f3TPnrdvtMGPCppkzNIe12FPwKZy32HikIUT7E7luSXW6BMTDcNB3nUVcS0B9EUsDP1W75rARJynW4=
X-Received: by 2002:a17:906:2511:: with SMTP id i17mr23698381ejb.165.1588050636161;
 Mon, 27 Apr 2020 22:10:36 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Tue, 28 Apr 2020 07:10:25 +0200
Message-ID: <CAL3xRKdrATjL0+xUH9p8XtgXKd7tD+wCW-+TASJ8saVxBnJVZQ@mail.gmail.com>
Subject: Re: [DRAFT] What's cooking in git.git
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Apr 27, 2020 at 06:17:37PM -0700, Junio C Hamano wrote:
> * jn/demote-proto2-from-default (2020-04-22) 1 commit
>   (merged to 'next' on 2020-04-22 at 1a5e0b221a)
>  + Revert "fetch: default to protocol version 2"
>
>  Those fetching over protocol v2 from linux-next and other kernel
>  repositories are reporting that v2 often fetches way too much than
>  needed.
>
>  Will merge to 'master'.
...
> * jt/v2-fetch-nego-fix (2020-04-27) 3 commits
>  - fetch-pack: in protocol v2, reset in_vain upon ACK
>  - fetch-pack: in protocol v2, in_vain only after ACK
>  - fetch-pack: return enum from process_acks()

Would it be ok to just proceed with the fix and skip the revert?
Or do we intend to revert 'jn/demote-proto2-from-default' after the
fix has landed into 'master'?

Cheers,
Son Luong.
