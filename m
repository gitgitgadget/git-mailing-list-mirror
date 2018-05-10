Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EAE51F406
	for <e@80x24.org>; Thu, 10 May 2018 17:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966686AbeEJR6P (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:58:15 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:64678 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJR6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:58:14 -0400
Received: from [192.168.2.201] ([92.22.23.119])
        by smtp.talktalk.net with SMTP
        id GppTf8tHjIEJtGppTfMWKq; Thu, 10 May 2018 18:58:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1525975092;
        bh=ymQY1moj6hM4pN+1vz8hbW1R5IJozHXWU6mLkeIPr5Q=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O5xsGG4KxUixFnlobeNOghG6TlU9mYq6Gup5wFnCJRo56qtKWzHkulzCuO+F+6kmS
         83VLsoEEmBGo2fqU90UQ+lRtxYBy1MN0bqsMoP34ttna2vF211yii30vFfRboa3w0H
         VJ/EQQmumMW3c1LdD/d+oWQwpqCUgWS1TKMQDSWI=
X-Originating-IP: [92.22.23.119]
X-Spam: 0
X-OAuthority: v=2.3 cv=SuG+FsG0 c=1 sm=1 tr=0 a=oWXjcmuSLv9+fGSLdn2kqg==:117
 a=oWXjcmuSLv9+fGSLdn2kqg==:17 a=IkcTkHD0fZMA:10 a=9jxfW5SSk6lpWmgnK4MA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Regression in patch add?
To:     Oliver Joseph Ash <oliverjash@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        mqudsi@neosmart.net, phillip.wood@dunelm.org.uk
References: <be321106-2f10-e678-8237-449d2dd30fee@talktalk.net>
 <20180510141125.21677-1-oliverjash@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <e8aedc6b-5b3e-cfb2-be9d-971bfd9adde8@talktalk.net>
Date:   Thu, 10 May 2018 18:58:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510141125.21677-1-oliverjash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLCga2ma5P6wc8WjWbty9zyV/KpnnLNr8RZej63xa0Apg8IT/GlpCKItRDmOtG7S2bR2pxDEnnr+j3PD9PXAKWJRwMwscN6ekqL3aIZ7EWZOxM9X4wa9
 VhKTqkA9yo0OiplEO1e3RzoqNm9vdwnbdMTRUy54pxbGFBmYXG6u3tV5xl4E5qE0yvfy3fwY5ncAvyO//8Ah+Etwu/25v2kGwmr3gWe1KjhhDSAWW9gQGHBL
 KGZGmP2W2FO0+Kt1m4+kOD3saF18OC+igv8qvErFwLrdW8gFxVMvHJtC0r/wkCkabg3lAkTBiPNsr9cRmftTFziyIHG5kcgoixZs7054hso=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/05/18 15:11, Oliver Joseph Ash wrote:
> You found the problem Phillip! My editor was trimming trailing white space, which breaks the context line.

I'm glad we found the source of the problem (and that it wasn't some
obscure bug)

> I had tried to use an alternative editor to account for any editor specific behaviour, but it turns out both the editors I tested in were doing this!
> 
> I suspect this change in behaviour will effect a lot of users? If so, it would be good if `git add -p` allowed for this behaviour, in the same way `git apply` does.

Yes, I think it probably makes sense to do that. Originally I didn't
count empty lines as context lines in case the user accidentally added
some empty lines at the end of the hunk but if 'git apply' does then I
think 'git add -p' should as well

> Meanwhile, I can easily configure my editor not to do this for `*.diff` files.
> 
> Thanks for your help, Phillip and Martin!

Thanks for posting an example so we could test it, it makes it much
easier to track the problem down

Best Wishes

Phillip

> Mahmoud, does this also explain your problem as per your original post?
> 

