Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF952C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 20:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbiBAUPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiBAUPy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 15:15:54 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE094C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 12:15:53 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e8so15229335ilm.13
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+qy6u/cS/3pRauSEAGyX8WefddE2jLR2WUFEpDbQW44=;
        b=3L46n8I1l87+YT/CYOsDvx2OiKTE+2Me3svWpT/Pwj4vIfqxqQ2MYKUuyo3RIHm4rk
         LONYd5h/2dFyPshbDYOGKc1P05PZgXON4kyyxV4Jk+mkUUj2wunwVS83GTGLsu6gxwtT
         hM3F38m9KKIK++MqpLe1Zf8l9TlqCnsg0r1pHA6De91ryOLCMu6Mz6QSERhusLPHt91Z
         c17Ux2vB2xeAnHpDF009Uel0KKikxtiD4FQO6EtSqRQgpvfoPyveqRD5zoDBuhmp/n/g
         y1KHVyfoXl+iNYAZrg7Nnf20gFnpY/5bjisoJYxWEeMdva8KcHCSoB3PidNyXDqLuCii
         zraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+qy6u/cS/3pRauSEAGyX8WefddE2jLR2WUFEpDbQW44=;
        b=Quuv1X4PwE3yOB8Was+gMyCjI1g9woQ7uoMP34XJUg3uaAVDGm25SqVv/fYdPpbmdp
         K5vgE2o8kZBJTDb9sQZYnRI96Bm9dUccXNaps408OmgrJaTE62DDhMz+Vj9JHs77gR5r
         qKzeNi/H5wkwc6a+r1OjMErvuaAtsIiTLCjCeXrVwlOcJevrizobdAUWh5YDI+VOgsvZ
         Q1JoaP3FZAs70EKz71muW/EDylkXS4TP1Xmflkh53sP+CgNtTQs2xURSJXFZ+EGfJy0K
         HI53SxmGhLD3U8oklcIDR/XPYkBgNuTCTW12hUXk7DWjQeYpLXsqsNIZD4Ko31GPrd86
         sRgg==
X-Gm-Message-State: AOAM531FClo4xInLknpZfg8F59qT6TF7aA7jr4WfUMe1jgwyTQbAOzsa
        xeV6UuvSnydx7Te+QDVB8nP9y7IrJQmZiw==
X-Google-Smtp-Source: ABdhPJxzao93EvM5a/vXv146KohzIcUK4cfd08F/bcz2n7kHeqrFVLsGnfwK2lnHaPYjIuVYee+QtA==
X-Received: by 2002:a05:6e02:16c6:: with SMTP id 6mr4087439ilx.320.1643746553265;
        Tue, 01 Feb 2022 12:15:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g14sm19328380ilj.41.2022.02.01.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 12:15:53 -0800 (PST)
Date:   Tue, 1 Feb 2022 15:15:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Getting rid of "hint: Using 'master' as the name for the initial
 branch." when initializing a repository with pygit
Message-ID: <YfmU+D7wB2ePMGTZ@nand.local>
References: <20220201184128.GT3113@kunlun.suse.cz>
 <YfmPiZZ/1RGzzfWE@nand.local>
 <20220201200246.GW3113@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201200246.GW3113@kunlun.suse.cz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 01, 2022 at 09:02:46PM +0100, Michal Suchánek wrote:
> On Tue, Feb 01, 2022 at 02:52:41PM -0500, Taylor Blau wrote:
>
> > If you have set the init.defaultBranch configuration, we will suppress
> > the hint you're talking about.
>
> That's the problem - there is no way to pass the configuration when
> using a library to create a repository.

Of course; but I was suggesting that you set it in $HOME/.gitconfig, or
in your global /etc/gitconfig.

> > Alternatively, you can make sure that `git init` is invoked with the
> > `-q` (quiet) flag, which suppresses that warning whether or not you have
> > set the init.defaultBranch config.
>
> Yes, that is exactly the option that would do it.

OK, I assume that this means that you can pass custom flags down to `git
init` via the library you're using.

Thanks,
Taylor
