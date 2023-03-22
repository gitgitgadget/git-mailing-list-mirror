Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5CCC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 18:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCVSWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 14:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCVSWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 14:22:32 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414C164B38
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 11:22:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 86DDC5C00FF;
        Wed, 22 Mar 2023 14:22:30 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 22 Mar 2023 14:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679509350; x=1679595750; bh=eW
        AZ9zZzeK9nT9Jk6tqI6qRvDIvgZhH3jMwnsRcVWVc=; b=Gqoa6boigkAb5rlycP
        fO7yOm2W/rfL1YOltXQ/qMgbk9pigKBi7RhmCMEFm1ZIIe6V9W0E1EQQOEua9jiO
        l3lRQcEtVcDLesB+S+g7IPoUeHsvJX1Qk3ufRYTmUWj9TzMaaA5BXvdJ2Q0DblqC
        CjYziWp3RJr4sdccc1ZgtUYtHein0ibLOaWpi52vsjWbdkPD7Aoqn84A3uDT38E/
        XsV+0vzd0/HheIK6Rv+6/T/kz7ueMhBcLNVskI82UstTRAdCJrvx7GFY7OStzguf
        bVarAf/d4D1khZwl6U5G1tWrmhM9/K9co0Xfkwn8Stt0AlwuO2Y6KaZc5EJm38cw
        lQ5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679509350; x=1679595750; bh=eWAZ9zZzeK9nT
        9Jk6tqI6qRvDIvgZhH3jMwnsRcVWVc=; b=vgqlvvWAuYsdUUjb5grB7QamoXTD+
        1keAgWeACobfruEqTOpQ2KsguaUZ83LSObIySb8MNYC//a63nwiEWtp7YnJGGXwi
        jqE+sWYo4tlfXP7jLY2FOATvT2num0cGmwRkoI7wN/Vi3fcUrfRXu+d487DHBocs
        wnMsMkxJvrEHHB1h/v8nhbT1JfH/wtb3JPSmyhFESFLhAEXiHZMJi6uRdNB1QUz/
        MFYV8uvGdsYihT2SUlebSV+ed8W+Wite8nlaS0kA8EW59wI8mf1bbbqmEHnp/7qD
        w5kH8mVNSy34NVKrbdPj51PLWZ57l8dlyhn5SXSx3nQblBxa+Smq+nX3w==
X-ME-Sender: <xms:ZkcbZAj6bvaX1r-kwZdSskLrlViEpQ14TpdI0U9qBoAz8_DVbqD4anI>
    <xme:ZkcbZJDBOVklVZqIzNRI2DkD9UmzkFQFfuza9tys5j2DEuwcghB5E35Ohn46S0eEL
    4hMkw8KVgFbBccJQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefgtdel
    vdfgtdduffegvdejvedtffeiueegkeegjeeuteekleffieevgfetgeehtdenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:ZkcbZIEinyn9VXv6Onk0Nip7kKy83bxAICophfrpuHCvvw94odYvdg>
    <xmx:ZkcbZBQDkaOYQqMoWckWayBeT1h53m02TJaOyC7VhiEsecYQMNWL4w>
    <xmx:ZkcbZNwLNlgspuiK7rw8IeFYvjvaJTZFbO1rrlg8dJBRP28ZiHZy-A>
    <xmx:ZkcbZLau43f2LfFgioAR68z7ILzlq32l38rdLoeZhbJs7SFPsIGWBQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5A0B415A0091; Wed, 22 Mar 2023 14:22:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <73af529d-e918-445d-b0ee-9506e28188af@app.fastmail.com>
In-Reply-To: <3FC6072C-5856-437F-9B4F-BC182921426D@mac.com>
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
 <CAJoAoZkKTGzgVyL2wM9a4VcFObx4YpjMSatH9Bpqcgyi=zzBrQ@mail.gmail.com>
 <3FC6072C-5856-437F-9B4F-BC182921426D@mac.com>
Date:   Wed, 22 Mar 2023 19:22:09 +0100
From:   "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To:     "Sjur Moshagen" <sjurnm@mac.com>,
        "Emily Shaffer" <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023, at 18:29, Sjur Moshagen wrote:
> [snip]
>
> Yes, of course :)
>
> It only happens with binary files (.docx and .pdf files), which got me 
> suspicious. It turned out that updating the .gitattributes file fixed 
> the issue, cf
>
> https://github.com/giellalt/lang-sma/commit/fb5b56fa9fa7f25be1a1d7190bbb4d12b5a908fd#diff-618cd5b83d62060ba3d027e314a21ceaf75d36067ff820db126642944145393e
>
> What is still a mystery to me is that there has been no issues with 
> cloning files on Intel Macs (git version 2.39.2), or on Linux (git 
> version 2.34.1), even with the old .gitattributes file - ie the cloned 
> repos were clean on these systems. Only on M2 (possibly also M1) Macs 
> did this issue pop up.
>
> Please tell me if there is more I can do to help.
>
> Regards,
> Sjur

I still get a dirty working repository after a fresh clone (on Linux,
git version 2.40.0) on your commit 6425cb09a8d0 (Apply changes 127,
2023-03-22):

    $ git status
    On branch main
    Your branch is up to date with 'origin/main'.

    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory)
            modified:   "corp/SN\303\205SNINGEN 2014/43 uke/N\303\246ringsliv.doc"
            modified:   "corp/SN\303\205SNINGEN 2015/26 uke/\303\230lsamling.doc"
            modified:   "corp/SN\303\205SNINGEN 2015/38 uke /SAK1 -s\303\270rsamisk.doc"
            modified:   "corp/SN\303\205SNINGEN 2015/38 uke /SAK1.doc"
            modified:   "corp/Sn\303\245sningen 2012/20 uke/Artig med animasjon - samisk.doc"
            modified:   "corp/Sn\303\245sningen 2012/20 uke/Artig med animasjon.doc"
            modified:   "corp/Sn\303\245sningen 2012/4. uke/Mange vil l\303\246re s\303\270rs/Mange vil l\303\246re s\303\270rsamisk - saemien.doc"
            modified:   "corp/Sn\303\245sningen 2012/4. uke/Mange vil l\303\246re s\303\270rs/Mange vil l\303\246re s\303\270rsamisk.doc"
            modified:   "corp/Sn\303\245sningen 2012/4. uke/P\303\245 sameskolen/Det er p\303\245 sameskolen jeg f\303\270ler meg hjemme - samisk.doc"
            modified:   "corp/Sn\303\245sningen 2012/4. uke/P\303\245 sameskolen/Det er p\303\245 sameskolen jeg f\303\270ler meg hjemme.doc"
            modified:   "corp/Sn\303\245sningen 2013/50 uke/Dramatikk og kj\303\246rlighet - S\303\270rsamisk.doc"

    no changes added to commit (use "git add" and/or "git commit -a")

Note that this `doc` extension was not covered by your update.

But it becomes clean if I remove this line:

    $ git diff
    diff --git a/.gitattributes b/.gitattributes
    index bbd8c0db810d..3959fefadfc1 100644
    --- a/.gitattributes
    +++ b/.gitattributes
    @@ -2,7 +2,6 @@
     # DO NOT EDIT - the file is updated via the template system.

     # Some defaults:
    -* text   eol=lf
     *.png    binary
     *.jpg    binary
     *.jpeg   binary

-- 
Kristoffer Haugsbakk
