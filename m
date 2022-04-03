Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3C8C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 20:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiDCUU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiDCUU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 16:20:28 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262F8F3A
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 13:18:31 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2e5e176e1b6so79208747b3.13
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A6+Kq9frHaVfLmQyWwppoDkZ10mhcS0k2B6oAUp6mWQ=;
        b=cSGb+KZisDVwFSIQMO5FcoLE3gRNPNyiU2ApiEsOBGRTQn3yeHtUuvYrn/R5yMG3xQ
         8O+wK8NApg9FUnis2LE0EfPdgD+iVgq92JbbeMfofsq8w+JWEaaIBedpGpwBmTe97BJs
         O/vEZL41MXT8j+fj5/6I1X5sMK3cMQ4SNqGIKojlEn21TSjUe2puFikftQPirH5hVsfJ
         W+wlu3da9o6sbPGoDyl5E6t6ybtY8SwRl7izft6TeMfvXu7wbG9oV4+6xv2va5h62ETl
         RRgyO5y0M7PRDHRwob1iKEORsllwLl40zdqVM2HcCO5wjNcossRyTw6oFyabllxiPBQ9
         eHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A6+Kq9frHaVfLmQyWwppoDkZ10mhcS0k2B6oAUp6mWQ=;
        b=TY3uhjzDcnVJ9mnKTuiQQOfWA+La4hU4OyiBnH/FW1mxikioQnNpAIh/tYcVgSiyr9
         EDBP93DA5RdyxSdDXor+w3kbk6e/0MKs+kOzSLYW+vP7pnq7SQ+GI+Rc+Tdt9Y5nzvi3
         ko+J5ouC/ng7ujXbvtgzdKb4R2/sk3+uV/njqhkYY4kBkNqgX/IppaaCE/4f0wZfR/vy
         uMyQQ2fP4Iojl46rYK4PW9Vs3iNgDHrplqlm1ertVRTytxuNLRvQ2iq+z5u/Ikq3J8Ga
         jXZ4yIdspA7tXZzYDPlR+vRRiA3PrkeADn2sK5pFhzfcTe0BtUjl0a616IMfMgVo3ILV
         FJNw==
X-Gm-Message-State: AOAM530ooqQmWsnbFEbFC7RTv+FpJJtKUnT3P+MHILDXq5Z1OglrxifC
        GwIw4o4xTVEQok50x1gfEUHF+ZWwOiQCyNfU56I=
X-Google-Smtp-Source: ABdhPJzmMNAMl/qszPgtm/DpUHahGXfKqFMKh7JzqC57GJCd9OzgDsplWxJq+hXkfWDAklDQwR+AdYvIMFm5xiWe+iE=
X-Received: by 2002:a0d:ff42:0:b0:2eb:3711:f77f with SMTP id
 p63-20020a0dff42000000b002eb3711f77fmr8768913ywf.488.1649017110055; Sun, 03
 Apr 2022 13:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <CANteD_wDSRmwLQiYV1x133WEtVaRK__c584E3CbXN1tPOquitg@mail.gmail.com>
 <2a7eecb4a0b247ef8f855f1c4fb5d510@SAMBXP02.univ-lyon1.fr> <7a522ccc-0a45-47fa-509c-a7a8b159041d@univ-lyon1.fr>
 <c1f255d7-6637-b6ac-0a64-1f64404a6f6c@github.com> <CANteD_yZ8de2i54EUWW=d6eVzpiKm5NNHGVEKrXOmo5KXnXUVQ@mail.gmail.com>
In-Reply-To: <CANteD_yZ8de2i54EUWW=d6eVzpiKm5NNHGVEKrXOmo5KXnXUVQ@mail.gmail.com>
From:   Guillaume Cogoni <cogoni.guillaume@gmail.com>
Date:   Sun, 3 Apr 2022 22:18:19 +0200
Message-ID: <CAA0Qn1tscbh-jzRDxL-9heMA4Nu8Z=7ssuT6cTeKGB_yvKgwBA@mail.gmail.com>
Subject: Re: contrib/vscode/: debugging with vscode and gdb
To:     Jonathan Bressat <git.jonathan.bressat@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

We don't know if we can revive this topic, but we still think that
it's a good idea
to talk more about "how it can be useful to use the debugging tool that giv=
es
VS Code".

So, we make a patch about it.
We retrieve what Derrick Stolee did and add what we said in our previous ma=
il.

Thanks,
Cogoni Guillaume and Jonathan Bressat

--------------------->8-----------------------------------

Subject: [PATCH 0/1] contrib/vscode/: debugging with VS Code and gdb
COGONI Guillaume (1):
contrib/vscode/: debugging with VS Code and gdb

| Documentation/MyFirstContribution.txt | 12 ++++++++++++
| contrib/vscode/README.md | 5 +++++
| contrib/vscode/init.sh | 1 -
| 3 files changed, 17 insertions(+), 1 deletion(-)

--=20
2.25.1

Date: Sun, 3 Apr 2022 21:47:02 +0200
Subject: [PATCH 1/1] contrib/vscode/: debugging with VS Code and gdb

Remove "externalConsole" line in contrib/vscode/init.sh because it
seems to not work for everyone, and after a discussion with Matthieu
Moy and Derrick Stolee, we agreed that it is better to let the user choose
what to do with this line (Add his own configuration).

Add useful links in contrib/vscode/README.md to help the user to
configure his VS Code and how to use the debugging feature.

Add a mention to the README in Documentation/MyFirstContribution.txt
and a part "To convince a newcomer that VS Code can help him".

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Helped-by: Derrick Stolee <derrickstolee@github.com>
---
Documentation/MyFirstContribution.txt | 12 ++++++++++++
contrib/vscode/README.md | 5 +++++
contrib/vscode/init.sh | 1 -
3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.txt
b/Documentation/MyFirstContribution.txt
index 63a2ef5449..97f53f536d 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1265,3 +1265,15 @@ against the appropriate GitGitGadget/Git branch.
If you're using `git send-email`, you can use it the same way as before, bu=
t you
should generate your diffs from `<topic>..<mybranch>` and base your work on
`<topic>` instead of `master`.
+
+[[Bonus-useful-tools]]
+=3D=3D Bonus - useful tools
+
+=3D=3D=3D VS Code
+
+To see "how to use VS Code" read contrib/vscode/README.md.
+If you want to try to understand "how git works internally", the debugging
+feature of VS Code can help you. It will not give you all the keys to
fully understand it, but
+it can give you an idea of "how the information travels inside the code".
+It can help you to isolate some parts of code, with this you are able
+to ask more precise questions when you are stuck. (See getting-help sectio=
ns).
\ No newline at end of file

diff --git a/contrib/vscode/README.md b/contrib/vscode/README.md
index 8202d62035..a416a752c1 100644
--- a/contrib/vscode/README.md
+++ b/contrib/vscode/README.md
@@ -8,6 +8,11 @@ code editor which runs on your desktop and is available fo=
r
[Linux](https://code.visualstudio.com/docs/setup/linux). Among other langua=
ges,
it has [support for C/C++ via an
extension](https://github.com/Microsoft/vscode-cpptools).
+To understand "how works the debugging part" read:
+[Help with the debugging
part](https://code.visualstudio.com/docs/editor/debugging)
+To get help about "how to personalize your settings" read:
+[How to set up your
settings](https://code.visualstudio.com/docs/getstarted/settings)
+
To start developing Git with VS Code, simply run the Unix shell script call=
ed
`init.sh` in this directory, which creates the configuration files in
`.vscode/` that VS Code consumes. `init.sh` needs access to `make` and `gcc=
`,

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 27de94994b..f139fd8644 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -271,7 +271,6 @@ cat >.vscode/launch.json.new <<EOF ||
"stopAtEntry": false,
"cwd": "\${workspaceFolder}",
"environment": [],
- "externalConsole": true,
"MIMode": "gdb",
"miDebuggerPath": "$GDBPATH",
"setupCommands": [
--=20
2.25.1

On Sat, Mar 26, 2022 at 3:11 PM Jonathan Bressat
<git.jonathan.bressat@gmail.com> wrote:
>
> On 3/25/2022 2:27 PM, Matthieu Moy wrote:
>
> > I couldn't understand what exactly the option was supposed to do. If I
> > understand correctly, it should launch another window to show the git
> > program output, but I don't know which window actually (xterm?
> > x-terminal-emulator? a terminal program that isn't installed on my syst=
em?).
>
> In VS Code settings, it seems to be x-terminal-emulator.
>
>
> On 3/25/2022 8:01 PM, Derrick Stolee <derrickstolee@github.com> wrote :
> > >> - "externalConsole": true,
> > >> + "externalConsole": false,
> > I'd actually remove the line completely, to mean "let VSCode decide wha=
t to do", i.e. either VSCode's default, or the user's configuration ("launc=
h" section in settings.json, see e.g. https://code.visualstudio.com/docs/ge=
tstarted/settings ). If some user has a > non-broken externalConsole: true =
VSCode and likes this behavior, then the best place to configure it is in a=
 user-wide config file IHMO.
> >
> > I confirmed that deleting the line works just fine.
>
> Yes, we agree with both of you, remove the line completly is better
> because it let the user choices his preferences.
> And it also work for us.
>
> > Reported-by: Jonathan Bressat <git.jonathan.bressat@gmail.com>
> > Reported-by: Cogoni Guillaume <cogoni.guillaume@gmail.com>
> > Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
> > Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> > ---
> > contrib/vscode/init.sh | 1 -
> > 1 file changed, 1 deletion(-)
> >
> > diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
> > index 27de94994b5..f139fd86444 100755
> > --- a/contrib/vscode/init.sh
> > +++ b/contrib/vscode/init.sh
> > @@ -271,7 +271,6 @@ cat >.vscode/launch.json.new <<EOF ||
> > "stopAtEntry": false,
> > "cwd": "\${workspaceFolder}",
> > "environment": [],
> > - "externalConsole": true,
> > "MIMode": "gdb",
> > "miDebuggerPath": "$GDBPATH",
> > "setupCommands": [
> > --
> > 2.35.1.138.gfc5de29e9e6
> >
> >
>
> https://code.visualstudio.com/docs/editor/debugging
> https://code.visualstudio.com/docs/getstarted/settings
> Maybe, It would be nice to add these two links in
> contrib/vscode/readme.md, this may be relevant to
> help new users that want to use vscode debugger. And add some explanation=
s
> like "How to use it".
>
> Except that, your patch sounds good for us.
>
> Thanks,
>
> Guillaume and Jonathan.
