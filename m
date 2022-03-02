Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC3CC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 18:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbiCBSra (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244210AbiCBSr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 13:47:29 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B57D5DD0
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 10:46:45 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso2943338ooc.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YlNnvZrbO5D0mOd1ytZ6+u+JyVc46ZO3TCXq31R9eIk=;
        b=KC6dxoqBpSvg4Y2nLv66/pTWJ38eilCJma5Fj0z9RD3mE0cBawJovex9ERn2ecob7R
         P1XnkeNR+NBJVabOdpSC+nu5AyQMlYBbAoKTR41JBtWoAIlYJpblqgp0tNeRILlv88XF
         U7atVEK3jC86QGO/8E2bJ2KwO2ISrPdmqRmF+JqoGV8Cw5F8XNq6n+EZhW6kRJbv2HHB
         z0DT8ghaY5/NXp82pJV1iosLsylgRNCDugv+ycon12enkfM8rQyBTlO60EjaQ0EXm/Mr
         FAAIynjKt3FpwAD3fB8/T0m/pBfb3hfowPbZ6lPfABoLIyampJhwrkCo+ESSMCxF6SDs
         FmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YlNnvZrbO5D0mOd1ytZ6+u+JyVc46ZO3TCXq31R9eIk=;
        b=TvA40GbHV0CKdeIECb1q9WEp7rpDR2Ok2O5sJIA/Lted1QsrgHnqR6ahiW2lJ3qWxH
         AKe8cj1DObJ1mP6codL0jON3pG74UIlrS6uNy4h4fc7DKca9bQ5lHHVsDr5uizMHVx+l
         H0V68NMb1rrcTDgBfRAoaWQjtTJ4AecoMHKFK7l6IASoiXQtqODRKjRFW2CtvB1WIIoQ
         FtnUptr1PvrHgwJqS7KlvBqnu/4KeRA95pHjo0ZiUPGsTWCFbJ1YLfVUmVbWBkTKWG5/
         MHPN04QNJdLEdmE+eAoDCo1INceIWxD6W920YGCq/o2rdZ+1j7ljDLMIw83exV+ALeGr
         CiEA==
X-Gm-Message-State: AOAM533HMkidcCRf6fH3G4UDxk2VqdQxIZmxxGA5pwenbzBBzwJDHxPz
        JLqVvy+HzFt+igaxwPVbAmMjE7o6ONZq
X-Google-Smtp-Source: ABdhPJz4G9ew2H9z3CYtYlUE1uNTVQBwwbYW+x3DENIPqs0pwncGhVCwdvocxN79zHD771MDwxiFNg==
X-Received: by 2002:a05:6870:f61d:b0:d4:6806:953 with SMTP id ek29-20020a056870f61d00b000d468060953mr1026452oab.80.1646246805092;
        Wed, 02 Mar 2022 10:46:45 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j23-20020a056830241700b005af4acc68a5sm8142198ots.29.2022.03.02.10.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 10:46:44 -0800 (PST)
Message-ID: <1651a34e-38c1-fb8a-df59-1dcd8a8389b5@github.com>
Date:   Wed, 2 Mar 2022 13:46:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com
References: <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase> <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps> <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
 <Yh3rZX6cJpkHmRZc@ncase> <Yh325v3RBDMxjFnD@ncase>
 <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com> <Yh4zehdSnHLW1HuK@ncase>
 <1b9912f7-87be-2520-bb53-9e23529ad233@github.com> <Yh93vOkt2DkrGPh2@ncase>
 <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com>
 <xmqqh78gmdap.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqh78gmdap.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 1:15 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> Since our repro relies on private information, but is consistent, I
>> wonder if we should take the patch below, which starts to ignore the
>> older generation number v2 data and only writes freshly-computed
>> numbers.
> 
> ;-)
> 
>> Clearly, there is something else going on. The situation is not
>> completely understood, but the errors do not reproduce if the
>> commit-graphs are all generated by a Git version including these recent
>> fixes.
> 
> Do you mean "we know doing X and then Y and then Z on this
> particular private data with older version of Git without those two
> fixes will lead to a broken timestamp, but doing exactly the same
> with the two fixes, the breakage does not reproduce"?  If so, that
> is quite encouraging news.  Thanks for working well together.

Yes, that is my understanding.

>> If we cannot trust the existing data in the GDAT and GDOV chunks, then
>> we can alter the format to change the chunk IDs for these chunks. This
>> causes the new version of Git to silently ignore the older chunks (and
>> disabling generation number v2 in the process) while writing new
>> commit-graph files with correct data in the GDA2 and GDO2 chunks.
>>
>> Update commit-graph-format.txt including a historical note about these
>> deprecated chunks.
> 
> Sensible.
> 
>> @@ -156,3 +156,11 @@ CHUNK DATA:
>>  TRAILER:
>>  
>>  	H-byte HASH-checksum of all of the above.
>> +
>> +== Historical Notes:
>> +
>> +The Generation Data (GDA2) and Generation Data Overflow (GDO2) chunks have
>> +the number '2' in their chunk IDs because a previous version of Git wrote
>> +possibly erroneous data in these chunks with the IDs "GDAT" and "GDOV". By
>> +changing the IDs, newer versions of Git will silently ignore those older
>> +chunks and write the new information without trusting the incorrect data.
> 
> Good.  How does a new version of Git skip and ignore GDAT and GDOV
> in existing files?  By not having any code to recognize what they
> are?
> 
> I am wondering if there is some notion of "if you do not understand
> what this chunk is, you are incapable of handling this file
> correctly, so do not use it" kind of bit per chunks (similar to the
> index extensions where ones that begin with [A-Z] are optional) that
> may negatively affect this plan.

The chunk IDs do not have this special casing rule. This is a
bit unfortunate for certain cases like adding something that _must_
be understood. Here, it works to our benefit that GDAT and GDOV are
optional and can be safely ignored. Thus, clients with this patch
will ignore GDAT and GDOV and continue using topological levels
form the CDAT chunk. Older clients without this patch will ignore
the new GDA2 and GDO2 chunks and continue using topological levels.

For Git versions without this topic branch, this "continue using
topological levels" means no change of behavior at all.

Thanks,
-Stolee
