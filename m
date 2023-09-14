Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3AEEE021A
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 02:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjINClf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 22:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjINCle (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 22:41:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B8CE4
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 19:41:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7e81a07ea3so590300276.2
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 19:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694659289; x=1695264089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYlK8XLV9+HHd1iomgvecQsq/UF24iXGX3DFUrsFrBA=;
        b=ngN0ax46sgTpGfKZRiHJeWHytvj7z+D+D5Zg7YMyKQ4utXS5xlveupYh5iJTTxsSlO
         RdGP0ybr0HX77oebjZuzMLqR9KoWqttPLs4t9Fh2E0HDE73NYAucOVF6Yly+ogn3UgPs
         /gqJmJtP+laeW/ZuSG7dbfA5jV3+ujhwKGE2W0dpBjy671xSABz6I4+2J0wGYtRM0jpr
         8hEAzVQcKMMYz0fFrjZUPmxVTtBra6GMSl6vbSrTCnBfbopp3aJfjJbFnyIX32oeb9Q3
         oq0dIMYRQhMj+w9m9spJoelDecvJlqnDVlTKDhKu3HTONg7H4HNpkD6Nb3Vlfbwos9mO
         rBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694659289; x=1695264089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYlK8XLV9+HHd1iomgvecQsq/UF24iXGX3DFUrsFrBA=;
        b=tCL2j2RacwdYZkgJBn6EMVCNNPWe/D2YmJbb1hDYoSCZUpmIEOLUDZ2SOFpSushbeE
         QjQpZhGp15VpXoo03zjaldj651urHcvZkcbscsCOIoSJBE1ZuOoFPhjVKiuOhnQ2ChN/
         VeSxjoj7BwbNimQgKHJRZ76UNDhyDUaM+WOLk8Hxl4jtABuTU6BFLOoCLRq0GblqAeuH
         tmxy+K34o/z77SM/5OrKEBe3fdG/F5rUIFh73rHCLBMH6ThNEA9rtHrme1QCsezNQmUf
         rrfgmKNPPmEG2h6athVfNFLJUbO9CvDFB1bUnocktE/AmBUj+5oQWHCbSKjyxB3HQAm6
         OKOA==
X-Gm-Message-State: AOJu0Yypy6kfh1FgEU0Lz/cw0alKPNh2Db5J3L7dCXgeaoag9WT0bn39
        UwOxFNw4ZWyPKU5Wae+oa9OHVr2xCLQ=
X-Google-Smtp-Source: AGHT+IEDo2GZMG59WP5+Xo5DnClaBONh2cY6RWvYSeCrAI/PYaIlw7R9ubwlNUhfRXU0Gu8eWqRiSpbE+t4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:738c:0:b0:d81:43c7:61ed with SMTP id
 o134-20020a25738c000000b00d8143c761edmr114623ybc.5.1694659289547; Wed, 13 Sep
 2023 19:41:29 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:41:28 -0700
In-Reply-To: <xmqqr0n4v8ul.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com> <52958c3557c34992df59e9c10f098f457526702c.1694240177.git.gitgitgadget@gmail.com>
 <xmqqr0n4v8ul.fsf@gitster.g>
Message-ID: <owlyzg1pjx2f.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 5/6] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> [...]
>> So instead of using "*_DEFAULT", use "*_UNSPECIFIED" because this
>> signals to the reader that the *_UNSPECIFIED value by itself carries no
>> meaning (it's a zero value and by itself does not "default" to anything,
>> necessitating the need to have some other way of getting to a useful
>> value).
>
> It gets tempting to initialize a variable to the default and arrange
> the rest of the system so that the variable set to the default
> triggers the default activity.  Such an obvious solution however
> cannot be used when (1) being left unspecified to use the default
> value and (2) explicitly set by the user to a value that happens to
> be the same as the default have to behave differently.  I am not
> sure if that applies to the trailers system, though.
>
> Thanks.

I get the feeling that you wrote the "Such an obvious ... differently"
sentence after writing the last sentence in that paragraph, because when
you say

    I am not
    sure if that applies to the trailers system, though.

I read the "that" (emphasis added) in there as referring to the solution
described in the first sentence, and not the conditions (1) and (2) you
enumerated. IOW, you are OK with this patch.

Am I parsing your paragraph correctly?

> PS.  Glen's old e-mail address is no longer valid and there is no
> forwarding done by @google.com mailservers, it seems.  Can you tell
> GGG to drop the address (optionally replace it with his new address)?

Thanks for catching this. I've updated the GGG PR [1] to use Glen's new
address.

[1] https://github.com/gitgitgadget/git/pull/1563#issue-1837440424
