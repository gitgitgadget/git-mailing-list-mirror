Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07067C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 01:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjEIBQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 21:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEIBQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 21:16:29 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B276E9E
        for <git@vger.kernel.org>; Mon,  8 May 2023 18:16:27 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1928ec49077so4356794fac.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 18:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683594987; x=1686186987;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KMigbrM2NCiky+kpZoHL6IbIUgbRsGG1Wrrvkmql60=;
        b=jBh3sRelLBRU3n5TLo4/iq7D8aC0eA8tJ7N7rG6uucfmRIbU1ZiO6BEL/DccsHmxi+
         iFCvQgGZzea7NAwgnhByjfUroPJ32dKJBjVCqCw0tIC3gtM9YKur3gyfFiUcElX1d747
         DcTSkeZlQLwDV8/SALsjREBeKy1gU8cVuOn7Kyvbd7mwR96skfi8z/j/8M3vrDFugbiZ
         MNqfZiJpdg1EggdyjTweuw7/sXjkH4cK2Slat9zbqHIsfY218qH3mJM6XU5pSda+blxu
         AcHYFfS+scREUJhktvhfzke/WOOpnvpfW+jRVhJ2hfgTzGuOoQfrzQwGWkiZgcbIxP46
         R4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683594987; x=1686186987;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KMigbrM2NCiky+kpZoHL6IbIUgbRsGG1Wrrvkmql60=;
        b=JiMHWfx17hPOXaFI9Taajm3hVtTq8sUvMe8gfs7f+HRmI+n50/acVqv8tw2i/vQ2pT
         HL62ezjbo08Ngm4UKHQWQcPackLPqHNSRBSnL7kbJs3tuKH+VKC5e9f7pruL7CXCkt6e
         QqadVDTSLGBDsEuUUPpxYnJ4vThAsADOOEtxWl8ePPwo6YqGG27Q1Ans6Ku1M1ZiVPjH
         dRWVrvR3mGhblJbpRheq5kvF3ynlxSkkP3p0mpd/V6P2xDOcPjI7DG7uTjdwbTuBPq4T
         32PVr7OzXsrB97eg0FrWpObIPGTyVt7oKiACOLzMnRJV6CBKqtLZ2iK3t5mSHwvj/u5E
         jykg==
X-Gm-Message-State: AC+VfDyF4dSTMDBK3jxd1bUsuMIRWAZ/cE3iWYlbipJB4jNRjBozcXUp
        AdItPMs/8bkKx+OrXI5PzO5X258Nepg=
X-Google-Smtp-Source: ACHHUZ74qDRBZPlhXXUlqc2BaLGAD7Zd+etCaTO7PiPB2/MNSmInKuUGH7ov6ljU/pSYRQ1UoT3y2Q==
X-Received: by 2002:a05:6870:4293:b0:18b:15cd:9b45 with SMTP id y19-20020a056870429300b0018b15cd9b45mr5828880oah.40.1683594987161;
        Mon, 08 May 2023 18:16:27 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r1-20020a056870734100b00177ba198612sm5507663oal.53.2023.05.08.18.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:16:26 -0700 (PDT)
Date:   Mon, 08 May 2023 19:16:25 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <64599ee988190_7c68294b4@chronos.notmuch>
In-Reply-To: <xmqq4joribyv.fsf@gitster.g>
References: <20230503134118.73504-1-sorganov@gmail.com>
 <xmqqsfcdtkt0.fsf@gitster.g>
 <874jote2zl.fsf@osv.gnss.ru>
 <xmqqmt2lqofb.fsf@gitster.g>
 <xmqqttwskse5.fsf@gitster.g>
 <87o7n03qgq.fsf@osv.gnss.ru>
 <xmqqpm7fizsl.fsf@gitster.g>
 <xmqqjzxnixqr.fsf_-_@gitster.g>
 <xmqqfs8bith1.fsf_-_@gitster.g>
 <xmqq4joribyv.fsf@gitster.g>
Subject: Re: [PATCH] diff: fix behaviour of the "-s" option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >  * Then the interaction between "-s" and other format options were
> >    poorly implemented.  Modern versions of Git uses one bit each to
> >    represent formatting options like "--patch", "--stat" in a single
> >    output_format word, but for historical reasons, "-s" also is
> >    represented as another bit in the same word.
> 
> An obvious improvement strategy is to stop using the NO_OUTPUT bit
> and instead make "-s" to clear the "output_format" word, and make
> "--[no-]raw", "--[no-]stat", "--[no-]patch", etc. to flip their own
> bit in the same "output_format" word.  I think the "historical
> reasons" why we did not do that was because we wanted to be able to
> do a flexible defaulting.  We may want to say "if no output-format
> option is given from the command line, default to "--patch", but
> otherwise do not set the "--patch" bit on", for example.
> Initializing the "output_format" word with "--patch" bit on would
> not work---when "--raw" is given from the command line, we want to
> clear that "--patch" bit we set for default and set "--raw" bit on.
> We can initialize the "output_format" word to 0, and OR in the bits
> for each format option as we process them, and then flip the
> "--patch" bit on if "output_format" word is still 0 after command
> line parsing is done.  This would almost work, except that it would
> make it hard to tell "no command line options" case and "'-s' cleared
> all bits" case apart (the former wants to default to "--patch",
> while the latter wants to stay "no output"), and it probably was the
> reason why we gave an extra NO_OUTPUT bit to the "-s" option.  In
> hindsight, the arrangement certainly made other things harder and
> prone to unnecessary bugs.

That's easy to solve by introducing a DIFF_FORMAT_DEFAULT item, which
would be different from 0.

Then every command can update DIFF_FORMAT_DEFAULT to the desired
default, and if the default is cleared (e.g. `--no-patch`) that would
not happen.

-- 
Felipe Contreras
