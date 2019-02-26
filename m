Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FF120248
	for <e@80x24.org>; Tue, 26 Feb 2019 01:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfBZBxd (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 20:53:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46800 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBZBxd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 20:53:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id c17so2224999plz.13
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 17:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J7QS5aDxXSK+rCuf0Sb3N4ou/djwfJdrP5J8paAbulg=;
        b=TS2EcJkUvgyKBn5B7Nxiah+A2j6NpisLU8Pd5N84sHLzLNwSCd0XO6EAsMV03TRorc
         8bm3C5QO2rhf70g1mVUq98HiBAtPYb9gftOij6PAXFhhG2QV7vDWtTGU0GpT1RX88qUJ
         i5ITZOT4O4szoupnCi2Iaoiyan4ctSp1dfNxvKM/0LBd0A2qtSfBr6QWp9fI78ZIE7NP
         fXmVW99FwRajKHTT2UXUcs2kOIaaahIOabbz8PvqD7FMgM3+bNcjwR63cyuPlqGrIrNg
         8fljTsJOd3wH878731Smb/pJcC/dhr2NcbppdW8I/E194tlFeBjwUtVBqY2+q7vtY2DX
         xs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J7QS5aDxXSK+rCuf0Sb3N4ou/djwfJdrP5J8paAbulg=;
        b=Ag0EWjnanFMU3jFMAatN4FydG5eN+wEPS6IWdJ7Q2Z4gMUxNPOxJ4Z5I+DSZ4FbDfd
         8CA3lGBJVLssK1eHqAXHbexklYoA7qFpt1GXKkmi3hK80njqALyt95Gq/PDE7P1MBpAr
         2q0dUCguj0THK+m7TuzKU7BkWZEb4KL1KAksrxbHWdK0FcqyBCPrqqiWz4tk20NwQMyw
         bVA6cXiVj0oTUWa1a/K0uhcmelG42hUCU5TSx36yg15ac/j36SW9oMsyfhypS59NOUvq
         BJ6Cisvyv5mGnFd90NadJuXRT1CBn+y0yap2A9cXD/4OfMl2OkN76N/0IPnDlPGBhwqr
         CTfg==
X-Gm-Message-State: AHQUAuZlqqmIga2T/enCNghtbqPmhUQff9fN/tkcJ/A0Tq7aJSkP6mWP
        THDUtWQ6Ma4pKSChJ8V7R3s=
X-Google-Smtp-Source: AHgI3IZT4YDTKeUki5X2wHcBBEnr9n7SIG+sq1MijVj7p7R9fcAFZKI1pMqRSjzpqQOQZ3sjN9iNnA==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59mr23314388plc.220.1551146012207;
        Mon, 25 Feb 2019 17:53:32 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id c130sm10888444pfb.145.2019.02.25.17.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 17:53:31 -0800 (PST)
Date:   Mon, 25 Feb 2019 17:53:29 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [WIP 7/7] upload-pack: send part of packfile response as uri
Message-ID: <20190226015329.GE16965@google.com>
References: <cover.1550963965.git.jonathantanmy@google.com>
 <aae0f669627d7be45a967c6df464bf1ecdabce6d.1550963965.git.jonathantanmy@google.com>
 <CAP8UFD2RBU+f4=pB4CZHPHVO3DKXdGXVen=x3a8GvQHhGBG3aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD2RBU+f4=pB4CZHPHVO3DKXdGXVen=x3a8GvQHhGBG3aA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder wrote:
> On Sun, Feb 24, 2019 at 12:39 AM Jonathan Tan <jonathantanmy@google.com> wrote:

>> Teach upload-pack to send part of its packfile response as URIs.
>>
>> An administrator may configure a repository with one or more
>> "uploadpack.blobpackfileuri" lines, each line containing an OID and a
>> URI. A client may configure fetch.uriprotocols to be a comma-separated
>> list of protocols that it is willing to use to fetch additional
>> packfiles - this list will be sent to the server.
>
> So only packfiles will be fetched by the client using those protocols.

Yes.

>> Whenever an object
>> with one of those OIDs would appear in the packfile transmitted by
>> upload-pack, the server may exclude that object, and instead send the
>> URI.
>
> Ok, so each URI sent in the packfile corresponds to exactly one
> object. And when the client fetches one such URI it gets a packfile
> that contains only the corresponding object. Or is there something I
> misunderstood?

I think it's worth separating the protocol and the server
implementation:

The protocol allows arbitrary packfiles --- they do not have to be
single-object packfiles.

This patch for a server implementation only uses it to serve
single-object packfiles.

Thanks,
Jonathan
