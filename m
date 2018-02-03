Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AFD21F404
	for <e@80x24.org>; Sat,  3 Feb 2018 01:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeBCB67 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 20:58:59 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35183 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeBCB66 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 20:58:58 -0500
Received: by mail-qk0-f180.google.com with SMTP id 69so13169441qkz.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 17:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PNx4hfVLjpRAgRDjsNEBUG70nMebzhg+P+TW29kTbQc=;
        b=gB9/jX0IX9yNPphLTXpdzqI9l9I/XRnvychjjPISOXdgWMDUgCV1IEZb3lY3RLk5ld
         zlK1cH7J1TBSlB+R74mzUpvxGIQnY6O9PqBhMYP3cWJTDb0RsIAAZaZGqjgAV1wRdk5o
         g1BNgmMze4HvMO+Fp+8fO0UR+hmxvP6fOs3LXQzNqvRZwX76GsSX+yc/dS/WLnNHp9MS
         bJYwMehPIj+93u3f+BP2XZV8SGMZdot+qNHv6ADJgvkUcp8lUw587o+n0wxHuiWOheF5
         zkYlTR3eA+2QCwybgeaeVteLX1pxbk9c3IqGAHqL0ZUGzuy/gAaUGixItErMsHK/EUto
         GyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PNx4hfVLjpRAgRDjsNEBUG70nMebzhg+P+TW29kTbQc=;
        b=XB/qNP7CyiaM4GreP+QUBLDdh6cS0lGgj7t6Jw1oHVsSSgqREqj0bDFLsj9tZcIhdS
         9tj0ewHp+phEwUOJjJ2bsBZGHuvfHnrO2Q+t4Kd+tGwVPDvJENMBNyMuK8MKaocIW8AO
         Swbtjw6FbZMsR4r2urViqM16F+eeF5gXgL8og5k+FiYosJJr7rCKvXYDNHkeACIM1UI3
         NcHPdcsR1h57WuI21nzUI1oFYL51jHgSeZK2y9GOe9o9lljJBcNwILIArovpdoHB0JFQ
         RQvAvKopSwp3PyO06v8qjrwrx/D06JKtd0xs7JZh89Y2LlKBHp3KIUwa4IjKiW/qzPwp
         xMNA==
X-Gm-Message-State: AKwxyteHewpWctkTh/jxvyAwBlUvZS21cXaH6kR/7m749X2qjqeRGsQB
        NcK/cPwiT93RjWhYsIcbheY=
X-Google-Smtp-Source: AH8x227iX1c8xrbRDHW7q62tvKCH4jwDyr9aoZHUBuy3iF2Gbw9ZZpVkyK7YmS6K1Viuez2kla84Gw==
X-Received: by 10.55.79.68 with SMTP id d65mr64060118qkb.153.1517623137396;
        Fri, 02 Feb 2018 17:58:57 -0800 (PST)
Received: from [10.0.1.24] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id k1sm2321539qtf.96.2018.02.02.17.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2018 17:58:54 -0800 (PST)
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>, szeder.dev@gmail.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
 <20180201153349.c94fe3de6b632e2fd8f843cf@google.com>
 <CAGZ79kb8kHAb6HYrxY_oMq5v3p1+AHX_ad40nwUEwiDKe=i+Ng@mail.gmail.com>
 <xmqq607fc8j8.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <25571438-bdb1-81ce-ac5e-18dd0b6292d5@gmail.com>
Date:   Fri, 2 Feb 2018 20:58:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <xmqq607fc8j8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/2/2018 5:48 PM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
>> It is true for git-submodule and a few others (the minority of commands IIRC)
>> git-tag for example takes subcommands such as --list or --verify.
>> https://public-inbox.org/git/xmqqiomodkt9.fsf@gitster.dls.corp.google.com/
> 
> Thanks.  It refers to an article at gmane, which is not readily
> accessible unless you use newsreader.  The original discussion it
> refers to appears at:
> 
>      https://public-inbox.org/git/7vbo5itjfl.fsf@alter.siamese.dyndns.org/
> 
> for those who are interested.

Thanks for the links.

> I am still not sure if it is a good design to add a new command like
> this series does, though.  I would naively have expected that this
> would be a new pack index format that is produced by pack-objects
> and index-pack, for example, in which case its maintenance would
> almost be invisible to end users (i.e. just like how the pack bitmap
> feature was added to the system).

I agree that the medium-term goal is to have this happen without user 
intervention. Something like a "core.autoCommitGraph" setting to trigger 
commit-graph writes during other cleanup activities, such as a repack or 
a gc.

I don't think pairing this with pack-objects or index-pack is a good 
direction, because the commit graph is not locked into a packfile the 
way the bitmap is. In fact, the entire ODB could be replaced 
independently and the graph is still valid (the commits in the graph may 
no longer have their paired commits in the ODB due to a GC; you should 
never navigate to those commits without having a ref pointing to them, 
so this is not immediately a problem).

This sort of interaction with GC is one reason why I did not include the 
automatic updates in this patch. The integration with existing 
maintenance tasks will be worth discussion in its own right. I'd rather 
demonstrate the value of having a graph (even if it is currently 
maintained manually) and then follow up with a focus to integrate with 
repack, gc, etc.

I plan to clean up this patch on Monday given the feedback I received 
the last two days (Thanks Jonathan and Szeder!). However, if the current 
builtin design will block merging, then I'll wait until we can find one 
that works.

Thanks,
-Stolee
