Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFCFC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 07:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E9561184
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 07:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhDJH3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 03:29:47 -0400
Received: from mout.web.de ([212.227.17.12]:33123 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhDJH3q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 03:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618039769;
        bh=Yagi7VPtAjVxp2ExdME2fZP4opKISfWX9QPZXxKkaqM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aeJZnOlssuJlSiTZixXL1OLF09XoPW/EUB9ToJrU+3odKR9Xr1PVS0hWNb/CKMgRm
         /sTmfWJxpiHLVRqhtM7xD+WZImptVUf1hN2E9SOxdNhTlLWUO69VReYCB4R8YY47Hm
         tJIUryVbHuXMbXkGDIPWDRDjX1yaj5mcAg50Qf+o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M9XUJ-1lPwrn3YRr-00CzF5; Sat, 10 Apr 2021 09:29:28 +0200
Subject: Re: [PATCH 01/12] revision: free remainder of old commit list in
 limit_list
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
 <12f0dcaef109e7577eabcc6f94f8ee72695b79aa.1617994052.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <797e5ce8-14e2-0689-cf19-4426c1c8bd5d@web.de>
Date:   Sat, 10 Apr 2021 09:29:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <12f0dcaef109e7577eabcc6f94f8ee72695b79aa.1617994052.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MKo/gtaYuHl6d24Sb4vplQS0d8mcTmCbIgWX82gY2Q+pyI7CTFm
 P04p1h6bBISsxaVUl4j4a3iqnOUtDYgD+7nyKmnw3zcKtNGoF/cIEH5vLKPrzZKaV4xblts
 X0BqqmCAeJxd86quhsxwSg22qynoVG9+AqAbDxP+j7zHNw9YeYj/lcL5vwetd8iQPSL6H2K
 niQMBjpyrJTHb3QIkyYcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HZux974E24s=:PyokNSyoTl9Bsxsfq+yf7R
 WoDYmv9DMr8Q6Jj8DMXqBMltgbgPVKIyK/aXGldch95Qw55jsjNbOvG+tJi4p+UNZt7ScoW7g
 ufEbXfaEAmZK+WPJgb2KPjR6dXsKy5hdR56m5xsMfYNVqVzQhOJtuu1ip8bwKMaMG+L3ekpFh
 6DsrVSXx6XLzqTc7Z7jFb2dbqSximXxA1yDmKvbgQFRRFxVgFh8AQGYfoK9agHKYVrhdEIdFY
 heknGvAUL5q6kIMu93DVd3mFNi7V4KXuqM6H6ifhzsR/APb4ufduQtiigFIZaWf/u7kVr7Gi6
 FP5mbHMbMyQhXOdTXqlxAW9wE0UtrEZ6N1Azjm4wx5hSYmA6FelS6wHdRfM5pN74PmTNn3AjI
 y0I5toMkkeQsyuyRLDMEcuFQUXeeBNInfYceToAM/xb+qqhEgaKo8tB0m6PO+OGaMNCyW8T3y
 IwFJ3Vzyngc/hutlLu/9YHSItAUU1XoqT5lCYBSuh2cbrsO1/iB0Wi3NkOIU3lWdPHEH//GmE
 yA0C2BPe8DNRHsTWFY/qIJABHRqOVS/w6vNhM1OyCt75tG7nHMb26d3FAv88KgbMfHk4wOOQl
 Nm70EIbiryl99XkImEE2k0piRD/4FiNuHW9AmB8Gp36/4tvU5sQSrPoiRQhoOTi7fQ00A3X0x
 jtxcZ7TX5TWQmrL29jmZKswdDPqSa88CnAFZMTbz3ICNiMEVCGylnx/J2jYz4z688iW1YdJrs
 uSJ70vqmtGMEt6W1b7TEzJ3FA++FVyif69V7jJnCi0x+or4faPAJ+ocLroo7+wcKQmvY6ayBj
 gItMkhCeNJctD/hpa+jKHwxaPVYbLE9QXfArRepKe1oao8HrNsFEUHCTuZ1s+N5+56uyj0NS2
 cko7/+ftUrUCDwhPKOBIz/vab0LfnWm6ADN8k/lrbWD/KsmicpZPytRD4GMrAV7csuSkZNEt0
 Ow3TVIaOPV/IujztiEoVtK0bqCT/WiiOGxHb56ufFPDHLV20Cb2+jxccwZh278RPf+x84gjig
 5M1pkmLj/prADh+6+in6N/uOI24vdbaplmLCMuLJNmTjSZlGFZpu/Jx6MxaRz0eOsEeHRV56c
 fkDeDqfsJ1Zd1mIBTdtKsoUgqH4kebHaZ6466MT93PW8d6oempxxj7/XLNe2UxtILwiJVg67z
 KxlkSNv87GDZWo1DFxHLDM0sQZr9J7Od7hCP4EdzGaQ/v/9vZNHp+3FejK//hTI3SG4Pc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.04.21 um 20:47 schrieb Andrzej Hunt via GitGitGadget:
> From: Andrzej Hunt <ajrhunt@google.com>
>
> limit_list() iterates over the original revs->commits list, and consumes
> many of its entries via pop_commit. However we might stop iterating over
> the list early (e.g. if we realise that the rest of the list is
> uninteresting). If we do stop iterating early, list will be pointing to
> the unconsumed portion of revs->commits - and we need to free this list
> to avoid a leak. (revs->commits itself will be an invalid pointer: it
> will have been free'd during the first pop_commit.)
>
> This leak was found while running t0090. It's not likely to be very
> impactful, but it can happen quite early during some checkout
> invocations, and hence seems to be worth fixing:
>
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_l=
inux.cpp:145:3
>     #1 0x9ac084 in do_xmalloc wrapper.c:41:8
>     #2 0x9ac05a in xmalloc wrapper.c:62:9
>     #3 0x7175d6 in commit_list_insert commit.c:540:33
>     #4 0x71800f in commit_list_insert_by_date commit.c:604:9
>     #5 0x8f8d2e in process_parents revision.c:1128:5
>     #6 0x8f2f2c in limit_list revision.c:1418:7
>     #7 0x8f210e in prepare_revision_walk revision.c:3577:7
>     #8 0x514170 in orphaned_commit_warning builtin/checkout.c:1185:6
>     #9 0x512f05 in switch_branches builtin/checkout.c:1250:3
>     #10 0x50f8de in checkout_branch builtin/checkout.c:1646:9
>     #11 0x50ba12 in checkout_main builtin/checkout.c:2003:9
>     #12 0x5086c0 in cmd_checkout builtin/checkout.c:2055:8
>     #13 0x4cd91d in run_builtin git.c:467:11
>     #14 0x4cb5f3 in handle_builtin git.c:719:3
>     #15 0x4ccf47 in run_argv git.c:808:4
>     #16 0x4caf49 in cmd_main git.c:939:19
>     #17 0x69dc0e in main common-main.c:52:11
>     #18 0x7faaabd0e349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> Indirect leak of 48 byte(s) in 3 object(s) allocated from:
>     #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_l=
inux.cpp:145:3
>     #1 0x9ac084 in do_xmalloc wrapper.c:41:8
>     #2 0x9ac05a in xmalloc wrapper.c:62:9
>     #3 0x717de6 in commit_list_append commit.c:1609:35
>     #4 0x8f1f9b in prepare_revision_walk revision.c:3554:12
>     #5 0x514170 in orphaned_commit_warning builtin/checkout.c:1185:6
>     #6 0x512f05 in switch_branches builtin/checkout.c:1250:3
>     #7 0x50f8de in checkout_branch builtin/checkout.c:1646:9
>     #8 0x50ba12 in checkout_main builtin/checkout.c:2003:9
>     #9 0x5086c0 in cmd_checkout builtin/checkout.c:2055:8
>     #10 0x4cd91d in run_builtin git.c:467:11
>     #11 0x4cb5f3 in handle_builtin git.c:719:3
>     #12 0x4ccf47 in run_argv git.c:808:4
>     #13 0x4caf49 in cmd_main git.c:939:19
>     #14 0x69dc0e in main common-main.c:52:11
>     #15 0x7faaabd0e349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>  revision.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/revision.c b/revision.c
> index 553c0faa9b38..7b509aab0c87 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1460,6 +1460,7 @@ static int limit_list(struct rev_info *revs)
>  			update_treesame(revs, c);
>  		}
>
> +	free_commit_list(list);

This patch would benefit from more context, but this function is quite
long.  So let me sketch it:

	struct commit_list *list =3D revs->commits;

	while (list) {
		struct commit *commit =3D pop_commit(&list);
		struct object *obj =3D &commit->object;

		if (obj->flags & UNINTERESTING) {
			break;
		}
	}

        if (limiting_can_increase_treesame(revs))
                for (list =3D newlist; list; list =3D list->next) {
		}

	free_commit_list(list);

So the while loop can leave list dangling and you want to free its
remaining entries.  The for loop sometimes overwrites the list pointer,
though, and you will end up passing NULL to free_commit_list in that
case.  So either the call should be moved between the loops or a fresh
variable should be used in the second loop instead of reusing list to
make sure the entries are released in all cases.

>  	revs->commits =3D newlist;
>  	return 0;
>  }
>

