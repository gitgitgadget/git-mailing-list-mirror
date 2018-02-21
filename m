Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916141F576
	for <e@80x24.org>; Wed, 21 Feb 2018 11:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933584AbeBULmd (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 06:42:33 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:4081 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932556AbeBULmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 06:42:32 -0500
Received: from [192.168.2.240] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id oSn8eEfSmYeIpoSn8ecoR5; Wed, 21 Feb 2018 11:42:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519213351;
        bh=8X7SyPE6lDklwlPYZbkB8VQywdX5IdMBmfSfW4uUt34=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hnlrqr2KgubhhZmYVRq9p92Ir5thq75IzETNaEJaiTk+txZrHxodRbUrukgid3prS
         ncEUWm1/ks4D7v4cPceIAyGPPbAHDGFRLgzwZZH1sPhC49SPRH7PYTSt8eammpLVBi
         hZ29v0yKh97DhM05grOxaLxegtz080LBCE2O7xS4=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=WZB8UwpX c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=hFcsm8C3tOQNot5fCWsA:9 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/9] t3701: don't hard code sha1 hash values
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
 <20180219112910.24471-5-phillip.wood@talktalk.net>
 <xmqqk1v74l1t.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <8f39e6b1-0031-5d97-f636-ae67cfdb3f1c@talktalk.net>
Date:   Wed, 21 Feb 2018 11:42:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1v74l1t.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfES0QX0RRpLuEhZxkWMdlRUDobjmLvN4YxyZ/VdwtXLjqQaC6XjIpdcbugkVmz96CeiSmWXZqVfgHCF4UwSn7xxeEU6slycuU9Akp3PXiF5teXC1aSB1
 6974RXh10BEQgCOL8nx37/6c3zE7wpxuKUpxIBwuwxTkZN8t4orcDDSh5Q8WGu05kZQAmeP7BSkgzToNqmzDgoh/UN9Ny3kfXhXz73tP7XxBiDSUCPlgA3KX
 Paq0tgCYH22dUSMDNiYDjEg/r3BOHnQ3Ccz9L42nslFJfNRa5i09fS7lkWpVsZHx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/02/18 17:39, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Purge the index lines from diffs so we're not hard coding sha1 hash
>> values in the expected output.
> 
> The motivation of this patch is clear, but all-zero object name for
> missing side of deletion or creation patch should not change when we
> transition to any hash function.  Neither the permission bits shown
> in the output (and whether the index line has the bits are shown on
> it in the first place, i.e. the index line of a creation patch does
> not, whilethe one in a modification patch does).
> 
> So I am a bit ambivalent about this change.
> 
> Perhaps have a filter that redacts, instead of removes, selected
> pieces of information that are likely to change while hash
> transition, and use that consistently to filter both the expected
> output and the actual output before comparing?
> 
Keeping the permission bits makes sense (I'd not thought of them when I 
created the patch) as we want to check that the file has the correct 
permissions. As for the all-zero object name, is it really worth leaving 
it in - if a file has been created or deleted then we'll still have 
/dev/null as the file name for one side or the other and the diff lines 
will show it as well. As these tests are just to check the state of the 
index then I'm not sure the hash values add anything. How do you feel 
about a filter like

sed "/^	index/s/ [0-9a-f][0-9a-f]*\.\.[0-9a-f][0-9a-f]*/x/"

Best Wishes

Phillip
