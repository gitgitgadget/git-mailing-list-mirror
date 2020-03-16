Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082CEC18E5B
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 16:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDCA2071C
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 16:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB+hJTvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbgCPQc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:32:58 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44483 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbgCPQc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 12:32:57 -0400
Received: by mail-ot1-f53.google.com with SMTP id a49so15698020otc.11
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JL0iBDAtYJfTdSvf/5SBFsnYmoRnzYneBVBfPG+oAqo=;
        b=PB+hJTvK8tjj6unWX8jegFuOJxCeoPefCE/NrRO/ZXeyWWh8QsvrxNjEuPCl8omHuz
         YKllk9eaTZ3Tf9Xy0zp4ASxYVo/yotWoPj+TcJBCCJDWm9JAdS0Jhmdxc3FXwEckzVrb
         xJq2oWY/Lo9ZYUKVXptmdpJFbSN8OOSGWToRM6ghk70Ey6HgNZsU5N0maQguL7zPlGB1
         3PtUFIPMqJN2YcKX1mmfA7mPwlVj/8UF8rfSVl8JJhuWzoW+2L/rHQ3GWKKt8/lLkbDM
         jtkprD7aICTHSIjXISB2MS3HDoGk2kxzEZZyX44ZW2Ue288Mojjaw/gKIkWc1jx1wprv
         OQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JL0iBDAtYJfTdSvf/5SBFsnYmoRnzYneBVBfPG+oAqo=;
        b=fimenv2jqIN6U7oQQ6U9R/7IQA7WLhzBddYTIE73CANc/qrAD1n1B9gjmAOh7P7Scp
         sNulIgXXU56xOgL4BjpqEVVLfFPg/jbqaBvfVE25ZAhF6+qK2e1PgSpzBAQKUWX9uY1l
         1qUyfG4bzUFCJLl/ZXsHe4V8mDsKRMBi1d82OkWrxIP/UfhzEHvhnj7mDMbZhTkwOEe1
         /lETYDJbcEcVI/Kp71nDqtzUSX0XJUa4ZEYiIpOnK/I9uHlzedTYnmeAvh/kD4UjnM0V
         VzDc8D5GDEGW5DZfzqxh7AS7P0ASPz816WuWsHteaCPimfqr3qfV+LN1VsX6iqUrxvGx
         EQOQ==
X-Gm-Message-State: ANhLgQ1d1FMsyobrAeP5+e6g2ehpfsxJ3+q7ghZPEf93A1fajfbZu13/
        5/3oGq3u6tGDu//tFy0IPIsbWpwgPRWqnc36sfRhiA==
X-Google-Smtp-Source: ADFU+vsgimjXbZCPtzZmwi2QJxBbzKg7xOpqmA1uhnl4vuMmsrC+9Q90hspxSaMBMQRyUqm1LP3icfKFkz5eksDk70c=
X-Received: by 2002:a05:6830:1ad4:: with SMTP id r20mr113001otc.316.1584376376703;
 Mon, 16 Mar 2020 09:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au> <20200315221940.bdgi5mluxuetq2lz@doriath>
In-Reply-To: <20200315221940.bdgi5mluxuetq2lz@doriath>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Mar 2020 09:32:45 -0700
Message-ID: <CABPp-BEnYTvakuP9nBi3Q_-mP3i7BJEvKofC3_4N8cO9JkF22Q@mail.gmail.com>
Subject: Re: [TOPIC 3/17] Obliterate
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     James Ramsay <james@jramsay.com.au>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 15, 2020 at 4:16 PM Damien Robert
<damien.olivier.robert@gmail.com> wrote:
>
> From James Ramsay, Thu 12 Mar 2020 at 14:57:24 (+1100) :
> > 6. Elijah: replace refs helps, but not supported by hosts like GitHub etc
> >     a. Stolee: breaks commit graph because of generation numbers.
> >     b. Replace refs for blobs, then special packfile, there were edge cases.
>
> I am interested in more details on how to handle this using replace.

This comment at the conference was in reference to how people rewrite
history to remove the big blobs, but then run into issues because
there are many places outside of git that reference old commit IDs
(wiki pages, old emails, issues/tickets, etc.) that are now broken.

replace refs can help in that situation, because replace refs can be
used to not only replace existing objects with something else, they
can be used to replace non-existing objects with something else,
essentially setting up an alias for an object.

git filter-repo uses this when it rewrites history to give you a way
to access NEW commit hashes using OLD commit hashes, despite the old
commit hashes not being stored in the repository.  The old commit
hashes are just replace refs that replace non-existing objects (at
least within the newly rewritten repo) that happen to match old commit
hashes and map to the new commit hashes.  Unfortunately this isn't
quite a perfect solution, there are still three known downsides:

  * replace refs cannot be abbreviated, unlike real object ids.  Thus,
if you have an abbreviated old commit hash, git won't recognize it in
such a setup.
  * commit-graph apparently assumes that the existence of replace refs
implies that commit objects in the repo have likely been replaced
(even though that is not the case for this situation), and thus is
disabled when such refs are present.
  * external GUI programs such as GitHub and Gerrit and likely others
do not honor replace refs, instead showing you some form of "Not
Found" error.


As for using replace refs to attempt to alleviate problems without
rewriting history, that's an even bigger can of worms and it doesn't
solve clone/fetch/gc/fsck nor the many other places you highlighted in
your email.
