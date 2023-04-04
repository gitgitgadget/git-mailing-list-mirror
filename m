Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E95C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 10:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjDDKTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjDDKS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 06:18:58 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26EB211D
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 03:18:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C6322320092A;
        Tue,  4 Apr 2023 06:18:21 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 06:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680603501; x=1680689901; bh=yR+ZCzW1jLxyaXm2ImkgFqyq5
        J3bDUc3LHskicKZs20=; b=ZMy33ab91vrpRHcTGq2ieTdOCamqUfW7W9M9JF6wg
        640NN9hGSPF7DxWGQ6zLNqqwgMBtp5/Hw2p1SDvmm99bH4yeWR7hqP0mY6+vCodL
        ONANecwCozkOvW6G9qsO/Ep+lZnTHl1C+88bXMEkc6EuQs43ChcXL+Qqbszul9NX
        mNhj5pWlfc0bHDlkxyzCrW2uamdGOiFepdC4K5cfNhhov7CoOW/W9BzXTQsgSyIP
        WDs3EtFStY4DO29i0IxfE6Ma+ej8dasw1OjrIuZSyCeizuave5eheKKhh5VbuVF3
        8taJGe0Pz4P1jRJIA1z1kWFjQgPhe/B2TlyZXCilDfvJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680603501; x=1680689901; bh=yR+ZCzW1jLxyaXm2ImkgFqyq5J3bDUc3LHs
        kicKZs20=; b=gofDcRSUUbFv9A00h7Fec52YQW5fWePSU5kxWr32NlMSNEPdzxt
        c7AHVx1Q6G/OYuHEBJwKDsnkq9yZv/ZrA5VijtWp0vbHVW3TQgWSNBzOVZZHk4K3
        hbVJ1HaAPJb5hZqTPkleYEXSDHstOHzUD3z7IFdBMwDKeQnrrUPwGXGwW6wZ3Zdu
        xyZeXZJF/64zfL9b3EBfWg/xsQZhAweMd7VLkqQJ/Ft8Qe4czmYfrgbihf9BtFpj
        NV/0IutPXnBx8ekkSbXC7tTqpdhj62jduGY17BB91ZsnlvnmSJ14Ay3uzG9O1myo
        gn+iLL0nT0WZ7kGtoe93J3bWia8dDly20nQ==
X-ME-Sender: <xms:bfkrZB_tsjABCo-jmikOtak_y_EfeBR6VAbpioenr9X4s5izUPqs4h0>
    <xme:bfkrZFvswj9XHQyNV3MS9NOqQj-CqsaJqr5VyGIRBmbmS-8OrsrFj53KNCxVfX26w
    5-9JJLaoQqWKGNl7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:bfkrZPC8nAs0RyqaOVrrrSXr7fvk9wg6pnZ5_1JD_BDV-7yYtpbPxA>
    <xmx:bfkrZFd-n1VI_ggIelvxGIV5cUl4pYg7LTxbrKN_wRofr-7HAdjuWQ>
    <xmx:bfkrZGO54uaFhQLaMfq3GEIc7EU2_9BtGxn9v68USTo7yIzLAZO7Jg>
    <xmx:bfkrZJYv2Gacw8iK02LWMRTXubgkfIirYbvjGODD5fMb0EvO76F2Yg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2091815A00A0; Tue,  4 Apr 2023 06:18:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <8135fc7b-1953-4702-a9c4-b0f847e69887@app.fastmail.com>
In-Reply-To: <3473764.PTxrJRyG3s@earendil>
References: <3473764.PTxrJRyG3s@earendil>
Date:   Tue, 04 Apr 2023 12:17:43 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Thorsten Otto" <admin@tho-otto.de>
Cc:     git@vger.kernel.org
Subject: Re: "git diff" does not show a diff for newly added, binary files
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023, at 11:58, Thorsten Otto wrote:
> "git diff" does not show a diff for newly added, binary files
> [=E2=80=A6]
> I expected a binary diff for the new file, just like it is done
> when comparing two different, already committed revisions.

Do you use `.gitattributes` to get these binary diffs? What does it look=
 like?

--=20
Kristoffer Haugsbakk
