Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BADDC48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB7F61260
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhFRUqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:46:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53613 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233859AbhFRUqB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Jun 2021 16:46:01 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E36425C00BD;
        Fri, 18 Jun 2021 16:43:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 18 Jun 2021 16:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:content-transfer-encoding
        :in-reply-to; s=fm3; bh=GiYOObsI0bqK8lc41cH7+GPIx9Zzc+cskUfBHanG
        y8Q=; b=uj4GeQTv3YMN3vf37wWLBq+nnQ7q6DyJDpg9UQup8lXLRTNQ4l6kz4lM
        Wj9VbURpvuYL+F57mn/fU92FretehuIbvYvnYaunm29lFW6l9v0POJKl601S3Q+x
        Sc3j8CRffdX8/L/nVWTVrCCmfmWEbysqcTDtP6HFixRc30InB48ByMDUAj4Rah0s
        eg45MND3ru8kD3XgaI9CxJpdatk+8/39ABivgtXL1OGTzNROoxtN4K9Q808M2sAv
        tgChXW6XrUxl37aRY8w98j2b4Adc24rkesNrJGVPmgx0FNOM+fsZJBIEZxz3t+sZ
        A3y91MASbZLy2LCLiinqraHJkHRPAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=GiYOObsI0bqK8lc41cH7+GPIx9Zzc+cskUfBHanGy
        8Q=; b=HMnAgE9Q0pTYmE2SXOkx56sk3fP/jo9O1SvwewnliOsFgW7El4GHSb+mQ
        6Ctld83BgyuWBxZD3XrPY1+V1McAtifWZTRaUAqdUF4Jsdxmj2ne+zcT3v2dkZbr
        0O5AtC6hat6b/qvrey/RP4Vxhr7m6UJ4WRaQP+vJ2KRDjMem25EwkkTSSlV9+tk+
        /AohyiO/slWfzCU9KpztKle+s0jauJYLyY0xzcocRPxfrw0jpvxqmXQwE55IrfHy
        Bl1ollctQum2e0raRo6WPWAWk3bon/CMt6mW+7O3dBrNdbb36ZPxhYmlRa7UoOGq
        RiQci99WFE2nPz8i3Rq5l8G5HOAtg==
X-ME-Sender: <xms:hgXNYNP4RZYOruf2lfLDLpZVh97kqht8kVcs7ivy6hszoNmbDNg7JQ>
    <xme:hgXNYP-f0n0VBk4LFjgtCGdYOiaroFTnOZyZ3ZXgVjT3zD-8XT8G2NvLQI_etAW7Q
    s6RFzE50lwdImEC>
X-ME-Received: <xmr:hgXNYMSR4WZfCAO-sdNSyK8JjSqJKKD9dBI7dRh_U4xUCv5-fp-76O1KCY-lNlpbZRFDnbWF_n4zuk4RRWk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeffedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjfgesthekredttderjeenucfhrhhomhepffgr
    vhgvucfjuhhsvggshicuoegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhgqe
    enucggtffrrghtthgvrhhnpeehgedufeetkedvgeduieehieeuhfekleduhffftedvkeeu
    hffhteevleetgeethfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:hgXNYJuUlBQ6u2bmKPST9TXtIqoUuhh2MijFKxssUfrlL6KhjEdzwA>
    <xmx:hgXNYFdM7uUbVKMfv8B8FkWhr30bcDoXX-SXam8bz8Rrn9dta5jvMw>
    <xmx:hgXNYF1HJ1I6DGnjQjKjci5Nw2hR_KjCgxNM293NURkR4HFVL6_WxA>
    <xmx:hgXNYNQ4vz5As329XlooI70fh5Toe30jBz8pcOgFxMeikG4IPnG16Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 16:43:50 -0400 (EDT)
Date:   Fri, 18 Jun 2021 13:43:48 -0700
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        stefanmoch@mail.de, philipoak@iee.email, bagasdotme@gmail.com,
        sunshine@sunshineco.com, avarab@gmail.com
Subject: Re: [PATCH v3] doc: writing down Git mailing list etiquette
Message-ID: <20210618204348.GA3763@localhost>
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <20210512233412.10737-1-dwh@linuxprogrammer.org>
 <60c0fc311144f_1096b2081f@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60c0fc311144f_1096b2081f@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.06.2021 12:36, Felipe Contreras wrote:
>What happened to this? I see value in having this document, so I would
>be glad to pick it up if you've lost interest.

I fell off of the face of the earth. My life turned upside down but it's
slowly righting itself. A number of things took me offline but the last
of which is my father nearing the end of his life. Things are stable for
the moment so I am getting back in the saddle. Like I said in my last
update, I'm going to try to combine all of the contributions and
feedback into a patchset that includes Ævar's patches and cleaned up
versions of mine on top.

Right now I'm trying to get my head back where it was.

Cheers!
Dave
