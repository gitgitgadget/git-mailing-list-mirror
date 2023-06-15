Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B282FEB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 03:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbjFODDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 23:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbjFODDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 23:03:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51226A9
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 20:03:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb78a3daaso1620451276.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 20:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686798188; x=1689390188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lU/n0ZcAOk08/vj8CExcytkriiLTte265UVa3cudcdY=;
        b=m+gbraS4rkW9+jA1YWQYehi8kjyyihoXY81IkB86J58ccKXmpMjWfDpIPVSuuKCCRk
         cModVW+sDn+PbxqBN87rbr2uLkhcZqYz6K8hO7Z7SYSdGPyh/v0bhiAGaziaA/GyBBrb
         Vj/BibbyY/KnEYadZY01oMBO3vd+ELOugH6jDILdeI+oH6v/1/FVi1ZLdrUbdIrm8JE5
         a2OUFXgg9e6KXbTDRrvsawjgoWPCGTrWk+GOjLyU0VnK6SnfWTxPB05zQNuu0XCNCqDJ
         O9IV56ou9zgVJJYgTJNgBJcSxsOMLulJoZJX1UwanoZi6A0sF4U+AMp4fQRBj3TlMaVr
         LgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686798188; x=1689390188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU/n0ZcAOk08/vj8CExcytkriiLTte265UVa3cudcdY=;
        b=W8KhRWfNDSACnkCzCFWVG4vNsQJ9S4/aURfQKQEM3O6bTQszOVvceZp371fpEYgWjb
         mlg9YT0luiLShDyv1wr1hfY5zq0nICciDik7m8g5DDS7VZIiwPMcXkZ0qYzHbRRxMv0T
         SmtE9OFg7NCG7WidcuMj0IkOG6Mn3fkAlWnBxvJub2INQDX0xiHnlxQRx/sf3aFrnxJc
         LlAh2KXFcjlgM9y7MOhM71hcQzRBD3mmjuBLMHdSZm/VsiaZ276zs5NpzfuqdG6XLj3T
         NAxG3ty6ayaG8szbGRMNKu04lmjRNPkiyn5xX0oNUGGbHJTvLCd6oo5dCydCQbE6qiFb
         wdig==
X-Gm-Message-State: AC+VfDwwIruE/fnu1UdAmQ9fPWxUFAO5eFbOlZ3yBgrt8PO3JXWoDvDl
        KMyjkWH/Jk7negfTuqy1z522YBhtITM=
X-Google-Smtp-Source: ACHHUZ4UiOLZzm6P01FrryVFcJDMFkPPI0eVMqIgy+4Wz9BZHufOO36GshhfCxmCtt+TaHfuJYamU/ttcUQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:69ce:0:b0:bd1:7934:b4fe with SMTP id
 e197-20020a2569ce000000b00bd17934b4femr1597137ybc.13.1686798188028; Wed, 14
 Jun 2023 20:03:08 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:03:06 -0700
In-Reply-To: <CAP8UFD30qxHdyeOKXOuP7cE-9VB4f2mLWB2DLZz2Vskwt4QBDw@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
 <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com> <52f7d29f509070a17a32a6f1c888588cc87e6cb9.1686017304.git.gitgitgadget@gmail.com>
 <CAP8UFD30qxHdyeOKXOuP7cE-9VB4f2mLWB2DLZz2Vskwt4QBDw@mail.gmail.com>
Message-ID: <owlyilbpo2ad.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 4/9] doc: trailer: examples: avoid the word "message"
 by itself
From:   Linus Arver <linusa@google.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>>   $ git config trailer.sign.key "Signed-off-by"
>>   $ cat msg.txt
>>   subject

>> -message
>> +Lorem ipsum dolor sit amet, consectetur adipiscing elit.

> I am not sure this change is clarifying anything. If you want
> something clearer for "internal body text inside the commit message",
> you could perhaps just use "body" or "body text".

> I am not against using such latin words, but then why only in the body
> and not in the subject too? And if it's used in the subject too, then
> I am not sure it will make it easy for users to understand that the
> example is using a simple commit message.

I can't remember why I didn't just use "body text", which I agree is
better than the (albeit famous) Latin phrase. It's shorter, simpler, and
also search-friendly (for cases where the user is not sure of exactly
which word they want to search for). Updated in v4 to use "body
text".
