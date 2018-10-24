Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6621F453
	for <e@80x24.org>; Wed, 24 Oct 2018 05:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeJXNpR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 09:45:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33491 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJXNpR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 09:45:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so4046986wrn.0
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 22:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3TB3mdjSPCDMlFZk/VCsLXIfRq5DrLdcnzrba6AQfo8=;
        b=YoHNrTmwP1Um5+fSqqgKmZby7faPYxJNcP4OPJJpM70hq90FIUHly2/iiOTl4xa65z
         5QB1oUHSfdJG+kVC1rimQ/wg4Hvb+l7Fkp7jd8FAq87HzBXakxXvxat/4B5CJfatGyuS
         wuWdHDbLPlHXXsdFe6u7VN5qY1Xwa4IdbdxuTOEt0U0DiLSkJxT6P4o6wcwfAW7aTL9b
         2c8UJDNggHLNCP5PgRpvhbMzNlHobFHx8w0HJ9W2YV+fx7DI+92vMnKc8LhC2MJhyFrI
         JaaESUc2IRs62dqEfMXP/q7QjAfm+LcYRmOu9vA0ce9RBrROaXENQJueoI8brjUEw8T8
         VHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3TB3mdjSPCDMlFZk/VCsLXIfRq5DrLdcnzrba6AQfo8=;
        b=QDgnUQ1Sd0ngZBIhLmFqlvg85gO50TuBm/+ScTxKKCYELLGEjSzAfjS+GOhcQTj+2j
         El/XUxx5smLUREf+3c4Amy5kzG1MkUUADL9GvFu7Dtrfw2IgKpgl0uXA6YhXhXbUnuDH
         PkLgW+BPYuqhBOf73bqepSh6d0fdV4KCf/fqzcvZ9y8sPFw5VOhHzh7kdbk8I2th3MyP
         Fwr4eK5AIlGDCc9tmCeJq70qyDf4SVbwXjn+i4ftdG3kQ1BEF5hkFCPzVrkQRkkUf232
         teuBcveKmZnUVWKW4AaRjkFJBzIFKHHKjjN66xUbnTNfg72tDXjaQYm4B+5fH8lqX8kM
         73sw==
X-Gm-Message-State: AGRZ1gJjFbWWkRagusajwDBpK/8VoAzkKt9qSOzRcf11RV/oxEAoU/sV
        XceuRkpKPvFcK4Ejl80vlEQ=
X-Google-Smtp-Source: AJdET5cFRV4yp4rbmouIXyOXjkIoVejxrD4HBeRgvRmvAdQ3hoNtrNImRgcyGZ7bVNOP4bNfDCAr7A==
X-Received: by 2002:adf:f90b:: with SMTP id b11-v6mr1109930wrr.307.1540358325750;
        Tue, 23 Oct 2018 22:18:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a125-v6sm2176233wmf.8.2018.10.23.22.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 22:18:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        lucas.de.marchi@gmail.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
        <87in29dj55.fsf@evledraar.gmail.com>
        <xmqqmurkgaap.fsf@gitster-ct.c.googlers.com>
        <20181023140710.GA7073@ldmartin-desk.jf.intel.com>
        <xmqqh8hcqeho.fsf@gitster-ct.c.googlers.com>
        <20181024024309.GA22379@ldmartin-desk.jf.intel.com>
        <xmqqtvlcnd1w.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 24 Oct 2018 14:18:43 +0900
In-Reply-To: <xmqqtvlcnd1w.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 24 Oct 2018 14:12:11 +0900")
Message-ID: <xmqqk1m7orbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Lucas De Marchi <lucas.demarchi@intel.com> writes:
>
>> Your reply arrived just a little after I sent the v2, so I thought it
>> was just the race and you would end up seeing the unread email in the
>> same thread. Sorry for not including the msg id:
>> 20181011081750.24240-1-lucas.demarchi@intel.com
>
> OK, then I am not surprised that I do not recall seeing such an old
> message ;-)  Let me take a look.

Heh, it turns out that that is the version that has been queued in
'next' for about a week already.

One issue that was pointed out in v1 was that the log message was
unclear; it seems v2 didn't address that at all, though.

Thanks.

