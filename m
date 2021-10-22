Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D277BC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B110161183
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 04:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhJVEfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 00:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhJVEfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 00:35:10 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE468C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:32:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id s3so3030688ild.0
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 21:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+9yE5n8pp5n6tX1NZdJoYhmkcbL3PulWSRIBn2SxLmY=;
        b=ZgHT9lUtsKw2o77n4r9zYQChzP7SS9twnTraeMgbx7yM13xzkx9dHPam+KCBohPkVi
         xR/weqVP2PobVIbtecUVochrUyPc9eiYJsuAr8RwbU7S3FMZ6uke/fz9IveYkRBpUSNw
         8WX3jYW53sUvdB3XQ8ow3V0cI+l+mpP3/YYmzkYWPpclAk+vBZOmSpIfQRCmjNGA7Zlh
         1CmGLRB6MEICzRhP08Fb3erOvxKk7NNzHwd/zoeyB7iikrfnpFbaROCQRpXL/rKpdM3r
         nRFu7vGpyHkrKnX1+lTZ9LxR8SyEa/HHnBWwYK/4anGdaYp9RRSLV9aIUBY4Asdp+U7i
         XTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+9yE5n8pp5n6tX1NZdJoYhmkcbL3PulWSRIBn2SxLmY=;
        b=DcoUHHiMfEV/KAJFTeK1l9iRaR96rPQDhtEXGyyLYRz0tUZW6BhsMpTAuSrzcJDmqq
         wzumyAuiMvr3gTJDaLH5l+L7LtI8kmsmRkxbEugAFb2NaTBXS3hklQ6r6+7GoRy+9RRS
         Xet3np7z7AuWozSmUN6ro6NqJm508qTqDEwvkafaIBcGleZr50118A94qAANYt+ye4ss
         ULzTHHcK4UX5HEs4Wr6AeFRcPI0iXt4l7IadQ1ozIcPTbljmgvMosInZ4TIGk8X/LHYA
         mlPqgS1j6DAJTmXMh6RYp0WFnOV0fCvN05toT6D/P5WlFWJLTjEYNUaP5D53myqOdBZx
         vxgg==
X-Gm-Message-State: AOAM531/KEBanq6e42pt4AnXttkgFQD46fyAKh20bGvzBnD9EI17qmH6
        PY2i+wJHwELP8Pj+6VlPZ+zKMw==
X-Google-Smtp-Source: ABdhPJy42y/G+0zR8SBgu3dWUkh1eyBwJIGGr+OVpLsrTYAlrKMcoMQynDJhrwV0/XgJGZI+v8NotQ==
X-Received: by 2002:a05:6e02:16c8:: with SMTP id 8mr6213441ilx.169.1634877172911;
        Thu, 21 Oct 2021 21:32:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m10sm3947866ila.13.2021.10.21.21.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 21:32:52 -0700 (PDT)
Date:   Fri, 22 Oct 2021 00:32:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 10/11] pack-bitmap-write.c: don't return without
 stop_progress()
Message-ID: <YXI+8+vFyfeVenGI@nand.local>
References: <cover.1634787555.git.me@ttaylorr.com>
 <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
 <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
 <xmqqpmrykys9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpmrykys9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 11:39:34AM -0700, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
> > Looks good :) Just a note that this is in
> > "ab/only-single-progress-at-once" already in case you didn't spot it.
> >
> > That series is marked for "next?" (with a question mark) by Junio in the
> > latest what's cooking, so *hint* *hint* for any last minute review :)
>
> I wonder if it would help contributors if we give them a simple rule
> to follow before sending their patches out:
>
>  - You develop on an appropriate base (either on maint, or master,
>    or a merge of selected topics in flight you absolutely have to
>    depend on) as usual.

That seems like sensible advice to me. When I sent the series out last
night, I figured that it would be preferable to cherry-pick the commit
from Ævar's series, since it wasn't clear whether or not all or parts of
that series were actively moving forward (besides being marked as
"next?" in your What's Cooking email).

But I'll send the next iteration based on a combined merge of my topic
and Ævar's, and note your branch names for both of them clearly. To
encourage both of our topics to move forward, I'll throw Ævar's onto my
review queue.

Thanks,
Taylor
