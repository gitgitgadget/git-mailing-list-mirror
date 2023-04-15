Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F565C7619A
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 14:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDOOLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOOLI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 10:11:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A769F49FE
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 07:11:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A6195C003F;
        Sat, 15 Apr 2023 10:10:58 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sat, 15 Apr 2023 10:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681567858; x=1681654258; bh=Z2fdlckXELBaRmCgQ9l63NuWD
        0V/LyvdFxh3HWdnJ+8=; b=gruOnMgi17AF3thR1hzs32CkLq+tqd78ZyxgN61YA
        a0ABdD1+L2eaW2Mt9sG2oIJ6w/NGfhbuMqg9T5dl8rG1TxuyQ0ydwfeWlZyKQPeC
        H7gFDtNiKk/tSvp+FUPPluIMSElaYkMywhoK1ORSIIT4Xe60A+iBm5KmvJvDKYqu
        9UdswwezLYzl7I3fkvdryrEgy9HJ8pMZupxfKBg0aYK9JdWhwB4HzeNiT8obMfaf
        cEqFZqpTPye6AVgKZrGaGrvJImUN9T8zWr+bPbOrYGKCgP9iFkY/DvIMyKusSHLM
        e+k/pKBLFNEzeA40Fz/HCGFFFkYK5wyeAdlSDsSKdeyhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681567858; x=1681654258; bh=Z2fdlckXELBaRmCgQ9l63NuWD0V/LyvdFxh
        3HWdnJ+8=; b=LFZdPnOt7eMj5FdePkaCp7K30j9p+V+G5STd3Vcuz6R6T5+5Gnq
        ioF/TPhDeGAGcO8JkTiKhfJQNDV8rTTKB4Uu2hVybCH45MdH1iMTb0OHSiCqnMlM
        zstSOFp1MBUEJO5kJgwJdqptMj1S7CEQ+rjx2mlA+EyCcUhurLNfE1/rN03De8Yi
        t2RnVBFLlFT5FulbmM8Tyr+m1xKJlDVEo8GyeCNJpH7aO/uIKK3kpOoGVbPpGSmW
        skV4N+MgpUjh2GuZGCh4ezr1aTVPQMQsoORrZiXS1eWENceQFk7F9O8/fa8DgcEv
        Ra3vU7ukKJptFMhYXG8SFqCjHwdiySxA0Xg==
X-ME-Sender: <xms:crA6ZBDZFKK2kVx4t1fq9GvTU3Mz0oQ8NVWOkFRqSj7CUhbkEgQn49M>
    <xme:crA6ZPjnmgDFo-Md5eDHdH3ycTYqKDRHWRGUn8tgKxJ2uQiYnQiQn11oG9Z1vYIp3
    thc4_lhUjcxzZiO5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epffevgfdvvdeftefffeefvdeftddtueduteetffeukeefteevuefhkedutddvlefgnecu
    ffhomhgrihhnpegsrhgrnhgthhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhn
    rghmvg
X-ME-Proxy: <xmx:crA6ZMnsXU7ufitAAqJLRR78elBXJOkowuRvaXFK03qqF0yxotrz9w>
    <xmx:crA6ZLzT6ZwDHnc6shZESP0sxo3_bh_fn4jYqTtHOiE3dsZzK-Sorw>
    <xmx:crA6ZGTTXVmzaLeAH6QhpA8GVrRrOun2g2SOP6DqIiO5TrafpUjEIA>
    <xmx:crA6ZNMhp0gYZWq8GYQjZ1e6MKrwVgixO70NtfP6hKZaMI0ez-24CQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F26F515A008E; Sat, 15 Apr 2023 10:10:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <141f0f6b-ef5e-4470-b86f-7ebd6c2be3ab@app.fastmail.com>
In-Reply-To: <20230415085207.GA656008@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
Date:   Sat, 15 Apr 2023 16:10:32 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order': Commits
 from 2011 are treated to be before 1980
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023, at 10:52, Jeff King wrote:
> Of course it may also be reasonable to consider this mystery solved and
> leave the code as-is. These objects _are_ malformed.

I started to run `git-repair`[1] on the repository yesterday. I=E2=80=99=
m not
sure yet if it will finish.[2]

[1]: https://git-repair.branchable.com/
[2]: https://git-repair.branchable.com/index/discussion/

--=20
Kristoffer Haugsbakk
