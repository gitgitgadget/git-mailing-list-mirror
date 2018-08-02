Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8940B1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeHBWT4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 18:19:56 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37195 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeHBWT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 18:19:56 -0400
Received: by mail-yw1-f68.google.com with SMTP id w76-v6so131600ywg.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9OSmaNyWPD9jaU37AJGwnPkiJJSmO0+VcddG0yBzd0=;
        b=Ce3yspIRMJV9Qq7zH0cweeh09TF2/ZA7Se5GlrNz63DERDZhWOGb5iundonRCqTXbw
         hyXyockVDuhYaqx2oHnVEJeJyWpU6Scd7Ht9Fe42p+ki27ggWHXSGDMyECVo3Bh7k0s4
         vFS3YrcDjqDmkhSRX+q0FWubAWdVu1Rx48OYmqxuh5rNFpc/DxAcFJt/PsA4/bm2p3hy
         Z+tMHXYidogRsFQL9fDhsPN95J/IXqBzxrS98x0aqgAXjwXVx5acuMmsYHNzkTHQVzU0
         nhquERL3772s54809IFRWy2FFc/RoMr2Fcw9mAyKG+FEzHrvf08jC+2P68144UoSAjnK
         iewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9OSmaNyWPD9jaU37AJGwnPkiJJSmO0+VcddG0yBzd0=;
        b=ftxrNXSSm8fi/+uJ3s/zhTwJp9Wy62yodceWgkAQBF+BcAJHoowrE8EjjjE+YM8VnG
         AGyvBNReF8/iMRguAM8T1yyNatSsZ6iZfeQ5b92oZsDWeX7PCMKObqNqQN+M3/qG+DKo
         ypmgWZEKcLqKJz/h6r4hTBrbzaUkK6SaLaTHe6dQ7xwxghBXzAFqn76JZZdIQGPd9PTk
         Mj5aEeBG49Di9WhcIi3hLhsNl5Zj2T8rfafI/r7i0AT7/6glASzmDrd+Hcas/WiPFINK
         MiSkBI7YATOjmWR+VicfuakpW4ROS6EQtZbzpcUVwdgk0+LCgNct1zuRq2sX9vi7GSXL
         wVQA==
X-Gm-Message-State: AOUpUlFMjWWIxhi4sYNHIvlAxJs7+ptUwcAiaqcUzsF1acW3fsHzJxTI
        xYLrUCXtyfJrb9TithN6ZRCsa50NdD7SN3PVfNwxgg==
X-Google-Smtp-Source: AAOMgpeyxgb7/Tb3DasrmBOGHeXv9eOrSgG2cDWxwkiLUJ4/nSiB9DFvUrSzXsG3eczeyCmj6vRpjK3/lpA9xYsGuQs=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr641617ywd.421.1533241631471;
 Thu, 02 Aug 2018 13:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-10-ao2@ao2.it>
In-Reply-To: <20180802134634.10300-10-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 13:27:00 -0700
Message-ID: <CAGZ79kZABbh6bP1TD8gkx_051yo-=bLJq1XvJz9xUKdBKAPssg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/12] submodule: support reading .gitmodules even
 when it's not checked out
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> When the .gitmodules file is not available in the working tree, try
> using HEAD:.gitmodules from the current branch. This covers the case
> when the file is part of the repository but for some reason it is not
> checked out, for example because of a sparse checkout.
>
> This makes it possible to use at least the 'git submodule' commands
> which *read* the gitmodules configuration file without fully populating
> the working tree.

The reading part shows how nice our internal config system is, once
everything is put in place.

> Writing to .gitmodules will still require that the file is checked out,
> so check for that before calling config_set_in_gitmodules_file_gently.
