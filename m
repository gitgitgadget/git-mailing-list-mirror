Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA451F453
	for <e@80x24.org>; Tue, 18 Sep 2018 15:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeIRVFT (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 17:05:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43259 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRVFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 17:05:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id 38-v6so1174143plc.10
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GjKITQ5Jb5v4nmTUNv6ucoYP200wEXui1OW3qFyoV+w=;
        b=YKmKsORVEw0FNFwS5MrZSHtu3Kd51InJ0ISeseETMo8TlqUhtZ7PDD1tQvjgPLwcAD
         vNW28Rpt9bRwwUrqI7cYB/SD0czofvbIIZ1Z1vtO1cC+ENP7MVyhG60FSgLZdsd935HH
         OsFAGEolNazxRaFaZcDIWK8CzUWJitSKhvOb9V3C7Pifc/DYxpp2YvWxkXArPYQ5uVa+
         qvQszV+ZwumOLLtXwitPOFWFQfwADm479hiR8yNZ8OnZ/ZZQkJMUg4ykXmBPkaas/8Vx
         BtoIZcOeedOueD/MMzqBQqRwVlRWH9vt6D+rQwfVLgP//Ivn8fNc2qZUeJC3a5TR3A1N
         SAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GjKITQ5Jb5v4nmTUNv6ucoYP200wEXui1OW3qFyoV+w=;
        b=b5Nzur4FDg/tpcW7pn955DUO6wsPuKiAkKg6hCrbVs/8rCewDapbs0gYVZUz/xiKqG
         pPL1fpWwjnQQYMjpIZftq3sjvkvrJvTpmKdwI28n3njMTptHtwdDZZ9XxKdYzyHhWlOG
         qtL5fl0/2JgpPLBAtk7YKgQWh7HOPJ4g9ifoR9Hkdsleu9aD2Xtw1sewVl1sQOYGGHqr
         dmxWemR2H7ZykW58UTUQViloEh6wxGGs/gGWK1e07lWpo5y2iTr7MjxtAmRVcXJcl3lP
         2Rtid0IP7JWG7SCJenLpHQqlAiesVaTKrUDW/0bB8K32q9L+Kg6hIJq2Dlwz9Eow1gth
         0PQQ==
X-Gm-Message-State: APzg51Aoeg4+PUF6mK3+xqbovwbS7q4D8ODoXE4sohvlg9wUM39iSmrE
        UklFx6SGloTmqIUM3mqSM4M=
X-Google-Smtp-Source: ANB0VdapJGygnilYh6Xosjq44Kr2llWfqdYQj9zoMYQJeVYHN88677oV/rREwmh/p/KQ2ulpKOmZYg==
X-Received: by 2002:a17:902:1121:: with SMTP id d30-v6mr29288102pla.250.1537284733041;
        Tue, 18 Sep 2018 08:32:13 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b73-v6sm32033064pfj.93.2018.09.18.08.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 08:32:12 -0700 (PDT)
Date:   Tue, 18 Sep 2018 08:32:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Joan Daemen <jda@noekeon.org>
Cc:     Dan Shumow <danshu@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Git Mailing List <git@vger.kernel.org>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>
Subject: Re: Hash algorithm analysis
Message-ID: <20180918153210.GA133875@aiede.svl.corp.google.com>
References: <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <20180724190136.GA5@0f3cdde9c159>
 <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
 <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
 <20180724221008.GI18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807301058560.10478@tvgsbejvaqbjf.bet>
 <MWHPR21MB01738A46E37527E45E950937C42F0@MWHPR21MB0173.namprd21.prod.outlook.com>
 <64c1fc82-8830-bd62-7cc6-ef76ad06f6d5@noekeon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64c1fc82-8830-bd62-7cc6-ef76ad06f6d5@noekeon.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A quick note.

Joan Daemen wrote:

> when going over my todo list I was confronted with the mail of Dan
> Shumow on the successor of SHA-1 for git. I know the decision was
> made and it is not my intention to change it, but please see below
> some comments on Dan's arguments.

When the time comes for the next hash change in Git, it will be useful
to be able to look back over this discussion.  Thanks for adding
details.

[...]
> On 30/07/2018 22:01, Dan Shumow wrote:

>> So, I also want to state my biases in favor of SHA2 as an employee
>> of Microsoft. [...] As such, and reflecting this bias, in the
>> internal discussions that Johannes alluded to, SHA2 and SHA3 were
>> the primary suggestions.  There was a slight preference for SHA2
>> because SHA3 is not exposed through the windows cryptographic APIs
>> (though Git does not use those, so this is a nonissue for this
>> discussion.)
>
> We find it cynical to bring up a Microsoft-internal argument that is
> actually not relevant to Git.

On the contrary, I am quite grateful that Dan was up front about where
his preference comes from, *especially* when the reasons are not
relevant to Git.  It is useful background for better understanding his
rationale and understanding the ramifications for some subset of
users.

In other words, consider someone active in the Git project that
disagrees with the decision to use SHA2.  This explanation by Dan can
help such a person understand where the disagreement is coming from
and whether we are making the decision for the wrong reasons (because
Git on Windows does not even use those APIs).

[...]
> 3) The relatively large state in the sponge construction increases
> the generic strength against attacks when the input contains
> redundancy or has a certain form. For instance, if the input is
> restricted to be text in ASCII (such as source code), then the
> collision-resistance grows higher than the nominal 2^{c/2}. Such an
> effect does not exist with narrow-pipe Merkle-Damgård. (This may be
> what Linus had intuitively in mind.)

Interesting.

[...]
> [2] Daniel J. Bernstein, Cost analysis of hash collisions: Will
> quantum computers make SHARCS obsolete? Workshop Record of
> SHARCS'09.

I remember that paper!  Thanks for the pointer.

Sincerely,
Jonathan
