Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687AAC4332F
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 18:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiK1SPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiK1SPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 13:15:05 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8FF15A37
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 09:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669658251; bh=7hNMSGruKaUe1TUt8FoE0o0uupZz9slECd1RX8lRQhw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=IWC9KHgpyS3CZe19AqIeov6faD0exg4WGDt0E8nrCm0E/Z1rpbUU1lvu4xnlx5pib
         WgSFKHUq4xkSfyilqwHF0guKkZAIVtsHShI2AA9flhvxP0MjYn7Qgb9MBCpj1VyCMW
         5eLY0NBh3UbLd4BVRl4gea2AFbDO0eYuEs+ZZKp4CFZvl1ujfzbfJ4bbheyvKn6RXE
         O69uBc1XUjIhzRFX2j2SGwvSmBQNNcwlnnVtRWMWWvyM7OlifyidM/mVmjwKnB1q6z
         f39PD4/3kGyuJXbiLa35XKrl0gRKOiDAX6x4aC8irk2S2vU973o/RkwCtrVn/Onptf
         Gb+MbYlzbJD1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1on7FY1jH9-00vs3F; Mon, 28
 Nov 2022 18:57:31 +0100
Message-ID: <2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de>
Date:   Mon, 28 Nov 2022 18:57:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
 <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
 <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
 <221128.865yezkule.gmgdl@evledraar.gmail.com>
 <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
In-Reply-To: <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q1trVEk8Wkc8yTEVpGOkOGkSLOFLynGwR19RzdMqrjtX3eE1Ukh
 5M7ysD8ujoTqeXIYIz0mi0gO9sEZQdO6we2Gkn6Y9xwCqToxRw4+RtSGl1ecA2PSqixUfGX
 SkToNPtJ7qUfLZAA+KDTvG0Z1M6VDN0cKnPSHH/7MqSZ9ISRJMv/nDTV8rPizH8yGSBxsYY
 lPCNHqAmJYWqzbEgouaPw==
UI-OutboundReport: notjunk:1;M01:P0:g/B71XWntVs=;JW0aBjZxNYc/SBfINwb09LlC/nD
 bs5ixlV5+cVDZtUn7vvX5/CSe6J8Pkc9lTtJOO7kCDYJiLwim6EzWpa4emync5u8BBFSJ+qU7
 LRoKEXXD9JSKTI+VObxFnUb5lT4bP1wPIXJx5cpGRjSnQMsfHdzfFJZubHBXGBNjDDjFZkl6Z
 73jhVfQgJY9bU1084t6hoVFI9hKEstqX9mDa5V7GRV1b1l0btRqpwugkB4wFYxm/kQgZBuc2Q
 z5JDLTjIVA3SnCQI13XtLOq8FfKyAAqKr/qnm9v9qw+NaWkqycaLTFifhSvrxAXdM32NnlXu1
 +5nilEj0on0H9bDyS2zJ8r0ZxrUWR4KwFx2Pr+J98kyQxlIP5DFGotkxeeRPyimX0QzBele70
 4zp39v01dO8FgZC7DBSXt3ICsGye/g32mgfHZC6xGl6Zm7hXPvG5ie1vrToS1idhOxTmJ0DRI
 hEhaHITmsQ1/S0rZLWpybPwZ3T0xrl0pg61+5E27ZjzjMOs66v9E8Y7HBbmYhI2BJ2IFl1bcF
 QlIhsb/2C2fmkQpyS1BI1FeypVBRd9tKhNPLVCCecX1BP6swqgYDctqLkN5xMV5kJjmo5k/io
 0B4WBMDZjs79SFelcohLlAkZCnBLlktaBQ6Kg2yS8eWgFnVBQTc7rv6No75G0V7BPaOFWhkcL
 pHcUBbHdXL2o0m5zEymzZNqQD82kFEDsvlFAM4Ok2/W2iTOS40GnR2rslRYQBdo7AXoHRhuf2
 34cROyHqKlC9/WwjGNwG9nUU6sxvexX5KApPbHdV7PoBbQwpXlSjJZiBUhXjDYackbU92KVmz
 eoRhbYKMA90eoNB5+JMHQSm9H5g8MJv0KkRd/klbWx9cc+uusqkJmK+wkJvjMzIr4wPsSdgGf
 OtOEwQZYSV90yqSeeqbgbAG95yIi0kmytyuoN4mM/PXEpdAl8k7TwGV9gkZZOiJJ2rcDuzEBz
 Fxf5Y4HK+VVRHOayZaDqXM6bf38=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.2022 um 16:56 schrieb Ren=C3=A9 Scharfe:>
> The problem is "How to use struct rev_info without leaks?".  No matter
> where you move it, the leak will be present until the TODO in
> release_revisions() is done.

Wrong.  The following sequence leaks:

	struct rev_info revs;
	repo_init_revisions(the_repository, &revs, NULL);
	release_revisions(&revs);

... and this here doesn't:

	struct rev_info revs;
	repo_init_revisions(the_repository, &revs, NULL);
	setup_revisions(0, NULL, &revs, NULL);  // leak plugger
	release_revisions(&revs);

That's because setup_revisions() calls diff_setup_done(), which frees
revs->diffopt.parseopts, and release_revisions() doesn't.

And since builtin/pack-objects.c::get_object_list() calls
setup_revisions(), it really frees that memory, as you claimed from the
start.  Sorry, I was somehow assuming that a setup function wouldn't
clean up.  D'oh!

The first sequence is used in some other places. e.g. builtin/prune.c.
But there LeakSanitizer doesn't complain for some reason; Valgrind
reports the parseopts allocation as "possibly lost".

I still think the assumption that "init_x(x); release_x(x);" doesn't
leak is reasonable.  Let's make it true.  How about this?  It's safe
in the sense that we don't risk double frees and it's close to the
TODO comment so we probably won't forget removing it once diff_free()
becomes used.

=2D--
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 439e34a7c5..6a51ef9418 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -3055,6 +3055,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
+	FREE_AND_NULL(revs->diffopt.parseopts);
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
 	release_revisions_topo_walk_info(revs->topo_walk_info);
=2D-
2.30.2
