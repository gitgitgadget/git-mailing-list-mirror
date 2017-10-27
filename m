Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC052055E
	for <e@80x24.org>; Fri, 27 Oct 2017 07:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdJ0HlT (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 03:41:19 -0400
Received: from smtp-o-3.desy.de ([131.169.56.156]:35335 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdJ0HlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 03:41:16 -0400
X-Clacks-Overhead: GNU Terry Pratchett
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 04063280085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1509090075; bh=j7WngQKl+HyL0CeH8cgPP5430Ye9M2cJWjjC6e0MgH0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BcJZlLfyB3elpMHC6JpA/t00BfubHaKNt1XDPecQCmSnY5jgQpYo9Eb6QhjN4Lg9r
         8BmFBVGmJjXXhMgZeRjXLv/x08cWdMJZOmmPnb7JkuEmvUI1N5XNuiIcLAguRItq16
         DTFIGs5nsGx8IUrlgXnuwTKQEADFPnC45DkH2ZIM=
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
        by smtp-o-3.desy.de (DESY-O-3) with ESMTP id 04063280085
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 09:41:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (DESY-INTRA-3) with ESMTP id AB4741646;
        Fri, 27 Oct 2017 09:41:14 +0200 (MEST)
Date:   Fri, 27 Oct 2017 09:41:14 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Message-ID: <760741736.3439901.1509090074292.JavaMail.zimbra@desy.de>
In-Reply-To: <20171026213337.kbmwnaxlsyubat4w@aiede.mtv.corp.google.com>
References: <20171026195516.3354-1-tigran.mkrtchyan@desy.de> <20171026205509.2ydjd3bai2l6pqxi@aiede.mtv.corp.google.com> <1113033991.3307260.1509051676201.JavaMail.zimbra@desy.de> <20171026213337.kbmwnaxlsyubat4w@aiede.mtv.corp.google.com>
Subject: Re: [PATCH] tag: add tag.gpgSign config option to force all tags be
 GPG-signed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF56 (Linux)/8.7.11_GA_1854)
Thread-Topic: add tag.gpgSign config option to force all tags be GPG-signed
Thread-Index: PM0v9dJ3UHgmPJ3czeG3v1LEkDNyfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

I can't disagree with you - the right solution is to fix the build/release process to support
signed tagging. It's just too many of them to fix: jenkins, maven, IDE, etc. My naive assumption
was that if a tool (git) has a switch to enable some functionality, why not have a possibility
to make it default.

You can put this change on hold and re-consider it if more people will need such functionality.

Thanks,
   Tigran.

----- Original Message -----
> From: "Jonathan Nieder" <jrnieder@gmail.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "git" <git@vger.kernel.org>
> Sent: Thursday, October 26, 2017 11:33:37 PM
> Subject: Re: [PATCH] tag: add tag.gpgSign config option to force all tags be GPG-signed

> Hi again,
> 
> Mkrtchyan, Tigran wrote:
>> Jonathan Nieder wrote:
>>> Tigran Mkrtchyan wrote:
> 
>>>> In some workflows we have no control on how git command is executed,
>>>> however a signed tags are required.
>>>
>>> Don't leave me hanging: this leaves me super curious.  Can you tell me
>>> more about these workflows?
>>
>> Well, this is a build/release process where we can't pass additional
>> command line options to git. TO be hones, is case of annotated tags
>> there is already option tag.forceSignAnnotated. However, non annotated
>> tags are not forced to be signed.
>>
>> Additionally, the proposed option is symmetric with commit.gpgSign.
> 
> Now I'm even more curious.
> 
> I don't think we have the full picture to understand whether this
> change is needed.  When adding a configuration item, we need to be
> able to explain to users what the configuration item is for, and so
> far the only answer I am hearing is "because we do not want to patch
> our build/release script, though we could in principle".  That doesn't
> sound like a compelling reason.
> 
> On the other hand, perhaps the answer is "our build/release script
> does not have a --sign option for the following reason, and this is a
> better interface for configuring it".
> 
> Or perhaps there is an answer that does not involve the build/release
> script.
> 
> But with no answer at all, it is hard to see why we should move
> forward on this patch.
> 
> To be clear, I am not saying that writing the patch is wasted effort.
> E.g. you can continue to use it internally, and it means that once we
> have a clear reason to add this configuration, the patch is there and
> ready to use to do so.
> 
> Thanks again,
> Jonathan
