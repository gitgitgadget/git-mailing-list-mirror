Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB691F404
	for <e@80x24.org>; Thu, 13 Sep 2018 21:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeINCSD (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 22:18:03 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38717 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeINCSD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 22:18:03 -0400
Received: by mail-wr1-f41.google.com with SMTP id w11-v6so8121072wrc.5
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZZTC17+hhXMVbdnmgbhaZQnwMilUDAjS2ZvrponRnYo=;
        b=hcsmUbMeEPQWBnkMKDcQeZTHSe7St4w97dSKjnNYVsroSvidNLagIDcs3ReEQxH3Qx
         /qFJF486hyMh1uOes7dequl+p6LphDMgYMETPdynnK35CUNlVw/IZV0qc3xCKrBeFJnZ
         3bcxw9PVDWGSDtlIvYfvc5Qww8FDNkGHpFmlgk+RmtuLbOrbOR+fVDCXuh5GSzLb5Ia4
         CHRgoTn7a5PkDobLUxZZZ1WsmwyW5KNlp4qA080X0SH4fChc8orrP1ZhuJmHAFlb2If6
         XKkTgG70//iK5qoMGEkFr+6+uFOU8lnmDYVr9KitaFxEg+sIfY3yxQGrO2pnFMjF2dkd
         ZG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZZTC17+hhXMVbdnmgbhaZQnwMilUDAjS2ZvrponRnYo=;
        b=mAvcaZeAhINyUxZ0el7KmFQ+UjFopSWJv9jdmeDLIgYhopqFtWdcFVffYqupIv5Nnj
         WcVv3DrNiVwoVZrE/k1M0B8Z2GmmXoQ/cDGaAT8KrC/GbMqX9Bp7pe1vLIlPXpLGkwHD
         p+m/eSTm7diX+Uuvn00nuA0s/UETV9tjKCmUKRThXyrzIFUF3QxjK4mdiZ546G8yfa/f
         CDFfKCBKirxav5Dq+q9ssi2pxIBLwRcqJFMIY31WW+aj2V2uFrasV+0AihqSJZp2UUUi
         Qgk+vH9La0pu8Zb9GICuSel8+TZ6ByKpWzS5icZmvKpScbwnRNUM/WLUQnjdLoYs15ZJ
         kxIQ==
X-Gm-Message-State: APzg51DRU99o4xWhU3duy69LR+ij2CE7p5d5ZnwE1QUwCW8eYm8n7J4K
        DC0q+7izBceB/SFEX7wyK2M=
X-Google-Smtp-Source: ANB0VdZnXpb0o55siT5fMIUgOmzwkXLIDNLChd6iY1QIWUI0iNI2rMyKVM8N6R30NQEUcp/YP4m19w==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr6942909wma.43.1536872809123;
        Thu, 13 Sep 2018 14:06:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k35-v6sm11532088wrc.14.2018.09.13.14.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 14:06:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] commit-reach: properly peel tags
References: <pull.39.git.gitgitgadget@gmail.com>
        <pull.39.v2.git.gitgitgadget@gmail.com>
        <4bf21204ddf8b9daa823db9954ddde98ab264a1b.1536855032.git.gitgitgadget@gmail.com>
        <8d6061de-1654-577c-40c6-211dbd03aa36@gmail.com>
Date:   Thu, 13 Sep 2018 14:06:47 -0700
In-Reply-To: <8d6061de-1654-577c-40c6-211dbd03aa36@gmail.com> (Derrick
        Stolee's message of "Thu, 13 Sep 2018 12:38:16 -0400")
Message-ID: <xmqqy3c5ds48.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +		if (!from_one || from_one->type != OBJ_COMMIT) {
>> +			/* no way to tell if this is reachable by
>> +			 * looking at the ancestry chain alone, so
>> +			 * leave a note to ourselves not to worry about
>> +			 * this object anymore.
>> +			 */
>> +			from->objects[i].item->flags |= assign_flag;
>> +			continue;
>> +		}
>> +
>> +		list[nr_commits] = (struct commit *)from_one;
>> +		if (parse_commit(list[nr_commits]) ||
>> +		    list[nr_commits]->generation < min_generation)
>> +			return 0; /* is this a leak? */
>
> Of course, after sending v2, I see this comment. This is a leak of
> 'list' and should be fixed.
>
> Not only is it a leak here, it is also a leak in the 'cleanup'
> section. I'll squash the following into v3, but I'll let v2 simmer for
> review before rerolling.
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 4048a2132a..c457d8d85f 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -569,8 +569,11 @@ int can_all_from_reach_with_flag(struct
> object_array *from,
>
>                 list[nr_commits] = (struct commit *)from_one;
>                 if (parse_commit(list[nr_commits]) ||
> -                   list[nr_commits]->generation < min_generation)
> -                       return 0; /* is this a leak? */
> +                   list[nr_commits]->generation < min_generation) {
> +                       result = 0;
> +                       goto cleanup;
> +               }
> +
>                 nr_commits++;
>         }
>
> @@ -623,6 +626,7 @@ int can_all_from_reach_with_flag(struct
> object_array *from,
>                 clear_commit_marks(list[i], RESULT);
>                 clear_commit_marks(list[i], assign_flag);
>         }
> +       free(list);
>         return result;
>  }

With this, commit marks are cleared even when we do the "early
return", but only for the objects that appear in the resulting
list[].  Because the for() loop in the last hunk interates over
list[], those non-commit objects that are smudged with assign_flag
but never made to list[] will be left smudged when this function
returns (this is true when there is no early return).  

Is that intended?


