Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146351F597
	for <e@80x24.org>; Tue, 24 Jul 2018 06:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbeGXH4u (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 03:56:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32941 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGXH4u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 03:56:50 -0400
Received: by mail-it0-f66.google.com with SMTP id d16-v6so5006800itj.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 23:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GOxx7BWvPKTPhJyByHhB2G/Pw6Kx3DWPa1281wQFCA0=;
        b=iy30LzQq4vLErO459iHOOK44zAJCajtW3fnVWmjkmamKvfp4T7de7IxLga8YX32RWa
         pfUYv6gWJN1D6AMcuolkTFTVEW9Z8LjJWGHUYwbq9D04kQq3pGOQQPkg9+pccM7BiSgu
         M6nAng6EnT7YhuKSSyU9IwGkrrYjye4Ag2w9EIFi7DIz4Cfx7iVguJr790EuabubjBuw
         U1N4CwjjaVT/9TPozMeF7WV9aM7s+3/N3Q49uBh44UofkMchtDY9dkNkGUo/jZ60JKrr
         VW5riHg3Gl1wgxx/lKI7iUZf8wDRAOGqUWNrGntU5q1Mtpv0K61bVrTzaLThN8W1DZlB
         BJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GOxx7BWvPKTPhJyByHhB2G/Pw6Kx3DWPa1281wQFCA0=;
        b=eZt1Max8zSB7N2lx3PtYjckIOoV0J/T40v+9FVg8fL1Eq5L1u+XjwIMCvSi/XKmlr7
         Fyys20Ps5FmQQtRWMtoAZtVT5QK6GgKpmbJeZz95YuZ37/FWrrwvTjLuCejxFsYCQHQX
         3CFJfQK9R7ge/cK5y2WFqMdHJUNxlR3236C3p8Z37MYb1CwAFY1b2ECFC2UHs+w++mOb
         7XpsvOY2ss+zxKmg7x8uEtuzoUe+A3ZT+1s9D5ZyUmysI/HcHLdh0rHMhO1SCDNsH2YQ
         p9Rz52E1xJBDSMCZ3z2XLd1Q5kgWBU9PTRH+EaYzieKX7WqKzf/NIYXkEFOL+1UFIcNb
         NSUQ==
X-Gm-Message-State: AOUpUlEzGQpSM2rfuEcsn5bFB8W50eRKtN4opiIXkEQBCJvhodI+IOhN
        Rsya0zgtA7YQsGUEnrKdpcefKq+i
X-Google-Smtp-Source: AAOMgpe9Y5BRIARlAJVBO9h7MVdvNbhmevPgXtpg7FYI/epjzQpTt0SBNs3h5Iv6Nkd1lzSji6pefA==
X-Received: by 2002:a02:6901:: with SMTP id e1-v6mr14321741jac.62.1532415113807;
        Mon, 23 Jul 2018 23:51:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3474482iob.20.2018.07.23.23.51.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 23:51:52 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Evgeny Cherpak <cherpake@me.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] gitk: fix MacOS 10.14 "Mojave" crash on launch
Date:   Tue, 24 Jul 2018 02:51:20 -0400
Message-Id: <20180724065120.7664-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <CAPig+cTJvJLMe4CFOb-yxqwF4udvs4G-BUiT=Kp-NZcfAWAyiQ@mail.gmail.com>
References: <CAPig+cTJvJLMe4CFOb-yxqwF4udvs4G-BUiT=Kp-NZcfAWAyiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On MacOS, a "wish" application started from the terminal opens in the
background, thus doesn't match user expectation that a newly-launched
application ought to be placed in the foreground. To address this
shortcoming, both gitk and git-gui use Apple Events to send a message to
"System Events" instructing it to foreground the "wish" application by
PID.

Unfortunately, MacOS 10.14 tightens restrictions on Apple Events,
requiring explicit granting of permission to control applications in
this fashion, and apparently such granting for "Automation" is not
allowed at all[1]. As a consequence gitk crashes outright at launch time
with a "Not authorized to send Apple events to System Events" error,
thus is entirely unusable on "Mojave".

In contrast, git-gui does not crash since it deliberately[2] catches and
ignores Apple Events errors. This does mean that git-gui will not
automatically become the foreground application on "Mojave", which is a
minor inconvenience but far better than crashing outright as gitk does.

Update gitk to catch and ignore Apple Events errors, mirroring git-gui's
behavior, to avoid this crash.

(Finding and implementing an alternate approach to foregrounding the
"wish" application on "Mojave" may be desirable but is outside the scope
of this crash fix.)

[1]: https://public-inbox.org/git/D295145E-7596-4409-9681-D8ADBB9EBB0C@me.com/
[2]: https://public-inbox.org/git/CABNJ2G+h3zh+=wLA0KHjUn8TsfhqUK1Kn-1_=6hnXVRJUPhuuA@mail.gmail.com/

Reported-by: Evgeny Cherpak <cherpake@me.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Lack of 'catch' in the 'osascript' invocation in gitk was recognized as
a potential problem as far back as June 2013 [3,4]; now it's biting
"Mojave" users, making gitk unusable.

[3]: https://public-inbox.org/git/7vk3m7yukc.fsf@alter.siamese.dyndns.org/
[4]: https://public-inbox.org/git/1l424u5.uk987q18u3oxfM%25lists@haller-berlin.de/

 gitk-git/gitk | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a14d7a16b2..f13d1807bb 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12210,11 +12210,13 @@ if {[catch {package require Tk 8.4} err]} {
 
 # on OSX bring the current Wish process window to front
 if {[tk windowingsystem] eq "aqua"} {
-    exec osascript -e [format {
-        tell application "System Events"
-            set frontmost of processes whose unix id is %d to true
-        end tell
-    } [pid] ]
+    catch {
+	exec osascript -e [format {
+	    tell application "System Events"
+		set frontmost of processes whose unix id is %d to true
+	    end tell
+	} [pid] ]
+    }
 }
 
 # Unset GIT_TRACE var if set
-- 
2.18.0.345.g5c9ce644c3

