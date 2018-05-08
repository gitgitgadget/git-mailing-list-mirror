Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46CFF200B9
	for <e@80x24.org>; Tue,  8 May 2018 03:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbeEHD2x (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 23:28:53 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34589 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753958AbeEHD2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 23:28:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id p18-v6so30739168wrm.1
        for <git@vger.kernel.org>; Mon, 07 May 2018 20:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FdevQSMebpOjyGuxUji5P+qIv+nqS4Zv0IEV1VlTlK4=;
        b=Alz6pBhMWewMLxWc/w+lrrN0nkMGPn07UqEdRdV83GuGEv0le9S2z3g1FwUieFPz1r
         9C6tseguZPN03th1kFRKtYm9h0OHonkiSaAE56/mNITtdSNUnXBUJuxukjA9sGBFxzwS
         JV+YZu8hBco+akWcjgWmw7E7fqFmCJ5E3D/FxDV/spG5E3AadBvPdocfmOSyrMpPzuNr
         YQVFLWiA290oe9Epk5KjYG69QGAjBVcDo0B7Y18CJaIqAlIvKIy8NZ+ntaazBVvANOlO
         BhjmN7SdM09sUcyUZJlksifvBjat5JuJnZP43xs0H1saMINdkhv6/6SrJWGeAj5DFAP4
         GlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FdevQSMebpOjyGuxUji5P+qIv+nqS4Zv0IEV1VlTlK4=;
        b=QAgSFMM45QzK23OeGZZoEKndcE0au0XfWT+hUA5wshBhktw54OM2MWnrOONTaRuBaz
         tcNS8J4PA0FK+T0CcnoNWS/ATZsyyPb6M0hpt3fxOeWRQUYJemgTn33TlOg7N80FuVWF
         kkxwZUxNbg2BlcGVBTfd66EJTJCAPx04GijxrtfphxLD2dpuM8ADwlVGhMJSe1RMrG8v
         hO3jF0Ouv0OBhroChBptxGY8bst4jURy0i8QZ5gQo2cOCvBr3D+3DjU1KB68xb8WYuhy
         xkcN4VzuN691cLUk3ooExh/pJiErjaEh76vxRC3UgmodpggY5QCDwJqAYhYtMOjvv4/g
         Gckw==
X-Gm-Message-State: ALQs6tDIGmzyaXTfJjAzz5dusMPzBX6sV2sJGvbMoZGaVN0an+tBzVWX
        cw/xIQPyl79nVSe7bO0b5isl1MgpiRY=
X-Google-Smtp-Source: AB8JxZqlQQkqS3nYPx8EdOJNStg+cjY/+KS4I4n81CzhsdmZnrg+WcLf9VWXsYviXurjpC1gDtYGGQ==
X-Received: by 2002:adf:b88f:: with SMTP id i15-v6mr29587548wrf.163.1525750131766;
        Mon, 07 May 2018 20:28:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m64sm13074190wmb.12.2018.05.07.20.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 20:28:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Matthew Coleman <matt@1eanda.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached --options
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
        <20180417220219.30445-1-szeder.dev@gmail.com>
        <xmqqh8o9l7n4.fsf@gitster-ct.c.googlers.com>
        <21289682-5B46-4131-B7D7-57CE9F391B9D@1eanda.com>
        <20180508022842.GD26695@zaya.teonanacatl.net>
Date:   Tue, 08 May 2018 12:28:50 +0900
In-Reply-To: <20180508022842.GD26695@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Mon, 7 May 2018 22:28:42 -0400")
Message-ID: <xmqqr2mmn7v1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Hi Matthew,
>
> Matthew Coleman wrote:
>> I haven't seen any discussion about this recently. What
>> are the chances of getting it merged? I'd like to see this
>> included in 2.18.
>
> Junio's last few "What's cooking" updates have mentioned it:
>
>> * sg/completion-clear-cached (2018-04-18) 1 commit
>>   (merged to 'next' on 2018-04-25 at 9178da6c3d)
>>  + completion: reduce overhead of clearing cached --options
>> 
>>  The completion script (in contrib/) learned to clear cached list of
>>  command line options upon dot-sourcing it again in a more efficient
>>  way.
>> 
>>  Will merge to 'master'.
>
> I imagine it will show up on master sometime soon, in time
> for 2.18.0.

Yup, I do not foresee at this moment why that shouldn't be the case.

Thanks.
