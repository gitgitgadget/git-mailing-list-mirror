Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B60C433E4
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE76A206F0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwqWkmg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGXPDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXPDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 11:03:30 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFEEC0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 08:03:30 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id y22so8231678oie.8
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j0FWC7nIllJhQ1wSrKIENZA65olChTI9tTFi85xRX5I=;
        b=AwqWkmg/O6qjrBRTy8KsRtloLMoZl+rlBQsZtPRDSTvVu09WiojcZKrL3oOZ7e8J3N
         CushzMPlrCoHnhpw0JmdhYUVC7O84oioGV2SjIRfIODF8OKW3A9RLx+7u5OOjXIR5Azz
         fIfJcKTPE+GVN+S1VQgLQ4jf9hNbvMH/TbEfaYCqVc3cQfZYz44XyuIg3MO8fWNp00WG
         0Fx85CqlBbfi4xXMZUYn9rSj5UwDCFTsf0AcwIaVw/1/j7LcixHVzhbBdEYe+BsJYONV
         VNYkwQWgzDW1AaasGbq7cY5ISYjLCvdXkuZJ5DJn2fc/MKy8B7A+SjqcrNbgvw4x3PD1
         fSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0FWC7nIllJhQ1wSrKIENZA65olChTI9tTFi85xRX5I=;
        b=dIAaVrag6r4bJgaZcXb3dFinww2w+yYv7L6RV4Edq2why18sG9rnGv6J9oHgj/nJ+o
         uL/P1eZkmGEhIlGR50nJU7LjWBJMiQpyjK/GwPnVcbs7SkJ1WGZbEgjpFv6bu6LtjXHJ
         X94NrfYvgXj5meriy3q2lM/Upp63eZKGw7/ScaGXCTa13TKUiEJwIBA7qkXDf0mi/eja
         G4q3ACebmbGDIgw6ZdUFBh70QQkfACbYj0xQNv4Le8Uzoybc4G/gTvJ4r6b2+5qRd/rT
         oG7e11WKQ0vtoXb9kiMpaQyh79e+QL/krU+7Ydqtp1kKUrjG+9qv8/glYgZS+JvKSYKY
         xNrw==
X-Gm-Message-State: AOAM533+4NYcKdBgsVZ4EQv7j4+s82LYKNOuF9G/e3bCYwqVqZTIwvFY
        Th4TAQP/lI+d6K61cAj1+Gc=
X-Google-Smtp-Source: ABdhPJz/0cAi1HWCAn1qIWDvNnzQVnun+DY+XbQIRngFMzINmHNgR5btPhPKkFsah8DoFe6GaGZ+fg==
X-Received: by 2002:aca:5007:: with SMTP id e7mr8532601oib.70.1595603009185;
        Fri, 24 Jul 2020 08:03:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dd66:75cb:8c22:1387? ([2600:1700:e72:80a0:dd66:75cb:8c22:1387])
        by smtp.gmail.com with ESMTPSA id k9sm183006oik.27.2020.07.24.08.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 08:03:28 -0700 (PDT)
Subject: Re: [PATCH v2 10/18] maintenance: add incremental-repack task
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <b6328c210625e1ba98e2065208a2a478c2c64f94.1595527000.git.gitgitgadget@gmail.com>
 <xmqqeep1q4d0.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <54bfc8a9-e3bf-4199-9c58-8ed6ad50fb36@gmail.com>
Date:   Fri, 24 Jul 2020 11:03:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqeep1q4d0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2020 6:00 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> 1. 'git multi-pack-index write' creates a multi-pack-index file if
>>    one did not exist, and otherwise will update the multi-pack-index
>>    with any new pack-files that appeared since the last write. This
>>    is particularly relevant with the background fetch job.
>>
>>    When the multi-pack-index sees two copies of the same object, it
>>    stores the offset data into the newer pack-file. This means that
>>    some old pack-files could become "unreferenced" which I will use
>>    to mean "a pack-file that is in the pack-file list of the
>>    multi-pack-index but none of the objects in the multi-pack-index
>>    reference a location inside that pack-file."
> 
> An obvious alternative is to favor the copy in the older pack,
> right?  Is the expectation that over time, most of the objects that
> are relevant would reappear in newer packs, so that eventually by
> favoring the copies in the newer packs, we can retire and remove the
> old pack, keeping only the newer ones?
> 
> But would that assumption hold?  The old packs hold objects that are
> necessary for the older parts of the history, so unless you are
> cauterizing away the old history, these objects in the older packs
> are likely to stay with us longer than those used by the newer parts
> of the history, some of which may not even have been pushed out yet
> and can be rebased away?

If we created a new pack-file containing an already-packed object,
then shouldn't we assume that the new pack-file does a _better_ job
of compressing that object? Or at least, doesn't make it worse?

For example, if we use 'git multi-pack-index repack --batch-size=0',
then this creates a new pack-file containing every previously-packed
object. This new pack-file should have better delta compression than
the previous setup across multiple pack-files. We want this new
pack-file to be used, not the old ones.

This "pick the newest pack" strategy is also what allows us to safely
use the 'expire' option to drop old pack-files. If we always keep the
old copies, then when we try to switch the new pack-files, we cannot
delete the old packs safely because a concurrent Git process could
be trying to reference it. One race is as follows:

 * Process A opens the multi-pack-index referring to old pack P. It
   doesn't open the pack-file as it hasn't tried to parse objects yet.

 * Process B is 'git multi-pack-index expire'. It sees that pack P can
   be dropped because all objects appear in newer pack-files. It deletes
   P.

 * Process A tries to read from P, and this fails. A must reprepare its
   representation of the pack-files.

This is the less disruptive race since A can recover with a small cost
to its performance. The worse race (on Windows) is this:

 * Process A loads the multi-pack-index and tries to parse an object by
   loading "old" pack P.

 * Process B tries to delete P. However, on Windows the handle to P by
   A prevents the deletion.

At this point, there could be two resolutions. The first is to have
the 'expire' fail because we can't delete A. This means we might never
delete A in a busy repository. The second is that the 'expire' command
continues and drops A from the list in the multi-pack-index. However,
now all Git processes add A to the packed_git list because it isn't
referenced by the multi-pack-index.

In summary: the decision to pick the newer copies is a fundamental
part of how the write->expire->repack loop was designed.

>> 2. 'git multi-pack-index expire' deletes any unreferenced pack-files
>>    and updaes the multi-pack-index to drop those pack-files from the
>>    list. This is safe to do as concurrent Git processes will see the
>>    multi-pack-index and not open those packs when looking for object
>>    contents. (Similar to the 'loose-objects' job, there are some Git
>>    commands that open pack-files regardless of the multi-pack-index,
>>    but they are rarely used. Further, a user that self-selects to
>>    use background operations would likely refrain from using those
>>    commands.)
> 
> OK.
> 
>> 3. 'git multi-pack-index repack --bacth-size=<size>' collects a set
>>    of pack-files that are listed in the multi-pack-index and creates
>>    a new pack-file containing the objects whose offsets are listed
>>    by the multi-pack-index to be in those objects. The set of pack-
>>    files is selected greedily by sorting the pack-files by modified
>>    time and adding a pack-file to the set if its "expected size" is
>>    smaller than the batch size until the total expected size of the
>>    selected pack-files is at least the batch size. The "expected
>>    size" is calculated by taking the size of the pack-file divided
>>    by the number of objects in the pack-file and multiplied by the
>>    number of objects from the multi-pack-index with offset in that
>>    pack-file. The expected size approximats how much data from that
> 
> approximates.
> 
>>    pack-file will contribute to the resulting pack-file size. The
>>    intention is that the resulting pack-file will be close in size
>>    to the provided batch size.
> 
>> +static int maintenance_task_incremental_repack(void)
>> +{
>> +	if (multi_pack_index_write()) {
>> +		error(_("failed to write multi-pack-index"));
>> +		return 1;
>> +	}
>> +
>> +	if (multi_pack_index_verify()) {
>> +		warning(_("multi-pack-index verify failed after initial write"));
>> +		return rewrite_multi_pack_index();
>> +	}
>> +
>> +	if (multi_pack_index_expire()) {
>> +		error(_("multi-pack-index expire failed"));
>> +		return 1;
>> +	}
>> +
>> +	if (multi_pack_index_verify()) {
>> +		warning(_("multi-pack-index verify failed after expire"));
>> +		return rewrite_multi_pack_index();
>> +	}
>> +	if (multi_pack_index_repack()) {
>> +		error(_("multi-pack-index repack failed"));
>> +		return 1;
>> +	}
> 
> Hmph, I wonder if these warning should come from each helper
> functions that are static to this function anyway.
> 
> It also makes it easier to reason about this function by eliminating
> the need for having a different pattern only for the verify helper.
> Instead, verify could call rewrite internally when it notices a
> breakage.  I.e.
> 
> 	if (multi_pack_index_write())
> 		return 1;
> 	if (multi_pack_index_verify("after initial write"))
> 		return 1;
> 	if (multi_pack_index_exire())
> 		return 1;
> 	...

This is a cleaner model. I'll work on that.

> Also, it feels odd, compared to our internal API convention, that
> positive non-zero is used as an error here.
...
> Exactly the same comment as 08/18 about natural/inherent ordering
> applies here as well.

I'll leave these to be resolved in the earlier messages.

Thanks,
-Stolee

