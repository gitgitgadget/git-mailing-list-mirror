Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D131F453
	for <e@80x24.org>; Mon, 15 Oct 2018 04:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeJOMHg (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 08:07:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35462 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOMHf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 08:07:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id e187-v6so18164041wmf.0
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 21:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uoRcrltDUndHrepffhLxUiRgX6Ajv0seJ3Dn/4BTAag=;
        b=pq/tB40abHhTM/Q9jH622efuvF4bbn69pT7MdjZAWC21pZDOT7nWCVjMwVtdMiltmk
         WA7aN2OVtuNlheEscoqlyFyb+uwoADuVQcWdcnF7sQuS4hOWR6YVkhi0na8mAy4pcnB7
         veOyMMNCg2sD/BLITodfgjGrMfJ8/0kYCvqy+PFl0hmU4rDaBkRBL06jTd5CKRGPHqcv
         XfdngfQQy1EEzdKpCliV6Uf7pIZsjJOnsOsePO2W9C619IuuIixDNjJcxRkVlWQ6qe4h
         9fwfKRzRmw7411RdahJbmrBN+ooAzkcD27BbMiqzv4A6jxX6o08hC76psBHDrKZWthE3
         Uttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uoRcrltDUndHrepffhLxUiRgX6Ajv0seJ3Dn/4BTAag=;
        b=Kxj3GvMJiPWjymiuW5toYBjkb6Z9chgTOM9BYtTTij+fw8bXBhWFQRARCKq630X2N4
         zVQGAE72FWCLK+CZeX8k3RMoZXxp+BM7ZGIrfQdRyfBOHTiFXKYZC5ivd1fsoofuPC6i
         AEs3eAMXIcdsrIawK5WzIa8bpRFCkE1NbKAOHz+V+TtS6rUHRgKwrn3PLt/8iu06vleL
         038Vthm/gAqWCMwHX1S9TzCkh2FdgUpOlqi2BJPyDEduJKB2zSzuOJyTGeDjFg6gswro
         KnJXokEWvJIjGlaxFbALSuz1oG/mMl5ST8SXzXyfQjTJmmLb2uUXFsS461OeHgaGM5ld
         DSNA==
X-Gm-Message-State: ABuFfohEMHBtk73QsSFQxEHvMSkeZhUZ7VPmm4Amnwa5FZH5RlaZGaZc
        NV81yXWVZmGxTUuIQt4ynCc=
X-Google-Smtp-Source: ACcGV63699i8jkPNgwtJiZRodOqso20rn5sdEtMpqXKoWYpatisGk00Tp9HeeemshimEODHU5Hyaeg==
X-Received: by 2002:a1c:e08a:: with SMTP id x132-v6mr12302913wmg.60.1539577447031;
        Sun, 14 Oct 2018 21:24:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l125-v6sm39592202wmb.1.2018.10.14.21.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 21:24:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] object_id.cocci: match only expressions of type 'struct object_id'
References: <20181008215701.779099-15-sandals@crustytoothpaste.net>
        <20181012131116.23733-1-szeder.dev@gmail.com>
        <xmqqh8ho6ipe.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 15 Oct 2018 13:24:05 +0900
In-Reply-To: <xmqqh8ho6ipe.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 15 Oct 2018 11:34:53 +0900")
Message-ID: <xmqqefcr6dne.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> Most of our semantic patches in 'contrib/coccinelle/object_id.cocci'
>> turn calls of SHA1-specific functions into calls of their
>> corresponding object_id counterparts, e.g. sha1_to_hex() to
>> oid_to_hex().  These semantic patches look something like this:
>>
>>   @@
>>   expression E1;
>>   @@
>>   - sha1_to_hex(E1.hash)
>>   + oid_to_hex(&E1)
>>
>> and match the access to the 'hash' field in any data type, not only in
>> 'struct object_id', and, consquently, can produce wrong
>> transformations.
>
> Thanks, will queue.

I ended up taking this as part of Brian's "the-hash-algo" series.
