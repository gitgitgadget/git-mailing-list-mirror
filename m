Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3981F43C
	for <e@80x24.org>; Sun, 12 Nov 2017 05:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdKLF4A (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 00:56:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50111 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750823AbdKLFz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 00:55:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8410EA813F;
        Sun, 12 Nov 2017 00:55:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zvZi97FQrrF9BaBcRAJqDYhMtT4=; b=BFlWVJ
        z5ZK6npcmsori3mlB/aRcs/ZrgR2JpGnYIDDARze0KFuM12iwc1yC0Zh68AFIYaT
        Jie4nuPxuvsLH+vAdBl9/4QLN1+Z0ULlpOUx+bUqcRgj14atoJ2Sni6XJnExGPN+
        saAXFGHj3qX1QC/NPUE6o/2Wu07jb0nxDsSoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OVyoXCa7eC+E6Ou1FDSRk/R/b0LuZbgN
        6Z7DpRCVMq64xm6k//2K4ai6tx/JEWwnQUgpPOcg9iUMWVafDhVT6VOeOW0HlmGF
        BVhOAlrCt2EVAwoyBKxPmfhuenJ1H53gORFU2WEfVX+FbOZ3lWYyMHvztMqWd7Ko
        CZQkwvAk3ck=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66F1BA813D;
        Sun, 12 Nov 2017 00:55:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC117A813C;
        Sun, 12 Nov 2017 00:55:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] bisect: mention "view" as an alternative to "visualize"
References: <alpine.LFD.2.21.1711110838060.9569@localhost.localdomain>
Date:   Sun, 12 Nov 2017 14:55:56 +0900
In-Reply-To: <alpine.LFD.2.21.1711110838060.9569@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 11 Nov 2017 08:39:47 -0500
        (EST)")
Message-ID: <xmqqefp4ca6r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2757E22A-C76E-11E7-83FF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>  To see the currently remaining suspects in 'gitk', issue the following
> -command during the bisection process:
> +command during the bisection process (the subcommand `view` can, in all
> +cases, be used as an alternative to `visualize`):

I'd drop ", in all cases," if I were writing this.

If it were very common that some "synonyms" are only usable in
certain limited cases, singling this out and explicitly saying that
"'view', unlike many other 'synonyms', is truly a synonym to
visualize in all cases" would make sense and would help readers, but
I do not think that is the case.  An alternative by definition
should be usable "in all cases", so I do not think the phrase helps
the readers at all.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index fdd984d34..52f68c922 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1162,7 +1162,7 @@ _git_bisect ()
>  {
>  	__git_has_doubledash && return
>
> -	local subcommands="start bad good skip reset visualize replay log run"
> +	local subcommands="start bad good skip reset visualize view replay log run"

This change makes the end user experience a lot worse, I am afraid.

People used to be able to say "bisect vi<TAB>" and I'd imagine that
many are used to type exactly that.  Now they get two choices and
have to say 's' (or 'e') before hitting another <TAB>.
