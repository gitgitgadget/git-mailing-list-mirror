Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E196CD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 19:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjJJTLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjJJTLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 15:11:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C40A7
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:11:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6AD595C022E;
        Tue, 10 Oct 2023 15:10:59 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 10 Oct 2023 15:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1696965059; x=
        1697051459; bh=DfTtAUYqRvZUk2boyXSovZ9wsbTfoUdfDi/E0wU1A6o=; b=t
        zCSSGkKhxltHmwh78HZ6JTJHVPP1xcUr/D8+XDZ9IjbpHN0DLjiZ/h+NZ+1ekOhg
        OY0bymZzkGKnDN8gqSrh6mh4FUt6L7dvFN5xQ81rFRR4qiu65wEXEBOfBrIvC0Jl
        2K9E1ANGBa4rJZuZ0n4gySSW532Kzh707JqhJIsbH8iF0zVgitJbFBa/c2NB6yq3
        spGWfqrrMkQuX3aNSc+52/ufhGzsuvo2U3h6+hrW6MOUbpe7f1TvduRGv62ojV0Q
        PakhgLNwhCuN6OArdCjvl4NSPE7YUtI8+wJ4sBkz2/1yrZo1+5HeXIVtuViJo12e
        0L7orPKyzvdN0rfsYDlFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696965059; x=1697051459; bh=DfTtAUYqRvZUk
        2boyXSovZ9wsbTfoUdfDi/E0wU1A6o=; b=JIQK9KfdWucyzaWURhEgkLYOk9u9T
        25Qin4insJBoh45NW82Arokaugkt80KTwME20Wz6hpTiwyoydHwiVvDaELFnzA8e
        YzUt+YTlWJX54XpZ67boLIPlc7/FmZaA+4LWsSLz6HGNXGAvivguMH+GZIZns5lM
        sU2C4yyZH+NjTotbFLaap0sQkN4/kVlgQflchWfdyH6C12XasAK1OFOdlYMyITzw
        KI6npYDqiY5t6SbWb2QpNrt8xrTqwDJfpVAhjIqGCm1LnwKFqHGs3eqw57jPVGB1
        9aq6Gjn5NxuPBLbeTW+CeYxclN6r3n2O8elRcKPgxI6tQMTkLFtTnMelQ==
X-ME-Sender: <xms:w6ElZYcrBJjTIIBVd8p9Mc3DuOPwnTBgGWBFm7PkZID1RsogODkVTqQ>
    <xme:w6ElZaPuS_PJCaC7UNwxYVbh5jHwSdcG4rsfRmdMfSCgVqBT-RkK7U7frJDL9mR0a
    ox8_Fzs9q8YVSNjww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:w6ElZZhlXx8Of-idKYFdKZCPk52cNp11DnZP6Yp0PsHerk6jGg8Piw>
    <xmx:w6ElZd896M3lIr6oBVBvM6-0EJGzxP3C9RlnFbJ18tH2eq1KSBZuzA>
    <xmx:w6ElZUt2UPtYZ6h8Ac2SGakGw9K-x2ZMtNNDdJgq2rVhA5rO3Xx9Sw>
    <xmx:w6ElZa2dqoqm2M-MdTb3WTqUvkmqgypD9INpiya0kycNH1VvbYYXwg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EE88C15A0091; Tue, 10 Oct 2023 15:10:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <25b25127-aa10-4179-bc02-065fe12d01ef@app.fastmail.com>
In-Reply-To: <ZSVbUSRUQlNy0bj-@localhost>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <98387b86-1732-42bc-9ac5-d64a6617b2db@app.fastmail.com>
 <ZSVbUSRUQlNy0bj-@localhost>
Date:   Tue, 10 Oct 2023 21:10:34 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Josh Triplett" <josh@joshtriplett.org>
Cc:     "Sebastian Thiel" <sebastian.thiel@icloud.com>, git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Hi Josh

On Tue, Oct 10, 2023, at 16:10, Josh Triplett wrote:
> > [snip]
>
> While I'd love for it to default to that and require an extra option to
> clean away precious files, I'd expect that that would break people's
> workflows and finger memory. If someone expects `git clean -x -d -f` to
> clean away everything, including `.config`, and then it leaves some
> files in place, that seems likely to cause problems. (Leaving aside that
> it might break scripted workflows.)
>
> It seems safer to keep the existing behavior for existing options, and
> add a new option for "remove everything except precious files".

What's a scenario where it breaks? I'm guessing:

1. Someone clones a project
2. That project has precious files marked via `.gitattributes`
3. They later do a `clean`
4. The precious files are left alone even though they expected them to be
   deleted; they don't check what `clean` did (it deletes everything
   untracked (they expect) so nothing to check)
5. This hurts them somehow

It seems that the only files that should be deleted with expediency are
secrets. But then why or how would:

1. The project mark such files as precious
2. The user introduces these files (they are precious hence they were not
   part of the clone)
3. They are never deleted

This sounds unlikely to me. And if it was some kind of malignant vector
then all would be vulnerable to it (not just legacy scripts/legacy hands).

What am I missing?

-- 
Kristoffer
