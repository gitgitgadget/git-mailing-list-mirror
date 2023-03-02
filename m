Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDACC678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 16:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCBQPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 11:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCBQPl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 11:15:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB9555078
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 08:15:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso3284533pjr.5
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 08:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNGl4TYgjvHO8cszCbcNhW38rwZ/AmZUg+zUl8gofb4=;
        b=gqnSX43+lL/2FFYnxw5sEfgfbLwfIC/c2v2w/aSaL+/MSihtP80zqVDS78hDBpnakJ
         TdCwrcntZ3SfnLcxzNA2r4rvNFa9Hyols9/6MOgNc4Zgyl15I91vFRk31CXm60wOz44k
         ohj2Ncm9WwesB/Y80uG65P7MdS0/K1rXIAbikm6rlTLbgaGIAUtUXDKbaB0biX9uzmvx
         8Xnm2c/UMaYqhInKLL8cmAcB2pMKxuLssbDsT6IkdItO0kavcF7NuL0PJu18a+I4yaXi
         fgNULjTlI9WpDeAsgvbkU+mf/7z84aIk5s/f+6jN3gucMHgMcxGSbp0quBsVWWWXhinQ
         mCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNGl4TYgjvHO8cszCbcNhW38rwZ/AmZUg+zUl8gofb4=;
        b=sTaXOx9BwRMKLwmvQpzD/KyOKotU05BO1u3TnH6CI0n0hRfX1h/Bnku8+FOgnpkQb/
         RyCVQ1ViNFUiUSwF/DYcNHpQ8XnXHPO6UCccAn8RGpJCqcinrfn9esJ+PMEFrZoJ+pEo
         CqI0tAsZ3pDoSXz0TTGgQtClI+3iml+Srb7342xm42OF164CVm9MfZ6FMIxRm3okLPll
         QodBoeX7+zxV8whRmmmitv46nSCx1EKiPasSDe+d471yH3AxoWrkYCFjJ/QI2X8XG/q1
         0hmln9zXQYX92BMTRhQTWSTbO6GG5AwswelCTB/b68KnUGg6NuEUpFX7T0JwpMGFglLy
         PwEg==
X-Gm-Message-State: AO0yUKUAxyuEGNLQ+ZRLz4lJ5hqoxCMjmh2KsFlub2NJpJcvlWLF6vcD
        NbMOUzyLY5vwFfx8Ub+J43k=
X-Google-Smtp-Source: AK7set/FwzoaPsWwktfxSpTsgV2YAP7cDKhhpltgS6udJT3y10U5IFFCWzl+1VltOAc7VvabB8TTTg==
X-Received: by 2002:a17:90b:1e4f:b0:237:161d:f5ac with SMTP id pi15-20020a17090b1e4f00b00237161df5acmr12491793pjb.36.1677773730379;
        Thu, 02 Mar 2023 08:15:30 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id bj22-20020a17090b089600b0023739b104f8sm1801884pjb.50.2023.03.02.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:15:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 02 Mar 2023 08:15:28 -0800
In-Reply-To: <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 01 Mar 2023 16:37:51 -0800")
Message-ID: <xmqqr0u7ku3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> Finally, event without "log.diffMerges-m-imply-p", the rest of the
>> series still makes sense, so if the conclusion is to remove it, let's
>> still merge the rest, please! Let me know, and I'll then remove the
>> patch and will change documentation accordingly.
>
> Oops. Sorry, I missed this the first time I read this message. This
> alone should have warranted a response.

Hmph.  I agreed with you that the last step to add the configuration
would not make sense unless we are planning to break users later,
but I have been under the impression that the remainder were OK
clean-ups.  Perhaps it is mostly because I read them so long ago and
forgot the details X-<.

> I'm not convinced that the series makes sense without
> "log.diffMerges-m-imply-p":
>
> * The main patch is
>
>     diff-merges: implement [no-]hide option and log.diffMergesHide config
>
>   which gives us a way to redefine "-m" as "--diff-merges=hide
>   --diff-merges=on". However, we haven't seen any compelling reasons to
>   use --diff-merges=hide [1]. I'm also fairly convinced that if we go
>   back in time, "-m" wouldn't have the semantics of 'do nothing unless
>   -p is also given', and I don't think we should immortalize a mistake
>   by giving it an explicit option.
>
>   All the other patches in their current form are dependent on this
>   patch going in.
>
> * diff-merges: support list of values for --diff-merges
>
>   This only makes sense if we want to accept multiple values, which we
>   don't without the main patch.

Now you mention it (and show example in the previous bullet point),
I have to agree that we would not want this, not because we do not
want to have --diff-merges with multiple values, but because it
introduces an odd-man-out option that is not "last one wins" that is
not used anywhere else in the UI.

No response does not necessarily mean an agreement, but it indeed
helped in this case to be explicit.

Thanks for the clarification.  
