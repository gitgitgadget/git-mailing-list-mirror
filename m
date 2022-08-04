Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E372C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 13:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiHDN3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiHDN3J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 09:29:09 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8B15737
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 06:29:08 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v185so15080421ioe.11
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hBg9/YpVaffBSsGcQZKfsJQIBzlu/Do4Vv7PC2RozMk=;
        b=CbpOt7HEoUI415FlYZXLn/odJF5GlY/n+3kFcZx0exesdnYWfuckHwYDIkTlM5AD94
         BgAyvls8Y1GDV/EANitwYNcTNF9PrEoA1xkS8g+7XS0J+lAxrjKAFDZYfr+bFyS9BndB
         N73J+7+NSzxxIwTRttj7//eaobXoSAyXTCNjd0k+UuFx63DH1rSwf9lSAQuOTbSO5DTF
         SjSCLlF6eN4MhynysFhnuyJGckQrT3ILM/93dFuUiRiJhLr+KAsQ8aoYXIu06QBePEcY
         Zmidr8IjC3Caqo94mm5GImSPtVvDu9LpF748XIJ0pz0sXMXLuYOpaReBEu19yI5X2aQa
         dmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hBg9/YpVaffBSsGcQZKfsJQIBzlu/Do4Vv7PC2RozMk=;
        b=zhB1VC2tWwPHbuLGb2WW3qUMpOpcVZa4shQAd9UjwkiSGclivurblW1jnu973rwqcR
         sYT0IF4cf4dZm1G+uTMvzwQ8WY9boGc3ThSEwwUEbwQQXcfDaBSJUHIYQ3eAv1LecGZf
         TMhRM4kGYUZaFNX6dY5zJhsp2V5wDLMZH9KSdvkq6MSJ1W18Fw1VpAY/2ha91K8FcJV9
         v2itnHK8JEOyOyE5lOQrNfvbqx7Ry5VH5eM8p0EytVCeA4adCgeEgd/wAv8gosht80Ec
         S6azqsSJMhBEYrcjtusyX3T9xYtQgIC7g8eC/Azlgn0NB6LDE6nHpHF/zBWPYnJ+LLUV
         qesw==
X-Gm-Message-State: ACgBeo2jku0VtHtpd1FoPVzOER343sZt8u+jXZICJdkvHoN52yiHIwbo
        jgQ7WkL726TpaTpKHWOSmRxs
X-Google-Smtp-Source: AA6agR7iYS9BIpAqD8MEbXXRjnnFZY7KQqyKqTe/UHd5ITw07+mn70JFLrJPjgowvehkgIEVk2GSlw==
X-Received: by 2002:a02:238b:0:b0:33f:4ccb:3139 with SMTP id u133-20020a02238b000000b0033f4ccb3139mr858724jau.20.1659619747910;
        Thu, 04 Aug 2022 06:29:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id q21-20020a02a315000000b0034272baf43esm430267jai.168.2022.08.04.06.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:29:07 -0700 (PDT)
Message-ID: <9d60ae93-5acf-cf26-f0ab-cc2aa0808f7e@github.com>
Date:   Thu, 4 Aug 2022 09:29:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/10] refs: add array of ref namespaces
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <d7486390d57849971ee6a4ac27a0a784c41623ee.1659122979.git.gitgitgadget@gmail.com>
 <xmqqzggldf7y.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqzggldf7y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 2:16 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	[NAMESPACE_REPLACE] = {
>> +		/*
>> +		 * This namespace allows Git to act as if one object ID
>> +		 * points to the content of another. Unlike the other
>> +		 * ref namespaces, this one can be changed by the
>> +		 * GIT_REPLACE_REF_BASE environment variable. This
>> +		 * .namespace value will be overwritten in setup_git_env().
>> +		 */
> 
> Thanks---it is a shame that we have unnecessary flexibility that
> requires us to have this code.
> 
>> +		.ref = "refs/replace/",
>> +		.decoration = DECORATION_GRAFTED,
>> +	},
>> +	[NAMESPACE_NOTES] = {
>> +		/*
>> +		 * The refs/notes/commit ref points to the tip of a
>> +		 * parallel commit history that adds metadata to commits
>> +		 * in the normal history. This branch can be overwritten
> 
> This is not "branch" but is a ref.

Thanks!

>> +		 * by the core.notesRef config variable or the
>> +		 * GIT_NOTES_REFS environment variable.
>> +		 */
>> +		.ref = "refs/notes/commit",
>> +		.exact = 1,
> 
> Allowing just "the default" to be replaced by another "custom
> default" is a good start, but we probably want to support more than
> one notes refs, to parallel how "struct display_notes_opt" has
> extra_notes_refs to allow multiple notes refs to decorate objects.

I imagine that if we allowed multiple notes refs, then we would need
to use a ref prefix to define a namespace. If we relaxed that, then
we could modify this as follows:

	.ref = "refs/notes/",
	/* .exact = 0, */

(The comment is included just to illustrate the change.)

There is additional logic in init_notes() to track multiple notes
refs, but the change to things that use ref_namespaces would be
minimal.

Thanks,
-Stolee
