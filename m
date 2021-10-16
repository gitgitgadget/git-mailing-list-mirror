Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB5DC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 00:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C768611F0
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 00:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbhJPBAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 21:00:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51647 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbhJPBAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 21:00:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15F7AED0E0;
        Fri, 15 Oct 2021 20:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=JVpkYolBhlx9yCH0B1Mc2k14O
        NN614hBuvTA/uA42rQ=; b=RJRETS6XI6/i8CXZTP0yHLSlzMiUsSpVdpMLKCnRs
        UAWW0j5NNYJgoqIGr19prmOKybWtPBPFhUsARrlrMlGMqPVawEgRJPaeYQNjKF0y
        kQnKykgDwRQD0Vr5EKC8APUOa6vO6qB0Som1np9vo2KDmKGieopV0pFBk/oDhe3C
        AY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D83FED0DF;
        Fri, 15 Oct 2021 20:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 660BFED0DE;
        Fri, 15 Oct 2021 20:58:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 00/13] hook.[ch]: new library to run hooks + simple
 hook conversion
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
Date:   Fri, 15 Oct 2021 17:58:04 -0700
Message-ID: <xmqqbl3p4wgz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1EEBEF78-2E1C-11EC-9771-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Part 2 of the greater configurable hook saga, starting by converting
> some existing simple hooks to the new hook.[ch] library and "git hook
> run" utility.
>
> See the v1 [1] CL for more context. I've dropped the git-p4 folks from
> the CC list, your feedback on git-p4 would still be very appreciated,
> but I don't think I need to re-spam you for every re-roll of this.


This, when merged to 'seen', seems to fail so many tests to make me
question my sanity.  Something is not playing with it well.

Queued on top of a merge of ab/config-based-hooks-1 into 'master';
when tested alone, without any other topics in 'seen', it seems to
fare much better.  Only t2400-worktree-add.sh fails at 58-59 and 62.



Test Summary Report
-------------------
t1092-sparse-checkout-compatibility.sh           (Wstat: 256 Tests: 36 Fa=
iled: 2)
  Failed tests:  23, 25
  Non-zero exit status: 1
t5572-pull-submodule.sh                          (Wstat: 256 Tests: 64 Fa=
iled: 2)
  Failed tests:  61, 63
  Non-zero exit status: 1
t3432-rebase-fast-forward.sh                     (Wstat: 256 Tests: 225 F=
ailed: 203)
  Failed tests:  15-85, 87-170, 172-201, 203, 205, 207, 209
                211, 213-225
  Non-zero exit status: 1
t7406-submodule-update.sh                        (Wstat: 256 Tests: 58 Fa=
iled: 9)
  Failed tests:  14-22
  Non-zero exit status: 1
t3404-rebase-interactive.sh                      (Wstat: 256 Tests: 119 F=
ailed: 93)
  Failed tests:  4-6, 8-9, 14-21, 24-42, 44-47, 49, 52-59
                61, 63-69, 71-78, 80-86, 89, 92-104, 106
                108, 110-118
  Non-zero exit status: 1
t3426-rebase-submodule.sh                        (Wstat: 256 Tests: 29 Fa=
iled: 18)
  Failed tests:  1-6, 11-13, 15-20, 25-27
  Non-zero exit status: 1
t0021-conversion.sh                              (Wstat: 256 Tests: 41 Fa=
iled: 1)
  Failed test:  18
  Non-zero exit status: 1
t5520-pull.sh                                    (Wstat: 256 Tests: 70 Fa=
iled: 26)
  Failed tests:  19, 23-24, 26-29, 40-41, 43, 45-46, 49-52
                55, 57-62, 67, 69-70
  Non-zero exit status: 1
t5533-push-cas.sh                                (Wstat: 256 Tests: 23 Fa=
iled: 2)
  Failed tests:  21-22
  Non-zero exit status: 1
t3200-branch.sh                                  (Wstat: 256 Tests: 145 F=
ailed: 2)
  Failed tests:  140-141
  Non-zero exit status: 1
t3421-rebase-topology-linear.sh                  (Wstat: 256 Tests: 64 Fa=
iled: 50)
  Failed tests:  2-4, 9-16, 22-27, 29-33, 36-42, 44-64
  Non-zero exit status: 1
t2400-worktree-add.sh                            (Wstat: 256 Tests: 71 Fa=
iled: 6)
  Failed tests:  41, 45-46, 58-59, 62
  Non-zero exit status: 1
t7512-status-help.sh                             (Wstat: 256 Tests: 44 Fa=
iled: 20)
  Failed tests:  5-6, 8-12, 14-22, 28, 41-43
  Non-zero exit status: 1
t3420-rebase-autostash.sh                        (Wstat: 256 Tests: 42 Fa=
iled: 38)
  Failed tests:  2-3, 5-36, 39-42
  Non-zero exit status: 1
t7601-merge-pull-config.sh                       (Wstat: 256 Tests: 62 Fa=
iled: 11)
  Failed tests:  15, 25-26, 28-29, 33-36, 42-43
  Non-zero exit status: 1
t3430-rebase-merges.sh                           (Wstat: 256 Tests: 25 Fa=
iled: 21)
  Failed tests:  2, 5-10, 12-25
  Non-zero exit status: 1
t9903-bash-prompt.sh                             (Wstat: 256 Tests: 66 Fa=
iled: 47)
  Failed tests:  14-35, 37, 40-52, 54-63, 66
  Non-zero exit status: 1
t3415-rebase-autosquash.sh                       (Wstat: 256 Tests: 24 Fa=
iled: 23)
  Failed tests:  2-24
  Non-zero exit status: 1
t3418-rebase-continue.sh                         (Wstat: 256 Tests: 29 Fa=
iled: 19)
  Failed tests:  2-3, 6-9, 11-19, 26-29
  Non-zero exit status: 1
t3433-rebase-across-mode-change.sh               (Wstat: 256 Tests: 4 Fai=
led: 3)
  Failed tests:  2-4
  Non-zero exit status: 1
t3400-rebase.sh                                  (Wstat: 256 Tests: 35 Fa=
iled: 23)
  Failed tests:  4-6, 10-13, 18-33
  Non-zero exit status: 1
t7528-signed-commit-ssh.sh                       (Wstat: 256 Tests: 23 Fa=
iled: 14)
  Failed tests:  1-5, 7, 10-17
  Non-zero exit status: 1
t3435-rebase-gpg-sign.sh                         (Wstat: 256 Tests: 20 Fa=
iled: 17)
  Failed tests:  3-11, 13-20
  Non-zero exit status: 1
t7510-signed-commit.sh                           (Wstat: 256 Tests: 25 Fa=
iled: 19)
  Failed tests:  1-6, 8, 11-19, 23-25
  Non-zero exit status: 1
t3431-rebase-fork-point.sh                       (Wstat: 256 Tests: 26 Fa=
iled: 23)
  Failed tests:  2-19, 22-26
  Non-zero exit status: 1
t5407-post-rewrite-hook.sh                       (Wstat: 256 Tests: 16 Fa=
iled: 13)
  Failed tests:  4-16
  Non-zero exit status: 1
t7505-prepare-commit-msg-hook.sh                 (Wstat: 256 Tests: 20 Fa=
iled: 1)
  Failed test:  14
  Non-zero exit status: 1
t3901-i18n-patch.sh                              (Wstat: 256 Tests: 20 Fa=
iled: 8)
  Failed tests:  4-7, 12-15
  Non-zero exit status: 1
t3900-i18n-commit.sh                             (Wstat: 256 Tests: 38 Fa=
iled: 6)
  Failed tests:  33-38
  Non-zero exit status: 1
t2012-checkout-last.sh                           (Wstat: 256 Tests: 22 Fa=
iled: 4)
  Failed tests:  19-22
  Non-zero exit status: 1
t3436-rebase-more-options.sh                     (Wstat: 256 Tests: 17 Fa=
iled: 15)
  Failed tests:  2-16
  Non-zero exit status: 1
t3437-rebase-fixup-options.sh                    (Wstat: 256 Tests: 11 Fa=
iled: 10)
  Failed tests:  2-11
  Non-zero exit status: 1
t3407-rebase-abort.sh                            (Wstat: 256 Tests: 15 Fa=
iled: 5)
  Failed tests:  3, 5, 10-12
  Non-zero exit status: 1
t7504-commit-msg-hook.sh                         (Wstat: 256 Tests: 25 Fa=
iled: 1)
  Failed test:  25
  Non-zero exit status: 1
t7030-verify-tag.sh                              (Wstat: 256 Tests: 15 Fa=
iled: 6)
  Failed tests:  1, 3, 8-9, 11-12
  Non-zero exit status: 1
t3402-rebase-merge.sh                            (Wstat: 256 Tests: 14 Fa=
iled: 12)
  Failed tests:  3-14
  Non-zero exit status: 1
t3403-rebase-skip.sh                             (Wstat: 256 Tests: 20 Fa=
iled: 12)
  Failed tests:  4-5, 8, 11-19
  Non-zero exit status: 1
t3412-rebase-root.sh                             (Wstat: 256 Tests: 25 Fa=
iled: 12)
  Failed tests:  4, 6-8, 10-13, 19, 21-22, 24
  Non-zero exit status: 1
t3425-rebase-topology-merges.sh                  (Wstat: 256 Tests: 13 Fa=
iled: 12)
  Failed tests:  2-13
  Non-zero exit status: 1
t7031-verify-tag-signed-ssh.sh                   (Wstat: 256 Tests: 8 Fai=
led: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t3424-rebase-empty.sh                            (Wstat: 256 Tests: 15 Fa=
iled: 13)
  Failed tests:  3-15
  Non-zero exit status: 1
t7517-per-repo-email.sh                          (Wstat: 256 Tests: 16 Fa=
iled: 3)
  Failed tests:  7, 9, 11
  Non-zero exit status: 1
t6427-diff3-conflict-markers.sh                  (Wstat: 256 Tests: 9 Fai=
led: 2)
  Failed tests:  7-8
  Non-zero exit status: 1
t3416-rebase-onto-threedots.sh                   (Wstat: 256 Tests: 13 Fa=
iled: 6)
  Failed tests:  2-3, 5-6, 10, 12
  Non-zero exit status: 1
t3406-rebase-message.sh                          (Wstat: 256 Tests: 14 Fa=
iled: 13)
  Failed tests:  2-14
  Non-zero exit status: 1
t3413-rebase-hook.sh                             (Wstat: 256 Tests: 15 Fa=
iled: 10)
  Failed tests:  2-3, 5-10, 14-15
  Non-zero exit status: 1
t3401-rebase-and-am-rename.sh                    (Wstat: 256 Tests: 10 Fa=
iled: 5)
  Failed tests:  2, 4, 7-9
  Non-zero exit status: 1
t3434-rebase-i18n.sh                             (Wstat: 256 Tests: 6 Fai=
led: 5)
  Failed tests:  2-6
  Non-zero exit status: 1
t7402-submodule-rebase.sh                        (Wstat: 256 Tests: 6 Fai=
led: 3)
  Failed tests:  2-3, 6
  Non-zero exit status: 1
t3429-rebase-edit-todo.sh                        (Wstat: 256 Tests: 6 Fai=
led: 2)
  Failed tests:  3-4
  Non-zero exit status: 1
t3419-rebase-patch-id.sh                         (Wstat: 256 Tests: 5 Fai=
led: 1)
  Failed test:  4
  Non-zero exit status: 1
t3428-rebase-signoff.sh                          (Wstat: 256 Tests: 6 Fai=
led: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t5403-post-checkout-hook.sh                      (Wstat: 256 Tests: 8 Fai=
led: 2)
  Failed tests:  6-7
  Non-zero exit status: 1
t3427-rebase-subtree.sh                          (Wstat: 256 Tests: 3 Fai=
led: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t3423-rebase-reword.sh                           (Wstat: 256 Tests: 3 Fai=
led: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t3417-rebase-whitespace-fix.sh                   (Wstat: 256 Tests: 4 Fai=
led: 4)
  Failed tests:  1-4
  Non-zero exit status: 1
t3405-rebase-malformed.sh                        (Wstat: 256 Tests: 5 Fai=
led: 3)
  Failed tests:  3-5
  Non-zero exit status: 1
t3408-rebase-multi-line.sh                       (Wstat: 256 Tests: 2 Fai=
led: 1)
  Failed test:  2
  Non-zero exit status: 1
Files=3D942, Tests=3D24498, 113 wallclock secs ( 8.74 usr  2.04 sys + 726=
.97 cusr 424.82 csys =3D 1162.57 CPU)
Result: FAIL
g
