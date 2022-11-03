Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C058C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 19:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKCTBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKCTBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 15:01:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BA9FD3C
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 12:01:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t62so2947999oib.12
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=topFTgR8eT74toOcuKqOU/Pq2089F5S4lSAbINLzP7k=;
        b=nWKZ4BP3axJFwu+R6NkcNKjXxwXnysg5tzQlZ9PMxTYgvhtmDjDfOppHA2/N6eca+G
         510Q1Uk94rtbAB5sKYzfdpWTszk79D+zJBAbIA8jFRskfP5mgvQKLGvjSoN+I+OeUGzH
         LGLIlM6FUJJRMgrS7efwKgPTbGYXd+yD6FRrNs//gpl2ZYakXI0NeEmVa5/RzyWQtzyN
         gaqz7RDrOwH0x1eoWMaK7AFl0G0drM3jI7/nYRq4YL0mqKMJOyYMRDR9nDjr/NPeTvA/
         GDdsUsubWMnqCgMVJvYHJo36wdmUA3JTdhjycewtLEtc9SJjAIAmPeWlYZFyXpjJ1JWd
         vNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=topFTgR8eT74toOcuKqOU/Pq2089F5S4lSAbINLzP7k=;
        b=d1kc0gcJ0E7m7siZdRtd9S66DQ1u1xLhQbD9t2K0zvP4jS7fpRtuW+iJZFQ8E7tYab
         o1e9OM3Ebk5MaHeUehTsQhVzZ9RV0nyKOnJsQUAEZK+5+DwIwLmuI+aKm0UNYj+xYFei
         iyFq2MYENtoPAD+jmyokqZDjKVhxhTBaQds80V56vJdKmlzKIGfYA5r9Rj4E0NDsYdsu
         EeS4Kfw8qoYCvDjPWSzsK+8y9QXVL9Ang48eoIL1FCKChJuP5Ee0FQgXTTgPMOjngiKs
         Tj5Gh2L/3aL+/bkGxDWURUOTThQ5c7WMb3lZrlEn5HEs1w+XFsI9tm+20yVt0wydSVGJ
         CfEQ==
X-Gm-Message-State: ACrzQf2AAZeMR4D1SONpLFEaP1etIgKR8YuidT6MKdj/YIMygytcn2/S
        0LrxiOtpbGe7gNA3dJ9SKGBYNXsPQiOaMkNME/U=
X-Google-Smtp-Source: AMsMyM7VLzTMcKJ/iPYAU+Tfae1N3t3MoP3BZ1USBdaI79S+qNxWU2vQPK4R0h7g/VUkxhdUh77QhiPoQbNLnXi4jmI=
X-Received: by 2002:a05:6808:11c1:b0:353:f1a5:207a with SMTP id
 p1-20020a05680811c100b00353f1a5207amr24912727oiv.183.1667502076299; Thu, 03
 Nov 2022 12:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com> <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Thu, 3 Nov 2022 19:00:37 +0000
Message-ID: <CAGJzqs=o2O+W=Uecu+TJ0Nuw7FsehocKu4Dyko2iKdz5HyiKrA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Enhance credential helper protocol to include
 auth headers
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2 Nov 2022 at 22:09, Matthew John Cheetham via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> `authtype`::
>
> Indicates the type of authentication scheme that should be used by Git.
> Credential helpers may reply to a request from Git with this attribute,
> such that subsequent authenticated requests include the correct
> `Authorization` header.
> If this attribute is not present, the default value is "Basic".
> Known values include "Basic", "Digest", and "Bearer".
> If an unknown value is provided, this is taken as the authentication
> scheme for the `Authorization` header, and the `password` field is
> used as the raw unencoded authorization parameters of the same header.

Do you have an example using authtype=Digest? Would the helper
populate the password field with the user's verbatim password or the
Digest challenge response? Put another way, is the Digest
challenge-response logic in Git (libcurl) or the helper?

https://www.rfc-editor.org/rfc/rfc7616#section-3.4
