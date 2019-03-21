Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6549920248
	for <e@80x24.org>; Thu, 21 Mar 2019 02:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfCUC6G (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 22:58:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37034 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfCUC6F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 22:58:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so3483290wrm.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 19:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vozj2qjgQz4ST06RvroNmQt2tQtisQnpxhNkp8cyqi0=;
        b=Cxcx1AZheWYSIpYGJpg6SWrYGsoVFpz9KZP99LfsqoHjVQy7PfZGjfck5advBbuVgP
         mhSZ94nhQSpgEXH/ZorQg6GGf82xvrr6JnX9zF8yIiXckpQh1GfWYZs/uV/IN0h5KKu1
         F01MeOkZgGOBn1VYOsgPIRkddZeWs9XPByYqrwRdpESLhPKhADbybDD3uyVz992ELz5X
         ZuIq5Mg5fJc+G4yNFe0I7+A43AT1uaZgg8sZE+15OnCnNRZbHHBmY7JijLDCtr+iZjuZ
         x50e7wGcZgGR8UCsvR1mT8UC9kx028Soxaf3x4G1tZNgAy2JHJ9grvhFKK71kPooXF8o
         p/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vozj2qjgQz4ST06RvroNmQt2tQtisQnpxhNkp8cyqi0=;
        b=hos4GEQMbIiawrL0759zn/B8ac/cdt6uUA5jlIypRNzwuBy2SVh7jRSDn3gd8NkxWu
         AMgt6PH92ZTdGHgA5Capju3QUvX6NVAwvv8hlzHWdzIOzSQyXVrGIRqkvbVLPzsKDyv7
         7h06NX5zQQXnAfOlhDJ7/dGwtI52VUOQUxIZi0ejY2Le7QCSBArbyO6fGq4jV53lnMnJ
         x2k8hoBkmxnhBYjjwIQ2vIt+mJ4UoURE8PyZdyZw0gEaEqumZEWIhIqY/vQxKuDGay0i
         oOvAmHFLkTLRWZMrGTgoIleuvjF0srAzeUUHmmHjAds+udLTJRLSCgaO6w8nWsA+ZNST
         S0Ag==
X-Gm-Message-State: APjAAAUijOoxdRdsWq9zsw8lUadNEh3LaPw/4AXao5QDPLldsfUKD0f5
        mEaIQYFsG8m6tQRD8QrMBmfUUM8j9Q8=
X-Google-Smtp-Source: APXvYqzEQkAGR9jAyA+67K+UCU6c0HVGNJGzK4nlBmTK30jqTiHFzsKnOqMBDVsSlVM7SbuCLYRZ7A==
X-Received: by 2002:adf:dcca:: with SMTP id x10mr802538wrm.57.1553137083887;
        Wed, 20 Mar 2019 19:58:03 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f128sm3238060wme.28.2019.03.20.19.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 19:58:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/4] completion.commands: fix multiple command removals
References: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
        <20190320180329.22280-1-tmz@pobox.com>
Date:   Thu, 21 Mar 2019 11:58:02 +0900
In-Reply-To: <20190320180329.22280-1-tmz@pobox.com> (Todd Zullinger's message
        of "Wed, 20 Mar 2019 14:03:25 -0400")
Message-ID: <xmqq8sx9szlx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Other than a follow-up to update the commit reference in 4/4
> after 1/4 is in the final form on pu, I think this might be good.
> If it's easier, we can skip 4/4 and I'll resend it after the
> others are on pu.

A series that makes a single topic should expect to be read by a
reader who understand the context of individual pieces in the topic,
so it is more common to refer to an earlier step of a series from a
later step without the object name.  I would have written the log
message like so instead:

    completion: use __git when calling --list-cmds

    As we made --list-cmds read the local configuration file in an
    earlier step, the completion.commands variable respects repo-level
    configuration.  Use __git which ensures that the proper repo config
    is consulted if the command line contains 'git -C /some/other/repo'.

The whole series looks good to me.  Thanks for working on it.
