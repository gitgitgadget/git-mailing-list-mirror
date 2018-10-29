Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0491F453
	for <e@80x24.org>; Mon, 29 Oct 2018 16:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeJ3AvY (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 20:51:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35944 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeJ3AvY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 20:51:24 -0400
Received: by mail-io1-f65.google.com with SMTP id o19-v6so5294615iod.3
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMtyYrs1e8/qfxknMFIZLtClD6A7WGT+NcMJDtiH+Zc=;
        b=WQxNhGgnPq4PCmagup+K8qy/qrpDtO0S9xjj3C03AfN1sfWJ7uvfTgxGNAGqjr+Ikr
         BYHdbOAhYfhrk5aYe5N/ej40n/usc0FdlYtS11HGQsNt5PmUtd7ztlukfCGzo9FQtwCU
         e72Yr3Oh/PTIb2bI0X2tbkFck4Uqanma/3PGRcdptKttOeTCktr1bfiEZDlUbNKq9Ycz
         yzfM5VXInoJbPlTxcgeet1o8TUm1s/0p+5SLJrciF/7IkofPe1P6ZlOzQG69Vrcvh7ZA
         GZ4bjTGlzOmZrVz9oDDmakBAce5C2hvBJF5ZfjYKNjZGxwu17m4QNRhpPxBniGahb3qK
         HZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMtyYrs1e8/qfxknMFIZLtClD6A7WGT+NcMJDtiH+Zc=;
        b=CwrXdS/OddscRnl/RJTzsCga0+HLyRjKLTXm4k9fxZhnShKlL7YFP5hazUr2CIkVTl
         pF4yN316oLZA592HOPygStakxBcL6qOoDOTIe0fadvWU+cWLUKXL1pfCFq5Cmj0QxS1b
         m0c2O+vjWWJnW5p6Sauso6L0xu1k5B7OthbqiuK8C2EpQGk+LDQWgI5Fny0eSNJJwbZi
         gOERNFl6zqWqnoNV0S1h0aF9LJdz9DTGb9zNOYDjSSANEE/fGuUR+kzNOEpBCYvHlTWt
         +AiPU4Xhj8u2F/wVUNz3kF9HXIVpjbq5aD15+oc7aa3tm+/tFYuWA71h7YJzRDN7ppL9
         DYVQ==
X-Gm-Message-State: AGRZ1gInbX21+Q1MJym6o7LGh7zzsCYlI9y3Xz0Td1//ZzCG14JgDyOn
        n2oI9pWjBug96Jfev/PLn4/Lur9unA2mlsU2aQA=
X-Google-Smtp-Source: AJdET5cp0ztibh0kLF9Irue5JtblGURSwds8JpOhBGxGlX8BNcgi65gWFkaSeQhqWcdZis/XY9SLpmN5kLDPcwWZoUg=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr7444203iod.282.1540828930620;
 Mon, 29 Oct 2018 09:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181027071003.1347-1-pclouds@gmail.com> <20181027071003.1347-7-pclouds@gmail.com>
 <20181027074443.GE26685@sigill.intra.peff.net> <xmqqo9bd8pko.fsf@gitster-ct.c.googlers.com>
 <20181029142536.GE17668@sigill.intra.peff.net>
In-Reply-To: <20181029142536.GE17668@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 17:01:41 +0100
Message-ID: <CACsJy8Bp_9qmGeNZuywtda1_TdQTZM1essUjBD9Q8e31175V=g@mail.gmail.com>
Subject: Re: [PATCH 06/10] grep: remove #ifdef NO_PTHREADS
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 3:25 PM Jeff King <peff@peff.net> wrote:
> But if the problem is simply that we are not quite there yet in the grep
> code, I am OK with taking this as the first pass, and knowing that there
> is more cleanup to be done later (though that sort of thing is IMHO very
> useful in a commit message).

Since the problem pops up now, I'm ok with updating/cleaning up all
this in this series, unless there's benefits in keeping this series
simple and merging it early (probably not?)
-- 
Duy
