Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6C5C61DA4
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 09:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCEJuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 04:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCEJuI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 04:50:08 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9543DBEA
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 01:50:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 72BC73200583;
        Sun,  5 Mar 2023 04:50:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 05 Mar 2023 04:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sebyte.me; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678009805; x=1678096205; bh=3z
        05jVn01zcJUOzt4zIYbQXAB7i4eBbvufppN1h3wEM=; b=THM8Rva1wSPQunDWii
        oBmLT5/kf/U5TJrmE4ui4/UZ2vOD6ohBVoGUoaMRB89LALHDwS9XFjBKtUdxMraR
        g9qvW6gOaTQiNxEiOTq9zdelNGTYxIDgcfyAVd9w4KRCQxlsPZxPgITPtkFt4NsW
        7O3Orro0WFc9TIPnstfQSw/N4NXxHFT0UbBqTFJdZTADkFDxM+p/8NolSuFPHKH/
        WXIaC1zFSPLprSKXflVmVafFFjHX2lIYilR3IZnFeYeD4hkVqsshM5mdk82iNvYp
        rJkaRO71UTVBd3PeIwiqo9MUFJ88nrlyqbKI9gS6gVR+yZz7n+6JKa3BBCmfcatO
        S21A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678009805; x=1678096205; bh=3z05jVn01zcJU
        Ozt4zIYbQXAB7i4eBbvufppN1h3wEM=; b=e+Ezl5oD2k7EyMIWwdtV5eP9OXg/S
        27NRp+cvgBV+dxVAWFhfNajZ20/rn98i0bZVBxnI/612MoPHjh+bceTnKT9iV7ML
        pQA9tdWbRfb4k3aj9lEQ/LJaY0zb3folqPZroB6Aggi0hivm8rlaSVJg3FWiMVu+
        CDI3Hvyx4lBPpaArRiv5T4a5RkZ2mzkKmDvicQplQgI4qamcgwmwTKNOSUQe9aB8
        FXZgQbf6wcWUaZCdo97ap9ZafWHnvbv0MTS/LvfAlBmubopnWi+XyCEr/0suisyu
        2sxhhRLlPBK/1T8zf9dnFBAsv7OY038vFMyCkVYFzOh5wBrxsZGxYfY+A==
X-ME-Sender: <xms:zGUEZOH66rMcsI49NXTC3s5b7lkK85kJD4iQeeHoCjjUUhI5n-XPTg>
    <xme:zGUEZPUT1WUd5Fg5_g5vErD1zGWQgW2-wItxDf1twepkRvmhcYdo674f__J74fAEM
    DmRrDXpQgeUq8JaNA>
X-ME-Received: <xmr:zGUEZIL1454ORPh7gCw6xGFvdL7RzOwgOAn4yOYUx83u04Bhz6u905rRjfFZf_Q_NTtNxPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufhfffgjkfgfgggtsehttd
    ertddtredtnecuhfhrohhmpefuvggsrghsthhirghnucfvvghnnhgrnhhtuceoshguthes
    shgvsgihthgvrdhmvgeqnecuggftrfgrthhtvghrnhepveeuiefggeejtedugeegtddutd
    ffhfeiueehudekveekkeffgfeugeeugfeijeegnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshgvsgihthgvodhrvghtuhhrnhdqphgrthhhse
    hfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:zGUEZIHAXcqL2d4h2cE_rvRWXvPDRoiSdu8uraL3N3k8umwWgWRUMg>
    <xmx:zGUEZEWhDvZWWFBxWCPbxO_QX3DSGsuDFiJbzI3RE8UvIQngHhV20A>
    <xmx:zGUEZLNEoesAnRgLXT7grLbsZvk-Ym-eCVI1h39Msm60XEM1VtHfFw>
    <xmx:zWUEZNeA9XI0VpflqcLRW-d3FfIQz9rXwXRROAEWqVH3-tuxWqG_uA>
Feedback-ID: i9e78401f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Mar 2023 04:50:04 -0500 (EST)
Received: from sebyte by balor with local (Exim 4.94.2)
        (envelope-from <sebyte@balor.gnukahvesi.net>)
        id 1pYl0F-0015Jf-9g; Sun, 05 Mar 2023 09:50:03 +0000
From:   Sebastian Tennant <sdt@sebyte.me>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to mirror and augment a git repository
References: <87ilfgemkb.fsf@sebyte.me>
        <143e4a36-02cc-d2a6-ff60-6b143d9e47b4@gmail.com>
Date:   Sun, 05 Mar 2023 09:50:03 +0000
In-Reply-To: <143e4a36-02cc-d2a6-ff60-6b143d9e47b4@gmail.com> (Bagas Sanjaya's
        message of "Sun, 5 Mar 2023 16:02:05 +0700")
Message-ID: <87mt4rcyt0.fsf@sebyte.me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoth Bagas Sanjaya <bagasdotme@gmail.com>
on Sun, 5 Mar 2023 16:02:05 +0700:
> On 3/4/23 19:19, Sebastian Tennant wrote:
>> Hello list,
>> 
>> I wish to mirror _and augment_ an upstream git repository.
>> 
>>               .--------.
>>               |Upstream|
>>               '--------'
>>                    |
>>           .----------------.
>>           |Augmented mirror|
>>           '----------------'
>>            /       |       \
>>    .--------. .--------. .--------.
>>    |Client#1| |Client#2| |Client#3|
>>    '--------' '--------' '--------'
>> 
>> Clients of the augmented mirror must have access to everything
>> available from upstream but must also be able to collaborate on
>> additional development branches not available from upstream.
>> 
>
> I guess the augmented mirror is integration tree before changes
> from clients going upstream, right?

Some of the changes introduced by the clients may end up being
accepted upstream.  The augmented mirror is primarily a way of
collaborating on and distributing customisations between clients.
