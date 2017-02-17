Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8218F20136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934087AbdBQQ6P (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:58:15 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:51046 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933900AbdBQQ6P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:58:15 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id D96CEC7E4;
        Fri, 17 Feb 2017 17:58:11 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id D408310052B;
        Fri, 17 Feb 2017 17:58:11 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id D08736069E;
        Fri, 17 Feb 2017 17:15:07 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Johan Hovold <johan@kernel.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>, Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
References: <20170216174924.GB2625@localhost> <vpqlgt6hug6.fsf@anie.imag.fr>
        <20170217110642.GD2625@localhost> <vpq7f4pdkjp.fsf@anie.imag.fr>
        <20170217164241.GE2625@localhost>
Date:   Fri, 17 Feb 2017 17:58:11 +0100
In-Reply-To: <20170217164241.GE2625@localhost> (Johan Hovold's message of
        "Fri, 17 Feb 2017 17:42:41 +0100")
Message-ID: <vpq4lzs7o0s.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via smtps.univ-grenoble-alpes.fr ACL (97)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, Feb 17, 2017 at 02:16:42PM +0100, Matthieu Moy wrote:
>> Johan Hovold <johan@kernel.org> writes:
>
>> The "multiple emails per Cc: field" has been there for a while already
>> (b1c8a11c8024 released in 2.6.0, sept 2015), some users may have got
>> used to it. What you are proposing breaks their flow.
>
> Note that that commit never mentions multiple addresses in either
> headers or body-tags -- it's all about being able to specify multiple
> entries on the command line.

Indeed. I'm not the author of the patch, but I was supervising the
students who wrote it and "multiple addresses in Cc:" was not the goal,
but a (IMHO positive) side effect we discovered after the fact.

If I had a time machine, I'd probably go back then and forbid multiple
addresses there, but ...

> There does not seem to be single commit in the kernel where multiple
> address are specified in a CC tag since after git-send-email started
> allowing it, but there are ten commits before (to my surprise), and that
> should be contrasted with at least 4178 commits with trailing comments
> including a # sign.

Hey, there's a life outside the kernel ;-).

>> 1) Stop calling Mail::Address even if available.[...]
>
> Right, that sounds like the right thing to do regardless.
>
>> 2) Modify our in-house parser to discard garbage after the >. [...]
>
> Sounds perfectly fine to me, and seems to work too after quick test.

OK, sounds like the way to go.

Do you want to work on a patch? If not, I should be able to do that
myself. The code changes are straightforward, but we probably want a
proper test for that.

> addresses in a Cc-tag in that it breaks --suppress-cc=self, but I guess
> that can be fixed separately.

OK. If it's unrelated enough, please start a separate thread to explain
the problem (and/or write a patch ;-) ).

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
