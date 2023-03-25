Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB2EC7619A
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 09:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCYJRb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 25 Mar 2023 05:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjCYJR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 05:17:29 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59AE136F9
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 02:17:28 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so3802574pjt.5
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 02:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679735848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CI6pGGFe9e5yt1Dh4eq2RvRPdW5LctVPMrC15ncrv0=;
        b=yIEnqcOcV78M7Uoe25t03D4T8KlEH6SkpscGvfuBB3w0HXCsNOFWyyTOO3RCsMgY9a
         fzLuFPO59s3rr7bxKpp+7O/nLB4GIh3Y9ZXLd9xyjC7aNkfFUENIPtcO70T5E7CKlBbs
         zFWBwF4w0jZ7cH7JF7Rz+02NI5AQwkVDV3yzCOmN4ePCiIp/F7rDn3vwPU3XuO3vJ5PJ
         K7lf0erWSRYoXGv26gk6VTAR0yZLTXMziy7fFlLt/PQyPipdgWf6gM2/uOxrapliJ96Q
         GHAJd3AR/jnU87LCo9lEytVLXx0IMLzCUtcHPDWsSNnYbzZ4Wv2t4HP5N2rmmuU7fL3d
         k3SQ==
X-Gm-Message-State: AAQBX9d6ELcz3uFp+B0DvewO6V+qzyeEgl+e5cNhGJNMUo3oUgFqK7nU
        zS0FbO4k7arh84v4HetDC7DHcGUH3qpj+upuNRUtmM21dwM=
X-Google-Smtp-Source: AKy350b0P/nR9A3Popa/Wn5NH2VRmHiKpqki5hjCNROLkVfgNPNm0wHjq66+6orTn0K8MgxYJuwjodo5S0nDWpJN/Vc=
X-Received: by 2002:a17:902:da8e:b0:19f:28f4:1db with SMTP id
 j14-20020a170902da8e00b0019f28f401dbmr1911697plx.8.1679735848299; Sat, 25 Mar
 2023 02:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net> <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
 <20230325075832.GA579632@coredump.intra.peff.net> <20230325080453.GA852237@coredump.intra.peff.net>
 <CAPig+cTBwAugUL_u_SPebFRj4j1Gv6FMuH8vn+uUy=6_+GXy3A@mail.gmail.com> <20230325084107.GB3738217@coredump.intra.peff.net>
In-Reply-To: <20230325084107.GB3738217@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Mar 2023 05:17:17 -0400
Message-ID: <CAPig+cRfAARLWH7VoQfHbrSETGN-ZiS_d2PTF5J4Lrv3-o5k_w@mail.gmail.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 4:41 AM Jeff King <peff@peff.net> wrote:
> On Sat, Mar 25, 2023 at 04:18:54AM -0400, Eric Sunshine wrote:
> > This approach
> > does have the benefit that it gives at least _some_ protection (minus
> > caveats mentioned below) on platforms where it may be common to
> > disable chainlint.pl due to slowness, such as Windows.
>
> Certainly the output from chainlint.pl is much nicer, too. :) I think
> I'd be comfortable dropping the internal one at this point in terms of
> quality. The bigger question to me is whether there are setups where it
> isn't run (you mentioned Windows, but I'd have thought the
> single-process invocation made things nice and fast there).

It was my hope and intention that the single-process invocation would
be fast on Windows, but that proved not to be the case, and I've
pretty much given up hope that it will ever be fast on that platform.
Quoting from [1]:

    Somehow Windows manages to be unbelievably slow no matter what. I
    mentioned elsewhere ... that I tested on a five or six year old
    8-core dual-boot machine. Booted to Linux, running a single
    chainlint.pl invocation using all 8 cores to check all scripts in
    the project took under 1 second walltime. The same machine booted
    to Windows using all 8 cores took just under two minutes(!)
    walltime for the single Perl invocation to check all scripts in
    the project.

[1]: https://lore.kernel.org/git/CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com/
