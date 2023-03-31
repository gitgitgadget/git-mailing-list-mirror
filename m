Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F9AC761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 18:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjCaS3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjCaS3C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 14:29:02 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC3A22E8F
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:28:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 23E565C0060;
        Fri, 31 Mar 2023 14:28:49 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 14:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680287329; x=1680373729; bh=HRCegf3AB/K1Li8Bg1MNrzkZx
        KsW+E6xGB2SJeRIaJQ=; b=SLiIwUzF/X9GN5Orz32bxBrchvsldHey/42MwIkni
        i4aU+xHyj0oMO08JV8hs5JgF8klG+54JlcX+UL9lRxqf8uR4GzWe7k1ykbL9XN+M
        MgjmELE5p4qjCkQU/51YQ5WqAV2sUovcF+qv5iD7V1z+B7Gh60QnGK1M2lCTd1nb
        y78W+qAaFhGnQBsscinIf45x8OtrX3aGYzHVISnfvdnI7nlCOZ0Ci5b0xpwDR5ak
        dd4GUxjcS4gbmFCkVY0gUro2s4bJYhMAK/ukqEXq0FsJ/zcdqE6I6Yve3OWzfE2R
        0SmwDw754ZjA4KAPQjWcoxABb/VTi1gCpERCMy4tr+13Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680287329; x=1680373729; bh=HRCegf3AB/K1Li8Bg1MNrzkZxKsW+E6xGB2
        SJeRIaJQ=; b=mC9uVIN/vMjSjLOo8AyfYoOPYu5kWc1GpngNabZHnC+ZFovIj7N
        CJjmvhI8/NEdwJzBa6bdfWzY06YyXoTPt9KP9A2NvtaQcKd5uKQRz7/y3nSBXTCl
        WQWm/XpM6zxPlxwl/zqvD2lesBgBfLXTzJSJAb4Vz3p9SPMF6fGagpleInAHc4+O
        XKKmTo23Et9w6zpkLegfShQUQdaAfDOMwu8tIjl1OJ/YZGPDZxuxQlGfWR7fwGpQ
        XYKucnhpQLDuyJkPdqfo/YCXFQdRoNbAKH1MXmKnLI8p8n9r5LQKpoMUZ2jXbR9H
        x6oH4J7v7d/G+UvK1E756GwNcvbgM4ohc5g==
X-ME-Sender: <xms:YCYnZOkDmgu6wqTBB2JEvKy8yLl_jokit0MyCQH2mNCztUpIA2LfkOo>
    <xme:YCYnZF0c2UDWapTmTjKzIMq919KLwxLNGwD1DUabU_JONdN-yt4Qg-1T7_ZWVb22i
    lLN5QkASOd0jnFuFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfeliefgkedt
    ieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:YSYnZMr5CG_-pXE9jPlhbvd0eJQhYwAzZms5fvaw9QVBB_AKMtUMLg>
    <xmx:YSYnZClDWQ4k0AkA-U71YwsNXJrAdGwuJPtgbQs205TgxPfRrVNJGA>
    <xmx:YSYnZM0yaAJ19Cp6qQrlxK00YpdzIeP9PR_EVNduNj_j2IdaEvb0DA>
    <xmx:YSYnZNidz4C_Myzfj2HcIOec62sMWbQkIwGgFcwXOXPOHf1864wAFg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E7F4215A008E; Fri, 31 Mar 2023 14:28:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <4c5ca07b-dd36-4176-8f93-bbae7c3f672f@app.fastmail.com>
In-Reply-To: <e1d11808-3740-47ca-bbea-24858d09bfef@app.fastmail.com>
References: <20230331180817.14466-1-code@khaugsbakk.name>
 <20230331181229.15255-1-code@khaugsbakk.name>
 <e1d11808-3740-47ca-bbea-24858d09bfef@app.fastmail.com>
Date:   Fri, 31 Mar 2023 20:28:28 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: interpret-trailers: remove trailing spaces
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023, at 20:21, Kristoffer Haugsbakk wrote:
> I=E2=80=99ll re-roll later.

Interestingly though it worked for the third patch which had the same
subject since it got encoded properly. But I pasted in the same subject
manually in the cover letter.

--=20
Kristoffer Haugsbakk
