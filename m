Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592E01F404
	for <e@80x24.org>; Thu, 15 Mar 2018 18:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeCOSlo (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 14:41:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42977 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeCOSlm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 14:41:42 -0400
Received: by mail-wr0-f193.google.com with SMTP id s18so9284385wrg.9
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sCh3hmGkga1wfz2yw/OOv+kveXjYh4MYrdmtjsuCgDg=;
        b=i23Cq8JYUO8bpwfc0dpg3AF3d5Bo6fwrgfpi8xk3FeaoDNngJTHZL32LYRewkKQug2
         w+r9Mgo/IAtZIWOXyDuiang9cClndmdqV9wQOJbL0iWCAOU0dTPUM8mvs0A7Srpir/DW
         td2pSLb3COWC/Fv0pezoxb0K5CzoTttxklxvxNNQlIiQvDCYDHFnqEjsxVEvzIiNLWV3
         ZMVhR+cC9x+Re29DHVVDGGNsX8AYiTR+WYo9nNeWA6VTBTZ/QHgKKtgno0C+LhwquN9K
         arHuFYfjQlUI2pUyueFlvMVEkvFseEqR72K2ZtEeom3Nt3P4dvypVD2DDwLQqF6tUZHV
         XuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sCh3hmGkga1wfz2yw/OOv+kveXjYh4MYrdmtjsuCgDg=;
        b=IKToX8qLvSnXf64pITpQxgUZqBGOWdrRy6eJvGfN/yi54UTuFWuc0zm6xQ2ezS8DiY
         MaIzUr3tfzIaNGnHHWPGDcqMZDJvJj9qE9/9L3nlkmAte4LKLjuOGc0Uq5cEZWmMWatx
         ykW3tsuvq+kTFsUNZuxXZv0WX7H5rFqzqifjlG5T2x84AZwpBXj2z1Jn046GWMTKKT41
         bGP9yNvhYzsQH5Pu6102+zbu8mvz6XZMpJlQOIBIdCXVx/Fmo/r0cGH97wSEpzeOmj2Z
         WLcJyCuh+50f88MSAv+93msKCFkKhrfLfSc7aR6XSzSUimiV4gNfBbLZhSvYtLrH25CH
         o3uQ==
X-Gm-Message-State: AElRT7HpmdQGFKbAUjCo/XRsAZyKdG76tlZzaxcwR41Coo6zPkQpSIkW
        rQ68me98yTRQHUsi8W3jQZEm35/lots=
X-Google-Smtp-Source: AG47ELuohIOa/hYST45RPCj5+8gmFRlAWkc1ktuiMDCxsi21t6MbUGbEJ8qVEKhPpUgJZBH5Fu9P9A==
X-Received: by 10.223.138.138 with SMTP id y10mr7489216wry.44.1521139301279;
        Thu, 15 Mar 2018 11:41:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q6sm6140650wrc.30.2018.03.15.11.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 11:41:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
        <20180314192736.70602-1-dstolee@microsoft.com>
        <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803151821270.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 15 Mar 2018 11:41:39 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803151821270.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Thu, 15 Mar 2018 18:23:12 +0100
        (STD)")
Message-ID: <xmqq37115ggs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Stolee, you definitely want to inspect those changes (`git log --check`
> was introduced to show you whitespace problems). If all of those
> whitespace issues are unintentional, you can fix them using `git rebase
> --whitespace=fix` in the most efficient way.

Another way that may be easier (depending on the way Derrick works)
is to fetch from me and start working from there, as if they were
the last set of commits that were sent to the list.  "git log
--first-parent --oneline master..pu" would show where the tip of the
topic is.

