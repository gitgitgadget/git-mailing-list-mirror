Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060E4C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJTUam (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJTUal (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:30:41 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829219ABCE
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:30:39 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id fy4so2348307ejc.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjec/ce/upOK6qd/aS1YJJEom+obPCgngVNz1UuVQYU=;
        b=yb+RumIGjNxosEBgvgY26OKlbOfQgF7HdUppKB2qDzHc97M2ffXpKVzCzhyCtIDc+W
         g2SrLcAKoNLV+1HWTe3YuS4WIejw1MrIgCVO/VZQIxtGk1aTJeap+oxASBguXVNyLTFt
         sUwTPLT6siuct30bLPBgW6XG3tnq/dYWYpVOBesQ4xCoZ6Vtquk15m/4fA1tVwSxxzBE
         +2OntBEOnJw0JvqzM6orA/lH3uUEv2XZqNe3zAe2yranldPnnY0D3IhhAHtWI1P/oPxD
         pRxxbRbbBbTRwmCgOnRh+r9El5svmOptCJpkQku6uHVBOTTNHdkQvOXHwvI+P2nW4C/y
         EGJA==
X-Gm-Message-State: ACrzQf25RMRHo+j4GeLZ/1fh6SwwjidEsCwvysNv8i4cDKTR0SOXGqT0
        N/SBKI/QaGS9c08RqinCXlfQ+U6Y7lsbTfmelSr7linL
X-Google-Smtp-Source: AMsMyM6zbmgEHIMph65Cl9VKuFLT2o7i8IsJH1+72AAJusfdUIyPicNHe24YeDwhl+r6iM4LgL8Yh720QDtYDi6ubqE=
X-Received: by 2002:a17:907:60c7:b0:78e:1cc:57de with SMTP id
 hv7-20020a17090760c700b0078e01cc57demr12510367ejc.33.1666297838081; Thu, 20
 Oct 2022 13:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com> <CA+JQ7M-NA9UYafMurb9MAo5bp6djdzRP7ChAbdmzU+nmrkXTNw@mail.gmail.com>
In-Reply-To: <CA+JQ7M-NA9UYafMurb9MAo5bp6djdzRP7ChAbdmzU+nmrkXTNw@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 20 Oct 2022 22:29:56 +0200
Message-ID: <CA+JQ7M_hE66XiBc4G7nXJMWpdOBWEm+Zp_74LcXQSOD8fo9LJw@mail.gmail.com>
Subject: Re: Cloning remotely under git for Windows not working
To:     "W. Ekkehard Blanz" <ekkehard.blanz@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sorry, forgot reply all

On Thu, Oct 20, 2022 at 6:04 PM W. Ekkehard Blanz
<ekkehard.blanz@gmail.com> wrote:
>
>    $ git clone 10.0.7.181:D:\gitDepot\test.git
>    Cloning into 'test'...
>    username@10.0.7.181's password:
>    fatal: ''D:\gitDepot\test.git'' does not appear to be a git repository
>    fatal: Could not read from remote repository.

Any interesting information if you run with
  GIT_TRACE=1 git clone ...
or any of the other debugging flags?
https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables

I recall having a difficult time when I hosted a repository on windows
a while back. Not exact specifics but that I ran into issues. Maybe
because of some default windows things. Like the default terminal
and/or the default ssh client.

Maybe something along the lines in this stackoverflow post
https://stackoverflow.com/a/67937630/1507124
It mentions the following issue
https://github.com/PowerShell/Win32-OpenSSH/issues/752
and the workaround is setting receive/uploadpack to use powershell.
I distinctly recall facing this issue and I believe I solved it the
same way, changing the default ssh shell to PowerShell instead of cmd.
Not sure if it solves your issue but I think it helped me.

I'm also pretty sure that another time I tried setting mingw-bash as
the ssh shell and then faced another issue related to mingw/windows
path quoting shenanigans
