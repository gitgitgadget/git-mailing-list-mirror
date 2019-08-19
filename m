Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B951F461
	for <e@80x24.org>; Mon, 19 Aug 2019 19:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfHSTXm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 15:23:42 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:42935 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfHSTXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 15:23:42 -0400
Received: by mail-qt1-f170.google.com with SMTP id t12so3179612qtp.9
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=elJ2/1/+YtXu2aMOV08CJdFgRwyoLW1t6WeYTScsOL8=;
        b=PpMUzMFd7vYAikDroBKiDpmFhjdclJlVhncN/cY3wm2iGPUxO5JgoJ/6yLfWyU+2w5
         0V3/wvLlAGlg/5/ds8LtWLgPCYob1iH+t8s+HXT7A4rIDF7I6Zr9HvHxfFSAG/I7s3PN
         qvjGI6w2uYmrDxla0CSEF/D3UolzQPMG3k5yAcjZh6l8eksDZzf7N2p1/OInzviFIF9Z
         p+p3EDncVvwt/LcU4Fq4KPssPWljdraXKUnEsC38XWf158btHzUc6ZGr4gfe+j1mtcXL
         pyMqHgS+yYre7nFcVtsRrmPl96mVplgyQohWoo3ukjKMkCzTWhWNRMvpZoUpfXUhu232
         gglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=elJ2/1/+YtXu2aMOV08CJdFgRwyoLW1t6WeYTScsOL8=;
        b=doKRzVYV17/xz4nJBGgXsOfkPaYhUapD9TOUyoSJzn96eyNbWBRxAipOD/mx947buS
         1q/HGYawFN1g5syD6KAEWc8VwGXClvQ7n0GT3PVVUiQNlRxqLI/gVowz+kVkDPMRWKFx
         gKEaMef2ZcYYKQAIX6iqPOFxP1VN6Yr8WzlspPwO2bC7bo9gvGlMoYsEuJEZR5NX4tk4
         zLJpk7kY882QJpjhI/8QWWWunquOWA2uaiHAoLd9ifpPJwym5tc6Bsc5R/mucklwfOpj
         oRodTB6D6IrVMylsKI1NYv8BQlt7W+fjAgjAG+37enVyOWS9JFWGdJ+/kBJrWXon3tbg
         fJ+Q==
X-Gm-Message-State: APjAAAUDGxBDHBuRFCOQgMM3jb//fB+XHraP49bxoi11SR0csE1vbWvY
        1U4v6SCYCtuIy2Vzy5A0RE57LccGh8qQIqGCMnS/glY+GbQ=
X-Google-Smtp-Source: APXvYqx4nBGTIf9RDaTt/JPmOf6zsIQaZPZ6YCQ1V/AsFyWi1VK4Rk157C83sD5kO9KqR7nnbcTkrchzEPmMpQJULJg=
X-Received: by 2002:ad4:54a6:: with SMTP id r6mr9688048qvy.128.1566242620150;
 Mon, 19 Aug 2019 12:23:40 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Nordholts <enselic@gmail.com>
Date:   Mon, 19 Aug 2019 21:23:29 +0200
Message-ID: <CAC-DJzJBHKrXG=3sXKPdaMrPCDXWOWgOBnuXjiHnJ_VdC-7Z8A@mail.gmail.com>
Subject: gitk causes SIGSEGV in macOS com.apple.WindowServer when started
 without Safe Mode
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I run a MacBook Pro (15-inch, 2018) with macOS 10.14.6 (18G87)
I run git version 2.23.0 via brew install git.

As soon as I launch gitk, I get an empty gitk window for about 0.5
seconds before getting thrown back to the macOS login screen due to a
SIGSEGV in com.apple.WindowServer.

If I launch gitk in macOS Safe Mode (reboot with Shift key pressed),
gitk can be started just fine.

When it crashes without Safe Mode, I see the following log messages in
Console.app.

Can anyone else reproduce this?

Best regards,
Martin Nordholts

Aug 19 20:04:47 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WindowServer[677]): Service exited due to SIGSEGV | sent by
exc handler[677]
Aug 19 20:04:47 martins-mbp-2 sessionlogoutd[1211]: DEAD_PROCESS: 676 console
Aug 19 20:04:47 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.ViewBridgeAuxiliary[1212]): Service exited with abnormal
code: 2
Aug 19 20:04:47 martins-mbp-2 diagnosticd[1155]: System mode client
stopped - Console (1154) - clearing mode: 0xa, still active: 0x0
Aug 19 20:04:47 martins-mbp-2 diagnosticd[1155]: Posting empty stream filter
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.76991C21-BB99-401A-BDDA-6F756DC5CA7E[1005]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.24706A0C-74AD-4CDA-87F3-620A95F47116[1047]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.06826255-40C1-40B2-844D-9A1B7D247380[854]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.2E190561-3E95-4391-86C0-A1BE5AAEB71F[1057]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.0F4448C0-E12A-4C0A-8B0F-569CC2CD38FB[1074]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.2DFF6196-EC40-48AE-A934-4C3A6522C214[1136]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.44C9CDA1-309A-4732-B1BA-C95368F3E328[1077]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.DD50C739-9EAC-48F1-BDCF-07051E50A01C[1059]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.F2ECC3EE-1DC1-4F91-BCF4-587499D45667[1085]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.00A2CFBF-4C9F-49AE-8B79-D810900410F2[1132]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.2F0D8F2C-B093-46EA-9D81-14BFB2776C32[766]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.coreservices.useractivityd[771]): Service exited due to
SIGKILL | sent by useractivityd[771]
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.CA39E5DC-4A94-4B48-971F-14FED587BFAA[1072]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.Dock.agent[727]): Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.DEF0E32E-11B6-4451-BD0B-A076C5956ED9[1036]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.WebKit.WebContent.8801C6A2-1E62-4140-B471-03CD427AD62C[1133]):
Service exited with abnormal code: 1
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.corespeechd[921]): Service exited due to SIGKILL | sent by
corespeechd[921]
Aug 19 20:04:48 martins-mbp-2 login[853]: DEAD_PROCESS: 853 ttys002
Aug 19 20:04:48 martins-mbp-2 login[798]: DEAD_PROCESS: 798 ttys000
Aug 19 20:04:48 martins-mbp-2 login[833]: DEAD_PROCESS: 833 ttys001
Aug 19 20:04:48 martins-mbp-2 WindowServer[1215]: DEPRECATED USE in
libdispatch client: dispatch source activated with no event handler
set; set a breakpoint on _dispatch_bug_deprecated to debug
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.preference.security.remoteservice[1128]): Service exited
due to SIGKILL | sent by com.apple.preference.security.re[1128]
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.imklaunchagent): This service is defined to be constantly
running and is inherently inefficient.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.coreservices.UASharedPasteboardProgressUI): Unknown key for
Boolean: DrainMessagesAfterFailedInit
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.user.loginwindow.1214.4294967295):
com.apple.pluginkit.pkd (lint): Service sets EnableTransactions=false
and EnablePressuredExit=true, which makes no sense. Enabling
Transactions.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.UserEventAgent-LoginWindow): This service is defined to be
constantly running and is inherently inefficient.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.user.loginwindow.1214.4294967295):
com.apple.universalaccessd (lint): The HideUntilCheckIn property is an
architectural performance issue. Please transition away from it.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.user.loginwindow.1214.4294967295):
com.apple.VoiceOver (lint): The HideUntilCheckIn property is an
architectural performance issue. Please transition away from it.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.user.loginwindow.1214.4294967295):
com.apple.AssistiveControl (lint): The HideUntilCheckIn property is an
architectural performance issue. Please transition away from it.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.user.loginwindow.1214.4294967295):
com.apple.DwellControl (lint): The HideUntilCheckIn property is an
architectural performance issue. Please transition away from it.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.user.loginwindow.1214.4294967295):
com.apple.universalaccesscontrol (lint): The HideUntilCheckIn property
is an architectural performance issue. Please transition away from it.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.user.loginwindow.1214.4294967295):
com.apple.noticeboard.agent (lint): EnablePressuredExit is not
compatible with KeepAlive=true. Ignoring EnablePressuredExit.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.noticeboard.agent): This service is defined to be
constantly running and is inherently inefficient.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.user.loginwindow.1214.4294967295):
com.apple.tiswitcher (lint): The HideUntilCheckIn property is an
architectural performance issue. Please transition away from it.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.coreservices.useractivityd): Unknown key for Boolean:
DrainMessagesAfterFailedInit
Aug 19 20:04:48 martins-mbp-2 SecurityAgent[1233]: objc[1233]: Class
TKTokenRefImpl is implemented in both
/System/Library/Frameworks/Security.framework/Versions/A/Security
(0x7fff8fec5098) and
/System/Library/Frameworks/Security.framework/Versions/A/MachServices/SecurityAgent.bundle/Contents/MacOS/SecurityAgent
(0x104f13d00). One of the two will be used. Which one is undefined.
Aug 19 20:04:48 martins-mbp-2 SecurityAgent[1233]: objc[1233]: Class
TKTokenRefCtkd is implemented in both
/System/Library/Frameworks/Security.framework/Versions/A/Security
(0x7fff8fec50c0) and
/System/Library/Frameworks/Security.framework/Versions/A/MachServices/SecurityAgent.bundle/Contents/MacOS/SecurityAgent
(0x104f13d28). One of the two will be used. Which one is undefined.
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.system): Service tried to register a
port for an endpoint declared in its launchd.plist(5): service =
com.apple.ManagedClient, endpoint = com.apple.mcxd
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.pid.SecurityAgent.1233): Path not
allowed in target domain: type = uid, path =
/System/Library/PrivateFrameworks/ViewBridge.framework/Versions/A/XPCServices/ViewBridgeAuxiliary.xpc/Contents/MacOS/ViewBridgeAuxiliary
error = 1: Operation not permitted, origin =
/System/Library/Frameworks/Security.framework/Versions/A/MachServices/SecurityAgent.bundle
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.pid.SecurityAgent.1233): Path not
allowed in target domain: type = uid, path =
/System/Library/PrivateFrameworks/FamilyControls.framework/Versions/A/XPCServices/com.apple.FCiCloudPrefUpdater.xpc/Contents/MacOS/com.apple.FCiCloudPrefUpdater
error = 1: Operation not permitted, origin =
/System/Library/Frameworks/Security.framework/Versions/A/MachServices/SecurityAgent.bundle
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.xpc.launchd.domain.pid.SecurityAgent.1233): Path not
allowed in target domain: type = uid, path =
/System/Library/Frameworks/MediaAccessibility.framework/Versions/A/XPCServices/com.apple.accessibility.mediaaccessibilityd.xpc/Contents/MacOS/com.apple.accessibility.mediaaccessibilityd
error = 1: Operation not permitted, origin =
/System/Library/Frameworks/Security.framework/Versions/A/MachServices/SecurityAgent.bundle
Aug 19 20:04:48 martins-mbp-2 com.apple.xpc.launchd[1]
(com.apple.AmbientDisplayAgent): Service only ran for 0 seconds.
Pushing respawn out by 10 seconds.
Aug 19 20:04:49 martins-mbp-2 ctkahp[1244]: objc[1244]: Class
TKTokenRefImpl is implemented in both
/System/Library/Frameworks/Security.framework/Versions/A/Security
(0x7fff8fec5098) and
/System/Library/Frameworks/CryptoTokenKit.framework/ctkahp.bundle/Contents/MacOS/ctkahp
(0x10c357738). One of the two will be used. Which one is undefined.
Aug 19 20:04:49 martins-mbp-2 ctkahp[1244]: objc[1244]: Class
TKTokenRefCtkd is implemented in both
/System/Library/Frameworks/Security.framework/Versions/A/Security
(0x7fff8fec50c0) and
/System/Library/Frameworks/CryptoTokenKit.framework/ctkahp.bundle/Contents/MacOS/ctkahp
(0x10c357760). One of the two will be used. Which one is undefined.
