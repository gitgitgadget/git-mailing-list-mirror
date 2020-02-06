Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111EBC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CFC206CC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuCzTrkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBFW4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:56:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45245 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgBFW4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 17:56:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id a6so352677wrx.12
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 14:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wNGDZz1ZqCpXmCvb0HnNmy909SX9mnqHH2KZdKl4tJY=;
        b=KuCzTrkV5WhFdyjPbxtvGeUVr+iUjyDxlUfUbdqO8mcAy75065myLGlUf+gmmCFL5C
         +MtmWlxJ3lZua5IfD1SE4ylKIGfsfgoY8V7nhJdLEiMidiw1bvxOWmnk4GEqlePxsSUX
         n3M/xU9aZJAUoQ4UrRVcQNs9ip36CiVK0PyheCcGJ5sqFsUXAbRlBQKhdGT9BeU12Ufo
         BBdBRmiAy7eSNlJpbauWDR9j+KX61gngl5cc0y37Sd3iOVT/433so9oobtgvgh1TXZL/
         OqOo7L4WMl2xQQKQ7/sByhJyd0DetViE8fdHXCFnUcivT7VxTmYK8BeeRko7qwB4f9CP
         hIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wNGDZz1ZqCpXmCvb0HnNmy909SX9mnqHH2KZdKl4tJY=;
        b=junIj0os+jyCs6M4FEnhaOCTnKZJdfZa1mqakmYBIMHZ1Xjt0Btv05N0iTZtKtz/+P
         lXupUPkwcFMKSCrX7wSW1wOc7WPs0mHoQGZp0Zs8jcr9t9CqcBoJayzet5Fr7VGSADvC
         Wn4EEUT6Hc6E6NT2nV/jWE9QYkyZPiUS02r2T3erD0fRlvHmEwHE8qjW+oVIBGfr0ssQ
         Wjpfr4NNlRxJJ2xhtpadZNGcqbJdtk4XHPG5/j+sIBTJ6I3vEfSoW3tfqAmCjJjpOeXz
         1OjdorcglswM19YQQsizV1pZmgt/kpXLfWv7T0ucc6IkNq68MNv7iDiN1LcKCakkDACq
         YDmw==
X-Gm-Message-State: APjAAAWb3IYG/KekNNZc56R74xBGuFZrItJFgKNg7eHuE4tAlmVGWWf+
        v6KhpqR+kMzdvy50aSVY9hVqjSig
X-Google-Smtp-Source: APXvYqwGJ/KEBf+ugnxtLMhZjhCwRh+gky0dG6fvyCeWlwKRHIm96O8lT4UyPC1xXY9DrvTe0EVEEw==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr300424wrl.117.1581029760342;
        Thu, 06 Feb 2020 14:56:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm1033974wmf.1.2020.02.06.14.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:55:59 -0800 (PST)
Message-Id: <fbdcdccc885bbd0e4f6607d1aa9cb31ec863bd29.1581029756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
        <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 22:55:54 +0000
Subject: [PATCH v4 3/5] refs: document how ref_iterator_advance_fn should
 handle symrefs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/refs-internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ff2436c0fb..1d7a485220 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -438,6 +438,11 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 
 /* Virtual function declarations for ref_iterators: */
 
+/*
+ * backend-specific implementation of ref_iterator_advance.
+ * For symrefs, the function should set REF_ISSYMREF, and it should also dereference
+ * the symref to provide the OID referent.
+ */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-- 
gitgitgadget

