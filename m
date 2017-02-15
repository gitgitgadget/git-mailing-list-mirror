Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244C72013A
	for <e@80x24.org>; Wed, 15 Feb 2017 22:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdBOWpw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 15 Feb 2017 17:45:52 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:41161 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdBOWpv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 17:45:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 0DE841E310B;
        Wed, 15 Feb 2017 23:45:48 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 90vc6QXVvBJ7; Wed, 15 Feb 2017 23:45:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 8CADA1E313E;
        Wed, 15 Feb 2017 23:45:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RlrSR3ESl_L6; Wed, 15 Feb 2017 23:45:47 +0100 (CET)
Received: from [192.168.178.31] (aftr-185-17-204-22.dynamic.mnet-online.de [185.17.204.22])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 44A241E310B;
        Wed, 15 Feb 2017 23:45:47 +0100 (CET)
Subject: Re: [PATCH v2 2/2] completion: checkout: complete paths when ref
 given
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
 <20170214212404.31469-1-cornelius.weig@tngtech.com>
 <20170214212404.31469-2-cornelius.weig@tngtech.com>
 <CAM0VKjkUu2k73+PxZ2UNKrnBg0nW_za+10O7eHEgcko6BaGx6Q@mail.gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Richard Wagner <bitte.keine.werbung.einwerfen@googlemail.com>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <11424310-7f76-12fe-0e56-e585ccf06aea@tngtech.com>
Date:   Wed, 15 Feb 2017 23:45:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKjkUu2k73+PxZ2UNKrnBg0nW_za+10O7eHEgcko6BaGx6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/15/2017 03:26 PM, SZEDER Gábor wrote:
> On Tue, Feb 14, 2017 at 10:24 PM,  <cornelius.weig@tngtech.com> wrote:
> 
>> +               *)
>> +                       __git_complete_tree_file "$ref" "$cur"
>> +                       ;;
> 
> There is one more caveat here.
> 
> Both our __git_complete_index_file() and Bash's builtin filename
> completion lists matching paths like this:
> 
>   $ git rm contrib/co<TAB>
>   coccinelle/                        contacts/
>   completion/                        convert-grafts-to-replace-refs.sh
> 
> i.e. the leading path components are not redundantly repeated.
> 
> Now, with this patch in this code path the list would look like this:
> 
>   $ git checkout completion-refs-speedup contrib/co<TAB>
>   contrib/coccinelle/
>   contrib/completion/
>   contrib/contacts/
>   contrib/convert-grafts-to-replace-refs.sh
> 
> See the difference?

Now that you say it.. I had never noticed it though.

> I once made a feeble attempt to make completion of the <ref>:<path>
> notation (i.e. what you extracted into __git_complete_tree_file())
> look like regular filename completion, but couldn't.

Can you dig up what you tried out? Maybe somebody comes up with a good idea.
