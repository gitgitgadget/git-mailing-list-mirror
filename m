Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18FDC61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 14:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjBVOsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 09:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjBVOr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 09:47:56 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B423C79B
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 06:47:28 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9799D32007BE;
        Wed, 22 Feb 2023 09:47:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Feb 2023 09:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677077241; x=
        1677163641; bh=b2Fi4CvthBQszjauOdTo0GebBuOimqvhPxdR8ss78UE=; b=1
        yxfUgdCfoQiRlo5TdLy6D5P1BtUdrkne1VZPVSxY3V8XmuEmt+yw+HpD3U3Yow2B
        f2al86dS+HDREpb+5kuSYex6yH+Rh9r3xjd4nkLk0dJO08Ouj+vj5YmzgG9/Hl1v
        1M+kDByGzIx2CTaPCuuEVdkHEkdsZrvVEDrWQ6BaAKGWgGSlvNLEnq3ffzEsKKNi
        Z4XsoAa2mmSWUO/MlcrqU0Ai+2qb9H5k59QeYcsZJx908aLlkuNxU5bAHRtrxpM+
        2Gzom0NFUGVCW1jaKxcPtvIs3QkMeXLhtPDLq8MpdrdbdPKTUy18iw3ZLzojgQdL
        FuNUyRvHb8xbi+LfjtUDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677077241; x=
        1677163641; bh=b2Fi4CvthBQszjauOdTo0GebBuOimqvhPxdR8ss78UE=; b=P
        ygCZnt8GysLYsQaKmFJinbs9rtaTwNF8vEJrpmozDsqtVHxI2H0boLrgGTwBS9Q0
        Rrm/TDHc4/YpWobP0jWekV4xQ2hcCtrTvRzO9ss3YXsufkw3ZZcrjCEP37eEqh3m
        /d7wajXspbw973Vn/LeLy9iZ1JYnemOARhyWxQhyBtbIK6XLX/tG5ctlRquGBrbI
        2RmplpyQtAhOUNQYP279J710p4xyvHYJr0TCgN/45LJFC1rJzpGtWJCBh4Zsqp65
        qDe5Kyw5I5jfaIII9HEmGA6M6qlVO31nvU6/Ts9KrKzxtg4/xlYKsIy8pnSAqWbf
        G0/n27euyf5294vAX/GnA==
X-ME-Sender: <xms:-Cr2Y7od-K-LMn9IPpRLZkenKeTIT3-Gyj__cGbeNKTfWzvixdrQyQ>
    <xme:-Cr2Y1rgx9I5bFN9cPJ_FM_PG8acV1yybXad6qiyXbKXhs-9AfpzyuWC5fJiDOMUl
    qRKvQqcgS1hpHUc>
X-ME-Received: <xmr:-Cr2Y4O6AykfSyfIkmRgd681ZY_9eBLBqNrzlpIQzCa_SB89SNeaqyoDVydfCdFgzgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepkfffgggfuffvvehfhfgj
    tgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghnshhonhcuofhuihhtvgcuoegsvghnsh
    honhgpmhhuihhtvgesvghmrghilhhplhhushdrohhrgheqnecuggftrfgrthhtvghrnhep
    gedtleevvdduveelffdtveeffedutdehleehgfehhfeileejveffhfeuudfgudegnecuff
    homhgrihhnpehrugdrnhhtthdpnhhtthdrtghordhjphdpnhhtthgurghtrgdqtghhuhhg
    ohhkuhdrtghomhdpghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsggvnhhsohhnpghmuhhithgvsegvmhgrihhlphhl
    uhhsrdhorhhg
X-ME-Proxy: <xmx:-Cr2Y-6Hz5_g6YYooduTa-2bhwl5NhBMU0ciD7R1Wb4jFqAbFU-SZA>
    <xmx:-Cr2Y654KG9OLwVN4jf_pbmpwgx2Az6q_Q6oVeCnQM5jXpSwAKGSog>
    <xmx:-Cr2Y2hS9lWGxBTgqNDySUTjMVMfkqaOzjmm9R9CNhlbK5LnLUJJjA>
    <xmx:-Sr2Y6GtHLejw5PVSV95tsDe64Qb4I8xOWRWgSrOtdwgEer-1nckoA>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 09:47:18 -0500 (EST)
Message-ID: <c7274d1c-0b26-cb5d-34da-51062ac8a93e@emailplus.org>
Date:   Wed, 22 Feb 2023 17:47:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: =?UTF-8?B?UmU6IOOAkGlucXVpcnnjgJFFQ0NO?=
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sora.Ueno.bp@nttdata.com
Cc:     Yuichi.Watanabe@nttdata.com, git@vger.kernel.org
References: <OSBPR01MB5223CD2469D1F8A8A5DE2E3CF3A59@OSBPR01MB5223.jpnprd01.prod.outlook.com>
 <5377cd67-3191-3758-69a9-ff39fbddac12@gmx.de>
Content-Language: en-US
From:   Benson Muite <benson_muite@emailplus.org>
In-Reply-To: <5377cd67-3191-3758-69a9-ff39fbddac12@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perhaps check with NTT open source office on their recommended
procedures, they maybe able to advise on your use case.
https://www.rd.ntt/e/sic/oss/
http://www.oss.ecl.ntt.co.jp/ossc/

On 2/22/23 16:44, Johannes Schindelin wrote:
> Hi,
> 
> Git is not a product, and the Git project is not a company. You won't find
> any joy in trying to get anybody in this project to provide you with such
> a Classification Number. It is highly unlikely that you will get this kind
> of support from volunteers who are not paid to provide that kind of
> support.
> 
> Also, insisting on a reply on the same day seems to have the adverse
> effect of what you intended. This is an Open Source project, not a
> contractor you offer money in return for such immediate demands.
> 
> To top it off, sending such a request that has nothing to do with security
> or vulnerabilities to the git-security mailing list can only elicit
> responses that you don't want, trust me on that.
> 
> I hope you can find what you need elsewhere.
> 
> Ciao,
> Johannes
> 
> On Tue, 21 Feb 2023, Sora.Ueno.bp@nttdata.com wrote:
> 
>> (外部送信のため渡辺課長をCCに入れています(外部送信する理由：輸出申請に必要な情報を得るため))
>>
>> In order to complete the necessary export process,
>> I need the ECCN(Export Control Classifcation Number) of
>>
>> ・Git version 2.17.1.2
>>
>> Please tell me.
>>
>> Please reply today.
>>
>> 上野　空 | 株式会社NTTデータ中国
>> Sora.Ueno.bp@jp.nttdata.com<mailto:Sora.Ueno.bp@jp.nttdata.com> | 050-5546-8996
>> 108－8505　東京都港区港南1-9-1（B） ＮＴＴ品川TWINSアネックス3Ｆ
>> www.nttdata-chugoku.com/jp/ja/<http://www.nttdata-chugoku.com/jp/ja/>
>>
>> --
>> You received this message because you are subscribed to the Google Groups "Git Security" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to git-security+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/git-security/OSBPR01MB5223CD2469D1F8A8A5DE2E3CF3A59%40OSBPR01MB5223.jpnprd01.prod.outlook.com.
>>

