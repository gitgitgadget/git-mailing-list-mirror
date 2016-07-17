Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	URI_HEX shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51F81FEAA
	for <e@80x24.org>; Sun, 17 Jul 2016 05:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbcGQF6v (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 01:58:51 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36588 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcGQF6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 01:58:50 -0400
Received: by mail-it0-f66.google.com with SMTP id j124so729468ith.3
        for <git@vger.kernel.org>; Sat, 16 Jul 2016 22:58:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pQH/Ed3IotnecqT16SN8VUdVXyRrn9WKng6NCG7guXY=;
        b=NNLNnQ9PEZftA43acsnOsILvm3N0R9PAtUeQpg6aMLOvBXwWddL6aaORuMn3/2g0TG
         QzA9Ad3cu9U0qH0k35Ek5hgZF2WDvpmU/p5HVb65XF2QGycPqoQEWtIjU25tF/h1swrb
         hLTuPjt9ZBOudYQxCRQ7HhYQYTvLetkwRO70MacNh1g5+1LS2SHy5uz/hAzhsF56tHKf
         zWw0Do6wOsiPP7zuigsnfOWsOnXSOZwZDXTzHgs9s0oCTWXXULIuFmrJIEdJrelelHJq
         6Xebhrr5HDkJ8wP9o31lyHXIqnvkPZ//jsktLrqkd4VcUTLhvk8tMQXa1TMr5pXTenlQ
         HkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pQH/Ed3IotnecqT16SN8VUdVXyRrn9WKng6NCG7guXY=;
        b=IAM7hLHFBk+yjmvzo6PX3q5M4cB+r47G/UJCuZGTEhS+7+x33/QFdIs6am+N7rGsBB
         ggnq8maiuq0pjojGNGpyTXKBwl5H8WGtzTR5+0XiSkpRUe7bvx9glYr5e/8Pca/tE+Y6
         Q/9+EWSTJ63CmhWDQed2bQ4/5L0/LQk4hxDMN468a0mWcTYNCshpdEnjUbIWiLYaEBkg
         1swKmeEYnoTQSjfxAS30qbhmPbYVkH0SEuTP2Odb7kIIN0gj9iZFO32Nd+WwWEqA+sJq
         C5qQI94majCBqWKv8f+vrEZI9uomuIN97g9UmbhvOxqDz5n1XUVbu+bSYJGiU0EczBlC
         qv1g==
X-Gm-Message-State: ALyK8tLI5w/Rs1I85n0dvYNLg41ScFXQolNBjuJCEszG6+AhE+gDduLKAtBzlPCqeM443cQGhDH2kgX4Qsuw/g==
X-Received: by 10.36.29.66 with SMTP id 63mr28834969itj.84.1468735129756; Sat,
 16 Jul 2016 22:58:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Sat, 16 Jul 2016 22:58:49 -0700 (PDT)
In-Reply-To: <20160717002533.GA14200@whir>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com> <FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com>
 <20160716210454.GA7849@starla> <20160717002533.GA14200@whir>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Sun, 17 Jul 2016 01:58:49 -0400
X-Google-Sender-Auth: fyIz6XUpOg8k1UVnfEbadHVJ2U0
Message-ID: <CAPig+cRvhbKwr=QJAyp=sYLLGDx-B2EHovHpn8Z1701stQMi1g@mail.gmail.com>
Subject: Re: [PATCH] list: avoid incompatibility with *BSD sys/queue.h
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 16, 2016 at 8:25 PM, Eric Wong <e@80x24.org> wrote:
> Eric Wong <e@80x24.org> wrote:
>> I also wonder where we use sys/queue.h, since I use
>> LIST_HEAD from ccan/list/list.h in a different project
>> without conflicts...
>
> Still wondering... Checking sys/mman.h in an old FreeBSD source
> tree I had lying around reveals "#include <sys/queue.h>" is
> guarded by "#if defined(_KERNEL)", so it mman.h wouldn't pull
> it in for userspace builds...

It's pulled in like this:

    git-compat-util.h ->
    sys/sysctl.h ->
    sys/ucred.h ->
    sys/queue.h

Very reminiscent of [1].

[1]: http://git.661346.n2.nabble.com/PATCH-ewah-bitmap-silence-warning-about-MASK-macro-redefinition-td7632287.html
