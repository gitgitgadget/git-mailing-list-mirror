Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975EFC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 13:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA9520746
	for <git@archiver.kernel.org>; Wed,  6 May 2020 13:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="NvGthBSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEFNMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 09:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728045AbgEFNMC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 09:12:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2031BC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 06:12:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r7so1829216edo.11
        for <git@vger.kernel.org>; Wed, 06 May 2020 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KCrLqRnyBj7eEkoLKLEFfCDbrNiN5GSP2B0KDx3yyw8=;
        b=NvGthBScSs0iFPLeZR5u2i3/1pSu4VQVni/v+sLo+U+ayAGBVd66++Rc63HHgJwfJF
         hnvRASZT/ZBcSnG1dw06bg3/xodBCr+7/8nhKtn1e71ga5+Cs5fH28EjwCVoK2WAdBPt
         x1Np2tE0hs2RIsH5tDq06N9G+QAp9mkG4GE0l3HQh1NpFT2uYUvoa3pBP2DEIelJQrON
         kEVu9UQoH8TKRIw7Z21a5ntFhAOG9ZNLkiOrHoqY/+YToNghlm95bR6eS+uLW5EcdZJi
         V/Zc6NkrgJh/NQlYwN3O78x+sruF9/hhrwKWgxrZtdtw2GLM1fbso+3oFPtgqRKj8kGC
         EraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KCrLqRnyBj7eEkoLKLEFfCDbrNiN5GSP2B0KDx3yyw8=;
        b=jSxLp43PwNEjmptlzPaME88WHmtbjsoCELaimqumt1KGqtOZZ399VxiihIbiy9JwQg
         iuFLNbsjTG6MdsnBBld5zF78urSc0IWALNaENG1mSaqWuDd0i5+v1kRXQmRTHjbRb79d
         xc7MVfWlTqgt8OQKCuL50GVEsgw7kxynARY+ot6tolaGAvLEaTeJP6a0TRk5UfRQPoXl
         cEL69ZSBXzJ7jtv7LcPOIoMBcuDI+PXBmXXUjTsYCVFGVOWmsFL2hVlLxrzgkPPilZo6
         bgru3xIy9cUS3G2Yy/sBmyOKnVF4N/FbjNUkAKwJ130MLf9x0K1zT8BpXZouTbwUZJdx
         0B3Q==
X-Gm-Message-State: AGi0PubH//QbswjPD91kNzL2WylN3BImDsqCvMxkjSt7M1WMH8NuE7VA
        lgl8AHgLzHcPMbFLECkeQLUPQlE48mV7NoC7fD97l4cHRQ==
X-Google-Smtp-Source: APiQypL/WXBLViIvcTTrQt+2XD25qkcOLRB8TugCLTg+VP9SXWFViE18FkWqsQTyioN4CWYfhrh90hSwrKajMFQHeMo=
X-Received: by 2002:a05:6402:1008:: with SMTP id c8mr6469008edu.242.1588770719460;
 Wed, 06 May 2020 06:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GP4boTMaShBbJUQUA0GThpXXPiCQHFGKFYUYLE3mbsjSdqTw@mail.gmail.com>
 <CA+GP4boXi4tW23Z6CDF2v_ch2_7_dqhB_POAhi1FfYrEBG4DWQ@mail.gmail.com>
In-Reply-To: <CA+GP4boXi4tW23Z6CDF2v_ch2_7_dqhB_POAhi1FfYrEBG4DWQ@mail.gmail.com>
From:   Claus Schneider <claus.schneider@eficode.com>
Date:   Wed, 6 May 2020 15:11:49 +0200
Message-ID: <CA+GP4brpeGhBy3LF0LomDO-AOEZS02tOi2phQ4e1XoTGgeAx2w@mail.gmail.com>
Subject: [RFC] subtree: use say and exit 0 rather than die in case of no new
 revision found scenario
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi..

Currently subtree dies if "No new revisions found" which is hard as it
is a non-operation.

I suggest using the "say" command rather than "die".

It will then become easier just to call "git subtree split" and you do
not need to handle this special case.

Patches can be found here:
https://github.com/git/git/commit/fe435a1ba128698f6acb69ee1891c45be32610fa

Best regards
Claus Schneider
