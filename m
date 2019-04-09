Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF2C20248
	for <e@80x24.org>; Tue,  9 Apr 2019 16:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDIQTx (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:19:53 -0400
Received: from mout.web.de ([212.227.15.4]:59031 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfDIQTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554826779;
        bh=Q3GHe6Dm154UJ/Pe19t2IO8qDIW86Z9ptrmYsGQtS84=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kdvbsr/gt5DCHTy38Z4/zHI5eZo8wbdWNWUbt0w3D9hZ5A/rjJb1Ins+Rxc+uEt4m
         /CmZZE6psvSuY9LSmIE+0zKBKggitV5TaG70oNmqDLGFuPj87OxJ3mrxq/4ys9WoT0
         E5slbxvA8s8Y+t7q8q2WoshUFBdccf3jD4XbAlKg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from macce.local ([134.30.197.86]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGiLB-1h9p0M0Xdx-00DZmV; Tue, 09
 Apr 2019 18:19:39 +0200
Subject: Re: [PATCH] Unbreak real_path on Windows for already absolute paths
 (with Visual Studio)
To:     Sven Strickroth <sven@cs-ware.de>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de
References: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
 <0f629384-638f-bfb9-89da-ade335e364fd@web.de>
 <950ee9b8-786f-28cd-3e89-ad174fd857a4@cs-ware.de>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <af640e82-ca1a-9c96-da47-62aaea1cc18e@web.de>
Date:   Tue, 9 Apr 2019 18:19:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <950ee9b8-786f-28cd-3e89-ad174fd857a4@cs-ware.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aSxeIumqou8S6uO+5JtJyk/Khior+MerEUFbylqcIu3VaZ44vcr
 4QC1BAhlG8RWKEOrxqY/tuy6557IxvSdDrxK8B5aeyTd8bmpQSCXYI9TAyrxx+yDjaM0D2i
 1Kg20a/hgtSO0SaHKbEc0yi1TaVcrYM50VERFUqGVgpbaR8LYoLUBQg1/ADDj0xaNVLZDVF
 i11UwTnseN9gc0uk0/67A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E54S5npJyD4=:gAdN93wc8DgTWtGcVbo+oO
 6ROiUeup16js5dmzaQUeRRKykG1ZC1/2o2bxGS3s+UOyA5oDwdxUnmzzBdlTZeMsW02PMnCLw
 K67dFAio21X4LfI20lpYhOaF8VHk40HbmKNhfs0A3dx+6jF3FhiYWaVYQa0RaaHdz1pTIAaLb
 5sMPS7HoiyP7ji1NQExEl4un5PWXQVatH+uGxUGDM5rWshDcQPTS/cLvw9YjvoLkTR/RNsTiD
 SYcvas3K6XZ7l2bW67lH7PZ8x0QZ+7rIs8RpaJKKP0A5dDff2bRAY3yn3bRFDxtugpVglWMy7
 hE2B84qsYH0VyGCXxtpN+lJlg/zodU0Ak/QtxWy2oHG0uD/8/83hn5/NvfKlpNe6oyTW6FO9U
 2rmg8mKHXq3O6SlbqGotkhTGuFKOrl2HI6IVfDFMXqYSVsX3aS9dfFZjg9zFZsdgl5j8dNrKW
 5VH4NeVzMU/o2NvJVKpUJmqJannNlOBXLMbTTrlRPpnW6DwzQlZ4NsqanRfnWuafXisD1H0IO
 uWfXtsPv8JJk71HnCWfV+Kyh9bjUch5JCIkkxc7FsmCYJSMQzF5twSfXbqWuomipIZMPKtSC1
 XhK0ruS2jWhwK0wRp/wfHKl8Bu9UC569FaTJ/tGsZUKVnN84HLEkpugeVYcRzke9Mi1YqUHoR
 o+4DrmOOJvQrqTnhXZ/b8gTByuoRkooOlP1ae/viP8n60eNs3wuIi5RnhUu6hmCTP63F26CPm
 9isTUm5sBVurz9XYetJQUxp9GXhKCGUlNVUNL33c2vKPECT4dyGHa9MCcjuGxh6VKy4T+39+z
 5AUivvrfPkriAr/yfJQQaleroXDr+N5RBmgoClcPIuM5rCUsY5w3Yh/tVfBhebBs3ggnBH8qD
 +IbSgZ4w9Bdu33lp+wsazZKGHsArhxAyNfSuIWt55hvr0UQX950wOisrgH1wLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-04-09 09:34, Sven Strickroth wrote:
> Am 09.04.2019 um 07:53 schrieb Torsten B=C3=B6gershausen:
>>> Regression was introduced in commit
>>> 25d90d1cb72ce51407324259516843406142fe89.
>>
>> Was it ?
>> 25d90d1cb merged this commit:
>> 1cadad6f6 (junio/tb/use-common-win32-pathfuncs-on-cygwin)
>
> Yes, I copied the revision of the merge commit.
>
>> And, if I read that correctly,  1cadad6f6 does not change anything for =
MSVC.
>> And the problem with the missing/wrong path resolution was there before
>> 1cadad6f6 and after 1cadad6f6.
>
> That's not correct, it was correct before:

No, I wasn't aware that msvc.c include mingw.c - for whatever reason.


> 1cadad6f6 removes mingw_offset_1st_component from mingw.c which is
> included by msvc.c. Then the in git-compat.h the new file
> "compat/win32/path-utils.h" is only included for __CYGWIN__ and
> __MINGW32__, here _MSC_VER is missing -> that's the regression.
>

OK, good.
If possible, I would like to see this kind of information
in the commit message.
Thanks for cleaning up my mess.



