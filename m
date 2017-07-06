Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33915202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 19:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbdGFTNc (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 15:13:32 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36810 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbdGFTNa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 15:13:30 -0400
Received: by mail-pg0-f48.google.com with SMTP id u62so5372801pgb.3
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a2vbkrjDQNBF8hRWtZsHyS8V4FX6d4KDRUtfh1O1oVs=;
        b=hLkNqFpJvhC4ZsgG/W6hcXU38ugNsOFTcR70jN7d8Ghp6tvljpjMAzZlcyiuECeVn2
         79uepi6bKql+qCxm8rtrzwW/WELMMRAWFua8bgObWO31gS86kfJHEbPh/OGfp2ssuMh1
         bsCm7TfDPEHMhy4iunO/I9mjYizXPHHUHOQ+J3KEPE2yqzEWyHOMcNIEXPry8jvV9kB1
         4PSwBBbHKVSnGejYaFpVN8AlVL4c2DmkGQd3OnMOmVd0soZA9PAN4WHK9gx1lz6zz28N
         lFMP2doAPZqEs7yoUqWpcaWUh/QJzwir5KeJqdIGSjtyLu2XwFqAFnjWWC8vJAwcdndQ
         tB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a2vbkrjDQNBF8hRWtZsHyS8V4FX6d4KDRUtfh1O1oVs=;
        b=fIZ1miEQNGCiNkcG5kz2uX3kDPfSwLPiHMkaWptZJoYdSrcPmmMMYwb3hnm9HqvjbH
         0xu6Inq9ZtOFybCjxqHbgg71/5Wy5FMy2qiOBiI4zw1jW7U84KaNvipF/pXF54d8Y7pz
         1xgXG4BEcjw2daeGrjT9V4gufSnnofDybXcSok+Q+p1gVc6IdBKLqV3SLAdctuiQ/AhQ
         wCaC3n8StsfetthkHexewbpnDfgziCgRSVVmssaFw+Vhl5PZgZ/xMAq68mIZOL0PBIfC
         Gh9zk+u7kMiqhKzxE9g6naES9wAalwf+w/erGiOvkHStyUH/i/fnURgz40DBUZNPgprs
         sfYg==
X-Gm-Message-State: AIVw113WhBcHkOA07UNEGZq6hWcvbwv29pWc/uqwETDv5Y5f4D62dQ9g
        rAoTjmUYftgp182UwKQ=
X-Received: by 10.99.163.26 with SMTP id s26mr18856331pge.232.1499368409922;
        Thu, 06 Jul 2017 12:13:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id t26sm2079616pfe.88.2017.07.06.12.13.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 12:13:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Francesco Mazzoli <f@mazzo.li>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
References: <1499116727-757-1-git-send-email-f@mazzo.li>
        <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
        <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com>
        <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
        <CAPB=P5z7MA+TuVaFLUQQdOoJXUb74YxEPS6k4O+NorneVpLitg@mail.gmail.com>
        <xmqqa84ikj61.fsf@gitster.mtv.corp.google.com>
        <EA42AB04-D538-4B4A-BC19-CAE9A80EEA76@mazzo.li>
Date:   Thu, 06 Jul 2017 12:13:27 -0700
In-Reply-To: <EA42AB04-D538-4B4A-BC19-CAE9A80EEA76@mazzo.li> (Francesco
        Mazzoli's message of "Wed, 5 Jul 2017 18:43:36 +0200")
Message-ID: <xmqqy3s1e5uw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Francesco Mazzoli <f@mazzo.li> writes:

> Moreover, it seems to me that the problem `--force-with-lease` is
> just one of marketing. `--force-with-lease` is strictly more "safe"
> than `--force` in the sense that it'll reject some pushes that `--force`
> will let through.

By that logic, a hypothetical update to `--force` that makes 1/3 of
the attempted forced push randomly would make it safer than the
current `--force`, wouldn't it?

When third-party tools fetch and update remote-tracking branches
behind the users' back, the safety based on the stability of
remote-tracking branches are defeated.  And the biggest problem
is that the way `--force-with-lease` misbehaves---it is not like
it randomly and mistakenly stops the push that could go through;
it lets through what shouldn't.

See the other patch I sent just now---with something like that patch
that lets those like you, who know their remote-tracking branches
are reliable, use the lazy form, while disabling it by default for
others (until they examine their situation and perhaps disable the
problematic auto-fetching) in place, I do not think it is a bad idea
to advertise --force-with-lease a safer option than --force (because
those for whom it is not safer will not be able to use it).



