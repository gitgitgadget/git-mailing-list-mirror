Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E641F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 19:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbcIITHE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 15:07:04 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38161 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754164AbcIITHD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 15:07:03 -0400
Received: by mail-wm0-f53.google.com with SMTP id 1so49036286wmz.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YxmHfNXP5HeCnkCEbSJ76V/hlluAuNObi0s+XObKuGQ=;
        b=z7QJSm6Qe4AkK0jNfkz4dc0kB2IcXFOBDFJVcvMBmbu9r5NzyMdrcAKpZm4wK9kjHP
         krso6SnJ8ML1M/ddeTp8K4BxcBfih+MZ78ZuehvBvL0AHjb6CZDTyvdDveYXAEH52bP6
         0LrZwJUgwHwWd6BtMUTv3Joj8pkLPe/9QqAXwmceu+yxLtkZk5Tt3SWcRDpgv1P8A/XW
         1A6phoD6rEBcMDw6jjuankgMe5kIp+FTR3wDt98boZvG4aRCU+wZ0+H5cOCQnx7Rh/CN
         dvKj8EkSYuXf++HG/8cmBMGvAOPoPOoj5uOeT36lYvh6/TBIci0PzxxM+iaI1h9TcN8G
         D26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YxmHfNXP5HeCnkCEbSJ76V/hlluAuNObi0s+XObKuGQ=;
        b=PUGH+C9EP0qVbwWqyhRMQ3djEXwt7h9/OCJmRrWvGghFnJQVUo985NWMwqWgW+5rAK
         MtguERuoXJl+dii1CCDGtSJEE9xsLb0fwB1oRWs8bEW7VXpmTPvPbeC7fTq2AQ42gqer
         mdXZxZEvm824WmTxpD8DntzrTdXWTsrX5h8h/5GVKCQFuh/axhiSIAEMmtoOep8c//Nx
         eKUCf8YYdvnDGVYi6FJGqm3/5YjzB+2Lpi7Ez+ZG7kTi37jzwa2v3pQP5DBQBg2jU8Kf
         B/DyHpN89gbgs2EGaQbgWKggZfQNf4gU8RtGWx4JsJyLAYwc5VyZgyjJY55zuh5Q2Pkg
         Taqw==
X-Gm-Message-State: AE9vXwMSU37nyPZ3NTnfC01OHfVolJXw0DxvErEjoFXx68LZG7z1dDBfuO9mPTaqPF8IVw==
X-Received: by 10.28.155.212 with SMTP id d203mr4234650wme.103.1473448021614;
        Fri, 09 Sep 2016 12:07:01 -0700 (PDT)
Received: from [192.168.1.26] (adby20.neoplus.adsl.tpnet.pl. [79.184.24.20])
        by smtp.googlemail.com with ESMTPSA id jd4sm4760883wjb.6.2016.09.09.12.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Sep 2016 12:07:00 -0700 (PDT)
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
 <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
 <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609011052260.129229@virtualbox>
 <xmqqeg53wj7a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609091708480.129229@virtualbox>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5b707a0d-6c10-abb5-3213-d13490e9b9de@gmail.com>
Date:   Fri, 9 Sep 2016 21:06:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609091708480.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 09.09.2016 o 17:12, Johannes Schindelin napisał:
> On Thu, 1 Sep 2016, Junio C Hamano wrote: 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I was sort of expecting that, when you do the preserve-merges mode
>> of "rebase -i", you would need to jump around, doing "we have
>> reconstructed the side branch on a new 'onto', let's give the result
>> this temporary name ':1', and then switch to the trunk (which would
>> call for 'reset <commit>' instruction) and merge that thing (which
>> would be 'merge :1' or perhaps called 'pick :1')", and at that point
>> you no longer validate the object references upfront.
> 
> Except that is not how --preserve-merges works: it *still* uses the SHA-1s
> as identifiers, even when the SHA-1 may have changed in the meantime.
> 
> That is part of why it was a bad design.

When preserving merges, there are (as far as I understand it), two
problems:
 - what it means to preserve changes (which change to pick,
   that is what is the mainline changes rebase is re-applying)
 - what are parents of the merge commit (at least one parent
   would be usually rewritten)

Maybe the internal (and perhaps also user-visible) representation
of merge in instruction sheet could use the notation of filter-branch,
that is 'map(<sha-1>)'... it could also imply the mainline.

That is the instruction in the internal instruction sheet could
look like this:

  merge -m 1 map(2fd4e1c67a2d28fced849ee1bb76e7391b93eb12) da39a3ee5e6b4b0d3255bfef95601890afd80709 \t Merge 'foo' into master  


Note that it has nothing to do with this series!

Best regards,
-- 
Jakub Narębski

