Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63725207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbcI2Shn (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:37:43 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34591 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcI2Shm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:37:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id r132so2110964oig.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fQVVdGDb3Q7Vkb7IJgMIh5zgrHdHv+81RG/Nw8ZMYXo=;
        b=x0abUH8F+2mIkZtrnM7SDdjeYARFV87sIdgaWm+snOGg3557zFFSwxtKxieU2mZ8c/
         lsski8RJtVWmv3gwd5kbmKa38TxhjCiz8furiSBHXlKyCuB0to+0Loi7W+AFSjdFz7td
         Es4Lm0+PFmVsA71QGLo76Fknz74uMiWp8SrbeitFu4wcx/TBYg+lpJGyPer4FtC8nVIh
         w7eqFQn6AuEOhR6XhOb+rAsMaz72ojUHQkLa8QHZVyDE+bTvE/IvoYrkQ6XNS1uTtZeT
         Vj1igFxLLG5CQ1qNWFJNr+pIRMf/h04CklgM0lBrnuHbdV5SBvwixoOz+ZJ7gEZfueDr
         DTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fQVVdGDb3Q7Vkb7IJgMIh5zgrHdHv+81RG/Nw8ZMYXo=;
        b=SNJ8e8ZNMHaO/qbe12MzaieGmHPmG/+DDtoASrRNIeW3HEYDkTrb2SDXaVeWWmusBo
         aFtvGpmzyLbEeMogkonrCjTmgwpmFrAExTN67pPibgdtSBugKd2dA0MCtLRWtEM1mpbi
         VkMjm1qYMuBScWStB7OoEtndpc3AAknQxi3PoGIeR+I9wG58/B1ReAy/1POazVUNhhxw
         0mCWrZj7rY6qAXl+lr+UvApIBXRfKKghvNlCKigd/SEpKvVCEnPFDjuVBZErLGxQJHG0
         hE6RuBEldqMbOr4LThnx7dt3xE8/T8RhOmfNZxA14ortDFzQE/qLJrnvpH4+OjrHliDR
         qfnA==
X-Gm-Message-State: AA6/9Rn4R29w5pfca2afbr3BbXM6lqPCZtVRrGl+wcwuaPXFRZ0kyYrALigkuUCSWncLc4eGSsKdWZArmZYthA==
X-Received: by 10.157.39.2 with SMTP id r2mr2177742ota.103.1475174261820; Thu,
 29 Sep 2016 11:37:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 11:37:41 -0700 (PDT)
In-Reply-To: <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 11:37:41 -0700
X-Google-Sender-Auth: 9BbCEtOi163zDYNP7v0EiCRNm5w
Message-ID: <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Yes, "git log --oneline" looks somewhat different and strange for
> me, too ;-)

I'm playing with an early patch to make the default more dynamic.
Let's see how well it works in practice, but it looks fairly
promising. Let me test a bit more and send out an RFC patch..

              Linus
