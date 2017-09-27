Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5015C2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 22:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbdI0WES (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 18:04:18 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55843 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbdI0WER (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 18:04:17 -0400
Received: by mail-it0-f65.google.com with SMTP id 4so8349668itv.4
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=P5gnVxrRWzO+irzBVn4puDKkcLz8GYPv4ooM+VP4Dmk=;
        b=jfTLp6r0g9mruzSvEgCEeEmVZhg4bA7Qg+XYelVUwz1uFFujwNZ/0Ns3UbV/s6lpVK
         4XJ6q/zzX7zmpBffLIdSh2icRoAJzTcDIQaLLlAw/35aINKjke1m2MS4xZLJtCy/eVMj
         ebqL9zCHQPXFpQfP0vUDiDTf56w7rQhyCFuzraxBZ27jcCYZm2s2ItwLDHxKZMqHW4ec
         PxfmCY7qM+asYPKmRig1sAUl+dC5fWm1bzKch+ikE1sVu72s4gJkq0E4t8yeEp6Uu2F0
         uHeCzpdLcWC+Bv1wjrK85pTHK6ZLBtwHku0lSY6+L8x1sJKsmywfb5+UpJGexUvv3l9e
         v/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=P5gnVxrRWzO+irzBVn4puDKkcLz8GYPv4ooM+VP4Dmk=;
        b=p5RbBlBNgN3aYn2jP6gEbPo+r+hWjM3OXuJjSXR5aLt4iZKas2KVw7L4yQbOX8fTIZ
         hCxKnfEoqpF+rJxzTFnEZWevUzCiFyN+2A46fOelhnJwI0vcOB+g3hzImyZ1hCNSrHvm
         1RICW1qLQcKQd1Y0sIJoLDICaOYAPsPy6ifIANqlBTMeT//bV2REEjudz9HMWBfuJJDg
         sqilTYFUuH3xi8AS4s1uU70gG2awqEJ1k6b+EZHBRGypqn9vmVKG6SCyq4eZIpoiOryB
         27XdZ4MejgWyTPTpyYBwk7yhfmfr5hlpJOlD+0txB4u9Fo3mLzdVFih2fF4EMCK4p9aF
         7NAg==
X-Gm-Message-State: AHPjjUg61glPCJ4hSMCug8jCZ+nSCVktoE01gBfdzmTJCkOWpQbmZDoI
        q7rYcNcuufNMYUDW2/k7dKDY4UOoCF4M7zfHd2A=
X-Google-Smtp-Source: AOwi7QBRIzLVXTvYj3ebW1/xelYpEMWrJl98AYBJupI6hv8uk5VZNwTUoc4HAAC1Od/c3yzBy+NQ4mfofl8I5/wdO1Y=
X-Received: by 10.36.12.14 with SMTP id 14mr2906343itn.94.1506549856674; Wed,
 27 Sep 2017 15:04:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.103 with HTTP; Wed, 27 Sep 2017 15:04:16 -0700 (PDT)
In-Reply-To: <20170927215852.20163-1-sbeller@google.com>
References: <CAGZ79kbCgTNaunfneWHP3xkLeXwW72CZZWs7Sv8A7QL_UYE_HQ@mail.gmail.com>
 <20170927215852.20163-1-sbeller@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Sep 2017 15:04:16 -0700
X-Google-Sender-Auth: Uj0WnJiwtq4kLnVPujQ-lkRSZHM
Message-ID: <CA+55aFxPZ8+MrB5mbad76aPo8v9S-Q9p3zvK7=j1m2e7o2dFFA@mail.gmail.com>
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 2:58 PM, Stefan Beller <sbeller@google.com> wrote:
>
>  Linus, I assumed your sign off for the original patch. Thanks for spotting.
>
>  Adding the mode change to t4016 seems like the easiest way to test it.

Looks good to me, and you don't need to give me authorship credit.
Just a "Reported-by:" is fine by me.

But yes, you can also consider the patch signed off by me, although
with your test update, _most_ of the patch is yours so it feels kind
of stupid to mark me as author.

              Linus
