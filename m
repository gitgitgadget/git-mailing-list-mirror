Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27471FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbdBIVOW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:14:22 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33922 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbdBIVOV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:14:21 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so941458pfb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 13:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=49kzqCYdYOGfaLqk0gaky+zHyDfOhr7MIPfBQ1PdB1o=;
        b=Iku9uUlDz/P/WbRwCGEl9D2P7pWDLbhGjhFjia76pwxmBlBXEfbU1ZOVFsbefPeyK7
         IGwfM6PcVaz/JIxmTxsO3/j7J+yLQcHoAt0c70tpiEx09HZpNWtQLcOXBrbUc2HqQqoJ
         sDf/CcS2h3gpebN+rqiQRIFFRlCFOfx4/oJRMnzYfDfZXW38BZGrAUmaDVAWkpIk4+6u
         mhVPRPg4WU7+hCVYmMvV5jzTHdA+z4Hm/VcEehL0/Il0wIAo8slr39I8cAZIxC00G1sG
         pvUYKHULaXC7faUq25rDQczPWdztJ92PEEfjsar9ICP6W8pb3eKFt/Fogx7F1yWAU4IO
         fAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=49kzqCYdYOGfaLqk0gaky+zHyDfOhr7MIPfBQ1PdB1o=;
        b=O0XT1uCBMbEoJTSRq4hObFpaUO5ojFr7jpQlQ7bODck15UnpXixXKItWIm3oZqyFrG
         oibdR1QGf4XENMr5NzbWZAlUanIVRNDGaKDRpZP2/KVYMZBKPiBIIc+VfMG2w1fBzx/G
         fuWX7LvcIJM9QzryfGCA7f0gYRu0UWn01/zEvg3LCZPQocQRtlQeFVo/6yC34JuQLM4v
         0CEhTC6GSAAcy9l/iy1JXAbSWmFkkXA0gWCDAXge5f02qhyLS3DbqRPAIqw57R0IhgHb
         yleQdCN0p/B1/p1tIA971pbXWY5HVo9AFiNmnr5MQzqIKP3CgCOS0oWTJlsD6EH/D3/5
         XONA==
X-Gm-Message-State: AMke39kQWrYKyl1E0uSgqrbjnYaQJFxmX2NbvD7PUZmMEpAhtGfxZielytWVqMYqWRQtMg==
X-Received: by 10.99.102.71 with SMTP id a68mr6380727pgc.67.1486674460895;
        Thu, 09 Feb 2017 13:07:40 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id f65sm31269663pfk.5.2017.02.09.13.07.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 13:07:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: push the submodule attribute down
References: <cover.1486629195.git.mhagger@alum.mit.edu>
        <8958e7e26cc8bf11a76672eb8ea98bc9ba662fdc.1486629195.git.mhagger@alum.mit.edu>
Date:   Thu, 09 Feb 2017 13:07:39 -0800
In-Reply-To: <8958e7e26cc8bf11a76672eb8ea98bc9ba662fdc.1486629195.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Thu, 9 Feb 2017 14:26:59 +0100")
Message-ID: <xmqqd1eroyxw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Push the submodule attribute down from ref_store to files_ref_store.
> This is another step towards loosening the 1:1 connection between
> ref_stores and submodules.

The update seems to retain the externally visible effects, but what
does this change mean for future backend writers whose code will sit
next to files_ref_store?  They need to have "submodule" field in their
implementation of the backend and keep track of it?

Granted that the primary thing that looks at ->submodule field in
the code before this change all live in refs/files-backend.c, but I
am not sure if that is an artifact of us having only one backend at
this moment, or a sign that future backends would benefit from extra
freedom to choose how they exactly implement their submodule
support.

