Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9C01F404
	for <e@80x24.org>; Tue, 20 Feb 2018 18:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeBTSzh (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 13:55:37 -0500
Received: from mail-yb0-f173.google.com ([209.85.213.173]:33282 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBTSzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 13:55:36 -0500
Received: by mail-yb0-f173.google.com with SMTP id s79-v6so4298635ybs.0
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V2TGt96plKAx/Sh+9Em6JU9iUhu+8FAvgLV46h3WZd8=;
        b=OUXzqr3l5r3MHRRNaLYfF9Kj/G3KbWF62qBbOQoDZqZYis0P7wybCEMmEfkmFnH8np
         Cjf4NTugG+q4S44xls0glNdZpN4jnrJESbjrlALEyJ6TohMQetkzUn2Mfy7s3NMUmXUk
         4de1GmIhlzSizrJM/dvkZzjhlcE4TBqdHhztztwTO2NOdk5KpTr2ElExxF5wsURLsU+g
         Hg21iMmd3aGer8B6IsutJAo5S2V5sVX5kiR9A88gyJYTU48Q0Opbhwi5ORLJ7B2+T0bt
         jrAKWc3fSTGjcKkGR/eRnjQLxSNpf6TNS0FxMbkes0MowSE/vbf1HSY3EYYflAp913Yf
         fScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V2TGt96plKAx/Sh+9Em6JU9iUhu+8FAvgLV46h3WZd8=;
        b=jG+/Eqeu2/EHQGcr5885OESMbwdBZnyGQjgfYIP4qFpBVJOVKc2bko140IPQNZma0e
         fhRo1jOD3ONhZ5vhqDs3/2RXq3UJ7X4bITgfjW3W3C5i+Gb4yvNv5QEbvyDF0ik3ZO6A
         F1nmmozlYzZSJiHtMRgcAMJLenDXZe5asxWkM1F0ZoOBNkqmmh99oKeCpWre+vJNCN2D
         xZoeQDQOdE0nVSTzMlxRc9PUoo5Yx3Xa1ZLHh0+FZgpjuPPvlWGNeTUWwb+lty5gk51m
         HyC8+fzu87G3GiDLNEH1Bjd9kV3V3q3bUZJguSaEzghBh8AUTHkhLX6NRaC51f7CInHy
         sqMw==
X-Gm-Message-State: APf1xPDqATqYW+GIdVawYEbkF+SZtBDCfUfnzx/3WIevNo7nXpKxfur9
        LtOHA1vGlS4K+nM99RKKXIYuzO9o4iPsumtFF9U4ZQ==
X-Google-Smtp-Source: AH8x225W66PLoHEfQXQu5Idrwir+WhBITKkykUjq2taVpIbJQ+3BmBGOzycOQ9rd9pPBQtc1ttPcWCTGsv8hIqH+/oU=
X-Received: by 2002:a25:b4d:: with SMTP id 74-v6mr534794ybl.167.1519152935866;
 Tue, 20 Feb 2018 10:55:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 20 Feb 2018 10:55:35
 -0800 (PST)
In-Reply-To: <20180216223404.GD216564@aiede.svl.corp.google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com> <20180216174626.24677-1-sbeller@google.com>
 <20180216223404.GD216564@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 10:55:35 -0800
Message-ID: <CAGZ79kafB8JZ0hz4ZbjSpkA2j2AOWjFjoxcQ3e9KcovLp1tzxw@mail.gmail.com>
Subject: Re: [PATCHv2 00/16] Moving global state into the repository object
 (part 1)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 16, 2018 at 2:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> v2:
>> * duplicated the 'ignore_env' bit into the object store as well
>> * the #define trick no longer works as we do not have a "the_objectstore" global,
>>   which means there is just one patch per function that is converted.
>>   As this follows the same structure of the previous series, I am still confident
>>   there is no hidden dependencies to globals outside the object store in these
>>   converted functions.
>> * rebased on top of current master, resolving the merge conflicts.
>>   I think I used the list.h APIs right, but please double check.
>
> For what it's worth, I think I prefer v1.  I put some comments on why
> on patch 0 of v1 and would be interested in your thoughts on them
> (e.g. as a reply to that).  I also think that even if we want to
> switch to a style that passes around object_store separately from
> repository, it is easier to do the migration in two steps: first get
> rid of hidden dependencies on the_repository, then do the (simpler)
> automatic migration from
>
>  f(the_repository)
>
> to
>
>  f(the_repository->object_store)
>
> *afterwards*.
>
> Thoughts?

I would prefer to not spend more time on these conversions.
If Duy and you would come to a conclusion to either pick this
or the previous version I would be happy.

I do not see the benefit in splitting up the series even further and
do this multistep f(repo) -> f(object store), as the cost in potential
merge conflicts is too high. Note that brian just sent another object
id conversion series, also touching sha1_file.c, which I am sure will
produce merge conflicts for Junio.

For the next part 2 and onwards I'd be happy to take either this
strategy or Duys strategy as requested.

Stefan
