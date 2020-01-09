Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263AAC282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 23:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD880205F4
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 23:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnynxTIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgAIXWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:22:16 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37145 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 18:22:15 -0500
Received: by mail-vk1-f196.google.com with SMTP id b129so85902vka.4
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 15:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxWum4xinEjnkUZc9B4XBQU5BNUhjQc34FqK9t5WjLI=;
        b=fnynxTIe2Xd+te+sDv2zY7jK1cu2YIwlrrjkAQtYlWNN9vbHk6KBpNjvTvs3UXqeht
         n1hABqMaMENO9KDgjJDa8DeU75rGV0PERiu9V7H7X7w6jZr/CfjfBHrsfUCCv9Se3+bV
         53TBuV18EOiK9SI5b/pmj0EcTV1pinaOVI6WVUrgkhTX8f+pIB5an1ubJNMlyHyZQy7K
         ImeEt44AjXD1e4Ca84DrD9tXuSVauFWTZqI9kbUBSR/k6BVEM0hZfnMOmpaykGHA36Ja
         sD0FYWmjizlRrz4s2wNWfk1ee8pNPm+L9b7bew6cDCvQutE4ota+j3Z+Qp5QL3jkwSAc
         6dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxWum4xinEjnkUZc9B4XBQU5BNUhjQc34FqK9t5WjLI=;
        b=G6Y3zBMIEIecMWrczxivRAmMg3sd5P0qNv39BTSXbetAoYlhRkQVabLPgZv8bbKnKZ
         VuMZ9v7wohv5GBJNuDjA5JY9GYyFKehTzHPfOwA/TPC55CaIq0wyXM6H4qXNK9t3aaTP
         KVKMbbz4ezQvG88W6bV9GgeHhCUBHYPa8xtK4OGk/vU0NMF0LWX4X6rIlB68mp2nmwa2
         6KnqMXYAuzGkIAl2jHG6TfOKdr/mBYcLv5+E6unXcPOLh/4RPKNpJ/SgMYAN9aEzJKcQ
         qLSuK96aSqYn1MUCNOFehDzEBQBJ5ez6DA5F+kO+g7oBv3giiMHHylW2017WsLtMpY2l
         281w==
X-Gm-Message-State: APjAAAUM3e8ItyK7xiqwVtmA/g+Ycz1IWUeVOsK6f9GY5iyoWwhIUQJJ
        QQPK6U14zAdDwiS+1E+w4gaVTaYBBBnSoRbNay9l/w==
X-Google-Smtp-Source: APXvYqwZvoVBCqt+RN3hRPMx8eepV10HoJ62gOr5EdO9Sgmj6wJqGZgNanJQ6cY3uJcTfhIIWJocisJPDjYVfizReJc=
X-Received: by 2002:a1f:5fc1:: with SMTP id t184mr46090vkb.57.1578612134721;
 Thu, 09 Jan 2020 15:22:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
 <pull.478.v2.git.1578565001.gitgitgadget@gmail.com> <b40480f03a5643761bd06d4b9c495a99b98a1ac8.1578565001.git.gitgitgadget@gmail.com>
 <xmqqlfqgzbwp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfqgzbwp.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Thu, 9 Jan 2020 18:22:02 -0500
Message-ID: <CAOjrSZvj5ne2Cyt=X-dCntjy9-Hvwn_DJXMPGR83=dZHU8R=1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] config: fix typo in variable name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Malapropism is a new word in "git log" output in our history ;-)
>

Yeah, I remember my coworker saying that to me the day I wrote the
message and it was just stuck in my head
