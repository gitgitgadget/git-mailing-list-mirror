Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002161F597
	for <e@80x24.org>; Mon, 30 Jul 2018 23:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbeGaAmC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 20:42:02 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:56143 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaAmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 20:42:02 -0400
Received: by mail-qt0-f202.google.com with SMTP id j9-v6so11502598qtn.22
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=TFv1JSHWxWG5HrPH5Sl3FO62xQkzTscvBzny6BJYJYs=;
        b=DDe/XrDTV53Ky+f6nj4QxfetMNq2X8mvgjy5Sd4jMgNTs8kXvCN6AqbPFwStaRcSFR
         Qi7UsvBj6TA6QfPSYIQuDvVIBx9VAOvlHsJxMp73/W3j+IHnMbxBLMxyqOKmDXtIt5Lx
         SYMgKOnia1zmGkPi/Uc4V8NB2mfR44eThmplxZ6TUUV3rcEHJtfvC/jz/n59U2XGc/J9
         XdvQQE9HNjHsvWWrxfTPD+uCr6DmYLtoV/JC/fE6a2fglsRRzLPB03Zd83La9QR1jREu
         oY+X0N8disKI/vES2T+DR7cQ0SRU4BlcAPQVMRLlHkxzg0MEQJaGKbVwrLkqdh0ZouO1
         Y2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=TFv1JSHWxWG5HrPH5Sl3FO62xQkzTscvBzny6BJYJYs=;
        b=B88wYWxvIPBBeag7tEADLq/lmYIF9vZT3L3ic2JLzEcitHEp3NvmvOnvmvk8yhDuig
         McecJbBdEldOeC6Yg35JvvoKQTL6EzaF3ihfSuwfVM+Jua4zsMCRNSKlHmEaoIa5M/ds
         8eUFlk9VTkLt5XAtS2hiCFZi5Iuy0ZNHVMLTeoJEd5mnbbU0G7UjyuhtPos559oPIvGJ
         82vxlNpPte6rY4fq2769PLSRH3W+BG85bDFk8yML9GmYaQ9scncFrHGsRYg6onwoHpAY
         n0t8mLBfH8eph5LWhMcB0FtfO3RsS2C7LgkK9nZdsanN6Ke4yxGHJW5lR4X5eSX2JOoM
         2Qdw==
X-Gm-Message-State: AOUpUlEBHyE2jmbHaHxYtIBWkXUk49DkJ8Q/SFRAEDvj/+9ruSxaG1iP
        y8N+xEg5VtkRxIXFacIoSzJvf4M27/4H
X-Google-Smtp-Source: AAOMgpcz9Ps/h9xbF6Uq8+BOVPaSwboqgaSPsEgzKy37orOmyNaH6SM9RIT+ndm6F7mz5Mwt0z8t0kxftScM
MIME-Version: 1.0
X-Received: by 2002:aed:2314:: with SMTP id h20-v6mr10792394qtc.40.1532991887072;
 Mon, 30 Jul 2018 16:04:47 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:04:40 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807301438440.10478@tvgsbejvaqbjf.bet>
Message-Id: <20180730230443.74416-1-sbeller@google.com>
References: <nycvar.QRO.7.76.6.1807301438440.10478@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 0/3] config: fix case sensitive subsection names on writing
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        peff@google.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 5:50 AM Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Thanks for the patch!
>
> The only thing that was not clear to me from the patch and from the commit
> message was: the first part *is* case insensitive, right?

right.

> How does the
> patch take care of that? Is it relying on `git_config_parse_key()` to do
> that? If so, I don't see it...

It turns out it doesn't quite do that;
The parsing code takes the old notation into account and translates any
  [V.A]
    r = ...
into a lower cased "v.a." for ease of comparison. That happens in
get_base_var, which would call further into get_extended_base_var
if the new notation is used.

The code in store_aux_event however is written without the consideration
of the old code and has no way of knowing the capitalization of the
section or subsection (which were forced to lowercase in the old
dot notation). 

So either we have to do some major surgery, or the old notation gets
some regression while fixing the new notation.

> > I would still hold the judgment on "all except only this one"
> > myself.  That's a bit too early in my mind.
>
> Agreed. I seem to remember that I had a funny problem "in the reverse",
> where http.<url>.* is case-sensitive, but in an unexpected way: if the URL
> contains upper-case characters, the <url> part of the config key needs to
> be downcased, otherwise the setting won't be picked up.

I wrote some patches that show more of what is happening.

I suggest to drop the last patch and only take the first two,
or if we decide we want to be fully correct, we'd want to discuss
how to make it happen. (where to store the information that we are
dealing with an old notation)

Thanks,
Stefan

Stefan Beller (3):
  t1300: document current behavior of setting options
  config: fix case sensitive subsection names on writing
  config: treat section case insensitive in store_aux_event

 config.c          | 16 ++++++++-
 t/t1300-config.sh | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 1 deletion(-)

-- 
2.18.0.132.g195c49a2227

