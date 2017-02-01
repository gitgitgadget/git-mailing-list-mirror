Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8FC1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 16:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbdBAQtv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 1 Feb 2017 11:49:51 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:43894 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdBAQtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 11:49:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 612011E2DE8;
        Wed,  1 Feb 2017 17:49:46 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Jp7mxVR-XMZK; Wed,  1 Feb 2017 17:49:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 05B2D1E3086;
        Wed,  1 Feb 2017 17:49:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aaTFe85FJKU5; Wed,  1 Feb 2017 17:49:45 +0100 (CET)
Received: from [192.168.178.29] (aftr-185-17-206-48.dynamic.mnet-online.de [185.17.206.48])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id A2B181E2DE8;
        Wed,  1 Feb 2017 17:49:45 +0100 (CET)
Subject: Re: [PATCH v2 7/7] completion: recognize more long-options
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
 <20170127211703.24910-1-cornelius.weig@tngtech.com>
 <20170127211703.24910-2-cornelius.weig@tngtech.com>
 <CAM0VKj=Ein4yrKG2aZnN7JU80ctZBQromcR6BEu-TyMLenLFCg@mail.gmail.com>
Cc:     j6t@kdbg.org, spearce@spearce.org, git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <2841d2de-32ad-eae8-6039-9251a40bb00e@tngtech.com>
Date:   Wed, 1 Feb 2017 17:49:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKj=Ein4yrKG2aZnN7JU80ctZBQromcR6BEu-TyMLenLFCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gabor,

 thanks for taking a look at these commits.

On 01/31/2017 11:17 PM, SZEDER Gábor wrote:
> On Fri, Jan 27, 2017 at 10:17 PM,  <cornelius.weig@tngtech.com> wrote:
>> From: Cornelius Weig <cornelius.weig@tngtech.com>
>>
>> Recognize several new long-options for bash completion in the following
>> commands:
> 
> Adding more long options that git commands learn along the way is
> always an improvement.  However, seeing "_several_ new long options"
> (or "some long options" in one of the other patches in the series)
> makes the reader wonder: are these the only new long options missing
> or are there more?  If there are more, why only these are added?  If
> there aren't any more missing long options left, then please say so,
> e.g. "Add all missing long options, except the potentially
> desctructive ones, for the following commands: ...."

Personally, I agree with you that
> Adding more long options that git commands learn along the way is
> always an improvement.
However, people may start complaining that their terminal becomes too
cluttered when doing a double-Tab. In my cover letter, I go to length
about this. My assumption was that all options that are mentioned in the
introduction of the command man-page should be important enough to have
them in the completion list. I'll change my commit message accordingly.

>>  - rm: --force
> 
> '--force' is a potentially destructive option, too.

Thanks for spotting this.

Btw, I haven't found that non-destructive options should not be eligible
for completion. To avoid confusion about this in the future, I suggest
to also change the documentation:

index 933bb6e..96f1c7f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -13,7 +13,7 @@
 #    *) git email aliases for git-send-email
 #    *) tree paths within 'ref:path/to/file' expressions
 #    *) file paths within current working directory and index
-#    *) common --long-options
+#    *) common non-destructive --long-options
 #
 # To use these routines:
 #


I take it you have also looked at the code itself? Then I would gladly
mention you as reviewer in my sign-off.
