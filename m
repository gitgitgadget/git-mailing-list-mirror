Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92ECD1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 20:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeJTFGZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 01:06:25 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:44437 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeJTFGY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 01:06:24 -0400
Received: by mail-pl1-f180.google.com with SMTP id d23-v6so2915451pls.11
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ay3NkFNjIk9gorAgzBPduOCdzVm0cqP4OZQijnbMLbk=;
        b=YlKx5YOyF9IeesckCLAPXJIko2B0RKlCcEBsdcB/KZki0U69NaNLUwpzfgFrFREqew
         6sl4Wv0eKD5CoQ8L9n0+ohshcexrAxQ0HdFepoEaL1TGsldN1raiyGSygZz2+z8DljZ6
         /jKHblEEyD+gbj6TckcoQfd1Zt4zISdb+T53DhSWKxlRfqp55OMmwMlDeKdB1dQurV5C
         h1ZSGdCt16Kff3yX3b4w+gg13cmFXiHXEaopizB7hTzpmTTqM84dixOBiPiw3PG9J8W6
         vun2mx9KqgZLbfLRut3QTpnPMej9V6Ickrv5x6CxcswyhDnYNhelI9jg+0urT3DyHkZK
         Qbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ay3NkFNjIk9gorAgzBPduOCdzVm0cqP4OZQijnbMLbk=;
        b=GbPuLdjB3UsixPSfJrXsJLR7sNSiW+vDVQjegNLEGTUcbJ32StFvP9uNchMjhbQBcj
         DgJB9xmnKsO3p8wDFe5oztBKNQ0Hd28PNESPhFhIf8vzUBuChd5iB+yDIL6Pa/v5qCeY
         oB7tb7xuGxTUePATQC/+NW+yyBQmWxvkIER10vCAmFfv8HK+u4VX76rGfUXUUvgZMyF0
         VyPqU+SHE1Odzc54EC1isFRx/FhuPVukGynak/LWl0ibzIqk8+6XacVGc3kxkO/iMgks
         /n+KcXe7qmZtBe43wYBeNx/s3rEu58Otjn8cJy+XhfbhycgGaK/YHvLUWNl4Q6nhItZ5
         C3Dg==
X-Gm-Message-State: ABuFfoh1VZ6fNN8z7Cl790jG2ae0otRL3Mxhb31qJhOo7DzZjJW7Ldk/
        Bt3pYRScblYdh2w27XTRJ+4=
X-Google-Smtp-Source: ACcGV60//59Z1m3Df2mgUCtBESJ6vV5AZ1wAPEScFJ+Sf7T3m2NX75pDw3HXWAIx2JKeiyVnAypsAQ==
X-Received: by 2002:a17:902:d806:: with SMTP id a6-v6mr2476256plz.301.1539982719485;
        Fri, 19 Oct 2018 13:58:39 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 72-v6sm34030724pfl.126.2018.10.19.13.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 13:58:38 -0700 (PDT)
Date:   Fri, 19 Oct 2018 13:58:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     juergen.vogl@jku.at, git <git@vger.kernel.org>
Subject: Re: Bug with "git mv" and submodules, and with "git submodule add
 something --force"
Message-ID: <20181019205837.GA84932@aiede.svl.corp.google.com>
References: <c4792c95-9a19-fd0e-9171-fded095b78a6@jku.at>
 <CAGZ79kZ4NSCknQTkpurdj_CzD+XvFzdaz1bdxPTFizjwV8=rpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ4NSCknQTkpurdj_CzD+XvFzdaz1bdxPTFizjwV8=rpA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Maybe for now we can do with just an update of the documentation/bugs
> section and say we cannot move files in and out of submodules?

I think we have some existing logic to prevent "git add"-ing a file
within a submodule to the superproject, for example.

So "git mv" should learn the same trick.  And perhaps the trick needs
to be moved down a layer (e.g. into the index API).  Hints?

Thanks,
Jonathan
