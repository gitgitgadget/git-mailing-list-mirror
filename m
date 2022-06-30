Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE25C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiF3VPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiF3VPI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:15:08 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96F5326DE
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:15:07 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l6-20020a170902ec0600b0016a1fd93c28so228762pld.17
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=cMzLr4021NyFZJzaz328DinnI1ky9rT/jHmGscJGj2A=;
        b=fWo9XurU8pua+HNtdfxzu8+gnxNIjbonnYqkHPBQXrMnX93Lxbkf3OEMqxfbPma7CU
         StWV7W/7N6td/NYY6z67nq2hKhFMEJ/wV94+QXIEW68zFFf8b4hmOfXqPE9B+Vmj1JMi
         CUxh0bxhq2QKjfvZdt1MalMQvhucJT/Fr8H2xj1LsAw5PJXtQ57iw+IuvSXxCR1plGwo
         0crsEA+KRYVOE2vvrFK/2Vbit5SEv2v/4miWdmLVaMpzWOfmVCWPFpcvbb6pVdpRxHu6
         p+n37k2quh3gcPJroZAnf8CKIJahUSM25FKIOoC/WnDKU8U1aMFiSDMccd8+B5b7Imz/
         69xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=cMzLr4021NyFZJzaz328DinnI1ky9rT/jHmGscJGj2A=;
        b=WG6dAkkoVkAl8jdiSy2QMkSX7ulY80yHg9LecQsAxqUHchWCn+qKEJGBP1kiqGxRqE
         zGKi2xAsj0Mf6IFlA67aJ/qoUJYcMezWk7gM+HMfTBcBBX9tTBOTJjLS1jMCKoSNeoff
         2hHq6HL0rRkAo28GkAWfYewXYX4QyE5WUM8vIaKKrzBfTEOEM/pebzQ6/R405LRN5u4K
         MshAlTnBDFQ7O/qeAhXFE9VFjA/GmahcQkk6sl5jMq3EuWSHd9mm6zecg1aHFlZWKuKj
         5EfqLfNSde9u8HK6xio/p0SvdLx5r29ugefeQ917PoiLse1owyOnac78moTebMLbTaqK
         8RGg==
X-Gm-Message-State: AJIora8Wk8Kn1yIj/9nD83PjyaXVP33VTgjFOgXk++frMfdMv5JyzEjq
        YNmovCUcCH7ZRoTzPCdFuoDNFHMUM6YxPz2FacuD
X-Google-Smtp-Source: AGRyM1v9rHAg9P/AEKUPJLTHskRPbfMKg/ZpXt+qmBc72RnmKJ99SzhsU/QQeVUVG11z6m8GdKxijzw2S4muLsrNHa2d
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:7e86:b0:1ec:8606:b3c4 with
 SMTP id j6-20020a17090a7e8600b001ec8606b3c4mr13891557pjl.186.1656623707301;
 Thu, 30 Jun 2022 14:15:07 -0700 (PDT)
Date:   Thu, 30 Jun 2022 14:15:04 -0700
In-Reply-To: <Yr0OuwCyDot0wJjs@nand.local>
Message-Id: <20220630211504.2833463-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [RFC PATCH 0/4] move pruned objects to a separate repository
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> We don't usually do pruning GC's except during manual intervention or
> upon request through a support ticket. But when we do it is often
> infeasible to lock the entire network's push traffic and reference
> updates. So it is not an unheard of event to encounter the race that I
> described above.
> 
> The idea is that, at least for non-sensitive pruning, we would move the
> pruned objects to a separate repository and hold them there until we
> could run `git fsck` on the repository after pruning and verify that the
> repository is intact. If it is, then the expired.git repository can be
> emptied, too, permanently removing the pruned objects. If not, the
> expired.git repository then becomes a donor for the missing objects,
> which are used to heal the corrupt main repository. Once *that* is done,
> and fsck comes back clean, then the expired.git repository can be
> removed.

Thanks for the information. Presumably, during such pruning GCs (because
manual intervention was needed or because of a support ticket), you
would use a cruft expiration of "now", not something like "14 days ago".
If so, more on this specific case later...

> > I think there is at least one more alternative that should be
> > considered, though: since the cruft pack is unlikely to have its objects
> > "resurrected" (since the reason why they're there is because they are
> > unreachable), it is likely that the objects that are pruned are exactly
> > the same as those in the craft pack. So it would be more efficient to
> > just unconditionally rename the cruft pack to the backup destination.
> 
> This isn't quite right. The contents that are written into the
> expired.git repository is everything that *didn't* end up in the cruft
> pack.

I reread what I wrote and realized that I didn't give a good description
of what I was thinking. So hopefully this is a better one: I was
thinking of the case in which GC is regularly run on a repo, say, every
14 days with a 14-day expiration time. So on the first run you would
have:

  a1.pack      a2.pack (+ .mtime)
  Reachable    Unreachable (cruft pack)

and on the second run, assuming this patch set is in effect:

  b1.pack      b2.pack (+ .mtime)          expired.git/b3.pack
  Reachable    Unreachable (cruft pack)    In expired.git

and my idea was that it is very likely that a2.pack and
expired.git/b3.pack are the same, so I thought that a feature in which
cruft packs could be moved instead of deleted would be more efficient.

Going back to the specific case at the start of this email. I now see
that my idea wouldn't work in that specific case, because you would want
to generate expired.git packs from a repository that is unlikely to have
cruft packs (or, at least, it is unlikely that the existing cruft packs
match exactly what you would write in expired.git).

If it is likely that cruft pack(s) would only be written in one place
(whether in the same repository or in expired.git, but not both),
another design option would be to be able to tell Git where to write
cruft packs, but not give Git the ability to write cruft packs both to
the same repository and expired.git. (Unless in your use case, Taylor,
you envision that you would occasionally need to write cruft packs in
both places.) That would simplify the UI and the code a bit, but not by
much (this patch set, as written, is already elegantly written), so I
don't feel too strongly about it and I would be happy with the current
pattern.


