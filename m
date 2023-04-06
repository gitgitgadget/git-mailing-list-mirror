Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5110EC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 10:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjDFKsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjDFKsI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 06:48:08 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1087049F1
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 03:48:06 -0700 (PDT)
Received: from [192.168.42.163] (221-99-142-46.pool.kielnet.net [46.142.99.221])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 03E163C0278;
        Thu,  6 Apr 2023 12:48:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1680778084;
        bh=kbsLneKvSBF/PdH4kw3VPoUsv/ThBcoo7YHVmsv15x0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NXOZooQUix1652ZM15cEIf6ouovimLPsKsdWGLhAAtlmENewkZD2ZBcGAW3IveAn2
         Y39kphtHbBQAxVYE+hrLAuZz+6h2VAGgOU7aGL5OIRkcaBidrtz2fnspKYXyNtO3eM
         +zpxmZXU28UHIqK4jJxd1+d1wvlvF0gJZ0KccP311RXQgm2Xjg8Zuqp7GwlsCk4o57
         DGdSJ/Uf8Oupvh0rFoqK4KkgFsRwQkt9SiuF+KubfBO+SP2LIAWZFeFPwJoGVhH57H
         4tpC2uanx4/ZVZ7ltBcZ/PshlEth52cTzj7zEwWdr+yWRNUydTaK5+0clqCxM90hci
         nmYcPKHo5WBVA==
Message-ID: <f3e522f6-294d-4c08-b261-34d8e5b03b46@haller-berlin.de>
Date:   Thu, 6 Apr 2023 12:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Possible bug in git-rebase man page
Content-Language: de-DE, en-US
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de
References: <db535468-c991-df18-61bd-ec312fdb5ca0@haller-berlin.de>
 <51aca4bd-0f2b-0689-4b51-260349cc4151@gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <51aca4bd-0f2b-0689-4b51-260349cc4151@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.04.23 11:49, Phillip Wood wrote:
> Hi Stefan
> 
> On 05/04/2023 18:36, Stefan Haller wrote:
>> The git-rebase documentation has an example for a git-rebase-todo file
>> when --rebase-merges is used; one of the lines in that file is
>>
>>    reset refactor-button # Use the Button class for all buttons
>>
>>  From reading the code that parses the file, this doesn't seem to be a
>> valid line; as far as I can see, comments are not supported for reset or
>> label. The label is the entire rest of the line after the command.
> 
> You're right that comments are not supported for labels, but for the
> reset command do_reset() ignores everything after the label so it does
> effectively support comments.

I don't follow; do_reset() simply uses whatever is stored in
item->arg_len, and this is set to go until the end of the line for
"label" and "reset" in parse_insn_line().

> I've got some patches to support comments on other commands which
> I'll hopefully submit before too long.

Hm, for label and reset this will make it harder for third-parties
parsing todo files. What's a real-world benefit of supporting comments
for these?

-Stefan
