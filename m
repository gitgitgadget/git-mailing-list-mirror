Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF49203BD
	for <e@80x24.org>; Thu, 27 Oct 2016 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034023AbcJ0OmT (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 10:42:19 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34594 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033994AbcJ0OmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 10:42:17 -0400
Received: by mail-oi0-f49.google.com with SMTP id p136so5878179oic.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fw22I3A+7NEVU6V3cyci10ZTxvMM+6WwxTWYRFaYrC0=;
        b=wkwTFktu5RJbiQdjr5Ulx3uqYuHE3q7X6s6aBTwZKyibSMtz9moOd9flKcRfmoR8Np
         e3WSBtDes7S3RLZ6ZpDcFj81RKTU0LuzXU2Uu0dHjwYzPOchUJERw/UtVNtR2b0iFpAu
         eK7gasyhQfzE7BrH6QU8nRA8kWu9wehZAGDaVDHKXV4qj3/xxoK3TB3BRy2bSwOyVg41
         leqja3Dj3sWAM08cBIzBKToCSCncZ4+I4WYRyz9U8QnhRb/dyp8KCkamCatns6ktrcqR
         yPoRwHn8scJXtDUE/K6ch5gMsrUeRIQ5yBC8GzVPWAtclCICj3xEmWGqLt8nS4O4xdWa
         7bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fw22I3A+7NEVU6V3cyci10ZTxvMM+6WwxTWYRFaYrC0=;
        b=SqRC6Gskl/WNAvFYqvCbqDlyJdP/jGvowKvoXhqZecLMs55ZET+SIlKfF63sTxf8dQ
         qtT9H+hC24smo0Eg/w309wSsPCXlBdIx0JK8HMP+05oseAHePb0hgpkIiGzC9qyNN1XC
         YT2AczMR3Yg1VE6imCJRe5UDE+smgDouJ6rIp/jap7iFnvX+wMZ1+lc9Bw5g2P6G9YNN
         g6ZBfNzR0GBvpEQYQOvJUonSHKYSB9mOsGSFFRwV3Ib5w1Ae/tHF1Ig5+4k93URs9rDW
         mKJPasRTR26tjpgFx1EKVV5q/VH6jrE8W6FzXjNy0sbgYRd1g6Agm5VRyGsjXPYxTg2j
         YhMA==
X-Gm-Message-State: ABUngvdoRVZ61sWyTmB1M4Thfe6vv/IIK91eLKXBgSeV1BkCmWMrVhgTK/RqIeWkQbS9bmnvOleGXmpAyaXEPg==
X-Received: by 10.107.59.6 with SMTP id i6mr6251693ioa.176.1477563969068; Thu,
 27 Oct 2016 03:26:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Thu, 27 Oct 2016 03:25:38 -0700 (PDT)
In-Reply-To: <CACsJy8C4Qd76LSYxk9BJtN3n3Knv_RCDgBOO-ybkNHFZK61ahQ@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-17-chriscool@tuxfamily.org> <CACsJy8C4Qd76LSYxk9BJtN3n3Knv_RCDgBOO-ybkNHFZK61ahQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Oct 2016 17:25:38 +0700
Message-ID: <CACsJy8BPe085Qu4GpJ3MLTPeZM_7pbVrX31enQrGQn0oyjSrdg@mail.gmail.com>
Subject: Re: [PATCH v1 16/19] read-cache: unlink old sharedindex files
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 5:43 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>  static int write_shared_index(struct index_state *istate,
>> @@ -2211,8 +2269,11 @@ static int write_shared_index(struct index_state *istate,
>>         }
>>         ret = rename_tempfile(&temporary_sharedindex,
>>                               git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
>> -       if (!ret)
>> +       if (!ret) {
>>                 hashcpy(si->base_sha1, si->base->sha1);
>> +               clean_shared_index_files(sha1_to_hex(si->base->sha1));
>
> This operation is technically garbage collection and should belong to
> "git gc --auto", which is already called automatically in a few
> places. Is it not called often enough that we need to do the cleaning
> up right after a new shared index is created?

Christian, if we assume to go with Junio's suggestion to disable
split-index on temporary files, the only files left we have to take
care of are index and index.lock. I believe pruning here in this code
will have an advantage over in "git gc --auto" because when this is
executed, we know we're holding index.lock, so nobody else is updating
the index, it's race-free. All we need to do is peek in $GIT_DIR/index
to see what shared index file it requires and keep it alive too, the
remaining of shared index files can be deleted safely. We don't even
need to fall back to mtime.

git-gc just can't match this because while it's running, somebody else
may be updating $GIT_DIR/index. Handling races would be a lot harder.
-- 
Duy
