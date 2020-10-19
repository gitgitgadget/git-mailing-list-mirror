Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183C7C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63F52224D
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="adpOKnUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgJSRh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJSRh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 13:37:28 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C365C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 10:37:28 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so645720ion.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pj0LQpwbJjf9NhbxiWfVBC4ffssGazuyB6A5fHKcqSo=;
        b=adpOKnUzfx8Gahr0ImNRSq5Xc7VXah0IrElECvJlel8uFyMvb3dKBdJskiVdLKgJDc
         XlmkQPoQZVTpxGg8LSOnAYbN4dTMcEgRJH/Gl+Ym/zd6LMc/14EU5Y91wG7xhmhWHD/r
         6+eGb7vOZtcVPgSiX7VC5KCAyBNK4Ah5wC2dr90l3OZHEG35IfgBT6efU19zfK24Oc5L
         ZNuFt84sWT4RW3XcnUlKHQzUWZmw7x4h6ji6BXPz5+YaAHrOuneK9HhgLQL716jZb3LK
         4xfezpRUeC31NL8lip80Du25vavpSkC/ma9Q2hxPGy4R8IHQtwrqS6uG/6N4xAhoQKaE
         +jeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pj0LQpwbJjf9NhbxiWfVBC4ffssGazuyB6A5fHKcqSo=;
        b=XFARaNG4Fk2Rv7OzOSFzKTJdUXHOADjljR5YMTadQPqGt++lmvXw5DP+mVXHT6gkJ5
         jSa3c8uekUYk2rjc2KgM9Dtq1Vo2vTObOF81fHtVe9qH4yJgdq4tqBB8I+kNITNv53Im
         elBcumTSVXw497qQ957maA0z5WWLjwXk9dq0/TK7Wqy784qCmuYn+zJ4+RgQ52UDUyPe
         1f/Nm8oTY4AHjobkFMHGU/qoE1mp08k32Mw7sYhcWZJEEaIuWRO4VC87MaTh2esXd7d3
         gwsmT4c72+he0sAjGpMeGlU9Ge95679PNsD69gPTQKjvFxuY7L8kY9iDDIVG/SguVsi1
         mQ9A==
X-Gm-Message-State: AOAM531OvTj/wzBUD5yHxXVAdli4lXpa3vYyPSpYvwT1ivDqK6x0aE/B
        u2DBg0wOAvyBNaLH1K9FDRgeYQ==
X-Google-Smtp-Source: ABdhPJxh3e3L2vN8OdV6xCUHvMTX26BqBaw/w3oUxr6sFZzSDNFwMXZrQNma6zGZJOoYAKakX3Xqcg==
X-Received: by 2002:a02:6242:: with SMTP id d63mr895689jac.19.1603129047393;
        Mon, 19 Oct 2020 10:37:27 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:c096:f5e9:cd72:773e])
        by smtp.gmail.com with ESMTPSA id 128sm386844iow.50.2020.10.19.10.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:37:26 -0700 (PDT)
Date:   Mon, 19 Oct 2020 13:37:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/4] fsmonitor: use fsmonitor data in `git diff`
Message-ID: <20201019173724.GA42706@nand.local>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
 <xmqqeelw8p8i.fsf@gitster.c.googlers.com>
 <CAN8Z4-W=+D-P_qCYijGMnStY-EGwKFx-+AYzjACDPAXnLRAA8A@mail.gmail.com>
 <20201018041642.GB2262492@nand.local>
 <xmqq1rhw86ur.fsf@gitster.c.googlers.com>
 <20201018234344.GC4204@nand.local>
 <xmqqr1puuo35.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1puuo35.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 10:23:26AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> > There is some overhead to invoke the hook and talk to watchman, but
> >> > I'd expect that to be dwarfed by not having to issue O(# files)
> >> > syscalls.
> >>
> >> "invoke the hook"---is that a pipe+fork+exec, or something else that
> >> is far lighter-weight?
> >
> > The former; see 'fsmonitor.c:query_fsmonitor()'.
>
> It brings us back to the "overhead of how many lstat(2) takes us
> closer to the overhead of a single pipe+fork+exec plus reading from
> the pipe", doesn't it?

Somewhat unfortunately, yes. Hopefully any user that cares to use
fsmonitor has enough files in their repository that a pipe+fork+exec is
still faster than however many lstats they would have needed otherwise.

Of course, finding out what that number is is still interesting...

Thanks,
Taylor
