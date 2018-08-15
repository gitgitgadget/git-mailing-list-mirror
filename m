Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78641F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbeHOULC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:11:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37491 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOULC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:11:02 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so2901818itf.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xV3o3NhHT7egX5ifNbEQGCmroaKMHuyRUFn8c3RtdYo=;
        b=M+plVXwCt2W/V7DqC/lyP7CaSQhMTr3CCUy+LoFfh4gQz/3yVcNOUV0CMLg0WTH2sv
         2sAFJZPkjHnM6obZXo4XAP+jEk/TYexxC8ukSZ3/UqCNillf3zxJ9Qdo6KsmQ+nOA/Oh
         104BWcZ4t/uMlPj6koW+izCS0kV4WqFZMI1G+vYta4ylueOlhLG1ZMBgwgXccstSQ8uF
         SkQJ6buX+mMT3svE0TUXxKNtK2KvfHanYL5RHDY8JaaC+A8TGuPM/BTPOVueOuGB5n4X
         PFZZZkOcuSbywUvhevNyLvVUTP4IuEjZ4D9NE/qb/SKyLtYan33WE+bW5CberFOBeM4E
         d2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xV3o3NhHT7egX5ifNbEQGCmroaKMHuyRUFn8c3RtdYo=;
        b=W1Z+XK55BjOwl5JZeww/BABqPFzYfvJmQ8o+pmR9k4tLVQOzcNLXPfIZAo67G63H8x
         VKlaXkmaGZ27tGcmyd85dR8UvMaAMvVagrMdnrvIPBQW8OOCkzSCA3JNAxI+prKRqueP
         FhxxxT7ahnfIs9/xhOXZiDNYKVS92KulAYG55DupFJEawpgQiZNNj2WVxEmQPYWXm4Gq
         HbHeKiy05z4slgyOZwARLh1Y98sFmC6tkNhLfdfk+d+Xlzz2xmqnpgYLwQncqnOuw0bp
         c19qjpIrGcdCtpue/yD3IqVaQh/4UjOthT7cHEMgxNPlNET2h2U90qZ96slM6RtRLJtX
         1q2Q==
X-Gm-Message-State: AOUpUlGDYmVG316pe0jjhkMx1h95MggLUgDXVqmcbBI/4LuzN4c9+zRb
        sQJ2IKXlQwxyKUeqWooJw4VaWRP67v35ljnR1u7+wA==
X-Google-Smtp-Source: AA+uWPw7bXCZieV9XdhmDpOueIHHCy01bGRrLoAQKK3T9E5Pc+9GENaFHLQLPrTvNqHAKgqM2ie3ZMTAWssLi99Ryao=
X-Received: by 2002:a02:59c9:: with SMTP id v70-v6mr22510829jad.94.1534353480403;
 Wed, 15 Aug 2018 10:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com> <20180815162308.17747-2-pclouds@gmail.com>
 <CAGZ79kYo-icUHfezTMg77s_2GtKcgH6jysNTu11XOoL4UT-9bQ@mail.gmail.com>
In-Reply-To: <CAGZ79kYo-icUHfezTMg77s_2GtKcgH6jysNTu11XOoL4UT-9bQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 19:17:34 +0200
Message-ID: <CACsJy8Br==4ugLh5G2jU9NV1XRsH8iBmYkMZ2Ke_9jZgwuyJ7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 7:09 PM Stefan Beller <sbeller@google.com> wrote:
> Technically you would not need patch 1 in this series, as you could call
> remove_branch_state(void) as before that patch to do the same thing here.
> I guess that patch 1 is more of a drive by cleanup, then?

Yes.

> It looks a bit interesting as sequencer_remove_state actually
> takes no arguments and assumes the_repository, but I guess that is fine.

Don't worry. My effort to kill the_index will make sequencer.c take
'struct repository *' (its operations are so wide that passing just
struct index_state * does not make sense).

> I wondered if we need to have this patch for 'a' as well, and it looks like
> which does a sequencer_rollback, which is just some logic before
> attempting sequencer_remove_state. So I'd think remove_branch_state
> could be done in sequencer_remove_state as well?

sequencer_rollback does not need this remove_branch_state() line
because it calls reset_for_rollback() which does this deletion. Patch
1/1 kinda hints at that because it touches all remove_branch_state()
;-)

Another part of the reason I did not put remove_branch_state() in
sequencer_remove_state() is I was not sure if it could be used in a
different way (I did not study all of its call sites and am not very
familiar with sequencer code).

> Or are there functions that would definitely not want sequencer_remove_state
> after sequencer_remove_state?
>
> Going down on that I just realize sequencer_remove_state could also
> be returning void, as of now it always returns 0, so the condition here
> with !ret is just confusing the reader?
-- 
Duy
