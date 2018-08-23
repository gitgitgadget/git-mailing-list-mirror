Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395B11F954
	for <e@80x24.org>; Thu, 23 Aug 2018 16:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeHWTux (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 15:50:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39468 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeHWTux (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 15:50:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so6463186wmq.4
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YMY7KUhfMZghjx80Ml5gWxXkZSY7U4Toi4IyrlertAc=;
        b=RvR2+uK5/HEsamZwz33dM56/A1q2dn2cOcDBbTpLE3/EC7EM9rIx32S1n7d/SDEcVz
         mSCuXkPq96vgsUZPANqge2fnAX8F2wJysS4yA768HMtsa/AOr3NcOwL6BLZkdWK49m3G
         gjJouUWsBSzOdm2mTWO91+jRLrehOc4qHPzFKWTCl7YGh10wTrobGBGJbOqJZwp1mt4S
         7AEfoWx50i3GIF0VySHi2rR1A/xxpk2jOejOazVpv8l/S7lj63P/DUjukxAK8zj94Ac3
         MLrHfSr7MCfndyI+TpNpka1BNwW5TSCOmm64OTg9sMK0Tc0gq9ishND3rzIb23gPSEnS
         FzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YMY7KUhfMZghjx80Ml5gWxXkZSY7U4Toi4IyrlertAc=;
        b=nffThBzuCMtAybY249FzjcoPYLg64jIJ2cvUsq2lTsKykv8sFd/R+/b1BRlts30leM
         oTEbhpXZvFHcJmh/+4+KlFIJ35hMJ1QYLegxLcoWvBxIaVmgmCsBY31cA+ZUW/FsMT2w
         eDDZLaqJxzVbUnmYAJH7a/81SBMVrz6ozn7Z+UCrm0bWyLjckOD9OY55Jc1xwvl7/Fs6
         F8YS62uhOk5hpt5CpYi54i2qHd7PtiTMPJt2WIhM6a4K3hDjvgsxllJEuH6QdL13JE7S
         tPM1myT9bp1WyN52UfKSOUquwC4MFSiahCRO5cSR1101EgisSFhkvdgBd+GdgzSGR17X
         OlVA==
X-Gm-Message-State: APzg51AcLD632I0t3kKX+k7XyyyfQEp4CeXzp4BMvIYaEfsiZwmHnYNl
        GRW30Zpec4A5XjntURpSPC4=
X-Google-Smtp-Source: ANB0VdbDk4dY8S6hT58sYs3i00fpYtEWt0G5QdHtrvVlCvf0Vhn5AHhfAMGEi8p58FjuIVpOedF5OQ==
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr5328207wmd.135.1535041226143;
        Thu, 23 Aug 2018 09:20:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i125-v6sm7341470wmd.23.2018.08.23.09.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 09:20:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] t/lib-rebase.sh: support explicit 'pick' commands in 'fake_editor.sh'
References: <20180619124651.17425-1-phillip.wood@talktalk.net>
        <20180823100915.22855-1-szeder.dev@gmail.com>
Date:   Thu, 23 Aug 2018 09:20:25 -0700
In-Reply-To: <20180823100915.22855-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 23 Aug 2018 12:09:15 +0200")
Message-ID: <xmqq6001jbqu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 25a77ee5cb..592865d019 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -47,7 +47,7 @@ set_fake_editor () {
>  	action=pick
>  	for line in $FAKE_LINES; do
>  		case $line in
> -		squash|fixup|edit|reword|drop)
> +		pick|squash|fixup|edit|reword|drop)
>  			action="$line";;
>  		exec*)
>  			echo "$line" | sed 's/_/ /g' >> "$1";;

There is a large comment before the function that says

    ...
    #   The following word combinations are possible:
    #
    #   "<lineno>" -- add a "pick" line with the SHA1 taken from the
    #       specified line.
    #
    #   "<cmd> <lineno>" -- add a line with the specified command
    #       ("squash", "fixup", "edit", "reword" or "drop") and the SHA1 taken
    #       from the specified line.
    #
    #   "exec_cmd_with_args" -- add an "exec cmd with args" line.
    ...

which probably needs an update, too.
