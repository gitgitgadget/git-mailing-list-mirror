Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4A21F404
	for <e@80x24.org>; Tue, 20 Feb 2018 18:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeBTSuF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 13:50:05 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43895 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbeBTSuE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 13:50:04 -0500
Received: by mail-wr0-f193.google.com with SMTP id u49so12661932wrc.10
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 10:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CoZM1RGTafOAvCnPeD0WPMw8SgESQhJRDoRPoKhweYU=;
        b=ERbbWJIkAJeOoRkoFeZ1RUJXufzzMcomKNHSm8iffBWSMLyzb+tAESkc3v9DhJ1GJC
         eSqQgUGTctlvbTaA9CqaiyZpb5rQToFy6TKWXLVOoyLCgn3oN7Ff31y+CvkRtyJtzMFU
         iq9w5eltio7e3HGJOyD+TAY5ZLs8UuJf4QUGZ8waiOPR6cApsMglET3+tALudxFanMXF
         qr81P5RYyAD40ZNhX2pFAzuMej+ykreNaNElibOVZWaCR35E+x40agwKH6I/onTCEDrY
         MwGUV+7G98j2O+GI8eiWGK0FWL2nJOUI4uTOk6GMVYPoIuQ8KcKZi3F6MOtlf6DKmG48
         NQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CoZM1RGTafOAvCnPeD0WPMw8SgESQhJRDoRPoKhweYU=;
        b=pEQT54Aw0GZ7Mk1sYP+FILeCwV5JdY3e/EKt89wk5dm2HSUwNPkm3QrcQ4p4AgI3IX
         1V0nkDMbcGKJaTzVuAarbB88ZUMsweAdz+qk6ibRAIwzRtz52tdvPCfy5YV9FjBkBdPP
         4bHxjqlNKxL76COtF9Dlg8PR5MHGSs9HUEYZGnppQd20a9eIB0H+fKkKIRTgMm7ROyhy
         pX1ViIjSVPhhOucTck6Bwz12V+dOtwvnbudzspeO6hkFvWcYvQwhVafbuf3hxGVq7smr
         l6c522z+NQOPFEpXOH3SGHYLz+jTkAzoray55xxZcqnqsAtT1SgVYrDc7vOykMJXyYnq
         /O0A==
X-Gm-Message-State: APf1xPDrf35xOu3nQOFiuFm3Q6VhFommUpgn0nYlG6blYJULteLcEeiS
        Z5rMzXoPn8ww5o4BwCaXgrnuiiT6
X-Google-Smtp-Source: AH8x227q2voMqXg/m7SIDhVhq8/JkbK/B4zUkRPJllVejHkdiCrXDVhQO3jKYY2MikVYaHTh+AWFzw==
X-Received: by 10.223.141.150 with SMTP id o22mr583529wrb.280.1519152603255;
        Tue, 20 Feb 2018 10:50:03 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t91sm31778832wrc.21.2018.02.20.10.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 10:50:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 9/9] add -p: don't rely on apply's '--recount' option
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180219112910.24471-1-phillip.wood@talktalk.net>
        <20180219112910.24471-10-phillip.wood@talktalk.net>
Date:   Tue, 20 Feb 2018 10:50:01 -0800
In-Reply-To: <20180219112910.24471-10-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 19 Feb 2018 11:29:10 +0000")
Message-ID: <xmqq7er74ht2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Now that add -p counts patches properly it should be possible to turn
> off the '--recount' option when invoking 'git apply'
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Notes:
>     I can't think of a reason why this shouldn't be OK but I can't help
>     feeling slightly nervous about it. I've made it a separate patch so it
>     can be easily dropped or reverted if I've missed something.

It is a lot more preferrable approach to produce a patch with
information as precise as the producer (i.e. add -p) can and feed it
to the consumer (i.e. apply) than to rely on the --recount and the
--allow-overlap options that are mainly ways to force the consumer
make imprecise guesses and accepting potential garbage with looser
consistency checks.  So I very much like the direction (and the next
step may be to make sure we coalesce correctly so that we do not
have to use "--allow-overlap").

Thanks for working on this.  Let's see if the updated code really
"counts patches properly" as the log message claims to ;-)

>  git-add--interactive.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 3226c2c4f02d5f8679d77b8eede984fc727b422d..a64c0db57d62ab02ef718b8c8f821105132d9920 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -677,7 +677,7 @@ sub add_untracked_cmd {
>  sub run_git_apply {
>  	my $cmd = shift;
>  	my $fh;
> -	open $fh, '| git ' . $cmd . " --recount --allow-overlap";
> +	open $fh, '| git ' . $cmd . " --allow-overlap";
>  	print $fh @_;
>  	return close $fh;
>  }
