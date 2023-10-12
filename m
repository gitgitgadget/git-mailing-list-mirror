Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4BCCDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 09:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjJLJFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 05:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjJLJE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 05:04:59 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E1590
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 02:04:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C7165C0476;
        Thu, 12 Oct 2023 05:04:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 12 Oct 2023 05:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1697101496; x=1697187896; bh=Y/E3DeK+iOkNFfWwB7Pjh+XI82zN5v/CNGV
        RZlmH36Y=; b=Zx2i/um2b5M5U6GURVHtk4nAeZcpXTNLcM7zExdH9LPKRAW4VY5
        UE0L0/rWDJvujxxHfBwqdzQBnPS+004jVCyr93dJTgTXb8k3SiJ9P2IEBaMQs7FR
        TqbjmAk+J9qYAHVz2loPUIehsGAKXyutqVWrBwYO0tIK31Qm9jA1WRffEtKT0YLg
        /KqCR4L6iWmZfDMLiUUth8dmfPNsy3OjzNoQPMMcdTBgPgfoVlwqxA+BtvSuK4zC
        1ofOAdrX8y31ARYMz6tX0/ws8l/dRlVP0TZI5KIxzm3oVOWnrQevjvD/TdlydxM0
        5N7jkrnMHKP5qXsLnB3NcVrUoRIebUE7ahQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697101496; x=1697187896; bh=Y/E3DeK+iOkNF
        fWwB7Pjh+XI82zN5v/CNGVRZlmH36Y=; b=QLZeXXMOfrIIMP8asVx8rJgiaX7gf
        BTzV+WwOS2EGBRophyJnNh90AlZGes5NGuHptPSynMSfQ1cIXmXx0HwQ0DtJBlob
        BXzqm7DJ56OvLhAyG9V77JYYeE5FPgfkontAGNdZknxrx9V4wfzICrnh6SEraKGn
        7TZXtI2tNfClIa+gHv8+Gu01hdlmW7UyIrOAxs5b5+GsqMhYFFFRDIeasFF62CcT
        oYkaIXxTsREDQkfAwc95EUd8HGJYfVmuRuX4VetHqEGu/v9ekYeT37kfip3bTDi7
        bO+e/K+JTDfqV6DuRLamvC703F4NlAqe67t+CSv6jrernFjF33uCA9Mkg==
X-ME-Sender: <xms:uLYnZfpJ2BCmK8N6tGOx6jYYKdOx68aawwtuCjEKvaJNrko-eiM7sg>
    <xme:uLYnZZo3_MT5Ke2jnhTBcWzSul8u__CoxkUBjidGSYQKeL8WYI2PumwRCQhg0l5Af
    cGJYCNCfmFXnK7z8m8>
X-ME-Received: <xmr:uLYnZcNgsD6lxKFF_xJfQ0MVaD1Lk6Krq4V9csoI-i13Tyll8NNY1vBGQ4nNNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudeigeehieejuedvtedufeevtdejfeegueefgffhkefgleefteet
    ledvtdfftefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:uLYnZS7Rr7oSCt0vFCqtDwQeOPN0vtd0yukHJHQNRkhcmL3lHxtrPQ>
    <xmx:uLYnZe4od2kreJ5gC-wQ1k2PySBN4Qnu83fBfyTnW6nA0u61J6sdDg>
    <xmx:uLYnZajd0JYvopcbskHz-mJNivy7wsAr3P5Oh4f_pViHeBFcvaCdzA>
    <xmx:uLYnZUSUkizdwtzH6otVseGhaoT6m2zzIfF9Myvg_Ui7xTbuqUQKCQ>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 05:04:54 -0400 (EDT)
Date:   Thu, 12 Oct 2023 17:04:46 +0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Sebastian Thiel <sebastian.thiel@icloud.com>, git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Message-ID: <ZSe2rvIWcNrrp-9R@localhost>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <98387b86-1732-42bc-9ac5-d64a6617b2db@app.fastmail.com>
 <ZSVbUSRUQlNy0bj-@localhost>
 <25b25127-aa10-4179-bc02-065fe12d01ef@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b25127-aa10-4179-bc02-065fe12d01ef@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 09:10:34PM +0200, Kristoffer Haugsbakk wrote:
>  Hi Josh
> 
> On Tue, Oct 10, 2023, at 16:10, Josh Triplett wrote:
> > > [snip]
> >
> > While I'd love for it to default to that and require an extra option to
> > clean away precious files, I'd expect that that would break people's
> > workflows and finger memory. If someone expects `git clean -x -d -f` to
> > clean away everything, including `.config`, and then it leaves some
> > files in place, that seems likely to cause problems. (Leaving aside that
> > it might break scripted workflows.)
> >
> > It seems safer to keep the existing behavior for existing options, and
> > add a new option for "remove everything except precious files".
> 
> What's a scenario where it breaks? I'm guessing:
> 
> 1. Someone clones a project
> 2. That project has precious files marked via `.gitattributes`
> 3. They later do a `clean`
> 4. The precious files are left alone even though they expected them to be
>    deleted; they don't check what `clean` did (it deletes everything
>    untracked (they expect) so nothing to check)
> 5. This hurts them somehow

The scenario I had in mind was:

- Project has ignored files; git doesn't have a concept of "precious"
- Users expect that `git clean -x -d -f` deletes everything that isn't
  part of the latest commit.
- Git introduces the concept of "precious"
- Project adopts "precious" and marks some of its ignored files as
  "precious" instead
- Users' finger-macros around `git clean` stop cleaning up files they
  expected to be cleaned.

That said, given Junio's response I'm no longer concerned about this
scenario.
