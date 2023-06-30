Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE3EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 12:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjF3MU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 08:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjF3MU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 08:20:27 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9EE125
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 05:20:26 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-634efb81e8dso12781676d6.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688127625; x=1690719625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8tFML385nRULd+QBCMRzz/aS9T6InDQ0Hr/LwdoL7I=;
        b=nmncZI0j9C8IaavwdyPnWV7Sy7rIuZdXVuqWWbO9cMKf0p8Zcfu24WnzWPy8NiM0d4
         NzyCpZK49eS+BB3reBaNNwYjI6SqUa+nxZgI97XbTLrEys1JwEoOqTrWbrnQyqsJBN9r
         qu2CYrhuPZOgmoZFyvvHV64+D5zeydc6lg0hQR45T86bKbQSQj1BZYMMDIgDpQkIPoXK
         AvMiwhZma/w5+MCJKI+48nfQpw7eDakRGttMRA3CX/DoxsW64HYjNd5yCF3RRpb9ghKv
         26sO7LIzetHSBNueWNOuvY3J4CttoAAtn/pav6bM077dZXZ6XrMa5QumsZVk/0wPor++
         YEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688127626; x=1690719626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8tFML385nRULd+QBCMRzz/aS9T6InDQ0Hr/LwdoL7I=;
        b=FC/W2j8gYP3owFf9ZclsmMj1NJbNA2o706sVsPEZU6OjOkIDxw42ltAq5iEgsuihHp
         wPq42ZaRmhtKoUkBIT1pWsXikWwXHETMwbnWiXVY+XY7g9+Ig/GH0mN8WITfMzSehb2Z
         9+gqXhQLUNhm55i1BfNrCKvy3xAkm0+srtt47yHZaJWgT+Lek2pYjOHwaAynTqtOc9gE
         NUwEElyrAhwwYfeQHfy4+s91NsDJ3OuBIMTkahkS4WQlGXlcM3xIG+syErNZNaeQNV7g
         q7VRGk7847+bPuajpDppid2ed1RNJA+GlPh4ZNmFNctYP/R6ZS5jsfhT25u4VrK/xXzc
         DrNQ==
X-Gm-Message-State: ABy/qLZyc7hHPwrQzYUqr779imJFP29d2Fp5KCXItNqSEj+w22Bzaalm
        xDOSAJQTCAmG4o8OLzadxdligqP7q+YPyhtoRIC1G2uBYOQ=
X-Google-Smtp-Source: APBJJlFrR0RmNjs0mxDqqhSKrTzX0RkWEvo6CFVJoa0J6WthUNdFGqvAuDjkEEQOjz2tu0/narWuGvTEA3jr1EJwYF8=
X-Received: by 2002:ad4:5ec7:0:b0:635:33b0:f42e with SMTP id
 jm7-20020ad45ec7000000b0063533b0f42emr3645786qvb.29.1688127625655; Fri, 30
 Jun 2023 05:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <xmqqmt0iajww.fsf@gitster.g> <ZJ303bm+VAvp5nyV@tapette.crustytoothpaste.net>
 <xmqqa5wh9adg.fsf@gitster.g> <ZJ4uKYIZMxi3DHo3@tapette.crustytoothpaste.net>
 <vt3cizczmwbcpgktwrkr3jbiwhee37rt7m243hnkzxik7gt4m2@d2upsqoxtlgc> <5880fe56-aa98-64ce-4d91-ca078d3a7354@zombino.com>
In-Reply-To: <5880fe56-aa98-64ce-4d91-ca078d3a7354@zombino.com>
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Fri, 30 Jun 2023 14:20:14 +0200
Message-ID: <CAL3xRKfQLj7Zufy5fMMs=ykeexBn7duqFH1jZ84+WRKKOaEpFA@mail.gmail.com>
Subject: Re: SHA256 support not experimental, or?
To:     Adam Majer <adamm@zombino.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> On 30 Jun 2023, at 13:25, Adam Majer <adamm@zombino.com> wrote:...
> On 6/30/23 11:31, Patrick Steinhardt wrote:
...
> > In any case I'm fully supportive of relaxing the current warning. Except
> > for the recently discussed edge case where cloning empty repositories
> > didn't create a SHA256 repository I have found the SHA256 code to be
> > stable and working as advertised. We should caution people that many
> > services will not work with SHA256 yet though.
>
> That is exactly true. But this is also chicken-egg problem. Services are not adapted for sha256 repositories because there is simply no demand for them. Only when people will start using sha256 repos, will there be some demand generated.

FWIW, in the Bazel ecosystem where SHA256 is very popular, there has
been an increasing appetite for FUSE file system to lazily fetch contents
of a git repository.

Build tools such as Bazel would often need to hash the content of the
source files to build a dependency graph.  And in a FUSE setup, it would
be ideal if the FUSE server could supply the hash via an xattr, so that
FUSE client does not need to fetch the whole file content and only the
metadata.

Most tools in this space (Bazel, Buck2) are using SHA256 and are exploring
faster hash such as Blake3, Aegis, KangarooTwelve for larger file
support.  As these matured build tools gains popularity, so will the usage
of SHA256 (and newer hash algorithm).

Another point I think might help motivate different forges to
move would be switching from the object's hash to digest (hash and
file size).  The additional file size information would help tremendously
in predicting compute resources when serving files of a repository.

So I think Git would simply need a bit more time for these related
ecosystems to reach a critical mass and help fuel the transition to a
<new-hasher>.

> - Adam

Regards,
Son Luong.

References:

- https://buck2.build/docs/rfcs/drafts/digest-kinds/#use-cases
- https://github.com/bazelbuild/bazel/pull/18784
