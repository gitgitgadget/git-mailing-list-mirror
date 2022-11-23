Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F340C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 20:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiKWUSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 15:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239742AbiKWURZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 15:17:25 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D404E5E9C2
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 12:17:24 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 537AC320051E
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 15:17:24 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute1.internal (MEProxy); Wed, 23 Nov 2022 15:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669234643; x=1669321043; bh=IgD7TJalmV
        nm5Rngg1uL3/o0juFtepHhxcOpHWvncaA=; b=dj+eRTS/Qhpulcq45gYoQhk7k2
        cPhy9JHH6bHhGkAPhJgHJqufovQXL4tv3sqlGvxF4158MNj7gYzsS8xUqSE0+Rpt
        wcGQTDDsXXjOy7py2+mfNmTvdSrLqV/blwz6ScdzDbU8NoblhCKazqi0T4PfILhx
        kstlXJm+C7qSVn7tYfwibsDUuZL07/xs3Kk4W4IYBkye++6wC6RSZbtkN1YXUIzF
        Hbdk3Rs0wpWhSikYkygclb+fHOt9uaiPYCwkQ3iwCzCwuOV6V3AyeLUqvBECfsWg
        VqinRikQCUn1UoWwY1fmkJdWr3+VBleWekVz3by8WFCvE83wH6972WR/edGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669234643; x=1669321043; bh=IgD7TJalmVnm5Rngg1uL3/o0juFt
        epHhxcOpHWvncaA=; b=UacGIZh7mZGoHEDoAvItVOyl1jBcOV2y0X23HFj9mTDV
        EKsflAHizi0N05bD1kaj/j+1e5ZO9YuuvGqDMYScJYlZRLZxN149P494ezsfo228
        glLoY7oH0cwW2wrOqHmS/O1XWenXjfj5TmXkElyBenHCu7/ShtuxnB/9JZRGWWsp
        D1NcMfa50Dd1PbXbMyjk9eht8pVzroxjVYzMnD4fYuZE4rTSpJZjk/we/eyBBon4
        fsaQHLcQ9+jeELJT2A2ft6y9am/AHkmEPe9R4Kpcuh7ILfgGsa8dcRNjZGJXS7T+
        jKoHiCLbkmEwtAD7tIEbqH9UE62c3jzktmffN+Z5RQ==
X-ME-Sender: <xms:039-YycXWhjZWKvsbUu0f0-IyjcS0AKglJcDHLI7uELU1EUhPz7wYw>
    <xme:039-Y8MBE8F81rrUWli5gVrs_OSNPOgYb4-3V6S6SziDK73MXHbsHB1qQgWzgGuMP
    sYopyLIH3fk9434tvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedugddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdgkrggtkhcuhggvihhnsggvrhhgfdcuoeiirggtkhesohif
    lhhfohhlihhordhorhhgqeenucggtffrrghtthgvrhhnpeduieeghfdtvefgjedtueefke
    evhffgtdduveekkefgkeefheelieffteduhfetkeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:039-YzhK0fm1Y65MHRmp23t8-4yBzdmwnFfetVfly1zAXlK3rVb2lg>
    <xmx:039-Y_9VTqdYirm-Lydm--hCGbDawfdG25aa-d1vg_qNJbNIPNse4A>
    <xmx:039-Y-t79UKIyDq1sb4x4Tg-xWKcSE1TwX0tS42D1uNcKJz9dK9ZbA>
    <xmx:039-Y86f8TXSdx7SQAfGoDEhl8QkE9Qpt9SbCIX7X7NC-NgMruFWLQ>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 70F53272007A; Wed, 23 Nov 2022 15:17:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <71fcf215-101e-4398-bffa-4ed7e286d9c8@app.fastmail.com>
Date:   Wed, 23 Nov 2022 15:17:02 -0500
From:   "Zack Weinberg" <zack@owlfolio.org>
To:     git@vger.kernel.org
Subject: [bug] git log --invert-grep --grep=[sufficiently complicated regex] prints
 nothing
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I=E2=80=99m attempting to have my blog, which is a static site generated=
 from
a bunch of Markdown files stored in git, automatically pull the
the most recent modification date for each page out of the git history.
The idea is to use =E2=80=98git log --follow --pretty=3Dtformat:'%ct' <f=
ile>=E2=80=98 on
each file and then use the oldest reported timestamp as the creation
date and the newest reported timestamp as the last modification date.

But there=E2=80=99s a catch: there are commits I want to ignore in this
calculation, such as mechanical changes applied to the entire site.
And this brings me to the bug: --invert-grep doesn=E2=80=99t work correc=
tly
when the --grep regex is sufficiently complicated.

Here's the complete set of commits that modified an example file:

$ git log --follow --pretty=3Dtformat:'%ct %s' \
  src/posts/uncat/unearthed-arcana-music-division.md
1668545053 Begin restoring the site structure.
1668545051 Reorganize directory tree prior to setting up Metalsmith
1668545032 Mechanically convert Pandoc to standard YAML metadata delimit=
ers.
1610735533 Mechanically convert to properly delimited YAML metadata.
1417101173 Correct slug for Uncategorized.
1417050416 The Great Dead and Moved Link Cleanup of 2014.
1416938128 Use category_meta plugin to fix category slugs.
1416763607 Initial import of content and Pelican skeleton.

And here's an application of --grep that prints only the commits I _don'=
t_ want:

$ git log --follow -E --pretty=3Dtformat:'%ct %s' \
  --grep=3D'^(Mechanically convert|Begin restoring the site structure|Re=
organize directory tree)' \
 src/posts/uncat/unearthed-arcana-music-division.md
1668545053 Begin restoring the site structure.
1668545051 Reorganize directory tree prior to setting up Metalsmith
1668545032 Mechanically convert Pandoc to standard YAML metadata delimit=
ers.
1610735533 Mechanically convert to properly delimited YAML metadata.

Theoretically, adding --invert-grep to that should make it print the
commits I do want, but instead it prints nothing at all:

$ git log --follow -E --pretty=3Dtformat:'%ct %s' --invert-grep \
  --grep=3D'^(Mechanically convert|Begin restoring the site structure|Re=
organize directory tree)' \
 src/posts/uncat/unearthed-arcana-music-division.md
[no output]

For clarity, I expected that to print

1417101173 Correct slug for Uncategorized.
1417050416 The Great Dead and Moved Link Cleanup of 2014.
1416938128 Use category_meta plugin to fix category slugs.
1416763607 Initial import of content and Pelican skeleton.

The problem seems to be related to the complexity of the regex, e.g.
(all examples with -E --invert-grep)

--grep=3D'^(Mechanically convert|Begin restoring)'             # works c=
orrectly
--grep=3D'^(Mechanically convert|Begin restoring|Reorganize)'  # prints =
nothing
--grep=3D'^(Mechanically convert|Begin restoring|Correct slug)'# prints =
incorrect subset

Incidentally, if there is a better way to query the first and last
commit (with filtering) that touched a particular file =E2=80=94 or even
a way to do the query for many files at once =E2=80=94 please tell me ab=
out
it.

Thanks for your attention,
zw

[System Info]
git version:
git version 2.37.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.0.0-4-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.0.8-1 (2022-1=
1-11) x86_64
compiler info: gnuc: 12.1
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
