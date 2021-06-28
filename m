Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E20C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AFC6191B
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhF1TRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:17:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40751 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236223AbhF1TRI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 15:17:08 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2287D5C0150;
        Mon, 28 Jun 2021 15:14:41 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Mon, 28 Jun 2021 15:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beshr.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm1; bh=OvOQTk2OGspSBddB4GfiRB1QxYx1pyP
        NqdMMsp2cvB4=; b=hbA6gSCVbdWgl5abOJdj0pSz7rGs817MPkal7kCXsi487CE
        KcJEoev/wTIfd3o8OWbpKEXdmjh6ydxtjZfPLG9elTTb338wZhry3Y7BTE5HTcS4
        k3ce652IX79TEnQRMxWHjFQVTTbPuG+PvD7thj4t0Uj7lo9Zc3CTy6F3Z6SSRrCZ
        9JiE2aLUKefkHxkybh8c7VKpubAjY+RZOv+M0kQQKqb9DawC6gaqq9NwK1OnyfIe
        I3lVtcTPrhUXNmieco0XQoguIc7rERGhHCxkz0dJbwhXpX+uwKbqlvtyN3EU1ozq
        FOKo3CzKRVoLWaayVLeJnzMf5gnyYpB1nsFkHwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OvOQTk
        2OGspSBddB4GfiRB1QxYx1pyPNqdMMsp2cvB4=; b=GdHb6DN5fLcQYGDoMxmRHT
        8dG7yNAJ6AAl7Lqo4wnxvSHfFzFZcvCTcyFHwlLeBeVM5PHd3i+xKKZnGw7Aq9oQ
        thxQHDByLp6HtljBoSmKFeoy9+uSn8wUZbCSzQjs/O8Uk2QshXvLdFHeEQs43lCU
        bh3fnifL+pOjImvlf7W0iISLE6kvYjdBWpqwdNmq7I6F0sCYtRcKqNhRIiaFz22u
        G0W0UnBXMDky0qviepo55atR6xA/7Od2XSrUDwYRI1fr4qNCk+OVBl9OMtq9pVKz
        xMZLIWkXLAFmHlXurm2Y3FIFnnEr6yf1VT+qSFYcKX8d4UH5bbANkmFFmKejeZfQ
        ==
X-ME-Sender: <xms:oB_aYESkkUppn7jaWRTn6STlhDV6OEJbBbdnS6l6wAXntvzc6wXTbA>
    <xme:oB_aYBwlPkgFFtmsMCdlVf8YxOAW25hndManS1FIYtIASgalnjAGRoxRXj1kN0AlJ
    ovKzhY-8HPQFrjVNmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesth
    dtredtreertdenucfhrhhomhepfdeuvghshhhrucfmrgihrghlihdfuceomhgvsegsvghs
    hhhrrdgtohhmqeenucggtffrrghtthgvrhhnpedvieehkeeileeiheetvedvkedthfelgf
    eiieekteetleffudffhfdvtdejvddtleenucffohhmrghinhepsggvshhhrhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgessg
    gvshhhrhdrtghomh
X-ME-Proxy: <xmx:oR_aYB1N_QzUTzTwyHi9SZueV2qPSXsWRbNwc133CyDb9AuReU4VNQ>
    <xmx:oR_aYIBPwZwgW0g5u-XircBMkv2R7ilY64_ZCut6QPhhcy4ZjLoU1A>
    <xmx:oR_aYNid__Htgo4L_c_kBHD3WHd12r15XanbYW7mnK24OPIcgw9tFA>
    <xmx:oR_aYHdf3xl1XJPtbvEI2IJzUZWRIqhhk3wMSdGbo7rxH4OXInWPeQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ED6783C0060; Mon, 28 Jun 2021 15:14:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-530-gd0c265785f-fm-20210616.002-gd0c26578
Mime-Version: 1.0
Message-Id: <4432c402-084c-4759-8c31-954ce5c054f8@www.fastmail.com>
In-Reply-To: <afef1ee8-dd6e-2954-2c97-57ae14b27668@gmail.com>
References: <20210628052631.345601-1-me@beshr.com>
 <20210628052631.345601-2-me@beshr.com>
 <afef1ee8-dd6e-2954-2c97-57ae14b27668@gmail.com>
Date:   Mon, 28 Jun 2021 21:12:25 +0200
From:   "Beshr Kayali" <me@beshr.com>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: commit patch typo
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021, at 8:05 AM, Bagas Sanjaya wrote:
> Hi Beshr, welcome to Git mailing list!

Hi Bagas! Thank you!

> On 28/06/21 12.26, Beshr Kayali wrote:
> > ---
> >   Documentation/git-commit.txt | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> Why isn't there commit message? But from cover letter of this 
> single-patch series:
> 
> > Simple typo fix (chose -> choose) in the documentation of the patch option under the commit command.
> 
> Don't forget to write the commit message in next series.

Sorry about that. I'll fix!

Thanks!

> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> > index 340c5fbb48..95fec5f069 100644
> > --- a/Documentation/git-commit.txt
> > +++ b/Documentation/git-commit.txt
> > @@ -72,7 +72,7 @@ OPTIONS
> >   
> >   -p::
> >   --patch::
> > - Use the interactive patch selection interface to chose
> > + Use the interactive patch selection interface to choose
> >   which changes to commit. See linkgit:git-add[1] for
> >   details.
> 
> Fix looks OK.
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara
> 

http://beshr.com
