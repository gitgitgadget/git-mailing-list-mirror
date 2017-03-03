Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FB720133
	for <e@80x24.org>; Fri,  3 Mar 2017 18:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdCCSfW (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 13:35:22 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:50850 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751945AbdCCSfT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 13:35:19 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1cjrZj-0001OK-KX; Fri, 03 Mar 2017 19:05:07 +0100
Subject: Re: log -S/-G (aka pickaxe) searches binary files by default
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <7a0992eb-adb9-a7a1-cfaa-3384bc4d3e5c@virtuell-zuhause.de>
 <CAPc5daVSY5Z_+cpT1dHY-cM-TzNeu+Vzv+zouoOHW08PTFRQ7A@mail.gmail.com>
 <20170303051721.r6pahs4vjtqqoevc@sigill.intra.peff.net>
 <xmqqzih29wdu.fsf@gitster.mtv.corp.google.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <dcce9a68-a54d-b798-e301-bc92b7fd2cd7@virtuell-zuhause.de>
Date:   Fri, 3 Mar 2017 19:05:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqzih29wdu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1488566119;1f977e26;
X-HE-SMSGID: 1cjrZj-0001OK-KX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.03.2017 um 17:07 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> On Thu, Mar 02, 2017 at 05:36:17PM -0800, Junio C Hamano wrote:
>> ...
>>>> Is that on purpose?
>>>
>>> No, it's a mere oversight (as I do not think I never even thought
>>> about special casing binary
>>> files from day one, it is unlikely that you would find _any_ old
>>> version of Git that behaves
>>> differently).
>>
>> The email focuses on "-G", and I think it is wrong to look in binary
>> files there, as "grep in diff" does not make sense for a binary file
>> that we would refuse to diff.
> 
> Yeah, I agree.
> 
>> But the subject also mentions "-S". I always assumed it was intentional
>> to look in binary files there, as it is searching for a pure byte
>> sequence. I would not mind an option to disable that, but I think the
>> default should remain on.
> 
> As the feature was built to be one of the core ingredients necessary
> towards the 'ideal SCM' envisioned in
> 
>   <http://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
> 
> "-S" is about finding "a block of text". It was merely an oversight
> that we didn't add explicit code to ignore binary when we introduced
> the concept of "is this text?  is it worth finding things in and
> diffing binary files?".
> 
> I do agree that it may be too late and/or disruptive to change its
> behaviour now, as people may grew expectations different from the
> original motivation and design, though.

Thanks both for the encouraging answers.

I'll try to come up with patches in the next couple of weeks for the
following changes:
"log -G": disable looking in binaries
"log -S": add option to switch looking into binaries, defaults to true

Thomas

