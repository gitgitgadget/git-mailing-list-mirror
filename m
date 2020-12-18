Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FEEC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF96023443
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgLRMOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 07:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgLRMOf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 07:14:35 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530E6C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 04:13:55 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j20so1697722otq.5
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 04:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ANJcqseiyaGf18ybfy7rYO0x1u2k043/qlFrdMe2lsk=;
        b=LxB28KW+XznFH5akAyAAaCPiG+y0lzz80f+Zt7TrJu/l4dW2Shxl8MmnDlFNvg7jfz
         /Hq4zLjc/K0uy63L+/Aom9avH/fKEhR3uOcbhj9Dmu91BnMPw+i+fjuBpAeRkBCFP2gI
         Hz8gxlmtc8h/xG0+m4Gm0rpT42o2rsfnIyGOXYdnd6sXL6vaYBEXqjSLzI0JRRkOTKSD
         1XrH2WFB1BD7S7Rg7pTA/jeMFAxP6Iit6r0bIb0RQEG3wkrAj95ZNalnX/GyDsGDC+L+
         Uqn35aDuppKrK74xAqqIYt60cvXKd3NeBJRgeucyhIimEbX4O3CFUsyhBjvOFOett3a5
         RqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ANJcqseiyaGf18ybfy7rYO0x1u2k043/qlFrdMe2lsk=;
        b=gm+Ccejh8rYcqfkmYRYyfmWgcz5qtMp2kVCVYdmubmf8jHQCOY8mPS8bCR+BX+kQRA
         PW7kVj7Hc/iR3mMJPO/bq7dv5/NYgm9MTzxqq+0T2FnUeXnwMqrPprmE4lRNmZ8jcG/p
         kjy7mfkgCEOLxYn+gWrQjTmHyT68LUMJJpMHxM5VEhEW3v/WbmsVMk0mB7ksrMuZ0h4x
         1x4YIioaygHctc6eKyI3M1ipsIWf8OLqMb51nymm2792Oqra6TicXxObrwstBiazyMRF
         cbxgjt7EHbpQIbn0V/F3+ULmVv75OAV9yz/KE/p4o8row/m678unLnd4AlnP5lWMQUkJ
         LYzQ==
X-Gm-Message-State: AOAM531mvmPpontsn3uWMQQxipcqnikciH4SH3TZAWfz6jm4z+JMjiQw
        EXQkqpX2qnxhZoFLETqLgo8B/4P9bSZafg==
X-Google-Smtp-Source: ABdhPJzWcWGAVjSQhJCMtHK2SlBig7ZV4PaSi74DpefRuZhwZeTdN0qQsXjd+8AvO3SVKsPg+Bkz6w==
X-Received: by 2002:a05:6830:30a8:: with SMTP id g8mr2438798ots.291.1608293634745;
        Fri, 18 Dec 2020 04:13:54 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d124sm1780291oib.54.2020.12.18.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 04:13:54 -0800 (PST)
Date:   Fri, 18 Dec 2020 06:13:52 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fdc9d00bffd8_104e15208ef@natae.notmuch>
In-Reply-To: <xmqqwnxftnbk.fsf@gitster.c.googlers.com>
References: <20201217054524.856258-1-felipe.contreras@gmail.com>
 <xmqqk0tgx7ms.fsf@gitster.c.googlers.com>
 <5fdc16b8de8c1_f2faf208ad@natae.notmuch>
 <xmqqwnxftnbk.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v3] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Right, althought the user can't configure otherwise, and the default 7,
> > it can't hurt to add it.
> 
> Yes, that would make it certain that the code would survive the
> change in the underlying xmerge part of the system.

Yes.

> I am still not sure what the right plan to deal with conflicts
> recorded in the virtual ancestor.  Do we just close our eyes and
> ignore it?

This is what we already do.

When a file has changes that don't bump into each other they are not
considered conflicts, for example:

 BASE:   sentence
 LOCAL:  sentence
 REMOTE: sentence.

Is that a conflict?

Whether you call these "trivial conflicts", or "non-conflicts" doesn't
matter, if the file only has changes of this kind, git considers the
file merged automatically.

If the merge has *all* changes of this kind, then the it is
automatically completed. No mergetool necessary.

> An easy way out may be to give an command line override so that
> users can easily re-run mergetool with the feature disabled only for
> a single invocation that went wrong,

Why would it go wrong?

Git has already determined there's no conflict.

Does it make sense to run "git mergetool
--consider-all-changes-as-conflicts" and go back in time before the
commit merge that had no conflicts was done, and run mergetool on all
the files that contain changes, even if git initially considered the
file as merged (since they contained no "true" conflicts)?

When does it make sense to open an instance of the mergetool on a file
that contains *zero* conflict markers?

-- 
Felipe Contreras
