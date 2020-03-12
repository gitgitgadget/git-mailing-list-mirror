Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E25C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3712206F2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="Po5lwirU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxHDUsOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgCLEN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:13:28 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42849 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgCLEN2 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:13:28 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 98AF221AD2
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:13:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=X9AgYn4TJO3xALjVGWyemttjiwJR2mCDMml2BcsAf5U=; b=Po5lwirUeqA4
        zSiuhvddUzivjt1vL0Roqk9FNbNq713YJukJx6eJ8xoxk7lpiqZxUZmMl3g4nZJA
        P3UI0lAc7F0nDGfj3YXLMlhWFT7PM6y6cqbsENJkVwrDlStcA/jJoeflPdRySDJD
        pum/seaaF2ShOoy1bu2Tgq82UCZDa5g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=X9AgYn4TJO3xALjVGWyemttjiwJR2mCDMml2BcsAf
        5U=; b=mxHDUsOtRDryl9B0xlPtzz4EBq0axGt/4T/VOcnYDPQInVbzYpP4MfWp6
        Sk5pwAxtM87jRAmxBI/NtdEEHjiP8cagf+gBtAuS5RAYIpAeVG4O7TWzdQPEtgTL
        XkbnPcy4MEM6tkx48snmVKhowoTS3IyB2+CYYcCCUfm9DjaCoknpyE/hJDQup0ia
        Oes4sNax7T7+hBhhKt6NZNnW2szZYohthNKJ58o3hCeXqGwe03XB/vMoraXj8AKu
        Tl7f/2k6pjhf9m1jZVUNiBOKTyQPi8bDyVboECHW96giTQPfCjdjmVBV+hySkNZE
        l5AlG29ax2jkEKMqoHDU8noU1Ms3A==
X-ME-Sender: <xms:57ZpXgkdKpLFF3YNVm2wT3w3iejefOFGO0w9LfucjZW99oB6PSD9bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:57ZpXnPpWLIAnVIxEBX6x5iiaTa8WYO4Fq-KOJtBmLEh1kyr8KNHXw>
    <xmx:57ZpXkO8asA88Y87gpGNlw1NwYL37uvjyAYxMNVRa_GZgSuCKzvzdg>
    <xmx:57ZpXog2nmXD03nSDF5BRJvM-jUiiIDsIqLm6arHU74D385o7VwxsA>
    <xmx:57ZpXrvWAfb_dkWWwTXFpI4WSTSvYmvoItkYIMaKC7Xyvb9WPREB3w>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA8A9306130A
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:13:26 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 15/17] Reachability checks
Date:   Thu, 12 Mar 2020 15:13:24 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <82E8EA09-EFC5-47BD-84C1-C4F5BC98580B@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Jonathan N: seed the idea that it would be nice to hint the ref that 
your commit might be reachable from to help the server avoid iterating 
over all refs. Also, any strategies for speeding up reachability checks?

2. Demitr: reachability by user, or would you consider open to everyone?

3. Stolee: we don’t do branch level security, but we do tailor ref 
list to default, favorites and those you’ve pushed. There is also a 
full endpoint.

4. Brian: security model we have to have is that we assume everyone has 
read to everything. There are too many ways to attack. Useful for 
performance reasons, but not sure reachability checks provide much 
benefit. Don’t think it’s difficult to automate.

5. Demitr: what about security issues

6. Stolee: we’d say find another way.

7. Terry: we have a mono repo, easier to test everything. JGit goes down 
to object level.

8. Peff: Git doesn’t go down to that level, doesn’t validate haves.

9. Jonathan: two lessons, no one except Gerrit cares strongly about 
this; second if we like the model by branch permissions, worth making it 
work well in Git to prevent distance between JGit and Git.

10. Terry: can remove a branch very quickly and prevent new people 
getting it

11. Peff: don’t deny its usefulness, but the performance implication 
is concerning. Trying to keep objects private from determined attackers. 
But pushing a malicious commit to Linux, a user can see it, and won’t 
understand reachability doesn’t imply endorsement.

12. Jonathan: if Git has an easy cheap way to do it, people would use 
it.

13. Peff: have flirted with it, but might have to open 50GB of 
packfiles, or bitmap has corner cases. There are some obvious ways to 
improve, but a lot of work. V2 spec says you’re not allowed to check 
reachability.

14. Jonathan N: nah, it says you don't advertise a capability describing 
whether it is checking reachability.

15. Peff: submodule, but then the commit disappears and becomes 
unreachable. How do you handle?

16. Jonathan N: encourage folks to do fast forward only updates. In 
hooks instead of the git layer

17. Peff: you might not know what ref has reachability to that commit. I 
like the hint thing, if it’s just a hint.
