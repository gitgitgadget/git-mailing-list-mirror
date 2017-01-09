Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB621FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 14:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937738AbdAIOTh (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 09:19:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51939 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S937074AbdAIOTW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 09:19:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 833CD5D025;
        Mon,  9 Jan 2017 09:19:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TpEAFbdqLTSXEESjZfcaDtDVDGc=; b=Z8GvND
        B7AkhSXVRl4VlxgHNYml4TfFeGx6SEXPae/ojC62KTLrlTbmcjYsQJb+SdPml52i
        fe1Of7GXhDDZ2V3LCcWT8AeUuv8QyrKmR9iyHfwLGcu5JGaZancLxGuPwUJ8iKSF
        CNoLe0CdcSKkq6LRCNvmK/KYfp8K6zfepeH14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZDWPUyjmjMT+H6T/4ESjL1AjfhTaAkPC
        jXBM1jmLuMBq9ecruTAGcxSOSBX7PztE5JIOCbG+p1QOqPzFBznQ36nefBOR7Syl
        XeKB0GJDy0y9ksI0y5FzVPbKdxOE7k+c1OTLyj0jb6+wkAyni9RDEhF6n1nlxeTB
        a5KEq16nd6E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 749D45D024;
        Mon,  9 Jan 2017 09:19:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E2325D022;
        Mon,  9 Jan 2017 09:19:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com>
        <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701090825510.3469@virtualbox>
        <xmqqh958y44c.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701091207480.3469@virtualbox>
Date:   Mon, 09 Jan 2017 06:19:18 -0800
In-Reply-To: <alpine.DEB.2.20.1701091207480.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 9 Jan 2017 12:13:58 +0100 (CET)")
Message-ID: <xmqqmvf0wc2h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CCECB3E-D676-11E6-A132-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > But do we really need to do that?
>> 
>> No.
>
> Exactly.

> But since you seem to convinced that a future bug report like this may
> happen (I am not, and it contradicts my conviction that one should cross a
> bridge only when reaching it, but whatever), how about this, on top:

I do not understand why you keep arguing.

With No-Exactly exchange, I thought that we established that

 * The original auto-detection for GIT_SSH is battle tested and has
   worked for us very well.  It may probably have covered 99.9% of
   the population, and we haven't heard complaints from the
   remaining 0.1%.

 * The added support for GIT_SSH_COMMAND, because the mechanism
   gives more lattitude to end-users to be creative, will have lower
   chance of correctly deciding between ssh, tortoiseplink and
   plink, but it would still be high enough, say 99%, correct
   detection rate.

 * It is foolish to add more code to refine the auto-detection to
   raise 99% to 99.5%.  We know that the approach fundamentally
   cannot make the detection rate reach 100%.

The last one can be paraphrased as "perfect is the enemy of good".

But that does not mean that it is OK to leave the system unusable
for 1% of the users.  If the auto-detection code does not work
correctly for a tiny minority of users, it is still OK, as long as
we give them an escape hatch to allow them to say "You may not be
able to guess among ssh, tortoiseplink and plink, or you may even
guess incorrectly, so I'll tell you.  I am using plink".  99% of
users do not have to know about that escape hatch, but 1% of users
will be helped.

IOW, "give an escape hatch to override auto-detected tortoiseplink
and plink variables" suggestion should be taken as an "in addition
to" suggestion (as opposed to an "instead of" suggestion).  I was
not clear in my very first message, and I thought in my second and
my third message I clarified it as such, but probably I wasn't
explicit enough.

In any case, "do this only if the first one token on the command
line does not have '='" we see below is flawed for two reasons and I
think it would not be a workable counter-proposal (besides, it goes
against the "perfect is the enemy of good" mantra).

For one thing, the command line may not be "VAR=VAL cmd", but just
"cmd" that names the path to tortoiseplink, but the leading
directory path that houses tortoiseplink may have a '=' in it, in
which case we would detect it correctly if we didn't have such a
hack, but with the hack we would punt.  More importantly, even when
"VAR=VAL cmd" form was caught with the change, it may punt and stop
guessing, but punting alone does not help users by letting them say
"I know you cannot auto-detect, so let me help you---what I have is
PuTTY plink".  If it always assumes that the user uses the plain
vanilla ssh, then the change merely changed what incorrect guess the
auto-detection makes from "tortoiseplink" to "vanilla ssh" for a
user who uses the PuTTY variant of plink.

> -- snipsnap --
> diff --git a/connect.c b/connect.c
> index c81f77001b..b990dd6190 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -797,7 +797,8 @@ struct child_process *git_connect(int fd[2], const
> char *url,
>  				char *split_ssh = xstrdup(ssh);
>  				const char **ssh_argv;
>  
> -				if (split_cmdline(split_ssh, &ssh_argv))
> +				if (split_cmdline(split_ssh, &ssh_argv) &&
> +				    !strchr(ssh_argv[0], '='))
>  					ssh_argv0 = xstrdup(ssh_argv[0]);
>  				free(split_ssh);
>  				free((void *)ssh_argv);
