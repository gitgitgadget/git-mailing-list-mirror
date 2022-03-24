Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363E9C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 03:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiCXDBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 23:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCXDBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 23:01:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C94674F7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 20:00:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso3791093pjb.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 20:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YtFjFu7Z0sDrKcAR/aY53+G4cqN1og0ZRKNZ5SfajU=;
        b=gNwHSU4MMzm/rV2PBls31+PERsR54TAMH8lnFbdu5O27j26eo7coqSLnvcxMLAvq0s
         LxJE1Or4bR3AHHmnnZe3VoxQarrNaKLZDNZx4XmsYgS0Wl517kwJGWFjduS8NHs4dofg
         uDfNebXWYPuAfGdoDhmmrUHrQVygQSYb+AqTR1Zhy+Mlf+VlY6cbspFeAVCc5ds6RlyU
         ImGz7lZRMWMlDkIWkgynrjH+YduM1pKGeRC8SWuo36ncGu0uIvrKBkYNXEr7lhIQlixF
         InY1skClh0ZwHnnxuhu0u9K6iQyyP83jZ87Ug6nbAB4TIFldCq/O2wvy69PGcjXJQJgd
         +qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YtFjFu7Z0sDrKcAR/aY53+G4cqN1og0ZRKNZ5SfajU=;
        b=RqyQP0s7uLyHR7BCykiwr1PqneL+0pW6zmxfBQF/InBfPL/QH2oa8lvKiqTr4Kjdeg
         DDOmcssgzzKUZPmwzkE6P5ps6WatJmzIFB4LbnsTt/trerGWRVbmzgM5ifZ0GPfaHyCi
         Y2tWwCGfOJi6jNtIepn9Weq44umdtm6eVLRN9QiVlMOk3NZqbte/MfeERRYuuLNf2n8s
         Y7FhQMlonNcJbkZmwtg4wzMQ83pbxYwuzlr0xFhtMDdytUWd0dIg6nLmClaXnNaR/Er+
         NuVvOFUPN4d9mNKhrir4kTu/uH6NoAty9l5aHLgZVFGTMWPEwLBAwYb4Jt02ZZgXBoGA
         +now==
X-Gm-Message-State: AOAM532sYsemybEc12TCC8ki6QrvZ8EtEKhI59DlhhR3RelGa7Sbtjg4
        NvpltyjUERp2lOskAEAUajnm8c8NNiXlNQ==
X-Google-Smtp-Source: ABdhPJwam3jTN/u4CNrR/fkXhZal0gvEJjrFEPEpkCtBTOygh4I3A4MXgh4bH6hzBTEtnPoUD7MThg==
X-Received: by 2002:a17:903:2488:b0:153:8f59:8c03 with SMTP id p8-20020a170903248800b001538f598c03mr3642731plw.54.1648090814984;
        Wed, 23 Mar 2022 20:00:14 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.57])
        by smtp.gmail.com with ESMTPSA id j7-20020a056a00130700b004b9f7cd94a4sm1162880pfu.56.2022.03.23.20.00.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 20:00:14 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        dyroneteng@gmail.com, git@vger.kernel.org, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v14 00/15] ls-tree: "--object-only" and "--format" opts
Date:   Thu, 24 Mar 2022 11:00:10 +0800
Message-Id: <20220324030010.124703-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.577.g74cc1aa55f.dirty
In-Reply-To: <xmqqee2ssaut.fsf@gitster.g>
References: <xmqqee2ssaut.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think readers will read "non-functional change" as "we changed it
> and made it not function anymore", but you meant something else ;-)

I tried to translate by Google and the translation is OK, but indeed
it will bring some little murmur on "function", I will try to avoid
this like ambiguity words for more improved description.

Thanks.
