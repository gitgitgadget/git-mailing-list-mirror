Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E57200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 08:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754369AbcLZIds (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 03:33:48 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33057 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbcLZIdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 03:33:47 -0500
Received: by mail-lf0-f67.google.com with SMTP id y21so24862844lfa.0
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 00:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nKDJglos8OfBayVSs6JBX6cLW/89rfNKtfy75wdeBdo=;
        b=sFUThATrTQdkCpcgLLAmfxCY2EJUbC6kYtevaAROe3svUeBVMMMy4LOf9N81n5kknl
         rptsaVZ7jhnegi6WgbFuwotcsoCoyhSXWL0mcXqJ0IuSyXh0HEDxcAo+g4NXVrZYSZwf
         gtRZQw9TJDT/JU4M2ITDjCtqPGCS/7ZkaZw4H4op3taAAkiRG35D9t4C/9aTczDkSH1d
         8YoFKrdKSFBylLB22coHTgJQruDrfVS+2Sm0hLlafvkLg71+9eVReabt1x6Z7ph9wgMe
         QP8bAOKEKPBeyA21c5JDrZdOpS2ZlyNuq/8uwPxsyxRm9x/mYMNpYUpPrjxsIyV6874K
         c1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nKDJglos8OfBayVSs6JBX6cLW/89rfNKtfy75wdeBdo=;
        b=OTDKXce71/O+NokG2Omy73IsrRZrmPlha3PiuF8ZsvjSnJikgn1q5L4u8Zp8cXopE+
         Q40ebL2JyNgy1VVG2RPGDOFCv8rrViXNQLe1r39f3kleC7g4LOxrFPZVruckRykXUJvI
         7h07J4LhJ9m3NJ7Z8AxgXdecnO3jmr2utHP6k4gcnShjZCsnAIQZsfYLd7eRFoBcSOiA
         jJc68i60cr8OOUCjbZurI7nM38solaONh/AHr7runOqZ+TnX5HHMNevHUR5SyaoorwM2
         Xwfcqx0Y6ZXWki9Hq8lq2f1B0WPTXq4LTlJ0mU2CyHVtqRKrv/pKbAlQ27bFnUmp/T4J
         lsJA==
X-Gm-Message-State: AIkVDXKZGDHMyekfd57+slfCdIlZkNrv2ng4eJ8bRVpauwte3DVssrDBG0YM3iZb84zhUNM214CGeG8mcMjfyw==
X-Received: by 10.25.209.73 with SMTP id i70mr7261873lfg.24.1482741225506;
 Mon, 26 Dec 2016 00:33:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.152.13 with HTTP; Mon, 26 Dec 2016 00:33:45 -0800 (PST)
In-Reply-To: <20161219114807.GC24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
 <20161217145547.11748-11-chriscool@tuxfamily.org> <20161219114807.GC24125@ash>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Dec 2016 09:33:45 +0100
Message-ID: <CAP8UFD0FmvqiY4ACSbThHBvVPmLySifBWjsgGeA=14jEfnkfAw@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] read-cache: regenerate shared index if necessary
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 12:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Dec 17, 2016 at 03:55:36PM +0100, Christian Couder wrote:
>> +static const int default_max_percent_split_change = 20;
>> +
>> +static int too_many_not_shared_entries(struct index_state *istate)
>> +{
>> +     int i, not_shared = 0;
>> +     int max_split = git_config_get_max_percent_split_change();
>> +
>> +     switch (max_split) {
>> +     case -1:
>> +             /* not or badly configured: use the default value */
>> +             max_split = default_max_percent_split_change;
>> +             break;
>> +     case 0:
>> +             return 1; /* 0% means always write a new shared index */
>> +     case 100:
>> +             return 0; /* 100% means never write a new shared index */
>
> I wonder if we really need to special case these here. If I read it
> correctly, the expression at the end of this function will return 1
> when max_split is 0, and 0 when max_split is 100 (not counting the
> case when cache_nr is zero).

It's better for performance if we can avoid computing the number of
unshared entries, which we can in case of 0 or 100.

> Perhaps it's good for documentation purpose.

Yeah, I think it's also good for documentation purpose.

> Though I find it hard to
> see a use case for max_split == 0. Always creating a new shared index
> sounds crazy.

Yeah, but perhaps to test shared index writing performance people
might want to use it. And I don't see any good way or any good reason
to disallow it.
