Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF911FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933503AbcHJWqN (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:46:13 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:34979 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbcHJWqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 18:46:12 -0400
Received: by mail-it0-f47.google.com with SMTP id u186so50818356ita.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 15:46:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ylWGJqWKX63Kb5Ho70XJ7b68LpSzBEBSKEjZWHrcRwc=;
        b=KpLAbteGelqePgNr0NvSlCgYLGWZyG0gKJsQAUAKD0pfJ4wcIJY/qZqYusHOWRFWj0
         HI8d2LUJImnI7w1fXtEYcYWjtNdS6jJRUllImy/5f4iFxpVgIhMTV7QEzpTEs0yirLPK
         vOJ4qY216VuYhaPKsSmxKBVtJMNqeJ3FaA/A/1R7bkn4hZIT1UFGZN/NiO9XalEr7Rnt
         tABJsJsHKWMXv9g16IddxVpZ+7SBmUYMdrZ9WL9sgLfeT4M3ZuTwpyJEd8DtLR8oIYD/
         rlXrDrE8z+tcU+ifND8Z+A1VhhVtfrTSSIgRhYVMBJxa4mNTGYWZxNkzrx8Zi5pKoPKB
         GZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ylWGJqWKX63Kb5Ho70XJ7b68LpSzBEBSKEjZWHrcRwc=;
        b=d+s+rZRPEdz/jfugJWx/HABMdJu9KHdLwp8Tgd0FVkhBB7GKoThQgNbdssdR4jO7rb
         7QaPXsVVQGfhwaoN9muHoKmjpL6ozHfqbhPWlKKtKCJepS7uqa9oXvpql8M/tFTISYGN
         HLdTNZXs7TbIIjbzLjoxQCdXB5RplPU4x015h5GFbc57orun8FxrdXuVORZNUXnTlsCW
         wCKizuWfihqbcJIFfnfAzq2evRsvzojDmEC8afbUPrJIt8W0ahM3A0beZ0xBPO5emGAl
         +ox+GUoF9YAKyRJWTizbIY89jFuP9elSPH2EzYvg2YVcATy9DDFFyeWiB/uRyGJHC3jj
         WYwQ==
X-Gm-Message-State: AEkoouvSkurCms5wjugX8bcevhs8YoLpN6jUHQZEZEz2q5IIvbavXiD1uLgJZFIsl0fPYXVM2ujWG9/QSOewz1GR
X-Received: by 10.36.217.9 with SMTP id p9mr6377549itg.46.1470869171601; Wed,
 10 Aug 2016 15:46:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 10 Aug 2016 15:46:11 -0700 (PDT)
In-Reply-To: <20160810173218.GB14758@google.com>
References: <20160810172800.23575-1-sbeller@google.com> <20160810173218.GB14758@google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 10 Aug 2016 15:46:11 -0700
Message-ID: <CAGZ79kb+PvU5yKfr9D0j13JWeo1mqcW=CWvVD88UrEeg1WBTpQ@mail.gmail.com>
Subject: Re: [PATCH] checkout: do not mention detach advice for explicit
 --detach option
To:	Jonathan Nieder <jrnieder@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 10:32 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> When a user asked for a detached HEAD specifically with `--detach`,
>> we do not need to give advice on what a detached HEAD state entails as
>> we can assume they know what they're getting into as they asked for it.
>
> Example? Tests?

There are no tests for the advice things IIUC.
What do you mean by example?

Stefan
