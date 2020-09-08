Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB14CC433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8361121D43
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="x4yEF52M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIHHtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgIHHtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 03:49:36 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABB9C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 00:49:35 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1599551369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=aYKl8ebKp4uoMpSe9hrPkeDzvpp2OhnasBUI+HWVO1k=;
        b=x4yEF52M2B09/hM/6lXQDJZStPvxX0xohG7DK1A/ZdHXb1/Jf28OUqL3xLpQzpHqtHI9Vp
        OGtcq0AKVqIPP74KEcAm/EjWSUePRUGXYA4msmzNJR8gAJvKQxCncUoarqPHzdEQGYuiKt
        6EIWTuSJxrm5suOkTFXoHN0pHGJ/MnU=
Content-Type: text/plain; charset=UTF-8
Subject: Re: `git describe --dirty` doesn't consider untracked files to be
 dirty
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Ash Holland" <ash@sorrel.sh>, <git@vger.kernel.org>
Date:   Tue, 08 Sep 2020 03:40:50 -0400
Message-Id: <C5HTGCE96RJ4.DT7CCU2SIG3Q@ziyou.local>
In-Reply-To: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Sep 7, 2020 at 5:04 AM EDT, Ash Holland wrote:
> There seems to be a discrepancy between how `git describe --dirty` is
> documented and how it actually behaves. The documentation describes
> the --dirty flag like this:
>
> > If the working tree has local modification "-dirty" is appended to it.
>
> but certain kinds of "local modification", namely untracked files,
> don't cause "-dirty" to be included.

I think the documentation here could be made clearer, but I'm not sure
of the precise wording that would be best.

I wonder if describe should have an option that considers the presence
of untracked (but not ignored, i.e. anything that would be flagged by
status) files to count as a dirty worktree. Implementing this option
might be the lazy way to make the documentation easier to rewrite.
