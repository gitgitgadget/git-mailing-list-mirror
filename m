Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C882C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B01E20575
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgCOSyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:54:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgCOSyW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 14:54:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id z15so18487951wrl.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 11:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jan/+rXgAmNO98ue7Rkh2f58keORwXLf5cyHraUVMas=;
        b=NR15RUytfu06+9hb3zir/SauCKRnV5V5myZOh5BRWr2JKb4hlD1SLKrMJZv7qc/nnh
         s8F8N3GIIlpJ3JQKa9xN+ao0JQq8jC6ny96aYwlQedQ7UUusWoIYN2dTzZKMsIYSAMfg
         jSBR+Y/hqV5ulKJIvEZqoCV2Sef3xqDXlvuDtdOivDNL2r4S2dYE7KWKz2waO8xN2qNt
         +bwrbFJVJ0he/9pK6TXng59m2M6pqOnty/2Egp7d/AmJ8RehDTu57vLpRKV1VF3Pgjee
         cE+gQvVFPXe5qG7Td5mU4Hy38aObvy45BVTV+YW081UbGJ49388tHKGaQxkkTUuOrQCD
         wZhg==
X-Gm-Message-State: ANhLgQ1LipxlTVUok564SwYfgLJW+btm1wz7F7ldaaoBLm7uEpQ5gs4Y
        SshdvDPonAisSCaZB0ZAhEtwlxkDKYzpYjCLtEqJsiC7
X-Google-Smtp-Source: ADFU+vsMlZvhGOIok2ZX7Ty+EPwFc9xHScfinSzDFC3lqkzzxG2VnANu6AKKZOmUZoW7bQeqBxdO5T067YR3/pRU4Uk=
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr261729wrn.415.1584298458917;
 Sun, 15 Mar 2020 11:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200314224159.14174-1-me@yadavpratyush.com>
In-Reply-To: <20200314224159.14174-1-me@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 15 Mar 2020 14:54:07 -0400
Message-ID: <CAPig+cRXD_bjUL6=daEAx7VnAy_nw9bao6rLK9xwTCYJSk48Qw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] git-gui: reduce Tcl version requirement from 8.6
 to 8.5
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 14, 2020 at 9:47 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Some MacOS distributions ship with Tcl 8.5. This means we can't use
> TclOO. So, use our homegrown class.tcl instead.

It should be mentioned that this patch series fixes a regression in
Git v2.25 in which git-gui could not even be launched on Mac OS. The
problem was reported here[1] a couple months ago.

I performed some rudimentary testing of this patch series on Mac OS,
and it appears to be working as expected; it certainly fixes the
problem of git-gui not launching on Mac OS. (I did notice a
misbehavior related to the original patch which caused git-gui to be
unusable on Mac OS in v2.25, but I suspect that misbehavior is not
related to or caused by this patch series, thus shouldn't prevent its
acceptance.)

[1]: https://github.com/prati0100/git-gui/issues/26
