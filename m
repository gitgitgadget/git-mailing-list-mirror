Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622E21F404
	for <e@80x24.org>; Fri,  2 Feb 2018 23:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeBBX1v (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 18:27:51 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35483 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeBBX1u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 18:27:50 -0500
Received: by mail-yw0-f196.google.com with SMTP id u21so14440331ywc.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 15:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eL6zdxmBbX1MF7jaVM1rpTNCBUx0sdFG6kyNCMahkww=;
        b=iI5b2mNCavE152iQTQEfnkV7NqFTGoYErzn48IypGFu29M6wLOTZBvvnAQ5wla2aQX
         m21zVmJFKkjc5RLV+2XPoEEubRBLZcfzKp5JqFMsLRMCPy2iH8cK//sRorZFmRLO0juo
         o2nsQu4KUMwtyqE3HF4GVITlwhSb0DKvNS1sAdEcC/pFk2RouuNO9EwLP+o4kbV+RTOM
         CoaNj5V54F8QdcBZBEboAA41QyAmo3sbygNYWBjnXBG87IiIcn7IA1OpCAsViTOSB3xm
         l/+3y65gXxLfLsPOVJacQglhT9vxxVUOw0CdKfjKMpUwCmLs64pXIZJchjY+QKYFW/X4
         +Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eL6zdxmBbX1MF7jaVM1rpTNCBUx0sdFG6kyNCMahkww=;
        b=jMmS+wwr/V2wHYXlPzP6aroqw+ARsJQYvsWO8tU9PLRWxFBNqCLsFKZUqmxOn4v3YT
         SN8FpTM2p2r1CaUxABd7wnavSAwo5P5FZhCieBsp2aqkuiRjNeDbVF1ic1ECTlgy6Qr1
         l8p/kTdqCNdMqJ1663bb8vApLXWHOF/p+xZdVljqRyQ64RpcOCzdPWeicV3sZ48IJ5MZ
         lpcP4ds9hX5CQ4RS/rzFzxQeTdQlsOj5QW9rZJlUScvPA8wdbwCKv7Fd8kUzXYSfj1WW
         ij6mS5I/z8j7GW4nK9Pyle0dsz8u+OCTd/2JTmDNbxqv8/PPgaAQh1Xv+6GASEP3/rSz
         1cJw==
X-Gm-Message-State: AKwxytdUx1pi5GCXbc4k/byCubTt5cyXHMIITHlOL4wmY2kG4N6KIT3U
        yHmmH9k0JIKuq2OsF5bigGVDnWSliUs7U6jhIxXAvNQ+x4o=
X-Google-Smtp-Source: AH8x227SEWuTweTPAXZjnzvBzOZYYIjKQLsqu5Qyt2XiprB58/C/yeqYlM9edvMyYrZd8i5EtOcA8Lv9clCPMUA3tRQ=
X-Received: by 10.129.86.139 with SMTP id k133mr27364307ywb.253.1517614069102;
 Fri, 02 Feb 2018 15:27:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 15:27:48 -0800 (PST)
In-Reply-To: <20180130232533.25846-13-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-13-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 15:27:48 -0800
Message-ID: <CAGZ79kZ4uHbOsqTj49SaKqUMdyTWCGjcHNNM9-8HYXyqZWqxWg@mail.gmail.com>
Subject: Re: [PATCH v7 12/31] merge-recursive: move the get_renames() function
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> I want to re-use some other functions in the file without moving those
> other functions or dealing with a handful of annoying split function
> declarations and definitions.

    git log --grep "I want" --format="%ad %an %s"

Nowadays we write commit messages slightly differently, more
passively, but I let others comment on the wording of the commit
message if they feel inclined to do so. I can fully understand what
this commit is all about.


> +               struct string_list_item *item;
> +               struct rename *re;
> +               struct diff_filepair *pair = diff_queued_diff.queue[i];
> +
> +               if (pair->status != 'R') {

It is not an exact move, you snuck in an empty line
between the variable declarations and this condition. :)
No big deal, actually I like it for readability.
(related https://public-inbox.org/git/CAGZ79kZX2FsEjD04zr5-oufU6dLhiOhBkxv4u8VEwL0OPRFtiA@mail.gmail.com/)

Thanks,
Stefan
