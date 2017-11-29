Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5089920954
	for <e@80x24.org>; Wed, 29 Nov 2017 00:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdK2AKh (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 19:10:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64264 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751908AbdK2AKg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 19:10:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E94D4AE45F;
        Tue, 28 Nov 2017 19:10:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PXfzxi/ccyIVMB4yhIeJT8onNvo=; b=Gw1xzc
        UITlpIthBzxhxwGBKo2ZnkrVnbySio+Yi3pP66dgyGSUF15fYNdaAlQQo1wQcRc6
        NCRt0o0DLZP+0DTZIkRNJ3hPo/9Oijbol7Yp3euecfyOertBAYDdKtHUw5E0wpya
        sBa8pZ9koe1wnkHhowvk76brHu+ODfHa98tbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FLyTSlx7A2zAwNehoRh3kPhWHRbz1rPy
        8iuGiBYXXOd0H8kTH0D2sHrOqbfvMKugkE9RFqbTW2aacTbbeNoiwgmirj0+PTGl
        XXmP3MH4THh4nEDxA5UsnsJeOh0zn5svNzXZzyQQegY686yl2cpYfr21X69CKaPj
        UGIN9L6LFfo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1D69AE45E;
        Tue, 28 Nov 2017 19:10:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59C97AE45D;
        Tue, 28 Nov 2017 19:10:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] rebase: give precise error message
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
        <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
        <xmqqpo8387hz.fsf@gitster.mtv.corp.google.com>
        <1511877882.10193.2.camel@gmail.com>
Date:   Wed, 29 Nov 2017 09:10:34 +0900
In-Reply-To: <1511877882.10193.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Tue, 28 Nov 2017 19:34:42 +0530")
Message-ID: <xmqqzi7654hx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8CFF3C2-D499-11E7-81B4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Something like the following diff with additional changes to other
> places that refer to <branch>,
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 67d48e688..ba4a545bf 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -9,9 +9,9 @@ SYNOPSIS
>  --------
>  [verse]
>  'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
> -       [<upstream> [<branch>]]
> +       [<upstream> [<ref>]]
>  'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
> -       --root [<branch>]
> +       --root [<ref>]
>  'git rebase' --continue | --skip | --abort | --quit | --edit-todo
>  
>  DESCRIPTION
>
>
> If <ref> is the correct substitute <branch>, I could try to send a
> patch that fixes this.

I do not think the above is a good change in the first place for at
least two reasons.  By saying <ref>, the updated text says "not just
branches but you can also give tags and remote-tracking branches".
In reality, however, it can take any commit-ish, as the "no we are
not rebasing the current checkout" form of the command is merely a
short-hand to check it out first [*1*].  It gives appearance that
the change is making it more broad, but not making it broad enough.
At the same time, more than 90% of the time, people give a branch
name there.  Saying "branch-or-commit" for a short description of
the command line (which is what synopsis section is) does not add
that much value.  The body text of the description where we refer to
the <branch> parameter of course need to be updated to say "in
addition, instead of a branch name, you can give a commit-ish that
is *not* a branch name.  When you do so, instead of checking out the
branch, the HEAD is detached at that commit before the history
leading to it is rebased."

And because we have to say "it can be a non-branch commit-ish and
here is what happens when you do so" anyway, I think the current
synopsis as-is would be better than making it less clear and more
scary by replacing <branch> with other things like <commit-ish> or
[<branch> | <commit-ish>].


[Footnote]

*1* As my "log --first-parent --oneline master..pu" is a strand of
    pearls each of which is a merge of a topic branch,

    $ git rebase -i master pu~$n^2

    can be a handy way to make a trial rebase (after double checking
    the result of "git tbdiff", I may do "git checkout -B topic" to
    overwrite the original or I may discard the result of rebasing).
