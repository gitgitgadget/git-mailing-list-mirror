Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7650EC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 19:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbiASTiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 14:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiASTiF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 14:38:05 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7AEC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 11:38:05 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id v17so3133620ilg.4
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 11:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QJ9kbnR8Kk/18Bc1lvs2jkSxI3EWFk6zrsao9GQQvZs=;
        b=gYB+mXqX/h9FvrAcUagRyGJkUf2nnElwWZjeI1yOHAcmCCggGYmwJ7bBt5U/RhWYDZ
         sqNRryMK5oErqd2BnQtdwz4HOVoNxYZ7r0EJgIzXy5f2/h+svbvRVyOE+1mniJl1GXGc
         teRslmnhEgcaIlWo81Krr7q7tptfxv9pvyG/7dQ/vWeFw0MwSD+G/l2fk+2lEWGR+u+G
         sCisYPMr8U55a3qlAZbweZiODHpi+Mjyv9VNdlqGh815K0GLkxyZpJw2ZiRfvYUe1dyO
         Mu2Ox0nWDRLlfF1QcIt/dVmlmReashiMAmhVUcy0/UZRos18IqLkbc+4iix8YmjV1weD
         3htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QJ9kbnR8Kk/18Bc1lvs2jkSxI3EWFk6zrsao9GQQvZs=;
        b=mfzGz4Qktbx3iSI0oFv6axZXeDy0ajRIfBscKU+fmPc4KNI+C03yrzKCSg8dC1bamf
         vA5bS3xES0IIF3SWwHddd9XnqKUWGZkEpxaaxPChqK0u29HdW6nlBzt1n8CIjwZAVMb+
         Hg4UPCM+wjG/p7RIFuuwlFCg6RsQZ4zfujmqQ1PiHRiTsBEdmaip/fXitKVQGfuTO/WT
         o+qmpcJIkWs2WAGnp0g1xhs13Eb8IcSzYteTEc4mY5OHvSKXuhTkukgpqTGI8Ja3BmRp
         oH3bb49QAKQCCsrYYRXc9+of0pqcxrLNx44Sx/erUPK3KiVDwDPE+8jzm26XZBM2rx5z
         NZHQ==
X-Gm-Message-State: AOAM5328AFB4K3hJc3UCnOqon5YQI43i2f/T7z+AAj4HqSZvCF74itq6
        RKHR4dX22YtYHr4bb32mCZMXSTIb5Qvm/Q==
X-Google-Smtp-Source: ABdhPJzrdQIsjDMTIbRf9wLnH0bDN5s2Ngi4pEz6Xvcz62HPaGVTgiXpBtekVtZ1RXhUYQgXi2pn0Q==
X-Received: by 2002:a92:1e09:: with SMTP id e9mr17581629ile.224.1642621084518;
        Wed, 19 Jan 2022 11:38:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z5sm302166ioq.47.2022.01.19.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 11:38:04 -0800 (PST)
Date:   Wed, 19 Jan 2022 14:38:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/2] cat-file: add a --stdin-cmd mode
Message-ID: <YehomwNiIs0l83W7@nand.local>
References: <pull.1191.git.git.1642615122.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1191.git.git.1642615122.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 19, 2022 at 05:58:40PM +0000, John Cai via GitGitGadget wrote:
> I think this will be useful for other things, e.g. a not-trivial part of
> "cat-file --batch" time is spent on parsing its argument and seeing if it's
> a revision, ref etc.
>
> So we could e.g. add a command that only accepts a full-length 40 character
> SHA-1, or switch the --format output mid-request etc.

I would like to see a more concrete proposal or need for this sort of
thing before we go too far down adding a new mode to a command so
fundamental as cat-file is.

Between your two proposals for other commands that you could add, I am
not convinced that either of them needs to be in cat-file itself. IOW,
you could easily inject another process in between which verifies that
the provided objects are 40 character SHA-1s.

The latter, changing the output format in-process, seems dubious to me.
Is the start-up time of cat-file so slow (and you need to change formats
so often) that the two together are unbearable? I'd be surprised if they
were (and if so, we should focus our efforts on improving Git's start-up
time).

In the meantime, this is quite an invasive way to provide callers a way
to control the output stream. If there really is a need to just force
cat-file to flush more often, perhaps consider designating a special
signal that we could treat as a request to flush the output stream?

Thanks,
Taylor
