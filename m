Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0A12022D
	for <e@80x24.org>; Fri, 24 Feb 2017 00:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbdBXAMe (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 19:12:34 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35402 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbdBXAMD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 19:12:03 -0500
Received: by mail-oi0-f49.google.com with SMTP id 62so3679716oih.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 16:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+i+at+yyePfXlRqMEC9j4iW4r95vokX1dNzQG1jIN8Q=;
        b=Ucjgk9hyP3sA7xsqvA/ya8VnegGAyKQ62uisywOoeDoV6etwybcYHIcZEzYranEVZm
         i6cqA/LJNOf9sdx6LFNTKnUm2wIjW4vlgDLHf3YtqYn4/93TQGn7JIiSgu+IWEylln3C
         iPuZUPhMn1BzZ5PVGxOlhRs/jOeyFtpCP+Ihll7Ce/LVcMLdFWroMPNP4stSLyfw8mxc
         GPRxevk5DCoS0DY+pWv7wtzUEiXKFy0+i3VMrdb1kBEh/emyNJmg96MuSbzta0yZ0df4
         HZDSXz86bEpfOFSsUqZ/AumjwWn7yS3kq4AvxeL9+cj5ZzxldEY8Te+OQxl6JXC29vN5
         vmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+i+at+yyePfXlRqMEC9j4iW4r95vokX1dNzQG1jIN8Q=;
        b=mA0gbn0hIu7ot4BkYDkGrL9dOgD6X8VB310Ynqr3pJVnbvde3f0e5RaSih8s8UBD6o
         dUzaNByJoLQXz3xbIoCGIOABd1DA3xwyGEDl//4go3wV2ppjDyrCXWRLfPUk4K8FYodN
         llq0cu7ddLbrjIwyZe+qaJrt8TWwD1dhPGwjlZxY7lNSoYaMkH2CtjeOGIcqF0bHntQK
         BHx9bLVTVUbtH3AoJ5RdoZ4iRSKy+XayLBxB3GajFg626O1ae0jTWfDCE+M6XZayvkM2
         2sBX4GrnCVFrtfUcP29zvx3dqiFQi1rj+KKxJI+9XlJhsgKWvBJfDuL3/us6aBriUpVy
         bTPA==
X-Gm-Message-State: AMke39kMWJVHQtEzSYKzpV1iMevQI8dYjjSA6Cz+qF5/Jqhe7Qlb788tmh3dOo9otHdCRCXGM2YMbsfqMyTnIg==
X-Received: by 10.202.207.134 with SMTP id f128mr11923636oig.55.1487895122291;
 Thu, 23 Feb 2017 16:12:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 16:12:01 -0800 (PST)
In-Reply-To: <20170224000143.cate5yncjq74hsys@sigill.intra.peff.net>
References: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <20170223230536.tdmtsn46e4lnrimx@sigill.intra.peff.net> <CAGZ79kZHPdBTKEqJeAa5xDcsC5v9x4DdUuDOiRNSgOV5aCx9Kw@mail.gmail.com>
 <20170224000143.cate5yncjq74hsys@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 16:12:01 -0800
X-Google-Sender-Auth: kzulfs71abiXE-iaVraK8r9MV3E
Message-ID: <CA+55aFx4gXEXqr-z12E4gz5fm2fye-vVio_Td7EbKxymGF2QUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] add collision-detecting sha1 implementation
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 4:01 PM, Jeff King <peff@peff.net> wrote:
>
> You know, I didn't even look at the LICENSE file, since it said MIT and
> had a link here. It would be trivial to copy it over, too, of course.

You should do it. It's just good to be careful and clear with
licenses, and the license text does require that the copyright notice
and permission file should be included in copies.

My patch did it. "Pats self on head".

             Linus

PS. And just to be polite, we should probably also just cc at least
Marc Stevens and Dan Shumow if we take that patch further. Their email
addresses are in the that LICENSE.txt file.
