Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702B7C636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 22:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBQWMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBQWMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 17:12:13 -0500
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08A363BF0
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 14:12:11 -0800 (PST)
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
        by cmsmtp with ESMTP
        id T5FApQbXNuZMST8xfpeUlb; Fri, 17 Feb 2023 22:12:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
        t=1676671931; bh=NlN9GF6kGLIU4UDu6wwWQTpWNQ7Pgu9/edlc8GRMnDU=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=PGJNazuiJdhTD+QZzi3/XOH+YvvVOJSkBioGadNjatBrsZEn0h8LuybHTBNfeJ8zx
         u5z2LdKuUaqQtVvCID0amqAtlXPl6knef++823QH5GPLnbTQxQRsBNR5bHyugrEBpf
         /tjpAVPzCtn+NlRz2JOWiZLv1piqOQZ9RDfoMC7+0Z/P4cxhq5BMQVkhbvyunZa6rS
         aPBEVPtQQomw51HD2dzf6y0AGiZmx+TrqeHV783NNl3W/lCBgo3mW/dWLcfIpxy+Qw
         kYPM377c9P4RLJxIyX//QhCfr6++HTLMXG9uEwIqkZ+5+yNA42GZCpjj52S5Z77Gfq
         T6Q1LHsKofwAA==
Received: from [10.0.0.5] ([184.64.102.149])
        by cmsmtp with ESMTP
        id T8xepw6aN3fOST8xepj52V; Fri, 17 Feb 2023 22:12:11 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=63effbbb
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=_Dj-zB-qAAAA:8 a=VwQbUJbxAAAA:8 a=q5I91NIi_Pmg4zTliJIA:9
 a=QEXdDO2ut3YA:10 a=rQFNUccIKK0A:10 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <e6696187-6fda-5b24-e2ba-91d323ffbfc3@Shaw.ca>
Date:   Fri, 17 Feb 2023 15:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: Brian.Inglis@Shaw.ca
Subject: Re: manual option --inline --no-attach override required for
 format.attach
Content-Language: en-CA
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230215215112.62559-1-Brian.Inglis@Shaw.ca>
 <xmqqr0uqwovt.fsf@gitster.g>
From:   Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <xmqqr0uqwovt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAmBuqrxzXlfLCZFFKKUkqmidjc2gKIdR9r3eCmfjP0Gg0OdqeX6EuG1aw+29WnBIWdBpoCSdzdiZjcB3xS3fLyyptndy3V0MAgQVgsW2uzOLqcdXLSS
 pDi9tFgUtpk9clHi8LTGyn0isBgAs6undY38fCJuv2RK9SApNPOzoHNgXX5q5fTMYLxdhpCZ5MeU009Xgr+VqTXvnvxW+ZPSBE4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-15 15:21, Junio C Hamano wrote:
> Brian Inglis <Brian.Inglis@Shaw.ca> writes:
> 
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> git format-patch --inline ... --to=linux-man@vger.kernel.org
> 
> This is documented to use multipart/mixed attachement with
> "Content-Disposition: inline".
> 
>> git format-patch --no-attach ... --to=linux-man@vger.kernel.org
> 
> This should be the default, text/plain patch contained inline in the
> message.
> 
>> git send-email ... --to=linux-man@vger.kernel.org
> 
> It is unclera what ... hides on this command line, but if you sent
> output from both of the above two format-patch invocations, then the
> output from the first invocation of format-patch with --inline would
> be MIME multipart messages, so it is understandable if the recipient
> sees such messages.

Thanks Junio,

I think I was being confused by a project maintainer insisting on --inline when 
what he really wanted was --no-attach to get inline patches for his process, no 
other project previously caring that /etc/gitconfig had format.attach, and my 
not even being aware that was set until I checked!
I also found my ISP had added outgoing milter rate limiting, rejecting 
everything after the 5th patch email in a series, adding to our situation!

But the point stands that there is no way to switch attach off in local or repo 
config if it is on in a more global config, other than remembering to manually 
specify --no-attach on every git format-patch. Suggest allowing attach=no|off|0.
This would benefit those contributing from orgs tightly controlled environments 
where they may be unable to change global configs.

There should also be a config item if project maintainers want to see --inline 
attachments, working in the same manner as attach, or as an argument of attach?

-- 
Take care. Thanks, Brian Inglis			Calgary, Alberta, Canada

La perfection est atteinte			Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter	not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer	but when there is no more to cut
			-- Antoine de Saint-Exupéry
