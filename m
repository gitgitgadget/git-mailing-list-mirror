Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4152ECAAA6
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 16:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbiHZQmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbiHZQmV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 12:42:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D95D91E8
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:42:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l3so2019140plb.10
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=LygqoHMj2N4vWWA4c2lE7+dGUz7QqNdzf82MC1UeIS4=;
        b=ERyZwVJG/YJthRNDnAMLNJHF1+URKG3+hkfbFuf+XFRumw0b2PoZK9NJ1dhveQ0Bi3
         8GQU+90pXVbz1X0uVIihisKCURLSzDIIAON3ZAEi1BAWsEJHvmGEhJ1m7tHR24KZkl8x
         c0OQcjGtz66vJUMDKATE+dIAqEW+Ucz3yUghco/0ZPq7pnziqVEDoA+Z31KMUhFdmC7l
         VpB2FgkcJZp+K1I82qeUblJ4WB4194mj0+C+HDfcgwGNSoDXyAtTvh7sMxc1K0/5LzVb
         ayqlFRLyDj+g5RU76ak8rHffq0MG4U3FDvYAzaWCyyP/dNf7S7GtlPaj4ZYC60WvN79Q
         XPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=LygqoHMj2N4vWWA4c2lE7+dGUz7QqNdzf82MC1UeIS4=;
        b=ARG+5dvBx4+iBsMi7HP5XeAoy0DqkEHgXf6xVxaho7Z9I6M9cGN5FjVnfQ3uLq1TA7
         REfoBXrmgbBBl4qrdbnRFXizgOj5+1DYBdgjmp90AB0nxwpXkuz/wYDibBG3GH6Ivftr
         SjQJsGEPYa6USAL4zZpvkbqR8JQNT5LoWAMX2R5N+IX1VuKfX8hITo3HIVznBYGoj0Eo
         AxBjy8O0oKq+SH5V9DLCMxLlVhCqq8pT42u+T6nyACNq615r3/D6wpv1sLh67j3l5vLA
         L1K1OrWJom9On+gxkJMG03fmb6nACwIuj851mivIUlMgDlnKdhSRgoN83mSDyBjs6jtS
         qFWQ==
X-Gm-Message-State: ACgBeo3dhb06iyaLte7L7EzekOojomqH1X56aT8o3MMyinlaRn53XNR0
        AvG+4yoezU4ytzWmOjr14MytTJvebY4=
X-Google-Smtp-Source: AA6agR7YCqfmLg6ed+lnLuTQEbCUihFrkjvDFpA7Z3fv0O8XkpHiCpJQxLNhynwP4xMh+DsMnP0DIA==
X-Received: by 2002:a17:902:cf42:b0:172:ed15:ee with SMTP id e2-20020a170902cf4200b00172ed1500eemr4275004plg.149.1661532133883;
        Fri, 26 Aug 2022 09:42:13 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b22-20020a63e716000000b004298d7b6e70sm1670485pgi.54.2022.08.26.09.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:42:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Zang <zealot0630@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Considering add log.format and show.format configure option
References: <CAOrge3pTP5WU3Z1HRLz7xqExwt7_n33FUkh9KQP2m6VyuA9sJw@mail.gmail.com>
Date:   Fri, 26 Aug 2022 09:42:13 -0700
In-Reply-To: <CAOrge3pTP5WU3Z1HRLz7xqExwt7_n33FUkh9KQP2m6VyuA9sJw@mail.gmail.com>
        (Zang's message of "Fri, 26 Aug 2022 15:12:34 +0800")
Message-ID: <xmqqh71zyn16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zang <zealot0630@gmail.com> writes:

> Hi forks,
>
> People including me are asking feature to use different format for log and show:
>
> https://stackoverflow.com/q...

We do not pay attention to SO, and it is good you came here.

> [log]
>     format = mylogformat
> [show]
>     format = myshowformat

I think something along this line was raised as a possible
enhancement on the list earlier.  If we were to do so, we should not
limit the enhancement only to "log/show" but to all the commands in
the "log" family, and similarly, not only to "format", but to many
common options.

Patches welcome.

Thanks.

