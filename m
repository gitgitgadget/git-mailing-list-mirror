Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB7BC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9DF214D8
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACl/7pFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406212AbgDPPOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395068AbgDPPMS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 11:12:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F49AC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:12:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a81so5268172wmf.5
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=taseW24TrCSliLEmPGK8XTlLBdSSTLk9M+ZOJV1v1EY=;
        b=ACl/7pFlcPWqtZFJ/yY0eGZOemfNQFBk7iIfStNcvGv+Hy3KTQNuMzCXruMZdTa3AR
         1z2d4cNNRTn8WbeGOJI/yQnzVmhtmRh3OlPWWJccxlEG2R3RJ6XIJcmQAeUqQ81uCn3f
         qMrZyYCnpzH2IK5L7SOhuIhFFyIZqd/fSEim+JgZhW+RCdUqYd+8TkAkYHfqqvGDt7Q9
         4eBSZCse2cppWHoAPxLsqhT0VHLmceL7LUzfcojsSoMuo0FHzIClkHXxjL4YyRKvgIfO
         f/8ApGo8kybvgQnyrYcFj0CTKPW+CjeFhJgl9X1ztGbC2xSf7vbrU8nrYrOz+uZo47Qs
         nRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=taseW24TrCSliLEmPGK8XTlLBdSSTLk9M+ZOJV1v1EY=;
        b=r/9AtFMD6WYB+yo//F0rFZ8z9qJn6NLOaHYfKF9L4/OGKEk2JZGzdC+3/RDqAR3nUK
         9g2iEcPtSgKI3G0cyC8y3Qt2fo31DfgI2WbCcYyS1gL9I0j2CZeIKDifJxQPRGDroIv/
         AOW9V/bZWeHIoYwCpx3sHi4Wz0qfEk9vrRdLXyWRAeWk9i/EHAkf1xrfe38nAoEMdd6b
         dalgy/1RVUFJ0sY0W8ZwyUjyknem3RbOD3jqo+p0icqndar5DTvOdrKHtgSKs8rVIqnm
         TqAik8J5q6w1H5YDidhNll2jk2X2mDD53cus6T1Cg6nfxbhR6Uy0Wj++wZKJS0Lhtau8
         AhCw==
X-Gm-Message-State: AGi0PuaMbFtJePhPfatG+W/a3Tf9SsS5MpHEhQ+eeBUMzp5S3L/VH7Ra
        mH+IpKHU21Xu9TmOq4IP7VHulTak+W4=
X-Google-Smtp-Source: APiQypJ5C5wT7LWCaD6IU7eG/ZnxpaU2Fsyju4J1qC6QdfxflfRoPzQd+VQCPiubRaey1sNCMMLPiw==
X-Received: by 2002:a1c:a913:: with SMTP id s19mr5639484wme.134.1587049936350;
        Thu, 16 Apr 2020 08:12:16 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id f8sm5411308wrm.14.2020.04.16.08.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:12:15 -0700 (PDT)
Date:   Thu, 16 Apr 2020 17:12:13 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200416151213.xbo5x6jt477ezwvo@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Mon, 06 Apr 2020 23:32:17 +0200
References: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
 <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
 <20200328131553.GA643242@coredump.intra.peff.net>
 <20200328133134.GA1196665@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200328133134.GA1196665@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Jeff King, Sat 28 Mar 2020 at 09:31:34 (-0400) :
> > > I am still a bit annoyed that I cannot call branch_get_push_remoteref from
> > > branch_get_push1 because of the PUSH_DEFAULT_UPSTREAM case, but this can
> > > wait and we will need to work with the code duplication meanwhile.

> > I looked into this, too, and have a working patch. It does get a little
> > awkward, though, and I'm happy to just take your patch for now as the
> > practical thing.

Hi Jeff,

I looked up at your patch again, because the code duplication gets more
annoying the more new corner cases I have to handle to get the push ref
correct in all cases (cf my cover letter to v6).

This implements what I was suggesting in
https://public-inbox.org/git/20200301220531.iuokzzdb5gruslrn@doriath/

Essentially in branch_get_push you call:

        remote = remote_get(pushremote_for_branch(branch, NULL));
        tracking_for_push_dest(remote, branch_get_push_remoteref(branch),

And as I pointed out, this is currently exactly what branch_get_push_1
does, except in the
PUSH_DEFAULT_UPSTREAM where it returns branch->merge[0]->dst.

But branch->merge is set up in `set_merge`, where we have:

                ret->merge[i]->src = xstrdup(ret->merge_name[i]);
                if (!remote_find_tracking(remote, ret->merge[i]) ||
                    strcmp(ret->remote_name, "."))
                continue;
                if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
                             &oid, &ref) == 1)
                        ret->merge[i]->dst = ref;

So in particular, when the remote is local, the current code path calls
dwim_ref. (I have no idea who set up ret->merge[i]->dst if the remote is
not local...)

So my question was: can dwim_ref(branch->merge[0]->src) be different from
tracking_for_push_dest(branch->merge[0]->src)?

So I admit I don't understand everything dwim_ref does, but there is at
least one case where the answer is yes: if we have a dangling symref,
dwim_ref which calls expand_ref in refs.c will detect it. So in the current
code, %(push) would show nothing, while with your patch it would show the
dangling symref.

Obviously we cannot allow a regression for this very common case ;)
