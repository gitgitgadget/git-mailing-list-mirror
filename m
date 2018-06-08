Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1593E1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 16:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeFHQAl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 12:00:41 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:36202 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751141AbeFHQAk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Jun 2018 12:00:40 -0400
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1fRJob-0002Ki-0O; Fri, 08 Jun 2018 18:00:37 +0200
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
To:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
Date:   Fri, 8 Jun 2018 18:00:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608090758.GA15112@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1528473640;dcb2c4b0;
X-HE-SMSGID: 1fRJob-0002Ki-0O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.06.2018 um 11:07 schrieb Jeff King:
> On Thu, Jun 07, 2018 at 11:10:52PM +0200, Johannes Sixt wrote:
> 
>> Am 07.06.2018 um 16:53 schrieb git@jeffhostetler.com:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> I've been working to add code to Git to optionally collect telemetry data.
>>> The goal is to be able to collect performance data from Git commands and
>>> allow it to be aggregated over a user community to find "slow commands".
>>
>> Seriously? "add code to collect telemetry data" said by somebody whose email
>> address ends with @microsoft.com is very irritating. I really don't want to
>> have yet another switch that I must check after every update that it is
>> still off.
> 
> If you look at the design document, it's off by default and would write
> to a file on the filesystem. That doesn't seem all that different from
> GIT_TRACE.

The patch also includes the following part

+telemetry.plugin
+----------------
+
+If the config setting "telemetry.plugin" contains the pathname to a shared
+library, the library will be dynamically loaded during start up and events
+will be sent to it using the plugin API.
+
+This plugin model allows an organization to define a custom or private
+telemetry solution while using a stock version of Git.
+
+For example, on Windows, it allows telemetry events to go directly to the
+kernel via the plugin using the high performance Event Tracing for Windows
+(ETW) facility.
+
+The contrib/telemetry-plugin-examples directory contains two example
+plugins:
+ * A trivial log to stderr
+ * A trivial ETW writer

which is not a file but, if enabled, some windows internal thingie where the data is gone/duplicated/sent out/whatever.

I for my part would much rather prefer that to be a compile time option so that I don't need to check on every git update on windows if this is now enabled or not.
