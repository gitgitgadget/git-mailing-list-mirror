Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC111F731
	for <e@80x24.org>; Sat,  3 Aug 2019 18:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfHCSvE (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 14:51:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34825 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHCSvD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 14:51:03 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so159442938ioo.2
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTU22mkAuT2gKmBhTCb/fNhae49t+n2n2H1FFN/Xxso=;
        b=HTzT7D5GgpUQapcne4CO7GyFZK3Oif6Y83SLgqcpZdosQJnoj1LHoDfg3vVpNncc9Y
         2qtiZqcd1J4z8X0BrRnHv3MYap9OvYkId6qdgmDF5wE2Rwd9tRC4up9JqfKTZ/37gzWY
         NQPOi6Q8RTDRy5XL8m/W4HeIbvu90tm2XmDmwJOMJSvN6ELz/fw2vO/enkbc8+wxVd+e
         0F7bqLmREcFjyVNeCni9YTzWYFgD6oEYc0UC+Xcsf1ucgBVclWk9Hok8luMfHS4NYKx7
         4NhtLYowXZtijwZ8H0toIcMRlvlTgcvorLZajbNb3UtTnYYJHQFEO3/3vYsYCuEFE7ul
         y/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTU22mkAuT2gKmBhTCb/fNhae49t+n2n2H1FFN/Xxso=;
        b=KgKCHsswR7ZGgQ0j2lHbKcEEphZE+pyv7yyY9MP8Z3B88X3pSMfZTs1SAZf2FD18pl
         nXdUP9hZEBtrXcJMry/JFMRWXkfMXZri1lU6s0EnvHsBzs+w74S5pnrsKvlbr6HVKQKp
         XULZXkmbF+Xeh9nBZnAvpCMr7wGVnB+0E6oc5/LjLWPU38Jsrt0gFdUVdN7beAtlfX7a
         Oiof6wgPGyf7HMREJEh5WVhCRousio4tAfQqfL5StKLZLNn9V6K36bz4yl3padAOumuJ
         v7PkQXy3L14Z5J1VfqCYKq2hay2edmcniIuZvKCCZfuYO9jLXxojw9/MAnde/fA7LXmC
         aAfg==
X-Gm-Message-State: APjAAAVyg7/lxSxwGitFDXa3d0VgyKMZMkf+jNMdasdCMeNZCI83RUb4
        15FazUiXAbspINGAeISenNPq2Wn45laTIA1EZcU=
X-Google-Smtp-Source: APXvYqy2Ml8JW1WBfLbz3j3X4r2Udztk5IKTTIHaGemw8vkTkb0eMSl/35eBAYqKu5jdBQdGh0oeeKkc8ghpvVtAFc0=
X-Received: by 2002:a02:6016:: with SMTP id i22mr119569741jac.56.1564858262706;
 Sat, 03 Aug 2019 11:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190727202759.22310-1-carenas@gmail.com> <20190801170946.81221-1-carenas@gmail.com>
 <xmqqwofvleuv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwofvleuv.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 3 Aug 2019 11:50:51 -0700
Message-ID: <CAPUEsph2S1+PpET6R-=YnTyvm8+5t5ytJL6VJR0nbmyMQWcYuw@mail.gmail.com>
Subject: Re: [PATCH v2] grep: avoid leak of chartables in PCRE2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio

Thanks for fixing the conflicts in pu as well; apologize if I could
had made it easier by doings things differently

Carlo
