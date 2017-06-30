Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21496201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 18:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdF3SAW (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 14:00:22 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36232 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdF3SAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 14:00:21 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so70599106pfl.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lN2kaW3uIWWcI1JO74Yx6+cpHUCMSgbcgMajCYpRMNo=;
        b=e9wVbsTbWl3P6JOUs7zhIidpy6ylQKDumw581il0hFXcWb4dhhrAcMcebuGkISZgEu
         Fn1T5T7aqSZKjkJgMjTiaoG55B/G+bMZe4SIQw+jCUs/6R7FYhP/ZqbXL8ZWbhoO4j+4
         dvW88WGnamTi5ky/Qmym8Mcf3b19wyPkUIrg3D3a5H0Ur0r70VR8z2uLyZsXm0WNMb7+
         nxoYoOwB5Cq+ICoHCTiqmGhmMdZJJAb9tT/dFs4xY6o+tuufIKWRH5UhsWVtjA4QBJCu
         9SsAbUd6VprBSmmMM9xZqMfzFcnYgIXiJqrSNtT2dsrAFshdoCfytp22PvA+mKIj9OLY
         fc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lN2kaW3uIWWcI1JO74Yx6+cpHUCMSgbcgMajCYpRMNo=;
        b=aBvp9PXIpPTSD3JvAvf2O9lMFNCXSArFaIk7KQ/XHnnjRCFYnqMA2oDimq/IDv8w+6
         fVnAd/Ba4yPqyP5WkcySeohCn+AnOsPZthS1ePRInwTp7jnByCfeHp8OzyDK5/QgVR2H
         9cYS6ywLGtj5V9s8uO04+STBac1/KiXfczVgRxuOrEiql541zQn2Lx45+/9mGCUMfS7F
         cXsYy4QHDYPe2HwyUKP7ErXRKkVXt5HzqFhCxQKO51gJXB/Vqczu5BWDTvyKXDmRulMf
         y1GgvDYO4WsLg10QJspKTb+xlOkbcgiQPmbEQEsUOHMphytFakg6I9jfzRYyUEYrs1p9
         r+7Q==
X-Gm-Message-State: AKS2vOy7/m1wiTN9q/KeDZghiXYgcHexemALVSiNrPCGvq8LbhxChHn1
        os2pUzq5yzhyJcA+DgAm6lnxYnXygXya
X-Received: by 10.99.141.76 with SMTP id z73mr22258340pgd.40.1498845619636;
 Fri, 30 Jun 2017 11:00:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 11:00:19 -0700 (PDT)
In-Reply-To: <xmqqh8yxs7by.fsf@gitster.mtv.corp.google.com>
References: <20170629011334.11173-1-sbeller@google.com> <20170629235336.28460-1-sbeller@google.com>
 <20170629235336.28460-2-sbeller@google.com> <xmqqh8yxs7by.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 11:00:19 -0700
Message-ID: <CAGZ79kbWXuC2y97+nOsgvNhCCqg=2+VgOOvTbUn1LGpH4f0=PQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] hashmap.h: compare function has access to a data field
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 10:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/patch-ids.c b/patch-ids.c
>> index 9c0ab9e67a..b9b2ebbad0 100644
>> --- a/patch-ids.c
>> +++ b/patch-ids.c
>> @@ -37,6 +37,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
>>   */
>>  static int patch_id_cmp(struct patch_id *a,
>>                       struct patch_id *b,
>> +                     const void *unused_keydata,
>>                       struct diff_options *opt)
>>  {
>>       if (is_null_oid(&a->patch_id) &&
>> @@ -57,7 +58,8 @@ int init_patch_ids(struct patch_ids *ids)
>>       ids->diffopts.detect_rename = 0;
>>       DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
>>       diff_setup_done(&ids->diffopts);
>> -     hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp, 256);
>> +     hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp,
>> +                  &ids->diffopts, 256);
>>       return 0;
>>  }
>>
>> @@ -93,7 +95,7 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
>>       if (init_patch_id_entry(&patch, commit, ids))
>>               return NULL;
>>
>> -     return hashmap_get(&ids->patches, &patch, &ids->diffopts);
>> +     return hashmap_get(&ids->patches, &patch, NULL);
>>  }

+cc Peff

>
> This actually makes me wonder if we can demonstrate an existing
> breakage in tests.  The old code used to pass NULL to the diffopts,
> causing it to be passed down through commit_patch_id() function down
> to diff_tree_oid() or diff_root_tree_oid().  When the codepath
> triggers the issue that Peff warned about in his old article (was it
> about rehashing or something?)  that makes two entries compared
> (i.e. not using keydata, because we are not comparing an existing
> entry with a key and data only to see if that already exists in the
> hashmap), wouldn't that cause ll_diff_tree_oid() that is called from
> diff_tree_oid() to dereference NULL?
>
> Thanks.

I am at a loss here after re-reading your answer over and over,
but I think you are asking if patch_id_cmp can break, as
we have a callchain like

  patch_id_cmp
    commit_patch_id
      (diff_root_tree_oid)
        diff_tree_oid
          ll_diff_tree_oid

passing diff_options down there, and patch_id_cmp may have
gotten NULL.

The answer is no, it was safe. (by accident?)

That is because we never use hashmap_get_next
on the hashmap that uses patch_id_cmp as the compare
function.

hashmap_get_next is the only function that does not pass
on a keydata, any other has valid caller provided keydata.

Thanks,
Stefan
