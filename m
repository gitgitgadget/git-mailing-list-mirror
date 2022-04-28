Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A58C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 20:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351878AbiD1UrM convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 28 Apr 2022 16:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiD1UrK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 16:47:10 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5F95AA61
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:43:55 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23SKhqvp027601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Apr 2022 16:43:52 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <20220428033544.68188-1-carenas@gmail.com> <20220428105852.94449-1-carenas@gmail.com> <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g> <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com> <CAPUEsph+p-fD8vMOMU4Djkc8cFUmm=9JVFdgaxkQ4-CpKZgnCA@mail.gmail.com>
In-Reply-To: <CAPUEsph+p-fD8vMOMU4Djkc8cFUmm=9JVFdgaxkQ4-CpKZgnCA@mail.gmail.com>
Subject: RE: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
Date:   Thu, 28 Apr 2022 16:43:47 -0400
Organization: Nexbridge Inc.
Message-ID: <000801d85b40$ac11ec80$0435c580$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEhoH1klsquz/XrUeoh6UIeie+nGgNSFEhJAdygO20BcR/rTQHiUZcMAngeyfiuG23GcA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 28, 2022 4:23 PM, Carlo Arenas wrote:
>On Thu, Apr 28, 2022 at 12:53 PM <rsbecker@nexbridge.com> wrote:
>> /etc/sudoers is not standard although usual. This path should come from a knob
>somewhere. We can't run this test on our x86 system anyway - no access to root
>or sudo even though it is installed.
>
>correct and note that the test would succeed if the file doesn't exist because what
>we are really interested on, is to make sure that sudo won't mess with our path
>when invoking git, and if there is a chance it would (because that setting is enabled
>in a different file for
>example) then we will just skip these tests.
>
>Obviously the target I had in mind when I built this test was my own workstation
>and our public CI, but feel free to provide a fixup that would also make it work for
>your private runs if you are interested in also running this test.
>
>> Also, /etc/sudoers is typically secured 0600 so the grep will fail
>> even if is_root passes
>
>It won't, because it is running with sudo ;).  note that as stated in the commit
>message, this requires a fairly open sudo setup (like the one github provides with
>their actions).
>
>> - and I'm worried about the portability of is_root, which is mostly Linux.
>
>I actually made sure that is_root was posix shell compatible, but got a little carried
>away when refactoring it to accomodate for reuse; eitherway it is gone in v3.

I tried to find is_root in POSIX but could not. Do you have a reference? It is not in bash 4.3.48, which is on our older system.

