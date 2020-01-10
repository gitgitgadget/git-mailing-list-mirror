Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8F9C33CA4
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFCA2051A
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtFuvFyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgAJTHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:07:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39167 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgAJTHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 14:07:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id t17so2565415eds.6
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 11:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L94FKpqN/LDL/uULrsLcUDkllxqecej4o4ln7ollm6g=;
        b=BtFuvFyyxxRtvnZ0T8nALA3xRoHMq5CHzLek+R7A8oLwU8jTQuTEDpHUNOermjHFfG
         156MGTDp0KBhyEoYLAzlVdhC7p0AoVVLp2U6o814JjNM5aq+q644WwOQf9pKosz3vCIe
         IM81DWw4oVuk5ZYNxkEPKGOgNSmnqi1Xowuga30vaKWiEQs55MpUseuVMncwgJDp5UV7
         QM6I0YoRwjT8tENKG19NJAFHuhtvQYMDdItFt9IkcvlpVyZ4ve8ZCfHTy23ALBIK9s71
         QWj8y/DiyCM/cntY4ztKBAWuw/kZJ76+yM39IR9pqWoqP74qaPrnc6LH0TgfJcTD0wWb
         YQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L94FKpqN/LDL/uULrsLcUDkllxqecej4o4ln7ollm6g=;
        b=f7hJr1gu7dxNpQW1f4Op1ZUBUZo+nayOjEBhA1vWpF89CyLjtnCzSUYkrzAOEB16RE
         VqFnGg6sUPbNQzXziHh/yz09SFbH6jHEr/risYyR7PyKx/bR07+cgxiPyLBGzgWwT4D3
         tTeJqdCYJFGF52u74fT7kJJG3y9uvOWgHti5F1LgGNrenXSlSrIK+0mp8vFagOf59GPq
         MO/yLwuXxFjYzpezuSz5k4x8znW55moYLcQMBEK++RwzEOUQ87KkvgHY3bhNYhmaYMfQ
         Be2/wx06ErAnKnb9p9DSGHLP3ZDdPFZp+dPtLcCbu+b1SCTZ5T3H5SQDiL2/KLvDv8Nd
         vXJA==
X-Gm-Message-State: APjAAAWOD01wvYOrMoNpFRKt48ajz1Fhxx3A/yElE/mIniqXGJfBnQYJ
        1Jw/Cm1BD7iWlAy4p+8WX/XeIl92GGX8TkaFUyo=
X-Google-Smtp-Source: APXvYqyQZBhN0epuIdab1xN7GTMkHDlLBuMwhWHGPstv3m3K8ykldyT2Ci3hra/0mG5ITU9Z5W9d9IDPDrP8kUleXNk=
X-Received: by 2002:a05:6402:2c3:: with SMTP id b3mr5095586edx.207.1578683238850;
 Fri, 10 Jan 2020 11:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20191114060134.GB10643@sigill.intra.peff.net> <20191114181552.137071-1-jonathantanmy@google.com>
 <20191115041215.GB21654@sigill.intra.peff.net> <CAHd-oW5qT5LmUd6GTL=O+-yXPmq5Uy9gk3ohL_2r+_K+6UJS3Q@mail.gmail.com>
 <CAHd-oW7WhSs2PDSwhksu0Kh5pAJE3rw3nmc-8VJ9dkJitz_N8A@mail.gmail.com>
In-Reply-To: <CAHd-oW7WhSs2PDSwhksu0Kh5pAJE3rw3nmc-8VJ9dkJitz_N8A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 10 Jan 2020 20:07:07 +0100
Message-ID: <CAP8UFD3QHNoePGsc9t0fVxTJpPy+KBCbPfXKGoNOx_2bCf1Hxg@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] object-store: allow threaded access to object reading
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Thu, Jan 9, 2020 at 11:02 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Thu, Dec 19, 2019 at 5:27 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:

> > However, re-inspecting the code, it seemed to me that we might already
> > have a thread-safe mechanism. The window disposal operations (at
> > close_pack_windows() and unuse_one_window()) are only performed if
> > window.inuse_cnt == 0. So as a thread which reads from the window will
> > also previously increment its inuse_cnt, wouldn't the reading
> > operation be already protected?
> >
> > Another concern would be close_pack_fd(), which can close packs even
> > with in-use windows. However, as the mmap docs[1] says: "closing the
> > file descriptor does not unmap the region".
> >
> > Finally, we also considered reprepare_packed_git() as a possible
> > conflicting operation. But the function called by it to handle
> > packfile opening, prepare_pack(), won't reopen already available
> > packs. Therefore, IIUC, it will leave the opened windows intact.
> >
> > So, aren't perhaps the window readings performed outside the
> > obj_read_mutex critical section already thread-safe?
>
> Any thoughts on this?

My advice, if you don't hear from anyone in the next few days, is to
update the commit message, the cover letter and the comments inside
the patches with the information you researched and to resubmit a new
version of the patch series.

Thanks,
Christian.
