Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D8BC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 23:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKHXI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKHXIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 18:08:52 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096081D30A
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 15:08:49 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4714A5C010E;
        Tue,  8 Nov 2022 18:08:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 08 Nov 2022 18:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667948927; x=1668035327; bh=E481aev9Swz6CxUgVvEWqoBoCAqD
        Inl2RJ13HLsS7Fk=; b=Jme/DPOUoDc5K0P/YO634ZdqDqev/NmrLtVk5thtV1C9
        zSrydNiexey0FuwJJxi59/tjJItmGSoLYQXeCWO/Og9FAf2go12lFjgT6H9Ipove
        XPd7uK+hKm1qqaXfKCIWCVEjlvjMj8Ufrp09GtZq8R01PfnfVXhu3otrZ//IjC64
        oV5RtF5UBJqUoDpwiAL5TqJBZkjsIGhfoCFl4E75YBTua55bDeKCrirpJilW5+sj
        DaIslqqrpBT84n6O9o3nqLYuMzry4BE69xy8sIbX8d4+knbns+d8/IC+fBP9YQ5l
        SGHRAfcSohxzugyalnYd6laHAq7ImFbnYbk3piC4fg==
X-ME-Sender: <xms:f-FqYw8afv8N-CeUF9ghhQM352Ga_fajmFi_32LIcAXRFMb6txcdcQ>
    <xme:f-FqY4uu5GMarEq3YQ-Wnyu4nBWJNQB4xqM9_pLcW-3rgZ5ugEm1CpkffG9LP5HCE
    RIhKRvbxVRKpirT>
X-ME-Received: <xmr:f-FqY2CLs2ZbqtbW2zy3LoVxd72YjRI9RM3AvfS0rzw_fP7PYiWo1YDFoYx6auk4m7ieVj-Ih4wrzCmhO_O-4h7mmScwm1Fo0zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedugddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepfdflrdcu
    rfgruhhlucftvggvugdfuceophhrvggvugesshhighhkihhllhdrtghomheqnecuggftrf
    grthhtvghrnhepgfetledthfeutdfgfffhtdffuefgueevueefvefghffhtdeftdethefh
    geethfevnecuffhomhgrihhnpehjphgruhhlrhgvvggurdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhrvggvugesshhighhkihhl
    lhdrtghomh
X-ME-Proxy: <xmx:f-FqYwcEDgsYCL0m8FmduVwpA2SHBPsEsrgE8YETm8_W77_9OBCuaw>
    <xmx:f-FqY1PFTVGLJQQlqy3cUuhcR2E-s9XUxzS50YYVgewsUWHPhn_Oiw>
    <xmx:f-FqY6ky0OCYonNdq8Tyb4yRcttx4ToSCAYtoXwbajTDKswTPyu_iw>
    <xmx:f-FqY2rkYnlu3hKJwQUX3LTaesYIkn0NdgyFQRy_lynottFXA6m7lg>
Feedback-ID: i4ce04002:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 18:08:46 -0500 (EST)
Date:   Tue, 8 Nov 2022 15:08:45 -0800
From:   "J. Paul Reed" <preed@sigkill.com>
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Odd git-config behavior
Message-ID: <Y2rhfTYDEGQ7EhaS@sigkill.com>
References: <Y2A1bdiw6kGC65f/@sigkill.com>
 <bc3aa4b1-4716-cf9c-5dff-22b25793f66c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc3aa4b1-4716-cf9c-5dff-22b25793f66c@gmail.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04 Nov 2022 at 07:47:46, Thomas Guyot arranged the bits on my disk to say:

> What prevents you from getting the owned uid or the repos and forking a 
> process as that user to run the check?

Laziness?

I should note: these aren't really "untrusted" user repositories, so I'm
not very concerned about it (though I understand your point).

This does beg the question: does running "git fsck" on an untrusted
repository as another user present a [security] problem?

If so, should it?

> >      2. I think it might be useful to warn the user that the behavior they're
> >         expecting isn't happening due to this security check, instead of just
> >         outputting objectively wrong information (i.e. that no config options
> >         exist when they actually do exist); I'd be curious what others think.
> 
> What was the return code for the git config command? If it was zero when 
> it didn't parse/output the config option you asked for that is 
> definitively a bug. If you failed to check the return code of git-config 
> then you should fix your script/tool instead.

underworld # ~preed/src/git/git --version
git version 2.30.2.4.g8959555cee
underworld # GIT_PAGER=cat ~preed/src/git/git-config -l
underworld # echo $?
0

best,
preed
-- 
J. Paul Reed
https://jpaulreed.com
PGP: 0x41AA0EF1
