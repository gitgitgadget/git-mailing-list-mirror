Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03441F404
	for <e@80x24.org>; Tue, 14 Aug 2018 16:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbeHNSux (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 14:50:53 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:56262 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNSux (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 14:50:53 -0400
Received: by mail-it0-f74.google.com with SMTP id e21-v6so13022504itb.5
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ktywcnUV6V6ltiNiHFp6CnF6j3GWM1Uj/2ce7O5QCUg=;
        b=RuOdA9WJ0LGQSABnzCnMoWuNMjqoyPdiYrzsOu4l88u1fomoUq0dm3ZTV5s3c9FiuP
         P2dOs6OveeieaubwJ0uLjv2or8BSmJyjBqMamHjXJKeQR6gta5a13VMa9MjJkkrQV8J+
         NEUmIB4o6IVMzIHYlCjiJYgiC+wdB2hJpl8ee995sVD3BTvPKp55luyUSm8nic3o4/WF
         LDICxwiWi4LVYab+k8R0+t3KHTDXTsXQNYlRFxj95Bn/Mmd7z/IF2CYoPSkv4EgpD5pb
         DbG+xQxTrN/a0+XXr1Bu0nwmPy/nur0nxrvDLthvUYbMUKR/QeQM4Z+P6iulStul6k5G
         Ykqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ktywcnUV6V6ltiNiHFp6CnF6j3GWM1Uj/2ce7O5QCUg=;
        b=eCr3W2Jn/jiaYIFg7+32IWHh+m5TopQRYPw/HgtMS7E6zF7RdKYFby7m116fozIL9B
         xi+lTj8lEi8tVCzMyKOqHWQ6RDOtPf3iC3Whk4AT0hWkJ/mfETGLu+WJo7hDxT2oqs4O
         SqafF6po24uLVV8tEtaybG2rYooqy/1RVGIe2xtY9AtgRAgsjgscpiORW1N0QW+P61fK
         r+iSFe6WdUwBx/Ja7CQtx4O+VSQKyYv7iglNw2de5MXY5qyLtWiPDSTBfbTZNu6tX6vB
         ZaHENdVnEu00025tpoiRb1OlI0zCTZzPNnze4V1XtegIJh6n6F6JRPyMaGf4tkNVD4/3
         i3Yg==
X-Gm-Message-State: AOUpUlEi0GPVS1IYw4IrDPHMviMWad6nJCC4cxLKz1eRBesylfhQZAWQ
        Tf8CtC01gW0k1+UBKlSDpJaZ3HNbRREYwE6BauNa
X-Google-Smtp-Source: AA+uWPzIcd6UB97Uqw4ngzoBaX2znH0CiIuuKno/5Ct219UIL2nxiuYfU3R9TvwQmtZiX71itfteBIJo6CBrE1J4Hxtc
X-Received: by 2002:a6b:c5c5:: with SMTP id v188-v6mr4413691iof.91.1534262587124;
 Tue, 14 Aug 2018 09:03:07 -0700 (PDT)
Date:   Tue, 14 Aug 2018 09:03:03 -0700
In-Reply-To: <CAMfpvh+awO8kpVtxKxMDuiXx2XM0o3xGycXdSF+ZJ0NXyzv5Hg@mail.gmail.com>
Message-Id: <20180814160303.693-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAMfpvh+awO8kpVtxKxMDuiXx2XM0o3xGycXdSF+ZJ0NXyzv5Hg@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: Re: [PATCH v2 3/5] rev-list: handle missing tree objects properly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I don't understand about the ">= 0". What should I replace it with?
> Maybe you mean the return is never positive so I can change:
> 
> parse_tree_gently(tree, 1) >= 0
> 
> to:
> !parse_tree_gently(tree, 1)
> 
> ?

Sorry for the lack of clarity - that is what I meant.

> > The missing mechanism (for error, allow-any, print) should work without
> > needing to consult whether an object is a promisor object or not - it
> > should just print whatever is missing, so the "if
> > (!is_promisor_object..." line looks out of place.
> Done. I considered that a missing object which is not a promisor is a
> serious error, so I had it die here.

It is a serious error, but as far as I can tell, that is what the
--missing flags are supposed to help diagnose (so we can't die since we
need the diagnoses to be printed). See, for example, 'rev-list W/
--missing=print' in t6112 - the "r1" repository does not have partial
clone enabled (which I verified by inserting a test_pause then cat-ting
r1/.git/config), but nothing dies.

> But now that I've added the
> do_not_die_on_missing_tree flag, it's more natural to keep the
> previous promisor check as-is.

OK, I'll take a look once you send out v4.

> Also, is_promisor_object is an
> expensive check, and it would be better to skip it during the common
> execution path (which should be when exclude_promisor_objects, an
> internal-use-only flag, is *not* set, which means we never call
> is_promisor_object.

That's true.

> > In my original review [1], I suggested that we always show a tree if we
> > have its hash - if we don't have the object, we just recurse into it.
> > This would be the same as your patch, except that the 'die("bad tree
> > object...' is totally removed instead of merely moved. I still think
> > this solution has some merit - all the tests still pass (except that we
> > need to check for "unable to read" instead of "bad tree object" in error
> > messages), but I just realized that it might still be backwards
> > incompatible in that a basic "rev-list --objects" would now succeed
> > instead of fail if a tree was missing (I haven't tested this though).
> The presence of the die if !is_promisor_object is what justified the
> changing of the parse_tree_gently to always be gently, since it is
> what showed the OID. Can we really remove both? Maybe in a different
> patch set, since I'm no longer touching that line?

That's true - the idea of removing both needs more thought, and if we
were to do so, we definitely can do it in a different patch set.

> > We might need a flag called "do_not_die_on_missing_tree" (much like your
> > original idea of "show_missing_trees") so that callers that are prepared
> > to deal with missing trees can set this. Sorry for the churn. You can
> > document it as such:
> Added it, but not with a command-line flag, only in rev-info.h. We can
> always  add a flag later if people have been relying on the existing
> behavior of git rev-list to balk at missing trees. (That seems
> unlikely though, considering there is no filter to enable that before
> this patchset).

By flag, I indeed meant in rev-info.h - sorry for the confusion. That
sounds good.
