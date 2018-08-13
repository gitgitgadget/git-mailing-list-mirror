Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0AEE1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeHMVnt (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:43:49 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45410 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeHMVns (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:43:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id 139-v6so14350026ywg.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3gz6pF8EU15od02SKNnBdbeaDv1JC43P7lr7fGTWnY=;
        b=mK9C9Rn/K19NP9ter5Hmwi1kwGjWQwFlSgVVv3C5HcoKaI3lTazkfbkcgLKYU2s2oY
         G8aFAyOWCf0XCE0pl6k5PpoBl6CdAx41aFXyQ/9qbsiEd1huVq0YA5spRZFxXqaOXTF0
         ehSUaSy6RmJECEMJ1kEJ7qbjaOvsDHjhgbHdBLTXmFtJhI0jlTNET+J9uMRlEyW3/N4G
         32a3UEoGeX6UhIbXeUyEW68PeCjTxU2ZsJtoALesgEBMh7zm7jNh5a4uyIx18ovRuteV
         n3Q8LUJMbknq6ruRrtItfC//f0uFkLswwQo/aMDPUReOYPCZryobECP67tG5tNmzAL7N
         VTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3gz6pF8EU15od02SKNnBdbeaDv1JC43P7lr7fGTWnY=;
        b=osxARRRWfLhgDRsyM0ZS2Owi2PZPEnjA1BfRYK9j8jCRm4ER1lAX9tx3l3g25NaYcG
         5ENXCG0Zdc51sqdbc5xvVgFXNKfXuJ/l6/4YamOQl+CibzT6jFdhoZJyCwg5RcqegJGN
         vOcLZbeOaLM38NfBxfaz0fQWAUCEqnbwj97RHXJ/dVBzZ2e8E6Nq/eiK2jTI5iSaiglz
         mlZ2KuQdxExg+MqYwyDVxhmQcatp84GUhKLoU/1BKNzhnEgoemDYIdahXAAaTr2HlSRB
         G2hCOpy/DwfEd373nfYWveUGLgaOxKAJ10nAzukQZnnnKjexfag+NcIBBGADncaj6kZt
         fuHg==
X-Gm-Message-State: AOUpUlFt3A9VGNffCJE4aj8/68XQ025oiKbKCECHn+srwVjp2zjgT+/2
        GgPwlaCc0RmDIgBAlhHbiM/H44nniFBBckHpMkDb/jRV
X-Google-Smtp-Source: AA+uWPwkjUQ9P/ABigO8ELXwJ5GK6aepVbihUgXI32WjK/4KOttdtJcvPHd2MHHI2mCeRdL4UOewmQVsCg/vVq5cnK0=
X-Received: by 2002:a25:af08:: with SMTP id a8-v6mr7338511ybh.167.1534186819157;
 Mon, 13 Aug 2018 12:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-8-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808131422580.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808131422580.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 12:00:08 -0700
Message-ID: <CAGZ79kYFkYqNADUVu-QCQBr5F5wFsFd8sUPfRsL5CqjnE4fDVw@mail.gmail.com>
Subject: Re: [PATCH 7/8] diff.c: compute reverse locally in emit_line_0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 5:26 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
>
> On Fri, 10 Aug 2018, Stefan Beller wrote:
>
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Well, my rationale for having the explicit `reverse` parameter is: this
> code is complex enough, introducing some magic "this and that implies
> this" makes it much harder to understand.
>
> So I am not at all sure that this is a good thing.

Yeah I am unsure, too. On the other hand the higher level functions
look so much nicer a the complexity is shoved downwards,
such that each function is solving problems in their own domain.

I'll think of an alternative.
