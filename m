Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC9720D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdFBBNl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:13:41 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33209 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFBBNk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:13:40 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so41907718pfh.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DCS+E4n/mVzMVKVI0Hn9MJkDnbAIYwiKm4Qa/KmMGZs=;
        b=rjstB6M/m2+m4JplPKD9B4i6zwlsGkn3Wov6qcj8L3zSZzOfstJtufDlW5GbwLOk+J
         LFCal676bEi/x1W6Kr+hP59RDKG/Woli3Svlxvp4gR/7GxWTbUFu5ly0RFPUK77oCZES
         rhrqpkPrTBypP9pIFRz3TRf8qXAZ12xqt+pmBdMknCNPzAtfwxxkoVXe+7SPleS8Tgc6
         S5M0e1em7Rw9/ddylk0zshySo0BHa4UR0rcDoIagib3IcraxqL3obdREqH59o5JlpPXC
         gctlOJtL9IvuQzFDpdmEqaRfyhlgGE5LW20S7e77FnarSs3OPK9cthZIOwQXeC7ca1mB
         yO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DCS+E4n/mVzMVKVI0Hn9MJkDnbAIYwiKm4Qa/KmMGZs=;
        b=hs81UPKwdmGmk3gDyk5i1TB3ZLHTBRVzf3C0AryB09loGsO+Owm88Mm+zw4JxRLrar
         8SsCZpD7/vIG8oyg0Rk2oUGCHGfPLouitk2/SDK2pnuDkz6cwWWsOKz1JUjRjHuZjrVU
         x5jdn3w+yRhKRa4YY2SsxY4IdOzADJ95AfKexLoLa7Nc3aJqgnlU7itKWLGoiAECNwh3
         j55vs4aDDJUEUKakeQ/Edw9OWsINRyfB8K+NHjM3a2ugVMqcUI2euB4JcrsM38ErZ87T
         1ln2aTLPKKyns5MGPgLSfCWWIumYeOHdrrSySwegTDdQsqIx+/oHo1wcv7p/N2O08CJA
         Z6XQ==
X-Gm-Message-State: AODbwcDDMvp0mPR2g+QhQBZG0D4Yv/yobshlTDU1sIc3s2BxVOx6bX7g
        RhiGUmG9LgKKbw==
X-Received: by 10.84.167.74 with SMTP id j10mr36768716plg.144.1496366019712;
        Thu, 01 Jun 2017 18:13:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id g191sm6223430pgc.49.2017.06.01.18.13.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:13:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH 22/33] notes-merge: convert notes_merge* to struct object_id
References: <20170530173109.54904-1-bmwill@google.com>
        <20170530173109.54904-23-bmwill@google.com>
        <20170530185653.cfy4cbq3pmxfq5x6@genre.crustytoothpaste.net>
Date:   Fri, 02 Jun 2017 10:13:38 +0900
In-Reply-To: <20170530185653.cfy4cbq3pmxfq5x6@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Wed, 31 May 2017 22:00:57 +0000")
Message-ID: <xmqqh8zz2nul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> diff --git a/notes-merge.h b/notes-merge.h
>> index 0d890563b..eaa8e3b86 100644
>> --- a/notes-merge.h
>> +++ b/notes-merge.h
>> @@ -33,15 +33,15 @@ void init_notes_merge_options(struct notes_merge_options *o);
>>   *
>>   * 1. The merge trivially results in an existing commit (e.g. fast-forward or
>>   *    already-up-to-date). 'local_tree' is untouched, the SHA1 of the result
>> - *    is written into 'result_sha1' and 0 is returned.
>> + *    is written into 'result_oid' and 0 is returned.
>>   * 2. The merge successfully completes, producing a merge commit. local_tree
>>   *    contains the updated notes tree, the SHA1 of the resulting commit is
>> - *    written into 'result_sha1', and 1 is returned.
>> + *    written into 'result_oid', and 1 is returned.
>>   * 3. The merge results in conflicts. This is similar to #2 in that the
>>   *    partial merge result (i.e. merge result minus the unmerged entries)
>>   *    are stored in 'local_tree', and the SHA1 or the resulting commit
>>   *    (to be amended when the conflicts have been resolved) is written into
>> - *    'result_sha1'. The unmerged entries are written into the
>> + *    'result_oid'. The unmerged entries are written into the
>>   *    .git/NOTES_MERGE_WORKTREE directory with conflict markers.
>>   *    -1 is returned.
>>   *
>
> Did you want to change the comment to say "object ID" or "OID" instead
> of "SHA1" like you did in an earlier patch?

Yes, that's a good suggestion.  Will queue a trivial squash on top.
