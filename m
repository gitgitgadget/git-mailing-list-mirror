Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E2D1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 16:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424027AbeCBQxi (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 11:53:38 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52389 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423840AbeCBQxh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 11:53:37 -0500
Received: by mail-wm0-f50.google.com with SMTP id t3so4349020wmc.2
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 08:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tgjcqjp65gMA4BrVutuFnVjZozq57tOFhO+87wjIdU8=;
        b=DbxKis1zpvbzvZpSTyp0yIRevRWlhp+a51ovlEekvqkt8JfVuuaCTF4oiIFR/pbkSf
         SCdCYVMBXcyp5FadpKGOZfHEOBD4VpOHoJqxf6qbecbdbt8P5IWiFYM0WHPrTvTKoKN3
         n8GHOi8s9AfIy4cVfowgAb2AllkrRFyb2R79ihmJA6moRIzTGBSDQ+9wzugY/Ml8U5VJ
         a1vZCeQxCcM+3L9o79PAoJeXECw/7QCp8pbZjpxza/glITFDVYFoJMFRAU0NuOde6u5W
         Mq7f7JkUX+iQX1BkioZepKydekaFRCDifCdN2NSKa6EbhZSruGAAvOOJTZubZ2y3DTww
         +wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tgjcqjp65gMA4BrVutuFnVjZozq57tOFhO+87wjIdU8=;
        b=H7IJE1X8RnNqrpJy4iC+yLLr4b2LTxNadHc+TmrFI5SkKcFLeNfQNtASIjmQo0uFrt
         wI68QL7+LZ98GcypBYMyNQaj0ElKeU+s43hgtVM5pQyox3fBveS/nKOkeYOktRUJ0VY5
         Nsuwj1zCexMUYtByKwKIaV+XgbDQIupWvw7Cz1q4Ij3ognOHLvxZSiU3Z9g3buo+yxxO
         qkLYLbRJjkznybpjmvEOeWkGVo5+gt0ow2C24WMXGfeAjIE+p4g4BB4ACAfDACKw89OQ
         BBwOIdn5NGw9YnELwwxBBJwCkMkbah0G9T3q/CzIz7xuadF43zRgdkn4Oe1hvLmRTF6G
         LPAw==
X-Gm-Message-State: AElRT7FQeluon10tvWW1vsoGvALtTUg/s+G5vub1j7bQbuOHu01Mb9sH
        A39h7Mk+Jg1751P9m8HI+48=
X-Google-Smtp-Source: AG47ELvmkhVV1kQI1Iw2uBUMaDPPt5vkaVJiyvs6J7DPuWsjYexh1TfeYSXvgVU0D9yNNoUe+4bZbg==
X-Received: by 10.28.173.198 with SMTP id w189mr2189733wme.139.1520009615464;
        Fri, 02 Mar 2018 08:53:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z3sm1937012wme.3.2018.03.02.08.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 08:53:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
        <20180302070434.GG238112@aiede.svl.corp.google.com>
        <20180302104608.GB11074@sigill.intra.peff.net>
Date:   Fri, 02 Mar 2018 08:53:34 -0800
In-Reply-To: <20180302104608.GB11074@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 2 Mar 2018 05:46:08 -0500")
Message-ID: <xmqq1sh2e7w1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Because the array is full of "undef". See parse_diff(), which does this:
>
>   my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
>   ...
>   @colored = run_cmd_pipe(@display_cmd);
>   ...
>   for (my $i = 0; $i < @diff; $i++) {
>           ...
>           push @{$hunk[-1]{TEXT}}, $diff[$i];
>           push @{$hunk[-1]{DISPLAY}},
>                (@colored ? $colored[$i] : $diff[$i]);
>   }
>
> If the @colored output is shorter than the normal @diff output, we'll
> push a bunch of "undef" onto the DISPLAY array (the ternary there is
> because sometimes @colored is completely empty if the user did not ask
> for color).

An obvious sanity check would be to ensure @colored == @diff

                push @{$hunk[-1]{DISPLAY}},
        -            (@colored ? $colored[$i] : $diff[$i]);
        +            (@colored && @colored == @diff ? $colored[$i] : $diff[$i]);
         }

or something like that?
