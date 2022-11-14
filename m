Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD59C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiKNWvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiKNWvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:51:17 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4679167F1
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:51:16 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id g7so4877441ile.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKvAg3o4jWSq628DQ8P1IZ3pT6dBw9uwQYmhVST/U5U=;
        b=MPMIDKwpS1eK9ekHFrBOJ3zpbIdWgx/Cy9suWG67S/b0v9STd94YN16Ev48c8sTxGE
         91dm+vK9KiD1aoiuVjo5myA2cy2CFAjR4VfRfpxkQEPnV24ZSXdwO/xatKJ1cBn6Lh/F
         8VX/jN+8C/Ia82SEmaO/psluYmHQ1T9GOkztEhOBdG4xTaKqQRPga0Vv85o0FTNVoEyl
         JdtOwIqXEjP14Y/49AgfgCcsyOgqk7goy/a7AMi6pkgJYmuflWIPdswakpx2qQ8pRVkw
         U/ngHfMb12ew7hHI2cZwR6V7IGjHcTRw6CkykwOz9+aHbrfnCBF1Gyb/5puVsuWykIiF
         hsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKvAg3o4jWSq628DQ8P1IZ3pT6dBw9uwQYmhVST/U5U=;
        b=KxTPWLrVTADemhNF2Cxh43DwpOihSPYMPI8r8d5YowPHXKWSKrIwxXmOHSGcBU4IkC
         nP+oj/BMH9Whw+foVIGva2y80sGUmQerlqlw6mI0iwIJAmNlUSWk9mh70IcKvbBfaBT4
         UYxo2VIACPCq+vQNkHz8Lnk4uQ/oHeni+PKVdpYOrmiTBJEiJ+02H92JCIXbs3HXbIdv
         xTBmFeoh7Y8YwIRAqhgLOOjFNybtyAuofSsuk3t37ssvMFbVh/QzV7vUQ3qIVEybN0de
         NA20JiehEt/+cNedPGA0VeV9Uvcz2yxtREWjXFhhrBMh7W5N7V4kv8/Atfz3U334Ls5U
         /y/A==
X-Gm-Message-State: ANoB5pnQefHiQoOtjxj05k5pCMfz3Cu42nqP5GnkSIS3uT3IYoheLu+4
        WfwuH9IeXcWpF5bgJjTG57dLtw==
X-Google-Smtp-Source: AA0mqf5XLD/uUyyMKu4kprzPae6SgAWOaZJP1pugZXy4c6dItLUXIje1QPhiQJF7TqafHzFrjRX2ew==
X-Received: by 2002:a05:6e02:10d4:b0:300:f452:339b with SMTP id s20-20020a056e0210d400b00300f452339bmr7102897ilj.306.1668466276072;
        Mon, 14 Nov 2022 14:51:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p2-20020a056638216200b003755c84f596sm3933808jak.9.2022.11.14.14.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:51:15 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:51:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Moss, Adam David" <admoss1980@gmail.com>, git@vger.kernel.org
Subject: Re: Annotated Tag Hooks?
Message-ID: <Y3LGYvgEsqPsAo0F@nand.local>
References: <CAMTDv-8kxu-vwtCgz-VGBhYEbUX8edXzyaQK4szg2bmMJLjF4g@mail.gmail.com>
 <Y3LFF9EFVlCn4Lt2@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3LFF9EFVlCn4Lt2@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 10:45:43PM +0000, brian m. carlson wrote:
> On 2022-11-12 at 11:10:38, Moss, Adam David wrote:
> > Hello,
> >
> > Is there any way to use, or are there any plans to introduce, an
> > equivalent of the `prepare-commit-msg`, `commit-msg`, and
> > `post-commit` hooks but for `git tag` events?
> >
> > I would like to make use of `git interpet-trailers` to automate the
> > inclusion of some additional information into the tag annotation in
> > the same way we do with commit messages, but am struggling to come up
> > with a nice solution at the moment.
> >
> > If there is a better approach I could use I'd welcome suggestions?
> > Alternatively I'd be willing to help implement such a capability if
> > anyone would be willing to mentor me through it?
>
> Without speaking for anyone else, I think such a feature would be
> beneficial and I'd be happy to see it come in.  I'm not personally able
> to mentor you on this, because I have limited time to work on Git, but
> perhaps someone else on the list would come along and be happy to walk
> you through it.
>
> I _would_ be fine with being put on a CC for the patches to provide a
> review, however.

Ditto for both ;-).


Thanks,
Taylor
