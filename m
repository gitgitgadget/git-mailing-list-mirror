Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09115C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiIGSga (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIGSg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:36:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD03BCCC8
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:36:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l65so15482441pfl.8
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=49B9XlNy5E5tvM+NH2xL3KsuwCy/E3efph2owkRcwIY=;
        b=Hish8vNBuYcl55lq4apLSHRLHX+/Fk8HWc6rLrPtrZUt0EbOhEcTAfIOJAv7R3PwUp
         aKn9LIpsWIeSPDXG/19ROwW9nhPCNqmV4QCWag0JC2mO0FCCRGaGN8MAHiX4b8ei4rXb
         1v5rpDVNyD2N4C7kAeduDNAXDf0eb6Ahk3AITrL+8+/qU3jkcfthkHfvqlgI3wjqmGIq
         4YeSqVSRd9q2Aq04TmDhzL0HECC2hg/vfkxLle7Fx6FkTGbPEaPcN9kK5T9dM4a/8viF
         6AH1kAKFLgiARXzLYA9Ev3vIATs0jn+P/komUvm4klE/1rigzqAscETyMj9LjelAQcpK
         2UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=49B9XlNy5E5tvM+NH2xL3KsuwCy/E3efph2owkRcwIY=;
        b=cH6+SdJiWCF4FBVhkfvRWvUUcrOQcktxpf+3miTS1o9F9H5jytBho/hw/+x9lzQDDN
         r+C18KRvm5rxr6oIv1A5vAmh+By0Snirf6Uqf+lVPfbM2qU5qZLVzNtGlwbN7X6FlujY
         a5QOCCTSKIxXz90sXhi3FwL3DVpfFhxOkGifJUaizIX9os/n0+LHhNionGCi/2s66RN6
         LIF1QouZKwxZbf4ydR3rjxzeHx7NaouUaXxPjlKATaAA0L2jtaIfaSL7KpXsabNF2RTQ
         OrsF6lgi2HNaYp5xgll1K4zDRwa5EKz+hpHj9IDLV6Ut5hCEPeIAco9vb0Q408RpnUqu
         5xhg==
X-Gm-Message-State: ACgBeo2djnpopfAVjvt3h973W8JEYxFAkxQrefv39TL3YHoZg9N6XecB
        5sT1ImryFhWLFnTF7BO1SQc=
X-Google-Smtp-Source: AA6agR69HaBPMBHQpR72dutS3BYpjSbUSixecZR+RCU9f+iDXG84f4NC9sjgD+L5E24dLhQHLW3N7A==
X-Received: by 2002:a05:6a00:e8f:b0:536:c98e:8307 with SMTP id bo15-20020a056a000e8f00b00536c98e8307mr5121455pfb.73.1662575786430;
        Wed, 07 Sep 2022 11:36:26 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id bj9-20020a056a02018900b0041bcd8f3958sm10885970pgb.44.2022.09.07.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:36:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        avarab@gmail.com, l.s.r@web.de
Subject: Re: [PATCH v2 2/2] format-patch: warn if commit msg contains a
 patch delimiter
References: <cover.1662559356.git.matheus.bernardino@usp.br>
        <a2c4514aa03657f3b1d822efe3dd630713287ee6.1662559356.git.matheus.bernardino@usp.br>
        <4d750ff2-9df5-504f-9972-59b082000db0@gmail.com>
Date:   Wed, 07 Sep 2022 11:36:25 -0700
In-Reply-To: <4d750ff2-9df5-504f-9972-59b082000db0@gmail.com> (Phillip Wood's
        message of "Wed, 7 Sep 2022 19:09:05 +0100")
Message-ID: <xmqqa67buj4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Matheus
>
> On 07/09/2022 15:44, Matheus Tavares wrote:
>> When applying a patch, `git am` looks for special delimiter strings
>> (such as "---") to know where the message ends and the actual diff
>> starts. If one of these strings appears in the commit message itself,
>> `am` might get confused and fail to apply the patch properly. This has
>> already caused inconveniences in the past [1][2]. To help avoid such
>> problem, let's make `git format-patch` warn on commit messages
>> containing one of the said strings.
>
> Thanks for working on this, having a warning for this is a useful
> addition. If the user embeds a diff in their commit message then they
> will receive three warnings
>
> warning: commit message has a patch delimiter: 'diff --git a/file b/file'
> warning: commit message has a patch delimiter: '--- file'
> warning: git am might fail to apply this patch. Consider indenting the
> offending lines.
>
> I guess it's helpful to show all the lines that are considered
> delimiters but it gets quite noisy.

True.  I wonder if automatically indenting these lines is an option ;-)

>> +
>> +	if (found_delimiter) {
>> +		warning(_("git am might fail to apply this patch. "
>> +			  "Consider indenting the offending lines."));
>
> The message says the patch might fail to apply, but isn't it
> guaranteed to fail?

Worse is it may apply a wrong thing (i.e. an illustration patch in
the proposed log message gets applied and committed with a truncated
log message).
