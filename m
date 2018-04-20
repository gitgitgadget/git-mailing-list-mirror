Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A211F404
	for <e@80x24.org>; Fri, 20 Apr 2018 18:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeDTSdp (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 14:33:45 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35401 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbeDTSdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 14:33:44 -0400
Received: by mail-wr0-f173.google.com with SMTP id w3-v6so25325063wrg.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=AQBusvvfMbywZ2niIGxqD4owBbbc9aJzuIc/BXv0Evk=;
        b=tA4xZ4De86/zy4hts+LQc4oatNRXR+YjG3RazB3BPi2CDeeUUbTmZLYk7gZ1gR/I1i
         2NHoHj1tbNDgq6TN039YCadkxKZpyjN4/WkqrXqCMc4fEkFvwXIvwO/qSMxmlzqXjKLm
         NTcSzqKQm/3wbYXJnqoG2poI0Oivvh6XWTguGnna49GqK75wZBZ8VTjrWbMqrkiwzqeU
         IoAAh+304W27DmMKn2NGf0VEGxycMPAUAJtGsJkUEagK5a0seT5sjf1Rm3vQ56bhiUMN
         6JRcEqPbPiEbydTUc5geHdP/U/rorRsJXcKQwfeQ7GJemlQE7T0vnROrEUifAVikZP7l
         LHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=AQBusvvfMbywZ2niIGxqD4owBbbc9aJzuIc/BXv0Evk=;
        b=gRreBKxD2//2+RUsA1ZGlvf6d4Tnc7UBMyKAIdOlHdm/mTrC0Z6BkbZWyBlGQvQlqY
         Lp1268AiC5SWQq822ZrADdfMfhrIuaQn8S8CERbWCf57gjHzmGIBQalKgHILNJE61BuW
         aK2VttFqjk5deupbrIk8fy0XWQoOu/WFxj8Rc+i6Cb03FhomtuHuBrhHvQ2hCMfbDXra
         pUEVzfTXBaNgFS7cC7VWsIwrJupAvIJeQVrdFhsMHF/dNm3Xj1g84iFwBhsPPWkMYAhc
         Myorfj3nXvegggEKBPfIuzaZqGWxORfDyEXMtOHic4m5SgGay7IEwi9Cemxnn/3r82Vb
         /pRw==
X-Gm-Message-State: ALQs6tCxBvSP9lbpWCHYTrETnu8Z6EWZOJzvaoT3Y0Dg3kI/T+hErvlJ
        IpCOooqn662fsKS43+a2YSXfMAsG
X-Google-Smtp-Source: AIpwx492c4Lw3VxK1FfWFbq+6m4CdvOlCLzaff5G49fxLfhwbraePXbUWv4nFNFwuYIeeqbD2IpOVQ==
X-Received: by 10.167.215.81 with SMTP id a17mr62377eds.220.1524249223223;
        Fri, 20 Apr 2018 11:33:43 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o16sm3898368edc.33.2018.04.20.11.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 11:33:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 11/12] gc: automatically write commit-graph files
References: <20180417181028.198397-1-dstolee@microsoft.com> <20180417181028.198397-12-dstolee@microsoft.com> <86wox1dbos.fsf@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <86wox1dbos.fsf@gmail.com>
Date:   Fri, 20 Apr 2018 20:33:41 +0200
Message-ID: <87fu3peni2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 20 2018, Jakub Narebski wrote:

> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> The commit-graph file is a very helpful feature for speeding up git
>> operations. In order to make it more useful, write the commit-graph file
>> by default during standard garbage collection operations.
>>
>> Add a 'gc.commitGraph' config setting that triggers writing a
>> commit-graph file after any non-trivial 'git gc' command.
>
> Other than the question if 'gc.commitGraph' and 'core.commitGraph'
> should be independent config variables, and the exact wording of the
> git-gc docs, it looks good to me.

Sans doc errors you pointed out in other places (you need to set
core.commitGraph so it's read at all), I think it's very useful to have
these split up. It's simliar to pack.useBitmaps & pack.writeBitmaps.

Makes it easy to start writing them, and then have a quick toggle to
turn it off if there's any issues rathen than go around deleting the
files or making sure they're not written out.
