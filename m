Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041DBC28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349714AbiHSSCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350378AbiHSSBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:01:12 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897B20BD3
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:48:24 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3375488624aso111335497b3.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dOJ1yf7ucG9itHK3D7xAnemDeXCPWNIiNgy4KiOVkkg=;
        b=rWdP6aREQtf6CkAUgp3z5HvddQgvpab2dDGZKPPfoYxjhaY7AiQvG/SHSRNOvbfVp9
         mJGW5RPonCmMmFC7iXjFcbc8p5oIeGeNToGC6ycIQ2qq5DZwn6s6a1GkXIeUa6ItnVmx
         tHWIXnppS5GdQbDgLDpMQO67KDAcSfzY0v76HVL03949HGdcZzptoVvycYB6SJB5Hlwv
         w0nCTk2B+faixux2hjQz3OhD8JmYz1KMx7es0Kxs9U+RNVSlJOT4ZM82SvwgYbM1sCX7
         d4sCpQMC80q9EwvkfM1XpHXfyXU89feI1LP0kPC3QqkpnrC3d+TGRYYSWMCrDPszSBq0
         Hpeg==
X-Gm-Message-State: ACgBeo0jhmiiXEK908GcaF0diIiiSnGSde3v3mbPN4BtUjpTDtyeyhSU
        vhuJtKRjIBIK6Hnr9o1uFQPaujGxhcrr4nA8SZNM/Eqnc+E=
X-Google-Smtp-Source: AA6agR6I/RW2W8WMfIQ95njESqrSNiDIyAw6zb1jL3f++D0DBPxGryjjHPbBpzDgf38z5gbeIf26Wg9BnTkZvhyZee8=
X-Received: by 2002:a25:fe07:0:b0:691:d1f4:681f with SMTP id
 k7-20020a25fe07000000b00691d1f4681fmr8835032ybe.211.1660931303652; Fri, 19
 Aug 2022 10:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Aug 2022 13:48:12 -0400
Message-ID: <CAPig+cSwqNp5Jc7tcn7wLBHNCTHKYVzFs18KzVb+t9rRsrn1Fg@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 5:00 PM Eric DeCosta via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Though perhaps not common, there are uses cases where users have large,

s/uses cases/use cases/

> network-mounted repos. Having the ability to run fsmonitor against
> network paths would benefit those users.
>
> As a first step towards enabling fsmonitor to work against
> network-mounted repos, a configuration option, 'fsmonitor.allowRemote'
> was introduced for Windows. Setting this option to true will override
> the default behavior (erroring-out) when a network-mounted repo is
> detected by fsmonitor. In order for macOS to have parity with Windows,
> the same option is now introduced for macOS.
>
> The the added wrinkle being that the Unix domain socket (UDS) file

s/The the/The/

> used for IPC cannot be created in a network location; instead the
> temporary directory is used.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
