Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F4E1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 23:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbcHaXDm (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 19:03:42 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:36746 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753692AbcHaXDl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 19:03:41 -0400
Received: by mail-it0-f50.google.com with SMTP id i184so37204430itf.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g21xni3uTebCTHJEVIcP+i691skTNy0S8T1CjX3xfSk=;
        b=EXZC5w+oW+G9hmNEOyBXUCGeoAXySd6WZEfgjIZnZlUqtkQY6iSjLYru69dHO+DQs5
         xFfj/o95jrNMnpBfqPeQhwY4/0M4tJBP1ozYgVB0zcAOeYG523qtI0g3V7DF9Y8GsFld
         2CTFCtPuQxV2iUgZhinC7Qb7InV7sJWMj6ObdASfy6Lmc8bDPKuG4h6MdiwXT4ri5Lve
         sydpYLfH2k4UHiLf3IxS8xhbpazGyg+jEfODpIJz57CgW/PDDIK/CtpnCjwyQK+jFgFC
         pK+AlfiEXQjGt7dExd1VF4ARX3bBzqnjPSHa3+WlDe/SM2Ztw1wsOvUiarzyxs7L/t6x
         0vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g21xni3uTebCTHJEVIcP+i691skTNy0S8T1CjX3xfSk=;
        b=Ycadwfd5EYXLLtLXDrZ9WVqwfDu9bJ3Cjav9sl8IkCTBXmuPZXEQsyiG4YpyDRFVxF
         lNHMxndAqVmfsr/3JKzB4XyH7gzxKbmzuQ2exjXnO1WDARbgDbdSij5Mrp0BEMH8loqI
         GhPlRGfk8XryntNOuFMr/jy1IL2Pj+I7MIH2JMPqqtgGyvWwfbz0ccouLJsVKVEeXs+w
         K/v6JVwx1iMwTXbXD6tbjxCVq/PkioFZT9p87nq8rhFI6mokE7gnE9tawHnq/2FhVss1
         gvxkGke7Y4mRysoyR733cHeo3DjMfb1mfvBypqbon2/py94wNdSSiysrpZrSEqNp1mBU
         li0g==
X-Gm-Message-State: AE9vXwPW9PPlK1+yd9yYsUG4KX4IP+WXAh3eGXQFbu32upE3IsioNFw1Nqpst/II76gnTTOJfedLbqDfZBan45H4
X-Received: by 10.36.107.82 with SMTP id v79mr34144774itc.52.1472684620402;
 Wed, 31 Aug 2016 16:03:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 16:03:40 -0700 (PDT)
In-Reply-To: <135c9ac7-49a6-8aa1-fc10-02c2a1fd0b1a@gmail.com>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <163aaa2a64ddf6dfb28c77c821726e14cc78619e.1472457609.git.johannes.schindelin@gmx.de>
 <135c9ac7-49a6-8aa1-fc10-02c2a1fd0b1a@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 16:03:40 -0700
Message-ID: <CAGZ79kYP6jYyuEOwQPC6pcOxCMVNNQ24pVLoQVrv6nNrGsDTKA@mail.gmail.com>
Subject: Re: [PATCH 09/22] sequencer: completely revamp the "todo" script parsing
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 10:29 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wr=
ote:

>
> BTW. perhaps we would be able to continue with 'git continue', regardless
> of what we have started with, I wonder...
>

git continue as a shorthand for `git <relevant-cmd> --continue` sounds grea=
t.

If we were to introduce that, I think we would need to unify the rest
as well then, e.g.
Both revert as well as cherry-pick have --quit as well as --abort,
but rebase doesn't have --quit documented, but instead an additional
--skip  and --edit-todo

Would we pull these all up as a top level command? (That sounds not so
great to me)
