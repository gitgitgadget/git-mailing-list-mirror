Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA4C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 11:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiK1L1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 06:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiK1L1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 06:27:01 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6431917A8D
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 03:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669634793; bh=Mbe5sOnkJ8AanVaT3sgPYikQvMziwY3n9rT4aEAlMso=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BnfaJMlnHONbvxQF6//WNTDAIWVDQocdpqjrlw2JRkQgWwnpln/xH84sI9scB3u/L
         /KzKJSx4Vl7B4p9B8rRchZyal1LsBDCP80FD3298FjHz7FwPvtHHq9T5iR4lxFQ3E8
         HkHkPsq/r1SNgWPoKUE34FWOxUMItAcAs+Hg73ign7VW9rnQlSoxTUgXT0MRgZ+61P
         cwjTqyuorYiyO3Z4mwve2BaDnlZa7feYrypDDQSMOxRoU8yLRFQcF7y1EyEktbSZ2Q
         HyL+Gqh1tIDIroos3zEBGBoqLhjSJIM5sgdzo40wmHQ3ZyzPzuKIMriZkEvcMceEHS
         K9WSMk81SKO2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk4e-1pSrAI3WOo-00TPn9; Mon, 28
 Nov 2022 12:26:32 +0100
Message-ID: <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
Date:   Mon, 28 Nov 2022 12:26:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqv8mz5ras.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sa1CB6nOBq5VtWxL7sp9DfCN0w8WA4ErrmpzgYonPhWOvWuuyYD
 1GqCiHrEI/5XUIAmaJabP2xmaWV51aEfwAChMYn7uln25u4m87Or/XbZ4MWF/E4ilGQnW9x
 ip6W9DBRgQo2eIZ3KzER9MaC5AbxN0GDzvKUCRrs82IY+P0M1cPMsVF8d0wZZCTyOKOb9VK
 LK03yWpndfcTakd0nTH3Q==
UI-OutboundReport: notjunk:1;M01:P0:nGGBHrIswUE=;x3VpnCX1Eo/vnFkZLllLWhgwEs0
 YRjNB4dqnTJr5PvwEvx/T3lZpRDfZlv1/WF5ID+H1u8Pfxh4qXXyTNonVTmRg6igK0So0id/3
 /Xh6+UAObgK0tJMVF76hgH+3mvzxyYys7fGawQmmG22BaBRMg7+Bx/yFGiyaBcWzZRXnHnBTB
 QGJy19DzVQX4El4u9YBVjpNGsmu1V9rgOZqAdBCy4p26vGJ85slafGiDeeErX2qFAy+sxDM5+
 8nFz/JZQGLMuwEYpSu0WAHxjlsXKLJ//ZKN4cmsLgGcUsGddNDv585GL7ZmIE0rd6k3k+1yAT
 I8zccm5wtvHFibGzbf4NLxJpTDH4k2/UEEPZRtIykCg/KDdr+DI3xXhmH9s/bWWoLVyurRC/7
 RocqoIyRVbh0lQUqofNM5AXP4Pa2I4kEn9NU8SSJtRCQOd1iVmPUQad5oEMyQAd7pDXc8xyro
 RDllmkyk+iVsFJ4O4/J7Q4wo+5Xo0gnnjUuA1EAQEgO1DM943RtiJlgVH3rHRyCzewyX5D7s6
 xMfBNh2hgdDPqh4nBpwsPGKcEtJSukAgMZYn5GUp2S5YD8rzLPWoJ3N2tcNWOBcM5qpOBwu8R
 XinCbMfOn1i/kUQ0VN+j+HW3jMs9DkTchVFCSLq6l/IhhygPxSWfr9F0QjcmZHhrPAxZFi7rF
 +bNtfAtBNToYkNY36GmAiuV+H6mgO14VkcefAejYbkk2cYFZanyjUl0KsI6aG9MV7u2vMNA6x
 FB7BJJ2Pe2eFy4Azuyj95hy88+DAyvfzc3Ms8+kIZdw0MDv8XE5UKTjydK8dCa0Wgyy1Zrozp
 6WIyhN8rmn1a4ceU/gJOwTPFwGbz5dE2UaaPE8Uf14bMLqKVWNRf9HpZs6hhkj7y6+qmcV+fI
 OYwfoBegYvsHEeQLY+c5q/xljMTMZbYvvMVIBCGA0rdw2/Yp1xkc8UPiPxAn/PIXmyjv4qSU0
 K5WBrJlk3C/nt0sUj0x66i7T4Sw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.2022 um 11:03 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>>
>> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak,
>> 2022-03-28) avoided leaking rev_info allocations in many cases by
>> calling repo_init_revisions() only when the .filter member was actually
>> needed, but then still leaking it.  That was fixed later by 2108fe4a19
>> (revisions API users: add straightforward release_revisions(),
>> 2022-04-13), making the reverted commit unnecessary.
>
> Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
> way.
>
> https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#step:=
5:3917
>
> Does anybody want to help looking into it?
The patch exposes that release_revisions() leaks the diffopt allocations
as we're yet to address the TODO added by 54c8a7c379 (revisions API: add
a TODO for diff_free(&revs->diffopt), 2022-04-14).

The patch below plugs it locally.

=2D-- >8 ---
Subject: [PATCH 4/3] fixup! revision: free diffopt in release_revisions()

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/pack-objects.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3e74fbb0cd..a47a3f0fba 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4462,6 +4462,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 	} else {
 		get_object_list(&revs, rp.nr, rp.v);
 	}
+	diff_free(&revs.diffopt);
 	release_revisions(&revs);
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
=2D-
2.30.2
