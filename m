Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257C0C05027
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 02:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjBOCku (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjBOCks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 21:40:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1D32536
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o15so14347286wrc.9
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Gl8WivU5aB6xmutiyB91Wu0/QdLTNlx6gmvGl6ACzs=;
        b=eTVz36d0uSjQu++dDcBJny9QupsYE2SYuL8sFKQvUrmK268oeMVTlOUXyaZSyNYYK6
         PHLRpKQFX/xjdnbGFCWawU2D2coRVKYASvJ5PB2mBfISlgNtf6OA6Y5l/jkjOc0fVrxw
         QG2UxjQdV3MaIE+3eFPVWfWpWoJ/kSB+japGcA7iQ+ggMD3iQHUKPYJauH2nVG/Bam3C
         t4GY16mvoJFbdu343gzrjsFDrThCEfZjtOTlTignj0YkJ38s4dPLB9rwn+lTqcvbltoo
         XHI62enP8LIG+vPI3++pHLJBiVyRve91FJ75+WknrrUspvTo9bczrBJnwogi85pmqSmY
         Bgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gl8WivU5aB6xmutiyB91Wu0/QdLTNlx6gmvGl6ACzs=;
        b=0vj8H4IHg9ZgPmhaKyVIXUB3gRJLAXYVeeqH4bsLsCjKoE1VgH3GlNrcU7tBXIqVTM
         ifDf0AJPia+7j024jrZur8320hh7d6oMn7KMDv/iDBt8AkZk370XAUX0eVQgfT6lAsRn
         WG/qkERqZd31CbJ46vKCoxllFilUd5wOuema21N0JDSrr9r0kRAhRICa5YfpRw6IJLTG
         tYtDLjWgETGdqlOttasgxpPcUeoU4badKlS4uZKJ0yW53GeA9laNOiBy2dazIAyzIaEa
         55uhR9Xz3KPjHMDJ+yw9/93XyjYY8JGwBiB5aJQRFEksJLHX4nkvFdBNM+HsiXtIYwMC
         5Ong==
X-Gm-Message-State: AO0yUKVvWcirhhPKksHgPh2nSxX7d6+hJDef6PsvVUfLgfxmNDNH7ljY
        SqMeI6mBKXVl9EcAJWALdbEITeCDgd6JZppd1Fk=
X-Google-Smtp-Source: AK7set+nk9vQMvjeqPD7jjXOvDCviVZi3gY7WZ9jW1RrmkzTVxPytvMoIi58VmPp4JW+UbufubGuMhftYZCdB5FJpSo=
X-Received: by 2002:a5d:610d:0:b0:2c5:5877:386b with SMTP id
 v13-20020a5d610d000000b002c55877386bmr12911wrt.230.1676428846271; Tue, 14 Feb
 2023 18:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20230206211823.8651-1-cheskaqiqi@gmail.com> <20230209154417.10763-1-cheskaqiqi@gmail.com>
 <20230209154417.10763-4-cheskaqiqi@gmail.com> <CAPig+cTKCMwCQ2TxXyc1KquZmB0QWQAuuag52a1qmeYh6XPXYQ@mail.gmail.com>
In-Reply-To: <CAPig+cTKCMwCQ2TxXyc1KquZmB0QWQAuuag52a1qmeYh6XPXYQ@mail.gmail.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Tue, 14 Feb 2023 21:40:33 -0500
Message-ID: <CAMO4yUHx68jSe31gKon6_hXTiqufHnHAFkP32DXmWg7dtagAfQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] t4113: put executable lines to test_expect_success
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 8:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:

> Although it's true that t/README explains why code should be placed
> inside tests, you can help readers out by simply explaining the reason
> here in the commit message. For instance, you might replace the above
> paragraph with:
>
>     Some old test scripts have setup code outside of tests. This
>     is problematic since any failures of the setup code will go
>     unnoticed. Therefore, move setup code into the tests themselves
>     so that failures are properly flagged.
>
Thanks, that really makes the change more clear for the readers. I learn a lot.

> Reviewers appreciate well-explained commit messages, but they also
> appreciate succinctness. Although it may not always be obvious how
> much to write in a commit message, you can assume that reviewers will
> understand obvious changes simply by reading the patch itself, thus
> you don't need to mention every little detail in the commit message.
> The important thing to mention in the commit message is the
> explanation of _why_ the change is being made, plus any changes which
> might not be obvious. In this case, all the changes are obvious, so,
> really, you can collapse this entire commit message to just the first
> paragraph.

Yeah, the commit looks very wordy. I'll make it more succinct.
>     test_write_lines a b c >file &&

> Same comment about simply using double quotes instead of
> single-quotes, however, this is also another really good place to use
> test_write_lines:
>
>     test_write_lines a b c >file &&

Thanks for the tips!

(Sorry for sending the V6 to you twice I send it by accident .)

-------------------------
Thanks
Shuqi
