Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 855891F404
	for <e@80x24.org>; Thu, 14 Dec 2017 18:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753786AbdLNSCH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:02:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61457 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753677AbdLNSCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:02:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41847C7153;
        Thu, 14 Dec 2017 13:02:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dk0Q5nBUx/Oc1tjBun76S0a3Efc=; b=Tv/eUe
        cNXgHOVSzWR8NKuzEimmnbeVaDbCBpyyqYFuEs9jd0M1wnmjkFhUa3m2yZyDEjQs
        TwmEbqS5apBvm+8lHWqN8hfQMaG6sVxCqpWqKbmAf/VX3qcpxzSNKVWyWGz7Al2V
        csm2jUvJFBzrYsTNaOdbGltu5fl89oWKbQW5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l4vSsEq0Qv1IwF7yVEEyMOxfGBa2lZ+Y
        qfed1CWR2znLyCBqLzCjmPwFs7wVzn+XxR5LEdVJp372TekoeHaQn4cQUm4FjKmG
        2bcwv/sXN/hcJqLnjrjMH5is8P/pUhVa7I/RGKil6iBvnU5yftL+B3rqnHa26Rn6
        gmZ+r8mxiuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39108C7152;
        Thu, 14 Dec 2017 13:02:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB95EC7150;
        Thu, 14 Dec 2017 13:02:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] Doc/check-ref-format: clarify information about @{-N} syntax
References: <xmqq609olg1p.fsf@gitster.mtv.corp.google.com>
        <20171214123027.9105-1-kaartic.sivaraam@gmail.com>
Date:   Thu, 14 Dec 2017 10:02:01 -0800
In-Reply-To: <20171214123027.9105-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 14 Dec 2017 18:00:27 +0530")
Message-ID: <xmqqa7ylur1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E33FD3BE-E0F8-11E7-A0AB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>  With the `--branch` option, the command takes a name and checks if
> -it can be used as a valid branch name (e.g. when creating a new
> -branch).  The rule `git check-ref-format --branch $name` implements
> -may be stricter than what `git check-ref-format refs/heads/$name`
> -says (e.g. a dash may appear at the beginning of a ref component,
> -but it is explicitly forbidden at the beginning of a branch name).
> -When run with `--branch` option in a repository, the input is first
> -expanded for the ``previous branch syntax''
> -`@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
> -were on.  This option should be used by porcelains to accept this
> -syntax anywhere a branch name is expected, so they can act as if you
> -typed the branch name.
> +it can be used as a valid branch name e.g. when creating a new branch
> +(but be cautious when using the previous checkout syntax; it may refer
> +to a detached HEAD state). The rule `git check-ref-format --branch
> +$name` implements may be stricter than what `git check-ref-format
> +refs/heads/$name` says (e.g. a dash may appear at the beginning of a
> +ref component, but it is explicitly forbidden at the beginning of a
> +branch name). When run with `--branch` option in a repository, the
> +input is first expanded for the ``previous checkout syntax''
> +`@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
> +was checked out using "git checkout" operation. This option should be
> +used by porcelains to accept this syntax anywhere a branch name is
> +expected, so they can act as if you typed the branch name. As an
> +exception note that, the ``previous checkout operation'' might result
> +in a commit object name when the N-th last thing checked out was not
> +a branch.

Looks alright.  

It was made unnecessarily harder to review because it was marked as
2/2, even though this no longer applies on top of the copy of 1/2
that was merged some time ago.  I needed to find that it was rebased
on top of 'master'; it wouldn't have been necessary if this was sent
as a single patch (with comment saying that this used to be 2/2
whose first one already graduated to 'master' under the three-dash
line).

Also re-wrapping the lines only to squeeze in "but be cautious..."
and replace s/branch/checkout/ in a few places did not help to make
it easy to spot what's changed.

This part looked a bit strange.

> +it can be used as a valid branch name e.g. when creating a new branch
> +(but be cautious when using the previous checkout syntax; it may refer
> +to a detached HEAD state). The rule `git check-ref-format --branch

I think "e.g. when creating a new branch" is a parenthetical remark,
so it should be inside parenthesis.  As the last three lines in the
new text (quoted above) already warns that it may not be a branch name,
I am not sure if the "but be cautious" adds much value, though.
