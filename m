Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5737020986
	for <e@80x24.org>; Wed, 28 Sep 2016 04:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbcI1Eoe (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 00:44:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36808 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbcI1Eoc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 00:44:32 -0400
Received: by mail-qt0-f193.google.com with SMTP id 11so1034559qtc.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 21:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N3OkgJUb3quSFWymeNqMC3NFX4LRunN6TDFcd/QEVvg=;
        b=xHvYWM8cl5v8AYYlrLmRKJlJDVsHPOvym77LNBdGnCWn2CsT/4aqJLBSy0noTg389M
         wAfcuRR0iJobCrJCuOaItpa3RYA/rm+yp7B+GypSCn4P7fvsUyWhkIohW5KQrtwuBt56
         s1GKmpG8WAvls0NVMHB29jm25VQfsF5YWI8bBP5k8IMYOnRxY8PALrrsQj0Zo83GkaOv
         6Aum5KEH9Yi1uRw6j1kp/ROYvaF5eUxcWlCkpCMMhiCtPWBgFOpi6R6ktyog8Y9su/n2
         CVP2mqjQy0EA9FXxZ1KWYdyZnvINZIWB8GWv/8ryVqUDzOgM+g1B9PLY4yR0K9hnyRkL
         9GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N3OkgJUb3quSFWymeNqMC3NFX4LRunN6TDFcd/QEVvg=;
        b=PWOCZfyVh15DH5+3J1CdkNF8BbVdlSekXAh3JrvZ9Zz3HNCZ3kDk1lqaba+dE8uzho
         f78i2oPtDRp6Ge7IbkXDoUdytcGfr9pnXrgyZF+V9WDcA8uySyGOgqnO3TbVQ7Zt2Qvz
         z7ee9CMo+TMMmK3SJ1wio/kgWE6AeL8L2Lheqznw3SAP8avBGyucYTDdHa6bntYbSLl9
         GvKMZAz8vTS/BEaouzB9s8qVbVylfmseMPu+INNZpanUZ50TV112n7GHcXuYywoJO8/c
         MWRpAO+dPVMLbuk7I9G5pk6SOvWWRX+erAsePfSX/hf176Rv39AQQ6XeCTCwZU9DZmt8
         B5EA==
X-Gm-Message-State: AA6/9RlrC9oaeCqh9vEunEluhX8klD5THFkE54HpzeV7bVSAwi4Y+hGUI+2tLx3yXvci/Q==
X-Received: by 10.200.42.130 with SMTP id b2mr30309399qta.106.1475037870851;
        Tue, 27 Sep 2016 21:44:30 -0700 (PDT)
Received: from kwern-HP-Pavilion-dv5-Notebook-PC (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id q62sm3063836qkb.4.2016.09.27.21.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 21:44:30 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
X-Google-Original-From: Kevin Wern <kwern@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 00:44:28 -0400
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 11/11] Resumable clone: implement primer logic in
 git-clone
Message-ID: <20160928044428.GD3762@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <1473984742-12516-12-git-send-email-kevin.m.wern@gmail.com>
 <CACsJy8B1bbKBhg1ke4u6PV3k4FWz-bhBPyN2X=mV2Z2=8Mhy=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8B1bbKBhg1ke4u6PV3k4FWz-bhBPyN2X=mV2Z2=8Mhy=A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 09:04:40PM +0700, Duy Nguyen wrote:
> On Fri, Sep 16, 2016 at 7:12 AM, Kevin Wern <kevin.m.wern@gmail.com> wrote:
> >  builtin/clone.c             | 590 +++++++++++++++++++++++++++++++++++++-------
> 
> Argh.. this is too big for my brain at this hour. It might be easier
> to follow if you separate out some code move (I think I've seen some,
> not sure). I'll try to have another look when I find time. But it's
> great to hear from you again, the pleasant surprise in my inbox today,
> as I thought we lost you ;-) There's hope for resumable clone maybe
> before 2018 again.

Sorry, I didn't mean to hurt anyone haha. I probably should have broken it down
into the bare process (priming from static resource, with no options), and the
resume option.

Thanks so much for your feedback! :)
