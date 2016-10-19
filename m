Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD531209A9
	for <e@80x24.org>; Wed, 19 Oct 2016 14:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935080AbcJSON2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 10:13:28 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38394 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934455AbcJSONI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 10:13:08 -0400
Received: by mail-it0-f54.google.com with SMTP id 66so29173172itl.1
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=un8Llj5u6murPodlse+Jm0qCG6auGZYu4M7RO0PWtTU=;
        b=SX8jqUtcVOKoCRW87QlfmzN3R5EIqk5ZaacaIiaLXFrcdvinugSQOOu5Ry6FNW0eIu
         kBvEWEk/Ogu6fILX2xyFftWasLtPaYmx7jDePw4ajbA8rqjyh+jEhD7jCIwKfeIv0VvP
         GmguDgbC5j5D+rcNxFRofiOj1vXpH577z2hyEqLcfLLR+KDZRlk8FxWNpdFPCqJzn+x9
         o0EaWKfpYuPWzLhtjxxn7DTSY9J1KlCzloGIKEZP7Y2BsEJ0hzasblOAd7Ogg4D0wT9p
         5DnViLW+jJebmj4/VvMGHPfwoVUJ71ZRkhtKitmZjCmW/dRPPNoFskPbFQo2t7HZIqd/
         rYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=un8Llj5u6murPodlse+Jm0qCG6auGZYu4M7RO0PWtTU=;
        b=lMNmc77GcglWr6en7X+xOJcyZKhA1LaAunLSIbCeHGnDB2R7eMAqs7xN+BYq5hbAw6
         pQ88zVNGm3B5ED/7pe1xLk5AhIkOIS/cBfMGvjpu7ABA1XO4GPDDiwWIP779Dd4/nd79
         LJNGzaYfxsXB13ZdpT8H0/B0wu1WkoO4ZBDp580iuHloaHUpRj6otgYYZsNBHG0jS34C
         qbEygcjuCTn+cmM8RQKimopd2skoonzvGN8oFkq5h2KdI2uRmsudApx1DkuNOF1nzgoP
         aMJVvBW00fJlvAP+GHZBZJa1CzIw7i/SpVWpL1qczEl531zdcc44Szp6xryxZ9XvG9r7
         RV7Q==
X-Gm-Message-State: AA6/9RlQ8yPHvTQfdIv2M+5ELW5EJoNp7nh+8G2nOD6y7cWk5+xyQXkQ8WOkuztGCIg3bcKnpVJDZiTELoQXoQ==
X-Received: by 10.36.33.139 with SMTP id e133mr3056036ita.3.1476886387913;
 Wed, 19 Oct 2016 07:13:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 19 Oct 2016 07:12:37 -0700 (PDT)
In-Reply-To: <87pomxildc.wl-lukeshu@sbcglobal.net>
References: <20161018150629.23205-1-lukeshu@sbcglobal.net> <xmqqvawppote.fsf@gitster.mtv.corp.google.com>
 <87pomxildc.wl-lukeshu@sbcglobal.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Oct 2016 21:12:37 +0700
Message-ID: <CACsJy8AzWqJ_9JQ_BGnAB3E3GrGSTS40z8umbtO6mQJukWOooQ@mail.gmail.com>
Subject: Re: [PATCH] daemon, path.c: fix a bug with ~ in repo paths
To:     Luke Shumaker <lukeshu@sbcglobal.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 1:05 AM, Luke Shumaker <lukeshu@sbcglobal.net> wrote:
>> I am not sure if it is even a bug.  As you can easily lose that
>> tilde that appears in front of subdirectory of /srv/git/ or replace
>> it with something else (e.g. "u/"), this smells like "Don't do it if
>> it hurts" thing to me.
>
> I buy into "Don't do it if it hurts", but that doesn't mean it's not a
> bug on an uncommon edge-case.

The amount of changes is unbelievable for fixing such a rare case
though. I wonder if we can just detect this in daemon.c and pass
"./~foo/bar" instead of "~foo/bar" to enter_repo() in non-strict mode
to "disable" expand_user_path(). If it works, it's much simpler
changes (even though a bit hacky)
-- 
Duy
