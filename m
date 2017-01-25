Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439C71F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbdAYV2u (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:28:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55141 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752382AbdAYV2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:28:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2438063440;
        Wed, 25 Jan 2017 16:28:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0tVkNGckcioFVqcJ0Em4r/zsYW4=; b=SuRc7A
        B5C+dbQkSosrFfVsA42TZjHOQP/84UeQLFuripx9+jXy4ZdsDab7yuGk8N8A2tnd
        +Mc0YpNlqkRKEcgGGteTer1HdwL4wplbGaN9cCeorlWSMctnPn00gPEUEbDsC1FY
        WlkiH028dHp1fSUwj49dwyQJMjJe57G3DbTZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r3+rlf+Pw0ZKWaObLH4/nb7fMtPtjLOU
        3qdfuWPxRHLrIkVPOpRLH3BMbVlHvFDvIPjTns0Xs2fdOnlOh+RL5Vtnrp82mMDP
        nIngLa3mCGtyQJLq76acd5nAgcXB4oc7ZEvtd0tOdHHTq+DgBjduzj9xB2PGdaqi
        4aS11sqM+RE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C3F36343F;
        Wed, 25 Jan 2017 16:28:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8324C6343E;
        Wed, 25 Jan 2017 16:28:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH] difftool.c: mark a file-local symbol with static
References: <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
        <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
        <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
        <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
        <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
        <20170122052608.tpr5pihfgafhoynj@gmail.com>
        <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
        <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
        <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701251135090.3469@virtualbox>
        <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 13:28:27 -0800
In-Reply-To: <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 25 Jan 2017 13:35:42 -0500")
Message-ID: <xmqq7f5iakxw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 365A6C24-E345-11E6-B51D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The only advantage is that it is self-documenting, so somebody does not
> come through later and convert ("%s", "") back to (""). We could also
> write a comment. But I am happy if we simply catch it in review (or
> preferably the person is clueful enough to read the output of git-blame
> and see why it is that way in the first place).

And the last sentence unfortunatly does not reflect reality.  

I would prefer something self-documenting, like your wrapper with a
comment.  Then somebody who is looking at the implementation of
warning_blank_line() will not get tempted to turn "%s", "" into ""
because of the comment.  And somebody who is looking at the callsite
of warning_blank_line() will think twice before suggesting to turn
it into warning("").

That does not make it unnecessary to review; we still need to catch
those who wants to add new calls to warning("") without even knowing
the presence of warning_blank_line(), if the original codepath being
touched does not have any call to it.

> So maybe:

In any case, the patch is a minimum effort band-aid that lets us
punt on the whole issue for now, so I'll queue it as-is.

Thanks.


> -- >8 --
> Subject: [PATCH] difftool: hack around -Wzero-length-format warning
>
> Building with "gcc -Wall" will complain that the format in:
>
>   warning("")
>
> is empty. Which is true, but the warning is over-eager. We
> are calling the function for its side effect of printing
> "warning:", even with an empty string.
>
> Our DEVELOPER Makefile knob disables the warning, but not
> everybody uses it. Let's silence the warning in the code so
> that nobody reports it or tries to "fix" it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/difftool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 42ad9e804..b5e85ab07 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -567,7 +567,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  				warning(_("both files modified: '%s' and '%s'."),
>  					wtdir.buf, rdir.buf);
>  				warning(_("working tree file has been left."));
> -				warning("");
> +				warning("%s", "");
>  				err = 1;
>  			} else if (unlink(wtdir.buf) ||
>  				   copy_file(wtdir.buf, rdir.buf, st.st_mode))
