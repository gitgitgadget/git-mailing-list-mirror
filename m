Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D14A1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 07:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeJ2Pxm (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 11:53:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37971 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbeJ2Pxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 11:53:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so7396070wrs.5
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 00:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6DMUgHVGYY+fIV8v4lZ2iGPlQQCWcgINJEUHpbfhA98=;
        b=ImIr0GG4S7dfqx6E/Zc/gxpTqytEorz8pgyuZJkCEjJcL8Z1OoNdvkOL0IwM9mfO6I
         v6T6BNliPs8AbQAsXESPWYmt8a0lsc5QQv0obbtwyJ2uOqLANGl3stUopfjapeZy0MPi
         O3HAysCG23plHctJhxhcD/XvMCgGs+ci6VBDid0oDFG0Uw2JUaxLBTEjnzpKeXUm0X5s
         enqtLcwH7OE1n1yqlbTw6txI+j0LcKwJtToVq4tsnP3nGqnVHlQDtLvfIthoJj3keBMJ
         JJ892Bgn8Pe1Ki8YC+bNTgB0PTewIajc8KqAuy6FARpHStVTXjNtIDcuvTHoJkWblgYb
         s2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6DMUgHVGYY+fIV8v4lZ2iGPlQQCWcgINJEUHpbfhA98=;
        b=USXNY5ztWwO2I1Nzwgwm97oAVRRBFzffb4mZTvUhCacmekV4IVlYo4WNq8fBXlEJBk
         zM3tBRGLnuXUmrwiQ6Nc3MNXqbs3ZsW8qN5OhfihsYirzFdJKcksCGvFbCD/9e7hfJy5
         3BqpRNlI0I2IX2VB3IzOdkT/0Qro4hAohhGJ9XoFVuHMGjOMrI2IWFhw3yN9R5eV9VZs
         7XaGU8gq/2+pdXoAa/VV48vfrYpvfpOpixkpz4Pv6RImp7cRGl3MOR44elRg6WMmTMNO
         5+lyn6ggV70G3PpG/uQpmwrw98RRznKAMGreSb2Fwfj5+a3+wnk4PA0EP5J2NZd8y0JV
         i+SA==
X-Gm-Message-State: AGRZ1gIMZNWpz71ihL7cx9PchAGvaHhQ3KfjkVfJu2dWkSvsgw30Qm1W
        LZ3y6FZzh/07bNV/0VeoSmM=
X-Google-Smtp-Source: AJdET5eRPfITe0pTqFgOAx3A67kep7AY9fficjnWxIwHcvW59r0ELjM1kSUkgQpq0Lj9kER4mRVwEg==
X-Received: by 2002:a5d:48cc:: with SMTP id p12-v6mr13790263wrs.122.1540796778743;
        Mon, 29 Oct 2018 00:06:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q185-v6sm1400975wmg.45.2018.10.29.00.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 00:06:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/8] push: add DWYM support for "git push refs/remotes/...:<dst>"
References: <20181026192734.9609-1-avarab@gmail.com>
        <20181026230741.23321-8-avarab@gmail.com>
Date:   Mon, 29 Oct 2018 16:06:16 +0900
In-Reply-To: <20181026230741.23321-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Oct 2018 23:07:40 +0000")
Message-ID: <xmqq7ei144gn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> This is the first use of the %N$<fmt> style of printf format in
> the *.[ch] files in our codebase. It's supported by POSIX[2] and
> there's existing uses for it in po/*.po files,...

For now, I'll eject this from 'pu', as I had spent way too much time
trying to make it and other topics work there.

    CC remote.o
remote.c: In function 'show_push_unqualified_ref_name_error':
remote.c:1035:2: error: $ operand number used after format without operand number [-Werror=format=]
  error(_("The destination you provided is not a full refname (i.e.,\n"
  ^~~~~
cc1: all warnings being treated as errors
Makefile:2323: recipe for target 'remote.o' failed
make: *** [remote.o] Error 1
