Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B90FC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJRBkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJRBkC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:40:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F304DB5A
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:39:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CC6745C0217;
        Mon, 17 Oct 2022 21:39:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 17 Oct 2022 21:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666057195; x=1666143595; bh=npIpXjYxyc
        sTsjjsGdWr+jp9XSi0DT8VSnDx/W9y/F8=; b=OJGsXhK9PBPs6nrCynWlbMGJYP
        3Y3DnNsBm1r633YwiReaKEanVoI3SibFkBoGsXZ34Gn832sW+xTprp9bWGLMQqIY
        iE3kmfosv4VdqKp2tufA+68wxaZ3wtEgPhVssWmbVl40oDVexCSHI+rVhpMUfnU4
        +YM9shmy9e8pOoLAp/k0D+doFhH4k9uQGHECUWV2glv3ErsGWkX6byv/ZLQg6SgT
        G6WhRdiSsNaelWiGoylsDL6hLblekStGpHLL7ee1mQNo+uCkOFfV85rMclUgDr70
        ufiMMDyiRstOcOwqxc2b5ckooRXInEisUwI9a875j/N4TMXN50GoCzO8yrVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666057195; x=1666143595; bh=npIpXjYxycsTsjjsGdWr+jp9XSi0
        DT8VSnDx/W9y/F8=; b=svtkSjwV7gpOCGWTIuK8IJvub+OZIFL4RXNm7oAdAtbH
        +Lnm9pg0RTIZq4QCgy2rz/l9UGA1Twksk6U1LY3WqLPyrDTDYCzenS/XtvCCaDqx
        nBTyMASAjL4H8bhFWUqmFJe7iMN3Y5lEJS48jyuHv6cTj7AzyF5faa7jIUUkejxK
        vbZsRLcCH5Fca2RF+Hqio2f/HgBBDW5Ef2qFetsPhawQWNA4AtHwQC2qYBSSVhm9
        wqkd79JCNDqQA+iVY9qcJkouc8TVZniW/JITJByZLliGOWSTyj60vTD5SoTP/PFG
        HUc/RqG2Bs9TFGJmaL1SQ01cizUjmXqY64IuROu7fQ==
X-ME-Sender: <xms:6wNOY_d6Q5rlKLnXQnntgl0ejI6xTpUG_5-Mm3o-1jRFO5nwf21EWg>
    <xme:6wNOY1Nh3yTSxhvD8uqQp64cFTBGtrvUOF0IArQztrrjX-wNT9dv-nlHRKiI7s9Yk
    8jvJ6WxFBUySbxkAZM>
X-ME-Received: <xmr:6wNOY4hacQ4n1T_yh7TG8e4InrGhpFw5jwk4i6C9Dvjjc7gvb5EGaQMzXnAPw5NzkIwAy-pnkcMGjYudw-gNSTQfDHZhCeCFVS4KOnJAN3Rd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeltddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepofhitghh
    rggvlhcuofgtvehlihhmohhnuceomhhitghhrggvlhesmhgttghlihhmohhnrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuleeltdehjeefieeutddvheegteevgffhkeffgfeugfek
    teeiudekkeehfeeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmihgthhgrvghlsehmtggtlhhimhhonhdrohhrgh
X-ME-Proxy: <xmx:6wNOYw8o3ac9Y9yhhssZii70dVXu4YnfiKz4foPpucnaUq5bQvlRnw>
    <xmx:6wNOY7tMP1e-0V3_9a59tY96cAhCtxbsY9Ut0L55hqYo7kBBb9XUmw>
    <xmx:6wNOY_FJLmzPn9860rkP49CJn_-W3_u0Y7TtvBeC-TyaNt1VIOtV4w>
    <xmx:6wNOY7KcYfbrblGERWzmHMJWB_lFLFvlvh0dCGRjzucVskc2WCgvRA>
Feedback-ID: i9dc944d1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Oct 2022 21:39:55 -0400 (EDT)
Date:   Mon, 17 Oct 2022 21:39:55 -0400
From:   Michael McClimon <michael@mcclimon.org>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Git.pm: add semicolon after catch statement
Message-ID: <Y04D66rlhYhP99RU@newk>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221016212236.12453-2-michael@mcclimon.org>
 <Y0yRStZ6gM+H8/Bf@coredump.intra.peff.net>
 <Y0y7UdLf3qd7RgVQ@newk>
 <Y02SHlW1rNQdfCHI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02SHlW1rNQdfCHI@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yeah, this test is particularly confusing because unlike most of our
> suite, it drives the test harness using a separate perl script. So you
> have setup in one file and tests in another.

Oh good, I'm glad it wasn't just me; this was very helpful, thanks.

> 
> But curiously this still does not pass after your patch, because we seem
> to actually open the repository! I think this is because the C code
> allows an explicit GIT_DIR to override the safe-directory checks. But in
> this case that GIT_DIR is set by Git.pm searching for the directory, not
> because the user desires it.

Aha; this gets to what I was saying in the cover letter, which is that my
patch only fixes the runtime error from perl, and Git.pm happily carries on in
an unsafe directory. Fixing _that_ is probably beyond my knowledge!

> So your patch is definitely still the right thing to do, but it feels
> like a hole in the safe-directory mechanism, at least when called via
> Git.pm. +cc folks who worked on that.

If we wanted a test for just the runtime error, something like the following
(including your earlier suggestion to set up the bare repo) demonstrates the
bug and my fix. It doesn't seem like a particularly valuable test on its own,
IMO, but I'm happy to reroll if we want it. Thanks!

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index e046f7db..72681849 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -30,6 +30,11 @@ sub adjust_dirsep {
 # set up
 our $abs_repo_dir = cwd();
 ok(our $r = Git->repository(Directory => "."), "open repository");
+{
+       local $ENV{GIT_TEST_ASSUME_DIFFERENT_OWNER} = 1;
+       eval { Git->repository(Directory => "$abs_repo_dir/bare.git") };
+       unlike($@, qr/as a HASH ref/i, "no error from perl");
+}

 # config
 is($r->config("test.string"), "value", "config scalar: string");

-- 
Michael McClimon
michael@mcclimon.org
