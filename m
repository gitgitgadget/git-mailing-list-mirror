Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB53220401
	for <e@80x24.org>; Sun, 25 Jun 2017 04:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdFYEmY (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 00:42:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34572 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFYEmY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 00:42:24 -0400
Received: by mail-io0-f193.google.com with SMTP id m19so10481958ioe.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 21:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K4R1VB/TEF+6e98R9eHYViXKlmomseXoYxb/g2ZN6ww=;
        b=LqEM5u1ZpsuGS1Ze4VLxuScySweIbW/+mstHRy9pJD8P7aSQRVLXwFlBJv5CS28GHN
         x6PRA5VwHc72uwnM9E5EBDHXEOL9OHgCyKZZXhnvfSGzDIv9JyvbbPl0sgm9myV5NN4e
         zRyOBxvJTrgC8J12L83wTxzCLaGgglN6YHVzZIpu51S8IfzGCZy2oKAZ1t7lMJD9wIhs
         CLR1qaD1bXlmCzQLMdD/UU9q/87RwS3RCKYDQO3KzCy5JaovxvJnrwhWst6D4+8/MQjs
         M3j6i3DgTwqjSY0zwCwFK/owv0tLhJzEbMlsJFKXVbhk58ADNnehx7k4yT0Tccgph10H
         8nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K4R1VB/TEF+6e98R9eHYViXKlmomseXoYxb/g2ZN6ww=;
        b=nptY70ME1ZMVtPOZJ8eo8ozJw/B8RODbDkNnfu4WeWyK9Qz/LvI+Ydf3xdlgiC4wOO
         yshxjIZck+E4z95DfBnvVESCIt2usOubHO9+udq8qR1eLBJuP+2sn1M6432BYKDIaYUC
         I732YoK/11gRJ/aT31KmEDq3ZEaybHtZn7KAyWjc5kRLqZM4Htucco1d/OcBZba70HV0
         1PSQAI748MqwMpBcp1RMnm2KD0OMQjsxZeFHqw+6347gQ8dbjDZ9e7IKIsME6ehqMe/W
         7OG5AvLc4oYAW/EkM2eUAAGI8SC+u857JQuL2hNtMNoMiD2glBsbY8rw+yS4kkImrD9q
         GHRA==
X-Gm-Message-State: AKS2vOwV9DvLVZriiM9vYQwby5CbArenAM3A9XBhpkJ0l0jsPtDJlIFO
        5fDgzDQbx6ZYbiAXxP73B7djO6Xe1g==
X-Received: by 10.107.41.4 with SMTP id p4mr15447436iop.126.1498365743329;
 Sat, 24 Jun 2017 21:42:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Sat, 24 Jun 2017 21:42:22 -0700 (PDT)
In-Reply-To: <xmqq60fmcqgm.fsf@gitster.mtv.corp.google.com>
References: <20170623151640.24082-1-chriscool@tuxfamily.org> <xmqq60fmcqgm.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 25 Jun 2017 06:42:22 +0200
Message-ID: <CAP8UFD24RMxjWzowP7-LD5ZA+usNaHzr=1tzP4BNTUziqYF4_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] read-cache: use shared perms when writing shared index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 12:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:

>> Because of that, on repositories created with `git init --shared=all`
>> and using the split index feature, one gets an error like:
>>
>> fatal: .git/sharedindex.a52f910b489bc462f187ab572ba0086f7b5157de: index file open failed: Permission denied
>>
>> when another user performs any operation that reads the shared index.
>>
>> We could use create_tempfile() that calls adjust_shared_perm(), but
>> unfortunately create_tempfile() doesn't replace the XXXXXX at the end
>> of the path it is passed. So let's just call adjust_shared_perm() by
>> ourselves.
>
> Because create_tempfile() is not even a viable alternative, the
> above sounds just as silly as saying "We could use X, but
> unfortunately that X doesn't create a temporary file and return its
> file descriptor" with X replaced with any one of about a dozen
> functions that happen to call adjust_shared_perm().
>
>         Call adjust_shared_perm() on the temporary file created by
>         mks_tempfile() ourselves to adjust the permission bits.
>
> should be sufficient.

Ok, the v3 has the above in the commit message and also uses
get_tempfile_path().
