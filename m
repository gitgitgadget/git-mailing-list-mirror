Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABA1C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 05:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6483520724
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 05:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuOTDEzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgCSFso (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 01:48:44 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33358 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSFso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 01:48:44 -0400
Received: by mail-ot1-f45.google.com with SMTP id x26so1222109otk.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 22:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=g3xRRXRkTlVzNLcmFbY3r93l1UlvaF0yC0ti5B1prjY=;
        b=FuOTDEzOF2nM1A+3sxExkbaX0aV1GXYZOdgViqijz4OoUXGT7+Mj7/OE/qs/tQ6wnL
         5lYupHML2OGq06fIILOK6RZ5B+WXwkMwM6uTQykn2DfZtM5s0+KUyd2URueiyErW/5tC
         sJ6lxH1X7jWv0+m8t7rVm5iN7JSVt2i3XpW6vWs6GEmkJW3vmEYHo3lEcLKIzMCWmNKN
         2XppTg74efJVbZK0rw5MWEDIuoorkJ23v3Hj/wWN8+K12hJ4AHMnqQW9OC7WV7yK4EtT
         jRQloRNZQWUnILB52z+1xBQrc31NSJ2aq0qXN2J00yit3lv/ajMjW2B7aYKwPfccHSQ8
         1p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=g3xRRXRkTlVzNLcmFbY3r93l1UlvaF0yC0ti5B1prjY=;
        b=aliVwByjp4Q3ZwoDLatxXLXZ98X956LdPYPQ8hXY/Am3NF7oiIHLMZpFus065rgMTQ
         5NDEcAkmsEZK20lOLszer0fgWlXrZw/J+NRln/+6iVRrb/yA4ET5JH7ygUKQuxPD8GPi
         hmlL/vdXAk4ZJ0GZy3ifSnyyYQf+5XQJOAlEB9NMaq0wd0wklp8dXxZVoVFRPryHOiG0
         KurXd1ODMVHcyTqlivOHR/Bb4DYMcB2G5VELdDpBbNiRRVGmz7vYsSGQQyS/a5toKxfO
         u4ZEwmLv2Fzr92FT6OOsbyxiBGQEZZjT9cTlvq5ZoW7yRcsURmgipmE8ILEbhtCjuNFc
         T3dQ==
X-Gm-Message-State: ANhLgQ0W2UdHaYoTnSilAn8Ujy0brYE1NxzwFlKw5wCp/tYF0xFEQL8l
        a1xfcpKxeYU/ymKLM2/GyKcXKlwRWpH+wzRP5AyO1X+/tR4=
X-Google-Smtp-Source: ADFU+vuEGvU9ZljDkSU4My+KSFhq+qX6wUt+wfO17nWNbKGIQBce/TG9znaOhSQi666yPEnxqcY/92jmso7i6GSMz9s=
X-Received: by 2002:a05:6830:314e:: with SMTP id c14mr1044766ots.7.1584596923004;
 Wed, 18 Mar 2020 22:48:43 -0700 (PDT)
MIME-Version: 1.0
Reply-To: timothee.cour2@gmail.com
From:   Timothee Cour <thelastmammoth@gmail.com>
Date:   Wed, 18 Mar 2020 22:48:17 -0700
Message-ID: <CANri+Ey71QbWxNH+RhMfYuUSDEpYtv28ushUhK8Tt0xWUAU9iw@mail.gmail.com>
Subject: git makes it impossible to ignore or override global gitconfig, needs `GITCONFIGFILE`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git makes it impossible to ignore global gitconfig. This is
essentially what's being asked here:
https://stackoverflow.com/questions/23400449/how-to-make-git-temporarily-ignore-gitconfig

## proposal:
add an environment variable (like for tig and other programs), eg:
`GITCONFIGFILE=~/.gitconfig_temp git diff`
seems like an easy change that would make it easy for users to ignore
or override their gitconfig

## note:
I've asked here:
https://groups.google.com/forum/#!topic/git-users/1ehWsItL8vE but got
0 response after 6 months
