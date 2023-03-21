Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5390C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 19:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCUTtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCUTtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 15:49:40 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF979EE1
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 12:49:34 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id d2so8169693vso.9
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 12:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearearth.aero; s=google; t=1679428173;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=78jPE68bp6+lywmOv4Yd95/gsMxMQ+csT4OXfHHLBR8=;
        b=D4QsaZuNsPPdSdS/IS3II2z6Boa4OthFxxh95ChHciy6arniTip//JurmJdxddCf95
         on8WIWdFDom62iUNET34hPlGs2wsEouHnwRcTUIY3C5X3H4Qppv7lhpttTaaN5i8CWQh
         1tM2u8x51b+OzvRyEgOWuWOPSPrwqShq2Dr2dKPCfLnF65jNZzkP8muvdNwGFv/xPJ0A
         sJ9cNjE1fJaXHNRyy5csE1t4QkP6tAIDXbKLZP8robNX1343WKfYw+H5VHTCIKPg/8Ru
         aq9ZNW9feq2x9tYl1AmrDTaRC/wmZ+VUGzJLQAb36PZPktZVX4maij0VTjsayMY6L9Sy
         0fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428173;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78jPE68bp6+lywmOv4Yd95/gsMxMQ+csT4OXfHHLBR8=;
        b=MV9Zjn5jfuIFra2OcKADPjXH92AgIOJitAxFcXzGIgCySqRDp7oEqCNATNx+4wRVW0
         LqeTZ696LTzLzdNgp3vJSZpJqCgQWn+Ban5mkVfVspcFyqirf2aG6FDAuPKn+/uqSKBJ
         lgIHQlfkFKsVqQYSMKvUkkFZdWmsPn0lAP/s+fuGyMF7EQgmMQZUjbvtNNzX4l0BHtGK
         dG3ulBOGMSzLzBmaokyDFSL2DJp4z7nPReywQo+0O9rFvfKVs4vUkIdoiu0Lz8Co33gF
         rB/JndFjMSToYufL+OHFv5AOvadmVpYcbcmsuKTZ3+PjBYRxZabeUkPdRhwm53bi/mVy
         uE6A==
X-Gm-Message-State: AO0yUKUbM51fTQHkU4sjizS56G3sY1qZUKHktooxCUbWi6L65R4fOp7z
        NxsTd0u/afVAKXuhmgRuvvZLcjJGnIvIDNIBxFo=
X-Google-Smtp-Source: AK7set+10IWn/H7LxxE/bzNg8trzHOqrjJQnyfi3tJtvxOGbafiWZcZ1uOcwBtOX4y2W7UCoaVQ0rQ==
X-Received: by 2002:a05:6102:18e:b0:426:149c:f89 with SMTP id r14-20020a056102018e00b00426149c0f89mr1975892vsq.21.1679428173073;
        Tue, 21 Mar 2023 12:49:33 -0700 (PDT)
Received: from smtpclient.apple ([184.81.152.146])
        by smtp.gmail.com with ESMTPSA id j13-20020ab015cd000000b006903f96c1a8sm1226667uae.9.2023.03.21.12.49.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:49:32 -0700 (PDT)
From:   Ward Hopeman <ward.hopeman@nearearth.aero>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Feature Request: Ignore Tracked IDE files
Message-Id: <94EFF553-E498-46D9-B14A-3500FEDEBB47@nearearth.aero>
Date:   Tue, 21 Mar 2023 15:49:30 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.2)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
    I was unable to find this as a prior feature request, so I apologize =
if this is a duplicate request.

    Request: Create an Ignore section that allows for minimal IDE =
inclusion without impacting IDE settings for local users.

    Reason for the request: Most engineering teams share some IDE =
settings when working on code. More often than not, local IDE changes =
force engineers to resort to using "git update-index --skip-worktree =
<file>=E2=80=9D to avoid the IDE settings files from showing up. It =
would be nice to be able to identify IDE files that you want in the =
repository but not necessarily track all changes as most of them are not =
desired when individuals make those changes for local setup.But teams =
like to track and have available generic shareable configurations like =
tabs to space and line length etc. By making it a user configurable =
section of ignore it allows for future IDEs to be listed without =
impacting the way it works for common IDEs today.=20

    Example workflow:=20
Team member Pat creates a new repository.=20
Pat sets up the default IDE settings file(s) the way the team =
=E2=80=9Cshould=E2=80=9D be using them, but only minimal settings like =
line length, tabs to spaces, etc.=20
Pat commits the IDEs settings file(s) (often a directory like .idea or =
.vscode) to the GIT repository.=20
Pat adds the IDE settings file to the IDE Ignore section of the =
.gitignore file.=20
Team member Sam checks out the repository.=20
Sam opens a local IDE and modifies settings that work for local items =
like executables etc.=20
Sam makes code changes.=20
When running `git status` Sam sees a new status section for IDE changes =
like `untracked` files.=20
Sam executes `git add .` and the IDE changes are ignored.
Sam executes `git add -f .ide/settings.json` and the IDE changes are =
included (note specific file is identified not a general flag).


Thank you for your time,
Ward


