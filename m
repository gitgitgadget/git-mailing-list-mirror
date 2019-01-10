Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B2D1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 22:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfAJW34 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 17:29:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51149 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfAJW3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 17:29:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so583018wmd.0
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IoTPyzXIEhBAF/1GSuwnX2ZFynEikKNLCjefzAw4KXA=;
        b=bzqG11jzkxfA0hoNnaXNu+kRGDH5ctcp3YUVGUKMQo5fTwv5v5QvXBBvXlaI2BJlyt
         N958x/qOjUiI5zTem0YaPhQcZ5s4iE7QBS36x8jbWRT1KDS9zuYxzmk3uFmI2sEBzxtc
         o4i6ojMN9vPNYVm0YhGhac8OYcF/WU8wev7PQAU/BQQFZPrFFjremO68Rrg7xwft4luy
         oQBeEmIdyHUvLsQZs7VL8yEWopC/AZhvJetBHlt+PvRhhlcXW+39YkfDnY1I2HRaU3ou
         Rqi5Zf1QNf7iPOOiWv3C1P/IT7+BuhW9P/Hr36gVRxVStz0xLZkQWhRyM2pjlOfh5j7t
         jzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IoTPyzXIEhBAF/1GSuwnX2ZFynEikKNLCjefzAw4KXA=;
        b=c0szW+Sdg3q+qCd3eo3lFllmx0xzHpqdHCbm0j5G+o40rjoH+tpccvjobv/Bv4e+sx
         C5TtjI6At/UnBQZ7549s/1/6J/sCu/SRiUB7uyC8NP+fH7pGpvSBUhaX2gTEmOARyUmV
         1CTgpJyef35lEmLld+tzymqWnYMPss/FTm++N6ovkdDokrH52jcwmwRTqdr88LD7/6GI
         hf+8aeis/XeqTY5zq8OfzZZbKPswWtT4CUilSfJyShpElZx+Za50S68WpkAy+LN44IWv
         /02engSNx96wk8Yxf+6oFwIZZF8kPATin3RH+oEEzGQC/+4vYfCIll/3WnxiKg+3RZlh
         VXaA==
X-Gm-Message-State: AJcUukdTVoELubT0B9IUB0Ge+0B/jxRrmTikpgsmRUUVLpGYMLVXwFTe
        /RN/cb9aCgDFREhnwquyvtWKTsa+
X-Google-Smtp-Source: ALg8bN5Imh9rnkdMEm5RJwIBKKKGzx/V14+T9AxexVshR5Ok1w5b1yxCV4R3yVnCSCW704507tTuhg==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr469wmg.78.1547159393631;
        Thu, 10 Jan 2019 14:29:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l19sm18430063wme.21.2019.01.10.14.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 14:29:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
References: <20190107213013.231514-1-brho@google.com>
        <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
        <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com>
        <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
        <20190109154828.1b19dbb4@gnomeregan.cam.corp.google.com>
Date:   Thu, 10 Jan 2019 14:29:52 -0800
In-Reply-To: <20190109154828.1b19dbb4@gnomeregan.cam.corp.google.com> (Barret
        Rhoden's message of "Wed, 9 Jan 2019 15:48:28 -0500")
Message-ID: <xmqq1s5k16zj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> For instance, commit X does this:
>
> -foo(x,y);
> +foo(x,y,z);
>
> Then commit Y comes along to reformat it:
>
> -foo(x,y,z);
> +foo(x, y, z);
>
> And the history / rev-list for the file looks like:
>
> ---O---A---X---B---C---D---Y---E---F
>
> I want to ignore/skip Y and see X in the blame output.  

If you skip Y, the altered history would have "foo(x, y, z)" in E,
"foo(x,y,z)" in X, and "foo(x,y)" in A.  If you start blaming from
F, you'd get E as the commit that explains the latest state.  If you
do not skip Y, you'd get Y.  I am not sure how you'd get X in either
case.  
