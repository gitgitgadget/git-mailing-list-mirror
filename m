Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED44C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 16:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63501206D6
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 16:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMNilvCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDTQxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTQxu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 12:53:50 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75527C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 09:53:49 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e20so8745268otl.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VikWZ+YwfouAzXLU+EapQIt3eNJnmOI8hlCv87Id1xU=;
        b=XMNilvCDC/aNRPHrvqgTON1tNYwBkv2Qpbhwv3R8K84OZ7tnB8HWKbBwId7xRJL/CK
         uGz/KkYckAIzNgngVbt3J4CDZPh5qnRoaty/Oala5w5TyV2SKm1bJEYXILrY8EA+vb0/
         FsZvPIrXJFrgnBFu6CRj7sZSuQf+6uW6b24lTPDZBmfzbtMJbjzOSbqT+fmMYXm9WNd6
         KQRTq3MepEvOgg0rwYP+dJcpbktVgSqwaC7nodjHMW2L8xh7FSAWyArWzWxWo1WS31rI
         b5sE31crFUPuS633dSVYf7LDpOui7SYwXeQyM92JtsAkTNA7mOaf+6PE0qFRtnpynPai
         3SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VikWZ+YwfouAzXLU+EapQIt3eNJnmOI8hlCv87Id1xU=;
        b=h5gu3/bCxV0s2MG6GDsSOYSUNUOHQfhgxki3yxtws20CU2xvHxmiXAzW+K9aQik7OI
         pTDuZfqRBh7tCKgNZAgUvnZ0JnmmDGKSRf1wW5Lp0SkqlyBVlWKgMMpKUsi/M1oewDt6
         NbZvTOHb/QPldsuFbJp/so2qtH1UjVpSpZ6n9ZXHVACnOyAtLU41ObUHM2n4d8wUF1ef
         gXqA9lS61rum9SVHay423XmLAtA8od1+8q5YyujOTcd2Ad8HTbpU2anPpbFSjzbEvw8W
         l3y9KDmaZAiMMKzWL6uXSuhdsaW1SkDzUkLKGyALZYInee6D6w3w92HF/sGfO2Sjpivj
         Vt3w==
X-Gm-Message-State: AGi0PuZN6+jX/XSHUpYc5I2wCiJgNDuY1H2bqMtV2wtyZlfVY2CoW3cT
        GdK9JABRpN/v3xIaIvbtI9NfWrHUveqJuhFClGs=
X-Google-Smtp-Source: APiQypKD9ouoB8LGNGvgciOGw2vmxwgY/C7wVtyYM+jvO3I6Vejhi5KLSqQtq8RNnvnkY+SA4SGqwKaHq8jTYDMEITY=
X-Received: by 2002:a9d:23e2:: with SMTP id t89mr10761675otb.316.1587401628609;
 Mon, 20 Apr 2020 09:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR02MB371559B3C5445A3C9D39821B9CD40@AM0PR02MB3715.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB371559B3C5445A3C9D39821B9CD40@AM0PR02MB3715.eurprd02.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Apr 2020 09:53:37 -0700
Message-ID: <CABPp-BGis7wswAjwgTa84m-TsQznrQWQJVJZW0_MyN9ieFMzeA@mail.gmail.com>
Subject: Re: git-filter-repo For Windows (possibly a request for a bash for
 Windows primer)
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 8:11 AM Kerry, Richard <richard.kerry@atos.net> wro=
te:
>
>
> This follows my earlier query for which the answer was "use git-filter-re=
po".
> I've cloned git-filter-repo from GitHub, and I've installed the latest Py=
thon (version 3.8).  I'm working on Windows.  Windows 10 if it makes any di=
fference, so git is Git For Windows.
> The first instruction for git-filter-repo is to copy it into the "--exec-=
path" of git.  That fails, saying Access is Denied.  So leaving aside the o=
ption to change the permissions I've followed the second half of the senten=
ce and added my git-filter-repo location to my Path (or PATH if it's in bas=
h).  Now running "get filter-repo" gives:
> /usr/bin/env: 'python3.exe': No such file or directory
>
> My python executable is called python3.exe.  There is a note in the git-f=
ilter-repo project about certain Windows installations where it isn't calle=
d python3, but that now raises in my mind the question of whether I need to=
 tweak git-filter-repo to look for "python3.exe" rather than just "python3"=
.  Or can I take it that the Windows version of bash understands that it ne=
eds to add ".exe" automatically?
>
> Assuming that is handled automatically, what do I now need to do to satis=
fy the error message?  Do I need to put something in bash-for-Windows' /usr=
/bin/env directory?  Or is there something else entirely that I should be d=
oing?
>
> And is it OK to ask about this on this list, or should I be going to a gi=
t-filter-branch resource?  Or for Git For Windows?
>
> Regards,
> Richard.

Emailing this list is fine.  You can also open an issue on GitHub for
the project if you prefer; I respond in both places.  I may have
limited ability to help with Windows issues since I don't have a
Windows system to use or test on, though I have succeeded in fixing a
few Windows bugs based on reporter feedback. (So maybe this list is
better because more people can chime in with Windows experience?)
I've got at least a dozen or so reports of people using it
successfully on Windows so someone has figured it out.  I'll try to
provide a few pointers that might help.

You don't have to use "#!/usr/bin/env python3" or "#!/usr/bin/env
python".  I could have put "#!/usr/bin/python3" there, but that might
make it specific to my system.  I figured other systems installed
python3 somewhere other than /usr/bin/, but that /usr/bin/env should
be somewhat common and should find the python installation.  If
/usr/bin/env doesn't happen to exist on your system, though, it is
perfectly fine to have "#!/System/Commands/python3" or whatever is
needed.

If installation is difficult, you could consider using a package
manager.  In particular, the scoop package manager, built for Windows,
was one of the first out there to package git-filter-repo -- it was
even ahead of most the linux package managers.  (And, yes, scoop can
also be used to install python3 as far as I understand.)  I haven't
used it myself (because I don't have a Windows system as I mentioned
before), but since they were so interested in packaging
git-filter-repo and making "scoop install git-filter-repo" part of the
instructions (https://github.com/newren/git-filter-repo/issues/20),
they look like a friendly bunch that are willing to help.

I also looked through the issues and PRs related to Windows, and
thought that the following links particularly had interesting comments
that might be useful to someone running on Windows:
  * https://github.com/newren/git-filter-repo/issues/36
  * https://github.com/newren/git-filter-repo/pull/10
  * https://github.com/newren/git-filter-repo/issues/48
I don't know if any of them will solve your particular problem, but
they seemed more likely to be of interest or use than most.  Also,
I'll repeat the link for search for reports of Windows issues with
git-filter-repo in case I missed one that might be useful to you:
  * https://github.com/newren/git-filter-repo/issues?q=3Dis%3Aissue+windows

Anyway, I hope at least one of those pointers is useful to you.

Elijah
