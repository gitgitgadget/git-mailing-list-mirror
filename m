Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13A9C433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 18:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383035AbiEES5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 14:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383383AbiEES5o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 14:57:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC093EB83
        for <git@vger.kernel.org>; Thu,  5 May 2022 11:54:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y3so10371832ejo.12
        for <git@vger.kernel.org>; Thu, 05 May 2022 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/V+4pvLV5ef9QdYMGuyf3uEnf7J3s3M2fhu34cSzT0=;
        b=dS7h6Bfq+ZG/zNAAu9japHkO720NYtyQlBUE6TFiFGMQizIDHIITRmYzyVYttwkjG+
         T2c7T+3+8+0HSPwujt5aLO+MwAmqqaL2gdG6h4eiEh/yoMmuB7ZNrncn3pHZ9XpzvAYG
         HfghEOWX4xlsBil/x/meXS2r8lZrqkRFrNQ2K7/JK+O88r9zDGf9Z3xTBm2bT/xbTrZp
         1b08bv09OUou2lOhZmgyHj0lCK8tEywmigNqfMK2oFjMnIGcqcI1eqsEDBq8S7sNRP9e
         WMhFQGyFEFw3KavR1yRXdp7l25/dQIVSaF3jrXYxKIcG0c8C8E1hq4ET+A/O3jaMps+X
         eMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/V+4pvLV5ef9QdYMGuyf3uEnf7J3s3M2fhu34cSzT0=;
        b=HFmxtb/Y4qxw2jv0VBP7EbwbiSfQE+08W8UjFK3ufsBxNO0Lrc4M4iljeuBHburHv6
         tTbQAfvZF8gKxF7i30tX+uo5J188xKwOVGcNoWg3YciMDvAgUb4LCfHiyo91nB6oM9Kz
         LHCbK7xRWN+NKH4OQVCLyrsAHSpD4b6eqnWBAug+/SxJYkWAKbdtUDhhsJAl6koE0sU+
         OSWP0IPjqZ1Fln/gRUr5NoD5onN6qOc1m9Va2lsWe3AA1x8Ezukwt9sK/jBJYElRKdF0
         BlSSoEayBOjw1KOiB5kQzNkYQ3hqiEDkM7CZdgAj4XgnSGv9nzEprs4D0bu05QhtutqD
         kH5Q==
X-Gm-Message-State: AOAM530okU1JnaaEULjx+lx2jVHhWL1EiFhDN8eRWFneHXTo3+A2J5Ed
        SP+NjlUzM8BnOpTrDYjLLFlpLhz1Ly9QSjOBASk=
X-Google-Smtp-Source: ABdhPJzAVgM50RyJWIgfaSOvycZ/sfBoEJ+5yTzXsLMBOPaZwJcvmTncdKdRkiBMYZOLqoob8Z0WMaPbJgkLOBLkdNY=
X-Received: by 2002:a17:906:3a45:b0:6f4:e9e7:4ff with SMTP id
 a5-20020a1709063a4500b006f4e9e704ffmr6075806ejf.100.1651776838925; Thu, 05
 May 2022 11:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqilqnvacd.fsf@gitster.g> <0facc01f-ee36-333a-eb25-9c98d616700e@github.com>
 <xmqqy1zhmftk.fsf@gitster.g> <CABPp-BHDKRX4sW_Jjqw5j7Voas0X_xkFZgg5Jqk0TkNZOd7k1g@mail.gmail.com>
 <xmqqmtfwezx5.fsf@gitster.g> <CABPp-BH8VsH+Y3UxAvZM2kua8XGRE1RyenrESeYwofcq-=kjbQ@mail.gmail.com>
In-Reply-To: <CABPp-BH8VsH+Y3UxAvZM2kua8XGRE1RyenrESeYwofcq-=kjbQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 May 2022 11:53:47 -0700
Message-ID: <CABPp-BF9ftVVp7-ZZuhak456x12-H941Nj4qV7gNf71rrugGhQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2022 at 9:15 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, May 5, 2022 at 8:56 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
[...]
> > I vaguely recall there were folks who didn't like the change of
> > default the last time you brought this topic up.  Convincing them is
> > not my job---it is yours.  Mine has been to help prepare the code
> > ready for public consumption when that happens.
>
> That's a surprise to me; I don't remember anyone bringing that up,
> ever.  Did I somehow miss it??  I'd be happy to talk to anyone and
> hear their concerns if they do hold such an opinion.  Over the last
> year or so both Stolee and Victoria have suggested such a change or
> said they wondered why I didn't include such a change with other
> sparse-checkout changes we were making, and I mentioned a few times I
> thought it'd be a good future plan and finally submitted it.  To the
> best of my memory, no one ever offered a counter opinion.
>
> Are you perhaps mixing this up with the case where people brought up
> concerns with suggested tab-completion changes?  That's the only other
> related series recently where folks brought up concerns with suggested
> changes.

So, I did a few searches through the list history for anyone that may
have commented on cone mode as default.  The only comments I can find
are Stolee, Victoria, Lessley, and I being in favor.  Here's what I
think is a pretty good search on lore.kernel.org/git[1]:

   "cone mode" default -f:stolee -f:gitster -f:newren -f:dye -f:dennington

(Where the reason for the exclusions are because Stolee, Victoria,
Lessley, and I have all spoken up in favor of the change, and you
aren't stating that you're opposed to it just that you thought someone
else had been.  Plus those exclusions massively reduce the number of
emails to read through, since I think we're the only active
contributors to the sparse-checkout subcommand and related
functionality.)

Looking at all those links plus related discussion, the closest thing
I could find was
https://lore.kernel.org/git/20220118222234.GB2632@szeder.dev/ (which
was later in the thread from [2] which was the direct link from the
above search).  However, this wasn't an argument against cone mode as
default, that thread was where SZEDER argued that tab completion
should not be limited to directories in non-cone mode[3].  Now, I did
bring up making cone mode the default, but only in _response_ to that
email because it'd handle his example _better_ than his hand-picked
example of why he wanted completion to include files for non-cone
mode.  SZEDER didn't respond, which doesn't tell us much about his
opinion on this area, but he certainly didn't push back on the
suggestion to make cone mode the default.  And that's the closest I
can find to anyone stating a disagreement with this proposed change.

Did I miss some other email in my searches that you remember where
someone did actually have concerns with this change?


[1] Quick link:
https://lore.kernel.org/git/?q=%C2%A0%22cone+mode%22+default+-f%3Astolee+-f%3Agitster+-f%3Anewren+-f%3Adye+-f%3Adennington

[2] https://lore.kernel.org/git/20220115095725.GA1738@szeder.dev/

[3] Though the example he used was perhaps unfortunate since it wasn't
tab-completable with files anyway, and any completion that would have
been provided by file completion would have been wrong since it'd
complete on files in the wrong directory (namely, the root directory).
