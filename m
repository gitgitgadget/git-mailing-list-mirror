Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875D0C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 16:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbiD0Qpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243437AbiD0Qph (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 12:45:37 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9016268FA4
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651077726;
        bh=7ycUqGEumeaZZPGcc66nEnRNvU+vQk6M6a/2WBO24ZM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=d+doWui/SUsKd54I64KGcxh8p9hUU1AR7fA4gvg5j8YEq52+VrHVGdplU1f6NpQxr
         mS6QqDLJpHRyGue8m6fcvhp/ulKAVTqn/MqVJ1Wmyj9OcCP95is4qJjV3zb1qLCd0n
         ZMFfZchk31WoarURAuIhOcUCAiUOSKzR08Yzq5QM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N947J-1nyLcH1Qu7-016BgE; Wed, 27
 Apr 2022 18:42:06 +0200
Message-ID: <561a73aa-7e94-5a09-0c9c-08e8b6ce7188@web.de>
Date:   Wed, 27 Apr 2022 18:42:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] 2.36 gitk/diff-tree --stdin regression fix
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
References: <xmqqh76j3i3r.fsf@gitster.g> <xmqqbkwpvyyc.fsf@gitster.g>
 <83a76d46-5069-d6c7-b8b3-f3a063637abb@gmail.com>
 <6ac7e164-c4ba-0ffc-a8a4-4cede1d4e7ae@gmail.com> <xmqqo80nsw5h.fsf@gitster.g>
 <xmqq7d7bsu2n.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq7d7bsu2n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:00pumbhnGbcCDfTUlspghxMXMbOwTnCiDOUaxAPHbTOTZUbq8lD
 scvb1WgbF58F6iyt/hN+4meibvNpe6px0xD+DsnmaveLiGYfV0usOQXY6IDhpd6tulKQG3J
 9VK7YMgfRLLpTVd6v/iSwMxuHyQ8Rpgn+jsHLHEBwGKJy2JNKPv1hqPn9n5yLzMw6Bd/Pdn
 ZkMzTMkBM0rdP0KlIiKzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DtYJxM62l2k=:Q1yO2w2NlDSTHlp1rkqGUJ
 dPPa8t1U5p36Qr9ROYXYdwsa0rQXqaQHA21nPztH2QWIa+A72N0F+EcZAfgy4qoVdTYrP2KLC
 EUMWjHzeoPi8wMMGSHUBMHjn86KNYgL71bCzylYhdBDCV8QtPTNBka1jGmZmZcZUydf8idvTU
 aG+P8VORyQsyao4pblNAMvIUjWveC+shM3DYE6LcpR+00t/rRxMcygCKjAXZZdCvAPXgPaNdj
 kodVrc31IgSN5X7pFlJ38XTHjRHPiEU/haY52g5UaBij5/HkrZhIoQ3ymRnkdFXEfQvZ7q/S3
 rcd6UldMQPQcFsKTHKI0iZwAfp818BPZ+h504fsxWz3C+/D6o0OsBnpHYs1qWQDb1jBVLENxc
 AwlLOLCAa/BPo1HRXkrSk5tfO5OtVT3uFwxI9MsBYTJBsAvIqk+Cuvio/rOCvv+DwJ4sRtY9W
 DMIN2AktDbfUiT2xOHotnknucfA+Sv7oZuZVD82afY9nD94LyLgMUFsKsECgfp0Z+gY2oVFLt
 pNwO83OkPuGviQE8XRngSambN10eQ1IEZgwYN6e4ii2FlVDMAF8+e8c6PtsILVUgrfmAwJGei
 u2elHVx03BgZYowrh+P2k8Ri2Zs+P+MTAyHY2XFxMJa7HWMFiyKI9nmyJ71wQZq/d2HwiZ+m0
 zWfoo310eSy8VxMnLG7zeks+KP8ZVZQcLedL+XZ3zh3j32Uc99XXglEX2NoKcWce57Q+h88KZ
 qaW/vgLfJG8QC25W8xE05eH85Hnt4iapfsPwmtcFJ2vL81gws0zb0+LeSypyg48SHNTDbHFVM
 Tb7Nvumt8wyjJDH3LY0jC96vrHuqaDMruASDNEOGWcAAmV4Y7o5kL22V9sh5Lvgp3QjPFxSQL
 JmBgaipVzvqOlyMPDPknZRlrcfNQfJL9HUiBhQfa7oIyncQrZgD1eZ/x9hcX5LtO51aQkabEm
 xCiajsgfS9EvnpGeOs08bAjQhDMaRMz4ve9ErwGwikPqOZR4FYR9/xZLygRkA4wBYao1IKwbd
 dL2R1iS+dk3rbyuSySh41zqDYbBxiN8NKoD2FwRhH0beE8276/cvfVAsc40EW0QnGQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.22 um 18:11 schrieb Junio C Hamano:
> This only surfaced as a regression after 2.36 release, but the
> breakage was already there with us for at least a year.
>
> The diff_free() call is to be used after we completely finished with
> a diffopt structure.  After "git diff A B" finishes producing
> output, calling it before process exit is fine.  But there are
> commands that prepares diff_options struct once, compares two sets
> of paths, releases resources that were used to do the comparison,
> then reuses the same diff_option struct to go on to compare the next
> two sets of paths, like "git log -p".
>
> After "git log -p" finishes showing a single commit, calling it
> before it goes on to the next commit is NOT fine.  There is a
> mechanism, the .no_free member in diff_options struct, to help "git
> log" to avoid calling diff_free() after showing each commit and
> instead call it just one.  When the mechanism was introduced in
> e900d494 (diff: add an API for deferred freeing, 2021-02-11),
> however, we forgot to do the same to "diff-tree --stdin", which *is*
> a moral equivalent to "git log".
>
> During 2.36 release cycle, we started clearing the pathspec in
> diff_free(), so programs like gitk that runs
>
>     git diff-tree --stdin -- <pathspec>
>
> downstream of a pipe, processing one commit after another, started
> showing irrelevant comparison outside the given <pathspec> from the
> second commit.  The same commit, by forgetting to teach the .no_free
> mechanism, broke "diff-tree --stdin -I<regexp>" and nobody noticed
> it for over a year, presumably because it is so seldom used an
> option.
>
> But <pathspec> is a different story.  The breakage was very
> prominently visible and was reported immediately after 2.36 was
> released.
>
> Fix this breakage by mimicking how "git log" utilizes the .no_free
> member so that "diff-tree --stdin" behaves more similarly to "log".
>
> Protect the fix with a few new tests.

We could check where reused diffopts caused a pathspec loss at runtime,
like in the patch below.  Then we "just" need to get the relevant test
coverage to 100% and we'll find them all.

With your patch on top of main, "make test" passes for me.  With the
patch below added as well I get failures in three test scripts:

t3427-rebase-subtree.sh                          (Wstat: 256 Tests: 3 Fail=
ed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t4014-format-patch.sh                            (Wstat: 256 Tests: 190 Fa=
iled: 1)
  Failed test:  73
  Non-zero exit status: 1
t9350-fast-export.sh                             (Wstat: 256 Tests: 50 Fai=
led: 3)
  Failed tests:  30, 32, 43
  Non-zero exit status: 1

The format-patch is a bit surprising to me because it already sets
no_free conditionally.  t4014 is successful if no_free is set in all
cases, so the condition seems to be too narrow -- but I don't understand
it.  Didn't look at the other cases.

=2D--
 diff.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/diff.c b/diff.c
index ef7159968b..b7c837aca8 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -6455,9 +6455,16 @@ static void diff_free_ignore_regex(struct diff_opti=
ons *options)

 void diff_free(struct diff_options *options)
 {
+	static struct diff_options *prev_options_with_pathspec;
+
 	if (options->no_free)
 		return;

+	if (prev_options_with_pathspec =3D=3D options && !options->pathspec.nr)
+		BUG("reused struct diff_options, potentially lost pathspec");
+	if (options->pathspec.nr)
+		prev_options_with_pathspec =3D options;
+
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
=2D-
2.35.3
