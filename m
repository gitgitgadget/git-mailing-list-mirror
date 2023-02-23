Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14E7C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjBWIpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjBWIp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:45:29 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07B2822D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:45:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 03D475C0061;
        Thu, 23 Feb 2023 03:45:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 23 Feb 2023 03:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677141927; x=
        1677228327; bh=7eCXCuOPUp5k7BjsHu5ZhG9HYFR3vR5wOt6NdkpyeeE=; b=c
        tqvxqnDwz8L+8yM9XSWJth3LbjyzOB9OK3Z4PJRphmo6bV5Ro7TxdSgpkx/pdyKu
        yHAgeLqmlRPmTfL4Vmv8B+aRKm0sShNhsHnrIrRPuiCrSjgCNpw4ZAoduC5fOT6a
        xLvosiJLpTXdwe+u7rb4e4q7GddI6eB5r14KwfKunEh8VtmkyinlkaoTFUMhl3DZ
        Jdz+Ro++VCOh4moliYZGdJI6c6A1tZQVUE72lGduNENcaEQ8spdoQwblrrb1Opcx
        Z3vArRJ0C6AdjCvf+8k2s19ig1Auz5wFV2WHLqkxyiYp691gAwebPQ233ii2vDPM
        qoy6hTw9jucfpL0gxQrzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1677141927; x=1677228327; bh=7
        eCXCuOPUp5k7BjsHu5ZhG9HYFR3vR5wOt6NdkpyeeE=; b=RDQmDPBbRrT4qMtIc
        7MUuBvyT2Z7lPGZGHykx+cvOTtqjFc9hZjh7Fb8OTTiw1t1o6f/OWnMwqP7t1FPu
        g7KvFoQDb8pH+G7D+qLrE+xPspAqCvCVbI0hV26QDlQ5Tag18C6L8YwQOeU0Trn6
        ucBXRISJAF0VqG1X/ISZe659SQ+10rNzaqlhghmku3rU0Av+gmrlWES8yG0jZzYz
        t6bx9A4Zh0p4CpOKJwyy1hDUfyjndKFRRz05bDnZ6JJRX+MP/VxR2eGT9heTMHDj
        XKEGX5Piixptd9fbpJYBAlImvdBRMD0rTdLaI8ibvz8SMO2J1vztSmDZBnYSASL/
        s3yPQ==
X-ME-Sender: <xms:pif3Y1uQvPrrJcK9CIfznemfDsO7tcLO59Pju0Q-vr3RYVcE6C_4Sg>
    <xme:pif3Y-dU1XFuYf2c3OyhsY3hEXJ4a6lSFst1tYovO1bwZdUxHMBaCQS4n8A6_SIWd
    xbWnxl0vsBxssqx>
X-ME-Received: <xmr:pif3Y4wIcbDVfxLjsmdcm2VxjYplrmFH_0n4ibxl4nxAGfzoqthB2tE7702fodNlSAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghn
    shhonhcuofhuihhtvgcuoegsvghnshhonhgpmhhuihhtvgesvghmrghilhhplhhushdroh
    hrgheqnecuggftrfgrthhtvghrnhephfeuheevkefgjefgkeeffeetffdviefhudfghfev
    hfdtleetiedtheefheffgefhnecuffhomhgrihhnpehgihhtqdhsvghnugdqvghmrghilh
    drihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sggvnhhsohhnpghmuhhithgvsegvmhgrihhlphhluhhsrdhorhhg
X-ME-Proxy: <xmx:pif3Y8PXwTtT4b_vKNp0z82FiP8vdumSd6Facuu5zaGp3GoUHtTQJw>
    <xmx:pif3Y1_UadenQjKtlFlqDfL6WciDgwoQfEmROWjx5K4IRHlLxj81Iw>
    <xmx:pif3Y8ViV3cCcD0MPEbkrx4Fuq_cbWxD14N7pM7yyUmpL2IDWbfVjw>
    <xmx:pyf3YyErakuoC7d7bLGVn6ywYcpn_k6nqjt42SBDvkpbQGNu1LOdrw>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 03:45:25 -0500 (EST)
Message-ID: <4de72b33-fb1a-ab8d-11b8-9e89554fa8ad@emailplus.org>
Date:   Thu, 23 Feb 2023 11:45:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] MyFirstContribution: add note about SMTP server config
Content-Language: en-US
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org
References: <20230222011317.97943-1-gvivan6@gmail.com>
 <20230223082759.36021-1-gvivan6@gmail.com>
From:   Benson Muite <benson_muite@emailplus.org>
In-Reply-To: <20230223082759.36021-1-gvivan6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/23 11:27, Vivan Garg wrote:
> The documentation on using git-send-email previously mentioned the need
> to configure git for your operating system and email provider, but did
> not provide specific details on the relevant configuration settings.
> This commit adds a note specifying that the relevant settings can be
> found under the 'sendemail' section of Git's configuration file, with a
> link to the relevant documentation. The aim is to provide users with a
> more complete understanding of the configuration process and help them
> avoid potential roadblocks in setting up git-send-email.
Maybe https://git-send-email.io/ is also helpful.



