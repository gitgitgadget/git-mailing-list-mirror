Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFFCC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 02:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJRCis (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJRCir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 22:38:47 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601688049F
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 19:38:46 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id u2so6824771ilv.6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiO44qrtNZ+g2co7qjqj19P4w5Ebr0oplNAaUfIOBsA=;
        b=IlkV4Xo7fBCQZTodgMBYVGrQs8322vB0tnxvHMkuldEwD7mOQurIVIRJ9Dz14RAvba
         uL+vFZ/dKJlAdmFloNEkMguAnGbBylkK6x4zNUWpWVpeQP+jZydRsZAD8ue59ZMZ46Zk
         cm1JckcrYoryTrsnH9gABmtbcpBIy6e2eSaFxROjP3WO/elplXB2eqjkx3hV58i8Irug
         nEnvq0crm6P15Pmf+GF5NMy694aTJxthhjQD6soVVeFisgascUtcZjsu5GP/WV+O/8mr
         CxmzFLNppnX/abBwCib94hHbuJjouETIHepmzdXBA77UU5EhpPZ34aMJJiTAOuCHB0at
         /Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiO44qrtNZ+g2co7qjqj19P4w5Ebr0oplNAaUfIOBsA=;
        b=wSHgYuDeHzFNwfHUq+Yzs0Bns/1sT5ChG4Z65uls6+wHhB5yilnOuun6NDPLFQJIn2
         0feeiwjd58UUT6SSKZcL5Kd1vNoZK07oewm9fGvUV7Am3BR/kyiLvQhGGzCHo6YZ8Gqh
         MyKbIm6obLZnriagwEMxQKYjvccwsWGsEE23TK3Rvz0kfb0fk6gzmbS9aoW/vYy8YG5B
         Qk7obvyVtVxiy6FIg6f6xMdZiq0zXIRHELFW9hyg5p1C4OuLAMLGSVb9DJkBsQynjjXF
         /4siM0sN0f8bDsfz49ResVib3TcY8spJnnmj9lJjNIASeTXrUcp3E/Z3lt/N4n5GXsjc
         0SDQ==
X-Gm-Message-State: ACrzQf0PINa9A4t5GSpFpsI936AAdNwERXTnOUVsQnmhNDh4/QkvkaJG
        e4dTUiyjMSfSjoAZqm4OIQiqQ8Ne0105Ycj8
X-Google-Smtp-Source: AMsMyM61UUvpm/LckVGVaLsh0eviTXsAZvEUdhMtmdWQuY/7nxsACS0toruNn5sFiV2xRtQVegcBUw==
X-Received: by 2002:a92:2a03:0:b0:2fa:16e3:1833 with SMTP id r3-20020a922a03000000b002fa16e31833mr719723ile.286.1666060725545;
        Mon, 17 Oct 2022 19:38:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e4-20020a056602044400b006bc0f8e18d4sm569869iov.34.2022.10.17.19.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:38:45 -0700 (PDT)
Date:   Mon, 17 Oct 2022 22:38:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com,
        gitster@pobox.com
Subject: Re: [PATCH] builtin/repack.c: remove redundant pack-based bitmaps
Message-ID: <Y04Rs7V4IpkFtKWC@nand.local>
References: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
 <Y02YzYS172skpbAb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y02YzYS172skpbAb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 02:02:53PM -0400, Jeff King wrote:
> On Wed, Oct 12, 2022 at 03:05:33PM -0400, Taylor Blau wrote:
>
> > When we write a MIDX bitmap after repacking, it is possible that the
> > repository would be left in a state with both pack- and multi-pack
> > reachability bitmaps.
> >
> > This can occur, for instance, if a pack that was kept (either by having
> > a .keep file, or during a geometric repack in which it is not rolled up)
> > has a bitmap file, and the repack wrote a multi-pack index and bitmap.
> >
> > When loading a reachability bitmap for the repository, the multi-pack
> > one is always preferred, so the pack-based one is redundant. Let's
> > remove it unconditionally, even if '-d' isn't passed, since there is no
> > practical reason to keep both around. The patch below does just that.
>
> Yeah, this is certainly a reasonable thing to be doing. I wonder if you
> want to share the story of why the original midx-bitmap series did not
> include this patch. It is (IMHO, at least) an interesting debugging
> tale.

Sure, though note that this is a mystery that plague me on-and-off for a
year or so before finally figuring it out ;-).

When we initially deployed MIDX bitmaps at GitHub, I held back this
patch as a recovery mechanism (ie., if something was horribly broken
with MIDX bitmaps, we could quickly deploy a patch to stop reading them,
knowing that the existing pack bitmaps were still around).

After a while building up confidence in the MIDX bitmaps implementation,
I wrote something that resembles the patch here and deployed it. No big
deal, right?

Wrong. The "total time spent running `git repack`" metrics started
ticking up. But the metrics ticked up even in hosts and sites that had
not yet received the patch. Huh?

This led to many of the trace2 regions in midx.c that I recently[1, 2]
sent. But after deploying that patch and reverting it over and over
again, nothing in the trace2 metrics ended up yielding a satisfying
answer.

I spent a few days trying to debug the issue but didn't make any
progress. I confirmed that, yes, we were indeed reading MIDX bitmaps and
not relying on the pack-based bitmaps for some weird reason. And after I
confirmed that, I set the bug aside to work on other things, and mostly
forgot about it.

But in an unrelated incident, a colleague of mine noted a bug in a
GitHub-internal program called `git-get-unpacked-size`. The output of
this program is the number of bytes in non-bitmapped packs, and it's
used as a heuristic to help us pick repository networks to repack
roughly in order of "most non-repacked bytes".

The bug in `get-unpacked-size` was that we were including the size of
the cruft pack, meaning that certain networks would get scheduled much
more often. But in fixing that bug, I noticed that packs in the MIDX
would also get counted against our unpacked size.

So I wrote the minimal fix to fix the cruft pack bug, and noted the MIDX
issue for another day. When we did come back to it (I say "we", since
Victoria Dye implemented the actual fix), I suggested that we ignore any
packs that appear in a MIDX from the unpacked size, since we only write
a MIDX after repacking a repository.

When we did so, I suspected that it might inadvertently solve the original mystery. It did, and here's why.

Individual maintenance runs did not get slower when removing redundant
pack bitmaps. But because removing the .bitmap file causes that pack to
be counted towards a repository's total unpacked size, it biases
scheduling towards larger repositories (which have bigger packs, and
therefore a more inflated overall size). So we weren't slowing anything
down, just doing a slightly more expensive maintenance (on bigger
repositories) slightly more often. This explained not only the uptick,
but why the effect was so resistant to measuring.

It also explained why we saw the same effect when removing pack bitmaps
with MIDX bitmaps deployed to a single site only: whenever `git
get-unpacked-size` ran on a replica that *did* have the new code, the
unpacked-size count would get inflated. That explains why we saw
maintenance times tick up outside of our testing site.

So, that's the story :-).

[1]: https://lore.kernel.org/git/dc50527d99680fb0ff1f3240531105badaa221dc.1665612094.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/dd5ceb1ec3c01e8a2af55130718fff0b5eaf2de0.1665612094.git.me@ttaylorr.com/

Thanks,
Taylor
