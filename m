Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C58AC77B7A
	for <git@archiver.kernel.org>; Wed, 31 May 2023 10:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjEaKIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 06:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbjEaKIy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 06:08:54 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F5010B
        for <git@vger.kernel.org>; Wed, 31 May 2023 03:08:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 70B185C01AB;
        Wed, 31 May 2023 06:08:51 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 31 May 2023 06:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685527731; x=1685614131; bh=5jtC8IcEa6OlNs+PysKmGTdtI
        SnyWk9JzvlCp2dU5zE=; b=y50gT2zjw5Zsn707LD3cvfqnMaO7YWVvebP1xFTbO
        JwxAFwsWjU8jcIfFv0fKQ1tShy0pFVZSnWFIFbQoj3m/njetR/7rm/ao40QqZxl+
        8Fhh84M30pIJAXHlkQArX4BI5/ZT3IuXGeOVGs95OqdzV2bULmKy9qu1lM7RKk6N
        Mq9zv5S5rNDuvn03ka6Dvfm83iAa+kwrbEXdcdFwB7zj7kKRHPYHxsk3cPnkoNIP
        zekgWRx3Y/g/pB0BUmoHdiB/8gsrdZOwz3jksYn6xs1FnyADpCoW5rORk/G/hdoz
        f6A+onQQ9OuKXCzCJaPivROF0WvMosEefDE3FHHtOxYIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685527731; x=1685614131; bh=5jtC8IcEa6OlNs+PysKmGTdtISnyWk9Jzvl
        Cp2dU5zE=; b=WoX4Pu319O8eknl8du7XYV9azDK6VY/gdBhA6tuAWJb/aRqSoCq
        GogDaMFL6H/q8AgygiAC/eaP2KtUOcrzPYlDwzQUvJeZXIx3dL+d3uVH+upWlRv/
        Bv2fGzzayRQ5QbHX/Ykdtw2MlbAdOyQsMvaEpPAsI0ikJ3Vjw7MbY0wM1RIk3Tvo
        zBBvG5S9BFEYgXOyRoV5l4o+PIyhcIe5lNI9b2nrYOK3rOneZ5wkIA09rorK0p8a
        MKFRe/6BIIbbPdMuER2vWu1mrgcLARw683P/0U6+rMGqHc505w0oNTzLaaSmzjKy
        cI3UfuOXfbtr4qGZek6XA1AdwTmlB7oUh6Q==
X-ME-Sender: <xms:sxx3ZNTVI5vfipbRPz-nklPiHCo0gK7Ar24P-GCb6vv3Vrjz6i3uSS4>
    <xme:sxx3ZGyfxH9p3--9xQ5435Xfb08mq4tzUtD00G6hEyIPZos1Jr2eYzFu3mLP7dwLm
    1siok-mjwQ0N1s7HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:sxx3ZC1B46TR9PpKB58agJcT6EasFNHmx_QKwDjUQ0tCOc6tN8qNcA>
    <xmx:sxx3ZFCasMEnPGt6HIwgB0H4MEywTkaEn9Cu-kxkx6JxPA6Si93kVg>
    <xmx:sxx3ZGhY2QBOafGKz2yn-JQrl0QDIvmJiSG1yyKvi-voa9yCfUsKVQ>
    <xmx:sxx3ZMfTvCW9V-d8ezOgxZk9irCNh6I2WceCST9m6mRTAh_XeBeB0A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5041C15A008E; Wed, 31 May 2023 06:08:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <ea3e1ea7-7f2e-4f15-b910-06c3cad54e24@app.fastmail.com>
In-Reply-To: <lxh4jpacuv5ivqp35w5vpbcjlw67r7ix3yog6cc3cu5ij7yqho@mrtr24xxdstx>
References: <lxh4jpacuv5ivqp35w5vpbcjlw67r7ix3yog6cc3cu5ij7yqho@mrtr24xxdstx>
Date:   Wed, 31 May 2023 12:08:31 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     Carlos <kaploceh@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: not robust inconsistent git 2.40.1 with HEAD -> master, origin/main,
 origin/HEAD, origin/master, main
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Tue, May 30, 2023, at 20:14, Carlos wrote:
> Running git 2.40.1 with HEAD -> master, origin/main, origin/HEAD,
> origin/master, main with initial commit on main does not show all the
> objects from master

Does this mean that `HEAD` and all of these other things point to the
same commit? Is this the output of `git log` with decorations?

What are `main` and `master` meant to represent? One often doesn=E2=80=99=
t use
both of these names unless you have a legacy setup (originally `master`,
then moved to `main`).

What can be confusing to me is that git(1) uses `master` as the default
branch name that you get after `git init`=E2=80=94this can be configured=
, but
`master` is currently the default.[1] Meanwhile, GitHub uses `main` as
the default name. So what sometimes happens:

1. Someone makes a local repository with `master` as the initial branch
2. They make a repository on GitHub
3. They click on =E2=80=9Cadd a readme=E2=80=9D or something
4. Then GitHub creates a branch `main` with that readme addition on it
5. They push their local changes and end up with two =E2=80=9Cdefault=E2=
=80=9D branches:
   `master` with their own changes, and `main` with the default readme

Maybe both you (locally) and GitHub made commits named =E2=80=9CInitial =
commit=E2=80=9D?

=E2=80=A0 1: I=E2=80=99ve heard that the default might be `main` on Git =
For Windows, though?

> ! [main] Initial commit
>  * [master] Initial commit
>   ! [origin/master] Initial commit
> ---
> +*+ [main] Initial commit
>
> the chunk of objects are on master and not main, and yet it shows
> nothing once checking out to master.

It looks like both `master` and `main` point to the same commit.

Do you have some command that you expected X output or behavior from,
but instead got Y output or behavior?

> the git-clone operation is not consistent either. It's a disaster.

What do you expect it to do and what actually happens?

Cheers

--=20
Kristoffer Haugsbakk
