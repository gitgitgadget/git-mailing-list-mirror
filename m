Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C507EC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 23:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiARXlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 18:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiARXlY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 18:41:24 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0DBC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 15:41:24 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ft15-20020a17090b0f8f00b001b4f9b64cc7so319836pjb.8
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 15:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4diH9q7nL/zhoWVOEsofcX+NNWkOakAAAt4Dcq2PDH0=;
        b=jWbPiyCytV1lMC7SuFTGu6U97GTpFoe2eUt5Ow5amRE/Jq1N4rS52yamTMibuG1owO
         DNDoY75GB3q1MarSQgEn5xp9EYRtjG3FR/IQQJ6oO+0nR+a8MgtCom67JlnvN3DHGgf6
         2YfKfX82gZSNrP0f+Ds7HqqmXpKj0InSEF+0FvTrcXl8kPSZ9mxVHLBWKxFm9//Mhc2u
         FXMeWAVmllJv2K/HY0VV6E//kMhOouoQDcmbQQUpqTp2xNtMVCqQbc/BDCATXbbDZm8T
         n30/wpeZ5MsO967jx+O4rjd9/7xEezBx2R/F50J0pWGUW7lO8VxL4HJQOaWLbM21HpFG
         owYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4diH9q7nL/zhoWVOEsofcX+NNWkOakAAAt4Dcq2PDH0=;
        b=421kXdUL5xC6X87V1nfHiTBpc/PP5ZV6t4RqGZza5ur9mTw8eh856FdwyAg4hggwCh
         sCNblE1koHafPRz0BCIttjO6YnwggWMF0W8cgZ3R+vRA/8sITsrVbh0Dl+U90EWEC8vR
         kYqKBRax/BMnzFEo8fgjfgbR6b4ptbJo6up2vOPhMHnXOZ3QYARlsxCTuKNHR5OGCzF6
         GQAqKoa2GIN6JyBUZgL2TGF5r03F1dDvAomPkEZoZg5kOhjHJ9rP4KYKp3v3O7jfZ/Mi
         yMkQepECJMOX+RK0hb24A/r7c9JN9C3Y6wRj1tTIZf3imXNwXvJIPiVCBVvvcSWmGxyh
         7VdA==
X-Gm-Message-State: AOAM530H5a4QW8QScCSMuwvtsJCR0fbAWqxSQg4RZcXrFPzoq6Dszd+d
        NBHgj9Xu5P50LfrBLlRwx+8Lw/JwqmaoTg==
X-Google-Smtp-Source: ABdhPJxB6hmNNW1kp5YWDnWHU5npi6goW1y7X1qE41Ysugc1UjL4WKPOUEw3mgta+MpycAAgmdafIRSwF6VfWA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:d154:: with SMTP id
 t20mr1092239pjw.43.1642549283872; Tue, 18 Jan 2022 15:41:23 -0800 (PST)
Date:   Tue, 18 Jan 2022 15:41:21 -0800
In-Reply-To: <xmqqtue0r978.fsf@gitster.g>
Message-Id: <kl6lpmooy5lq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220113004501.78822-1-chooglen@google.com> <20220118185453.33710-1-chooglen@google.com>
 <20220118185453.33710-4-chooglen@google.com> <xmqqtue0r978.fsf@gitster.g>
Subject: Re: [PATCH v5 3/3] fetch --negotiate-only: do not update submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> +	if (negotiate_only)
>> +		switch (recurse_submodules_cli) {
>> +		case RECURSE_SUBMODULES_OFF:
>> +		case RECURSE_SUBMODULES_DEFAULT: {
>> +			/*
>> +			 * --negotiate-only should never recurse into
>> +			 * submodules. Skip it by setting recurse_submodules to
>> +			 * RECURSE_SUBMODULES_OFF.
>> +			 */
>> +			recurse_submodules = RECURSE_SUBMODULES_OFF;
>> +			break;
>> +		}
>> +		default:
>> +			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
>> +		}
>
> I think that this part has the only difference since the previous
> round, but I am puzzled about it.  Everything else looks as good as
> the previous round was.
>
> I did not (and I do not) mind the block for the body of this if
> statement.  Even though technically a single switch() statement
> makes a single statement block that does not need {} around, it is
> large enough that extra {} around (which you had in the previous
> round) may make it clear where the body begins and ends.

Yes, that makes sense. This was why I added it initially.

> But do we really need the extra block _inside_ the switch statement?
> IOW I would have expected to see this instead:
>
> 		switch (recurse_submodules_cli) {
> 		case RECURSE_SUBMODULES_OFF:
> 		case RECURSE_SUBMODULES_DEFAULT:
> 			/*
> 			 * --negotiate-only should never recurse into
> 			 * submodules. Skip it by setting recurse_submodules to
> 			 * RECURSE_SUBMODULES_OFF.
> 			 */
> 			recurse_submodules = RECURSE_SUBMODULES_OFF;
> 			break;
> 		default:
> 			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
> 		}
>
> Thanks.

Ah, I misunderstood. I'll blame the fact that I'm recovering from
COVID ;) I'll remove the block from the "case".
