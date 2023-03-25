Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E8EC6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 12:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjCYMn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCYMn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 08:43:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B268411171
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 05:43:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F20005C0132;
        Sat, 25 Mar 2023 08:43:54 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sat, 25 Mar 2023 08:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1679748234; x=
        1679834634; bh=H1pHTlngNEciazU4qTT6EXE2fXvbkbPei5I+TtjJfVw=; b=F
        fCkrByNesHgL41f+wqEPMbvo6Hjem5I9Dqcjl7jUGGWGY11Q8goXL0Rgt9BMgAaa
        RmxbwqMzto2Sjek/pbwyTo53a+TzOv9bzytoPhJlp1oV7eQT+OCUuIcn5gZ18BXO
        14InE/DjZXgsXjonSyS+VedDMnxX4GPt0p+nBJnq684S/LzPhXsIBQM4HpKYxzi1
        9MgsgWgHnpiDQEOpG8XdFcjFT2O3m28HP6qDNFXE4ZlLw+HSBbOYiAcwVbi80lSQ
        UyQzo9YgI9wF4eMdJGq0WCvIxC01oPKT9Sf3Cwj0ueDfTvzdMBWPPjdQoJaJoxf4
        6uqFG5t4KYsiD+044H17A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679748234; x=1679834634; bh=H1pHTlngNEcia
        zU4qTT6EXE2fXvbkbPei5I+TtjJfVw=; b=maq5pDRa/2uJwpj7Diaj0EcDrgsCd
        GZ6k0INDkVYTXP+pF1q9l3eTZPY4bmc9MkbyPqqYA5DbmF2MvLxrSvUTzj2fqFCx
        bl7Hii98QW525W6qMPxDj4fswvpVCkrpxwtJfaIC2s6QdD3X2cx+3oY0jRB4brmg
        1GwueJvpq0JT1IR96CM5sHhDqKXotRYMRNL1HraFknFuxqdgbVxZTkjXBNRpdBrb
        EZYSrcworpuI9hXE5zoP/w5fMmOpaIdBm4Vt+oe60EXUGDreL7mGrmtfJs6FkZ0J
        f3t66r2UuzoFbcvCcdvmAhKAFwoNw/8NQvTuzHqImVnWkU7EWZ++3CILA==
X-ME-Sender: <xms:iuweZE0umc1SUj5rvZq64gW8Ev3KY-nSG4kv7U30H8AuI0fmWI4DCnU>
    <xme:iuweZPEAxOY4uF-2wGPRmiiDdZwk3-YYH-qCRDQ4rPtke2KzwEwVNbJ4iqpy88tFU
    iFZLKTvTp1Rxp_UQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:iuweZM5E2S356t4NXiu9sP3GGXcUSTnAe5M10L4e-1opamqIerJ6Gg>
    <xmx:iuweZN3LHhCuT5uhAnhtESnUM53gC4iK9uRZIwh5bPwEr3C1ZfIBvA>
    <xmx:iuweZHEfRVonQiVqIbBmjRh56mNNsOY_3TIWXJO-TjoVR1ssUFf9Aw>
    <xmx:iuweZOwAc72Z9nKnQNhv25mPVua3pO2NxH0FZ3SYDvLnpny2myYubg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D7F1B15A008E; Sat, 25 Mar 2023 08:43:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <dd473fc3-cd03-4ef1-9fe1-8909e30a0edb@app.fastmail.com>
In-Reply-To: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
Date:   Sat, 25 Mar 2023 13:42:12 +0100
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Mario Grgic" <mario_grgic@hotmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git bug: Perl compatible regular expressions do not work as expected
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023, at 13:31, Mario Grgic wrote:
> What happened instead? (Actual behavior)
> Nothing is found, when in fact the search for term is present in the git
> history
>
> What's different between what you expected and what actually happened?
> git should print out the commit containing the search term.

Weird. It works for me.

    $ mkdir test
    $ cd test
    $ git init
    $ [add file]
    $ # This was missing from the instructions
    $ git add --all
    $ git commit -m 'added test file'
    $ git log --all -p -G '\bmain\b'
    commit 56fbac5e12649c4de95071cc1872569d7c34055e (HEAD -> main)
    Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
    Date:   Sat Mar 25 13:33:51 2023 +0100

        added test file

    diff --git a/test.c b/test.c
    new file mode 100644
    index 0000000..0bffa6a
    --- /dev/null
    +++ b/test.c
    @@ -0,0 +1,5 @@
    +int main(int argc, const char *argv[])
    +{
    +    return 0;
    +}
    +

.

    [System Info]
    git version:
    git version 2.40.0
    cpu: x86_64
    no commit associated with this build
    sizeof-long: 8
    sizeof-size_t: 8
    shell-path: /bin/sh
    uname: Linux 5.4.0-144-generic #161~18.04.1-Ubuntu SMP Fri Feb 10 15:55:22 UTC 2023 x86_64
    compiler info: gnuc: 7.5
    libc info: glibc: 2.27
    $SHELL (typically, interactive shell): /bin/bash


    [Enabled Hooks]

-- 
Kristoffer Haugsbakk
