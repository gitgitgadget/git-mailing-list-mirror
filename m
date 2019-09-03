Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362E01F461
	for <e@80x24.org>; Tue,  3 Sep 2019 21:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfICVkY (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 17:40:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60897 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfICVkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 17:40:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36DA518CDC;
        Tue,  3 Sep 2019 17:40:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZbELjNraP0CAbFfMvLWCTGQ4sFU=; b=GQS2jy
        B8oET6RVQQE9y89tDRtWag6N4x/zgvC+5Lr9WIUmBAYyGuDum7DjpwN+pIPeOqvy
        eTi6hFo81U3KuI98uo+p0XSc9y3PnG4PqR000XF5j2C5Ewte/44T4oSj30VqPNd2
        7u/juxB3+8jonCrAFGl5ZOlNRFYY9Y3aaDBFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xeRIw23UYvbZcVeaISql3FVQsddfy1LH
        FodYh4ClMNmxvQRwwUZKyN0RqelJ7/+iSgLwrJQl/aTbOdgaFOYifhY8ycP4ZA8n
        2cuPIro93FHwYOAz0v4Lu/0itAUK83YjBc1WpjUDywRkEMVYI31Cr+l9Bn51NWbm
        PfdZ14mwGCE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29B0A18CDB;
        Tue,  3 Sep 2019 17:40:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D56D18CDA;
        Tue,  3 Sep 2019 17:40:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/4] Recommend git-filter-repo instead of git-filter-branch
References: <20190828002210.8862-1-newren@gmail.com>
        <20190903185524.13467-1-newren@gmail.com>
        <20190903185524.13467-4-newren@gmail.com>
Date:   Tue, 03 Sep 2019 14:40:19 -0700
In-Reply-To: <20190903185524.13467-4-newren@gmail.com> (Elijah Newren's
        message of "Tue, 3 Sep 2019 11:55:23 -0700")
Message-ID: <xmqqo901rrcs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D92C894-CE93-11E9-BEF1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 5c5afa2b98..f805965d87 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -83,6 +83,19 @@ set_ident () {
>  	finish_ident COMMITTER
>  }
>  
> +if [ -z "$FILTER_BRANCH_SQUELCH_WARNING" -a \
> +     -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" ]; then

This is probably the only place where [] instead of "test" is used
in our shell scripts.

if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
then
    ...

> +	cat <<EOF
> +WARNING: git-filter-branch has a glut of gotchas generating mangled history
> +         rewrites.  Please use an alternative filtering tool such as 'git
> +         filter-repo' (https://github.com/newren/git-filter-repo/) instead.
> +         See the filter-branch manual page for more details; to squelch
> +         this warning, set FILTER_BRANCH_SQUELCH_WARNING=1.
> +
> +EOF
> +	sleep 5
> +fi

This should say it is "sleeping while showing the message and can
safely be killed before starting to do any harm"; alternatively it
should lose the "sleep".  The user would have fear against typing ^C
to get out of a bulk history rewrite command, and the message itself
is making the fear worse.  If your goal is to discourage its use,
then it would be a good idea to make it clear when it is safe to
kill it before going and studying the alternative.  Otherwise, the
sleep does not help that much---the main complaint is that filter
branch is too slow, so the user has plenty of time to read the
message anyway, right? ;-)

>  USAGE="[--setup <command>] [--subdirectory-filter <directory>] [--env-filter <command>]
>  	[--tree-filter <command>] [--index-filter <command>]
>  	[--parent-filter <command>] [--msg-filter <command>]
