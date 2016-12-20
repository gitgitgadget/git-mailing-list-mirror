Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6726A1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 17:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932542AbcLTRlV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 12:41:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50656 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751359AbcLTRlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 12:41:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15EFF57826;
        Tue, 20 Dec 2016 12:41:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M+M9uOICghYhoONZGLyT7ch0o3o=; b=RmoZNM
        IGvP4mhwYphOHLpBbksr5HCiPaxeNfmMhoqjH0UKkYv/l3ZTOWehKMhFXm0cNE93
        +vRWbcQPTX45CmsGiZbPa2wcl10euYTMxPf4bE9oLb3tvgOISnLpvL4Y184kyHqf
        EMz+HYPMwRnzYgS0PAFevpvNfdGaNfl8GyoFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gno0uvR3VFWzxwIsvAqPIrlfNuiwh6Kk
        mWiriP/Y3tIugmFkjzG6O6x2oYFKVZNjL6y7+XqYXLs/URPdu/e7Pcy16dINBgx3
        h1DzCu/ERXmvPkBSBdInAA4QJlwkLXhMBnR/JvyjCxPo2t2li5lm2G+u8emmxcSw
        wd9D+ycYWBA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C12957825;
        Tue, 20 Dec 2016 12:41:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 756BC57824;
        Tue, 20 Dec 2016 12:41:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     Stefan Beller <sbeller@google.com>,
        Josh Bleecher Snyder <josharian@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: $program_name in error message
References: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
        <CAGZ79kZ=QK5s0_94+4GNs3M5oo49GLm-KkT5K=yZktxX8C4UCw@mail.gmail.com>
        <CAFAcib9-rUSqyBRpauw3pTf9OPTKLYNf7bdh2gyykBNtJTZKGg@mail.gmail.com>
        <CAGZ79ka=RzAjrb=7u7p5xnveo=kcNCoGn=TC=0j-CBp8Oby7OA@mail.gmail.com>
        <xmqqk2avodi1.fsf@gitster.mtv.corp.google.com>
        <xmqqfuljod70.fsf@gitster.mtv.corp.google.com>
        <1482243418.2029.10.camel@sapo.pt>
Date:   Tue, 20 Dec 2016 09:41:16 -0800
In-Reply-To: <1482243418.2029.10.camel@sapo.pt> (Vasco Almeida's message of
        "Tue, 20 Dec 2016 13:16:58 -0100")
Message-ID: <xmqqd1gmlcqr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82BDB688-C6DB-11E6-A95A-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Thanks for the report and letting me know.
> Yes, these were mistakes and lack of attention mine. It was supposed to
> call 'eval_gettext' rather than 'gettext' when \$variable interpolation
> is needed.

Thanks.  

As both of the offending commits (d323c6b641 & f2d17068fd) were part
of the topic that was merged at 2703572b3a ("Merge branch
'va/i18n-even-more'", 2016-07-13), I'll queue this single patch on
top of 2703572b3a^2 (i.e. the tip of the topic).

-- >8 --
Subject: [PATCH] i18n: fix misconversion in shell scripts

An earlier series that was merged at 2703572b3a ("Merge branch
'va/i18n-even-more'", 2016-07-13) failed to use $(eval_gettext
"string with \$variable interpolation") and instead used gettext in
a few places, and ended up showing the variable names in the
message, e.g.

    $ git submodule
    fatal: $program_name cannot be used without a working tree.

Catch these mistakes with

    $ git grep -n '[^_]gettext .*\\\$'

and fix them all to use eval_gettext instead.

Reported-by: Josh Bleecher Snyder
Acked-by: Vasco Almeida <vascomalmeida@sapo.pt>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh | 3 ++-
 git-sh-setup.sh            | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a545d92c26..c5806859f0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -467,7 +467,8 @@ update_squash_messages () {
 			}' <"$squash_msg".bak
 		} >"$squash_msg"
 	else
-		commit_message HEAD > "$fixup_msg" || die "$(gettext "Cannot write \$fixup_msg")"
+		commit_message HEAD >"$fixup_msg" ||
+		die "$(eval_gettext "Cannot write \$fixup_msg")"
 		count=2
 		{
 			printf '%s\n' "$comment_char $(gettext "This is a combination of 2 commits.")"
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 2eda134800..c7b2a95463 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -194,14 +194,14 @@ require_work_tree_exists () {
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		program_name=$0
-		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
+		die "$(eval_gettext "fatal: \$program_name cannot be used without a working tree.")"
 	fi
 }
 
 require_work_tree () {
 	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true || {
 		program_name=$0
-		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
+		die "$(eval_gettext "fatal: \$program_name cannot be used without a working tree.")"
 	}
 }
 
-- 
2.11.0-416-g1351c11cce

