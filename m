Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BBC51F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeJOWpS (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:45:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40386 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOWpS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:45:18 -0400
Received: by mail-io1-f67.google.com with SMTP id w16-v6so14464341iom.7
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dA9zO8bSmmot6jDyHOdwHTGv6g5+zk8vlERAg6GNN0I=;
        b=VvIRCHjtOqq1YrD1AgER4a1fgNXEGXU9vL9+VUksoz+LKQc2NdTxTqw0iNP5cDsi9E
         PWilD+sYY/7BGHRBnoTb143dsq7MD7DdoPUn0AuqtC8/CWfxwp/vtEd6tHUO5h6LHQPB
         hwxbI0za5hffytWrsQNdGdgIgr9Q3+WDy2N2cRdbnhTp3OrYWJ/bDBLKvd53F5zz6lPg
         PSd5HnAHo4lsZa/kLv88oXp1ioYbzyuXSIhx3OD09OVbW9l0o43A8edmj+qkQbLDc0Qy
         2hBLd9h95LWw5qnrUuJkVYZ5qmE+Sw4sDinanBoge+EEi9mctWElsFvHJxfZBgVvcsT/
         B+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dA9zO8bSmmot6jDyHOdwHTGv6g5+zk8vlERAg6GNN0I=;
        b=IhfCFUtvWwtnL8Gq98jalvu4AOc895/f1JAalaSo99GGxucSKwkjcCR5bS5HaJ4aWt
         kdhL513Zs2ebKkJVuTpRsfk8zQYYqEh4Jg1CdaTYYIblV6zt42nE/VLgfPXUkWj1MI0E
         Qan3lD9IA9r2JWwrXr1Dx2NNF0qpWMSEi3XJzu8SFpNg75VKJdYvTq7Wk9xCPrYkEAis
         DsyCVPPp18Tu8IQk6sGNgCdUHa8jqUZYgI3xMPoOSFmSnJrmv1mi3wZ7vU9as9QoFxbE
         nHmBvQ/m1cDvjzan4czmskaNRrpaajKHXUEENFEN6M+DfwoCu0MisLiwgdYViEOeo3uA
         2RDw==
X-Gm-Message-State: ABuFfojFvtooTD1LAG+izVIlg/b40O7BslUTL3lSJ6C8bsT9cs+LECp9
        iDoLPcK6AnvdlJz+CED6CXL+wYA8aOExrr1cxHCbMi2Y
X-Google-Smtp-Source: ACcGV60v/p94piG3jaKOJg9kPrFDY3LBtBOWIXhfQwtZ0qTCFTrzVE1/Gm07VZWjcTrXC6ADPEAX/ihF4tEMUkMIyyM=
X-Received: by 2002:a6b:8b97:: with SMTP id n145-v6mr10124735iod.282.1539615580361;
 Mon, 15 Oct 2018 07:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net> <20181015021900.1030041-11-sandals@crustytoothpaste.net>
In-Reply-To: <20181015021900.1030041-11-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 15 Oct 2018 16:59:12 +0200
Message-ID: <CACsJy8AOu-SdLu+MQKOzVLEy0SM0r45TjwZYkD_S5W756hWRpw@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] Add a base implementation of SHA-256 support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 On Mon, Oct 15, 2018 at 4:23 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> SHA-1 is weak and we need to transition to a new hash function.  For
> some time, we have referred to this new function as NewHash.  Recently,
> we decided to pick SHA-256 as NewHash.
>
> Add a basic implementation of SHA-256 based off libtomcrypt, which is in
> the public domain.  Optimize it and restructure it to meet our coding
> standards.  Place it in a directory called "sha256" where it and any
> future implementations can live so as to avoid a proliferation of
> implementation directories.
>
> Wire up SHA-256 in the list of hash algorithms, and add a test that the
> algorithm works correctly.
>
> Note that with this patch, it is still not possible to switch to using
> SHA-256 in Git.  Additional patches are needed to prepare the code to
> handle a larger hash algorithm and further test fixes are needed.

At some point I assume SHA-256 will become functional and be part of a
git release without all file formats updated to support multiple
hashes. Should we somehow discourage the user from using it because it
will break when all file formats are finally updated?

The simplest way is to just not register "sha256" in hash_algos unless
some developer flag is set. Or rename sha256 to sha256-experimental or
something to make it more obvious (but then we may need to fix up the
test suite after renaming it back to sha256, not great)
-- 
Duy
