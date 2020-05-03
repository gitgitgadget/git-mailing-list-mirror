Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7BC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 20:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7012054F
	for <git@archiver.kernel.org>; Sun,  3 May 2020 20:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJMeIcwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgECUD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 16:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgECUD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 16:03:27 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D3AC061A0E
        for <git@vger.kernel.org>; Sun,  3 May 2020 13:03:27 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id w4so10186864ioc.6
        for <git@vger.kernel.org>; Sun, 03 May 2020 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5MP6M9GG1YmTSuFUD58FJe3b0uSRzqNH+7HNVT6mZ8M=;
        b=oJMeIcwDAAwViqok6L79LbEXLQjTVPi8Q8/Pi+S7Vqr52Vg/nrNRoN9xi+TdxUsX0M
         k8BoqB4rPBQawAx7r1u6uRlDaYbJV5vmYgul7+4bPETu/hyx43XsYHg2RlEgS1nSw0dl
         L3jTCEqH7K4KFY9vSQwj71oCbQPM3ZNvmO8GvHoxIgUybq/jU2V9VqPpOz8+0n66fcaQ
         xmJCD/XpoKY8Yn2GDZ97RYSEB92D/7Op7EBVeTL5w6hZgw9IbEbPc/0qLqB7Z/l5ZFgM
         x+hd9S6zz/mZ9LoTH0mb/zDCuFRhfVsOBk7CJQewIWPm3vSsujDH2p1z9MFlwNJcOUGU
         +YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=5MP6M9GG1YmTSuFUD58FJe3b0uSRzqNH+7HNVT6mZ8M=;
        b=k/Kxn50XzoaGPuiq3ihHvvMtGu0eB36I+ncvl+nMwsGEVbClIrlieK/AZPvSfEEXgK
         8zDCn4hP/e9wtGCwUc5tx0zZElb3r3tUWuXIbBl4ZmlWIFNg+b2WEtilKxl2dCEVNJY2
         NtJOf6kkvrANl3xoczhxzYvZUBIx/Fmd+IwdsE2P92KItJlueLjZVIzMEk3+31Kd0X1+
         I42vlVURWgmRKCv6xsaGf4ZO8Ll+APHQCIl7WWRXEh48wQpj7k8e48wNUaB3rm1jkt9i
         LgtdOnKrSgf7VpZnYlE4RIumB6Ev/vEtpnDhRiYdTlaT4SM6TbtD1YDFgF1DrD+dBHWX
         RU8Q==
X-Gm-Message-State: AGi0PuYHc5wUeCX9CcUBYB6sfsBQgvYnoGAQXHoKeLtMHHinKzs8oIvw
        +6jgC9dRNBCiSCfpSJC3/nwGPMDRlmH8DUX2GeKgtXY=
X-Google-Smtp-Source: APiQypKiWqnn9iMRvDjTjEGUqRL2zyW4fTcX2acc5bL6gEWt+nZLeF3BUe24WlCZGytAWNcSBWCPSmgNagR2SHWyOTk=
X-Received: by 2002:a05:6638:102:: with SMTP id x2mr11411405jao.119.1588536206550;
 Sun, 03 May 2020 13:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEoQP9gVur=UDDPzHnLq-AryDnd45uYdEs3kajzLrtr572e_rA@mail.gmail.com>
In-Reply-To: <CAEoQP9gVur=UDDPzHnLq-AryDnd45uYdEs3kajzLrtr572e_rA@mail.gmail.com>
From:   =?UTF-8?B?RXdhIMWabGl3acWEc2th?= <kreska07@gmail.com>
Date:   Sun, 3 May 2020 22:03:15 +0200
Message-ID: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
Subject: file is showing as modified even that it was never commited
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I=E2=80=99m probably missing something here, but it looks really weird and =
I
can=E2=80=99t find any information on this.

My situation is as following:
I created empty repository on Bitbucket, then cloned it, added code
and made one initial commit (without push).

Now I changed the code and I would like to commit it, but I have some troub=
les.

The problem is some files are showing as changed while I never committed th=
em.
I never intended to commit them (they are under .idea directory, which
I added to .gitignore).
I checked with git log - I have only this one commit.
I checked files affected by this commit using git show --pretty=3D""
--name-only. Mentioned files are not there.
Also checked the history of one particular file, using git log -p - no
history here.|

At the same time, file is showing is changes not staged for commit
when calling git status.
For what is worth, file is even not there.

I hope you=E2=80=99ll help me unravel this. I am out of ideas, kind of seem=
s like a bug.

Best regards
Ewa
