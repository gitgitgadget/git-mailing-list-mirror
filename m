Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90687205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 14:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756044AbdABOJP (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 09:09:15 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33859 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755940AbdABOJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 09:09:14 -0500
Received: by mail-lf0-f68.google.com with SMTP id d16so27885845lfb.1
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QTd/6/c8Bt+s7vABx7srWTEoRW9VXHTXwAIOFHFbnh0=;
        b=FXW0/AtxqZpAUdx+KCAo66LXfPId/TgDN1wtoBeRVY7/M/2qt7mEm//+fiOWl7hPDi
         +19Qkqfmap5Ng3hJBo5bs9JIEhdqYljJ3oejeFzLBRhTvnVUVdnNTDll2WB5GCoKxag9
         m3cxCK4wPposb4FMWSWTFd1afBYSYW3iBhVgIh6amqKSwaepVrC1Nf7ci9ZnNaRQrEfm
         ntzhruiOO/4Xb+V3PRFA2PcBDC5tcmjZmt1yWy68PjzYoZ6rVx9oqOP+kkWTH6nAVrA2
         4msvso/V7B+uK124UFulZL+7K2cgaWHUDTxtn5dMO7fidzL+JNb0jdWzLSn1x2+OoD5L
         GwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QTd/6/c8Bt+s7vABx7srWTEoRW9VXHTXwAIOFHFbnh0=;
        b=HBpWnvsZqdygzUNbzcbX1YzhCxrjO3OcS2VH6SyQK63medcdGbladuEZUZTbX/pPnB
         U7fN48r32rmaXWNtiNfxrw2dpXQaevhGHb27LJDXgQAlrRUoTAZrApWJVLPbiIXbwrGK
         gt0rQL+UvIei2zLMwDC/GuG0mCu5+Rc9WIX7H2Z452Tlnz8iTObtsStM2QqYmzaKHXBE
         J8V+nxlnW2TA7p5bOmXuIO93kWCyJJgtm0jc1XkWel8Hngql4+7cTHyxq8sIAog6x+PV
         qWdvFCFuVNk/dCtEAQonZEO03wtheAsKqAO574dsCfXHxHIH/abvkVWP8WH7FvvzFyFd
         /mAg==
X-Gm-Message-State: AIkVDXI3NJBc6aE8olcrKTftD5foqZv4TOBFbxAjTtEW7fyI25cVoi9q0jo1LIFeTISeDNJ6wrkxP8kkaZH5oQ==
X-Received: by 10.25.199.198 with SMTP id x189mr21234064lff.164.1483366153244;
 Mon, 02 Jan 2017 06:09:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.135.198 with HTTP; Mon, 2 Jan 2017 06:09:12 -0800 (PST)
In-Reply-To: <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-15-chriscool@tuxfamily.org> <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Jan 2017 15:09:12 +0100
Message-ID: <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 8:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +/*
>> + * Signal that the shared index is used by updating its mtime.
>> + *
>> + * This way, shared index can be removed if they have not been used
>> + * for some time. It's ok to fail to update the mtime if we are on a
>> + * read only file system.
>> + */
>> +void freshen_shared_index(char *base_sha1_hex)
>> +{
>> +     const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
>> +     check_and_freshen_file(shared_index, 1);
>
> What happens when this call fails?  The function returns 0 if the
> file did not even exist.  It also returns 0 if you cannot update its
> timestamp.

Yeah and I don't think it's a problem in either case.
If we cannot update its timestamp, it's not a problem, as we could be
on a read-only file system, and you said in a previous iteration that
we should not even warn in this case.
If the file does not exist, it could be because it has just been
deleted for a good reason, and anyway, if it is a problem that the
shared index file has been deleted, it is better addressed when we
will actually need the shared index file to read something into from
it, rather than just to update its mtime.

> Shouldn't the series be exposing freshen_file() instead _and_ taking
> its error return value seriously?

So what should we do if freshen_file() returns 0 which means that the
freshening failed?

>> +}
