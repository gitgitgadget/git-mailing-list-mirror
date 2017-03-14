Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B2020951
	for <e@80x24.org>; Tue, 14 Mar 2017 23:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbdCNXjM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 19:39:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60612 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750797AbdCNXjL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 19:39:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F39E36E73F;
        Tue, 14 Mar 2017 19:39:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IZjicJwSf/T/XF7D6B/fp73txvE=; b=XTtnXZ
        u9DHx27y6arkr/pr7T+UnMb0m0HyEZ8/oUYX4myVai4/nPjUmyyeShcYc3jEs198
        M2aqk29VM1jTXdx00F2XiRVr1MLgeqj2eeRaOYJwH3G5beoCime1U4Eu6hAH5eJy
        1b/yWNmr0vStAZ+FWSdQ3eO/x5u5YqRAnfCMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YX7cQGpZytUp91N0gz7BEO/ADemdS68Y
        nChoyyBdMVHljvVr/pQu15Eki6nvcf5Mnyxl+l6R/pgN2jqSChfxKd4JaiCLIaUi
        Pi3qHZ5lDe9Bn/1yFJ9SFxBCaZwNT04blltyPfPUF+r9x4HD0vR5LdqKeF/UnesS
        ei+HsXWXAqY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDD136E73E;
        Tue, 14 Mar 2017 19:39:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66D6D6E73D;
        Tue, 14 Mar 2017 19:39:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #06; Tue, 14)
References: <xmqq4lyvh1nw.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 14 Mar 2017 16:39:08 -0700
In-Reply-To: <xmqq4lyvh1nw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 14 Mar 2017 16:35:47 -0700")
Message-ID: <xmqqzignfmxv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BB60D2A-090F-11E7-A883-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Among the topics merged to 'master' since v2.12 was tagged, 40+ of
> them could be also merged to 'maint' (some of these are new features
> and by default should not be, though).  Among them two are fixes for
> regressions found in v2.12:
>
>  * The patch subcommand of "git add -i" was meant to have paths
>    selection prompt just like other subcommand, unlike "git add -p"
>    directly jumps to hunk selection.  Recently, this was broken and
>    "add -i" lost the paths selection dialog, but it now has been
>    fixed.
>    (merge c852bd54bd jk/add-i-patch-do-prompt later to maint).
>
>  * Git v2.12 was shipped with an embarrassing breakage where various
>    operations that verify paths given from the user stopped dying when
>    seeing an issue, and instead later triggering segfault.
>    (merge ce83eadd9a js/realpath-pathdup-fix later to maint).
>
> These two have been merged to 'master' only a few days ago;
> additional tests on 'master' to make sure they fix the issues, and
> more importantly they do not introduce new regressions, are greatly
> appreciated.  I am hoping we can merge them (and probably others)
> to 'maint' to cut v2.12.1 by early next week.

Those who are curious what "probably others" are, a good place to
start is this list (refer to RelNotes on the 'master' for what they
are about):

jk/delta-chain-limit # 2 (2 weeks ago) 
jk/grep-no-index-fix # 7 (2 weeks ago) 
jn/remote-helpers-with-git-dir # 2 (2 weeks ago) 
jk/show-branch-lift-name-len-limit # 3 (2 weeks ago) 
jk/tempfile-ferror-fclose-confusion # 1 (2 weeks ago) 
rl/remote-allow-missing-branch-name-merge # 1 (2 weeks ago) 
dt/gc-ignore-old-gc-logs # 1 (2 weeks ago) 
jc/config-case-cmdline-take-2 # 2 (4 days ago) 
jk/ident-empty # 4 (4 days ago) 
jt/upload-pack-error-report # 1 (4 days ago) 
rs/sha1-file-plug-fallback-base-leak # 1 (4 days ago) 
jt/http-base-url-update-upon-redirect # 1 (4 days ago) 
jk/add-i-patch-do-prompt # 1 (2 days ago) 
js/realpath-pathdup-fix # 2 (2 days ago) 
ss/remote-bzr-hg-placeholder-wo-python # 1 (2 days ago) 
ax/line-log-range-merge-fix # 1 (2 days ago) 
vn/line-log-memcpy-size-fix # 1 (2 days ago) 
jc/diff-populate-filespec-size-only-fix # 1 (2 days ago) 
ab/cond-skip-tests # 3 (75 minutes ago) 
jk/interpret-branch-name # 9 (75 minutes ago) 
mm/fetch-show-error-message-on-unadvertised-object # 3 (75 minutes ago) 
dp/filter-branch-prune-empty # 4 (75 minutes ago) 
ew/http-alternates-as-redirects-warning # 2 (75 minutes ago) 
jk/push-deadlock-regression-fix # 6 (75 minutes ago) 
mm/two-more-xstrfmt # 2 (2 weeks ago) 
ps/docs-diffcore # 2 (4 days ago) 
ew/markdown-url-in-readme # 1 (4 days ago) 
rj/remove-unused-mktemp # 2 (4 days ago) 
jk/ewah-use-right-type-in-sizeof # 1 (2 days ago) 

