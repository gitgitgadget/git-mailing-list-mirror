Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44181F42E
	for <e@80x24.org>; Thu, 10 May 2018 05:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756600AbeEJFjQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 01:39:16 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:52483 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756582AbeEJFjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 01:39:16 -0400
Received: by mail-it0-f41.google.com with SMTP id y189-v6so1752544itb.2
        for <git@vger.kernel.org>; Wed, 09 May 2018 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PnhEpge1HFSC7mtM7hztw6tWdkGchZkxhCddXJPyXVo=;
        b=uNQpL0Itt+8nB5ObdIEsD5os5aVD9vlA/pUrQnRGg8NPLc+1um4ju9QAkRYx2ndlmP
         yoLUGodOWtDgjbLbhikyB/CnfxipzRycgh+iO5NQ/uags6nSiB6X63suaDarx2e+4iq0
         WjwcbfsRWIXY18H7hwvAvdJsF/raJM/8wKp8nbHO3DhUCHOuaLKuGZjIF6T0STAF1Qhq
         fUMDkcZwJKjvBBHrYohDh+XIlNBCDcGiAWSFhZWr8lQg4by8eTp/Fft2VF4IRCwJbubq
         VYEWg7rj12bt61KUUcpoikAFVLTEwmiWoPKphkb8dlBBfexURjtWJtTifoT7jEI/JoL2
         shCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PnhEpge1HFSC7mtM7hztw6tWdkGchZkxhCddXJPyXVo=;
        b=GznddH9GWdM8Ti6d1ttOOldODpvbZ25alThy7f0TE5jl+LK8dIY8yNuDknDqGXR+96
         z0TwZtCXNHdGkyg2alOLScqqP/IWEPlY2CSLlBUMWXpFcSUoCAzbN6HQICujolkClvZs
         rhv8ezH66b3ahfDOK517rdEC0hvfxdBUjUXyolQGQht018xt3+hdbhHANkwu9hOJFdtR
         bpkVhcfDElIEbXVmrZ5XyHK7n+M7XK1ZUG78fzR/8SbbRymA8td45XEBzWnGyWAF5BiW
         j1K8MEI6GrHLf+xZbBupiMjaIp/TNKXU+HeZXBgP0Ku64h520Qhbs233joCZP3UMvnsv
         +7RA==
X-Gm-Message-State: ALKqPwcJzxZ9DcrWZEYAdNGZaW0J9gAxJhrxkooB+uVg4K5I78uMuwF4
        wD/Z7bNeHD/bRX3mcsDRxSTs+clJ2+oqb/4FPCA=
X-Google-Smtp-Source: AB8JxZpN8fwaBowStu0O0bBGOkXniAMdzULVf2M8smsy4e301Y7myiViTfjITTH1BeVPjVv7LMAzhNrjPmpNFEDDSQg=
X-Received: by 2002:a24:8a47:: with SMTP id v68-v6mr320099itd.21.1525930755326;
 Wed, 09 May 2018 22:39:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Wed, 9 May 2018 22:39:14 -0700 (PDT)
In-Reply-To: <20180509215728.57046-1-tiagonbotelho@hotmail.com>
References: <20180509215728.57046-1-tiagonbotelho@hotmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 10 May 2018 07:39:14 +0200
Message-ID: <CAP8UFD0WmU7D+NGyNDdavixoQFrc=RRR7sgqq039hbmpyPQYWA@mail.gmail.com>
Subject: Re: [PATCH] Implement --first-parent for git rev-list --bisect
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tiago,

On Wed, May 9, 2018 at 11:57 PM, Tiago Botelho <tiagonbotelho@gmail.com> wrote:
> ---

Please add something in the commit message (above the "---") about why
this new feature is useful. For example you could just say that it
will make it possible to implement bisecting on first parents which is
useful for people who don't test all the commits in the feature branch
they merge.

Outside the commit message, so after the "---", you could say that
this patch is based on pu so that it can be on top of
hn/bisect-first-parent, and that this patch is not finished as it
needs some tests. You could also have signaled that by using [RFC
PATCH] in the subject (see the --rfc option of git format-patch).

Thanks,
Christian.
