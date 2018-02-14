Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39081F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162514AbeBNTBG (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:06 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36490 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162506AbeBNTBD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id f3so23812645wmc.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EUYFCD1uZi2RsbiQxVTr8BX83Ql3ib49OpZatRLXuzI=;
        b=oTY/m1ZP3n0oVOeXovAtHU2QLgyeNesGgKFC9ePXNlywlbYVPoF4g0GKOxpsq2AK//
         Co5SR9p8tZHQohmygx2LkA8n7/tLQJeZioxSM59CTYUQSpM2kljAxblGmd/4mp3oQl2k
         509dZcezga68ciy0djP3hFhDW1JwhNkDF1fsTqIu8VlQpiuVDYJmGdqZx9wsD25AmsT8
         Uc/EO9LcwRxGr29hR0RO/atOLufE2+WpXxFH+fufw8DlbGiR8W+Jc/yQ53gUgEF5KdzR
         s9HA9e0/H+CAm6EadVolwvt4VlwGnG1LNidsiBkNWpOIKya6FuknZ2ZWGFr54EnpIaKx
         s8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EUYFCD1uZi2RsbiQxVTr8BX83Ql3ib49OpZatRLXuzI=;
        b=O96BnHZpYuMIOaqZJrRuoF6le+WoiJQcj/IL3ODQv+HEbtDxJvEDNAog7pwgOiS2bK
         F3AmCOiHO4cPbHpnhzmIRyQhWxRZQsumgS3JhfYypc8bf9k+r0wW64/jAGNOSHcbkEYB
         CiTdH8KQXdlX0RgEO5+0A2nHKDlizSLeVXwZi3PKbV86RdwM4JKWGm3VXkvmU3dgxFFI
         ASKNQY8jf4Gj+qa4dUYjHl+hy5warr1GkvLkIkardm1pY7WaVqjnAik6V52Z0yjOOx9u
         sPOrc9aFr+Z3FqRy0kqWI0JymAnSFrLvfrjjM7VAklvlp5A+CLVB4bwzx5DIpriANyqb
         x82w==
X-Gm-Message-State: APf1xPBMPY+9LRqPFmzB+2EMQcaAnWF+E7gEvYm+mbiquRaH4tPS/mqb
        gh6jP2kBnUSov6udKrXylIo=
X-Google-Smtp-Source: AH8x225FJLGxbYQ3PcStS6zzxMo8seaoFlzXH4Io/11aIGtUJga/9d2BqdQqYc42ae9esybmzz5djg==
X-Received: by 10.28.19.199 with SMTP id 190mr75127wmt.41.1518634861895;
        Wed, 14 Feb 2018 11:01:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x127sm9508496wmb.36.2018.02.14.11.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 11:01:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] test-hashmap: simplify alloc_test_entry
References: <20180214180322.GA9190@sigill.intra.peff.net>
        <20180214180819.GE9919@sigill.intra.peff.net>
Date:   Wed, 14 Feb 2018 11:01:00 -0800
In-Reply-To: <20180214180819.GE9919@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 14 Feb 2018 13:08:20 -0500")
Message-ID: <xmqq3723o0pf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This function takes two ptr/len pairs, which implies that
> they can be arbitrary buffers. But internally, it assumes
> that each "ptr" is NUL-terminated at "len" (because we
> memcpy an extra byte to pick up the NUL terminator).

Makes quite a lot of sense.  In addition, get_value() assumes that
the key cannot have NUL in it, so the use of counted string in
alloc_test_entry() serves no purpose other than to confuse the
readers ;-)

> Note that we can get rid of the "l1" and "l2" variables from
> cmd_main() as a further cleanup, since they are now mostly

Made me wonder if this "we can" is "we could if we wanted to in the
future although we do not go that far in this patch", but it turns
out that this is also done, and I think it is a good clean-up.
