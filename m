Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F35C3F68F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 21:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F3C222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 21:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjGLpG58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbgBNVXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:23:30 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:36500 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgBNVX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 16:23:29 -0500
Received: by mail-io1-f45.google.com with SMTP id d15so12104912iog.3
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 13:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=icRWPn80kPnyRQcE9aZ9yZAwzUAD2zFO8keJqJBCH3g=;
        b=CjGLpG58OyAfAr/FO93CTIP7fU1BJlC6RLeQ5PJmFNfO9Q8HPMngUecIm+lmrssIp6
         /6ItQm1GaYiK8Dm60HSjQg/fojMI9SCk1GF4vhi4CkKFlPv3D/9QvIKDazo0ocGdtUSj
         ++3VgufVz8bP/5Z8Wwgo1L0E+C5i7B9UwGLVmMeUvDu/CIZdDY9MVBFvdAFIRIQOQ4zy
         bzRgs1jSwTzjnGRhxfV6+ssuvDSf97ldyD3ZD9dVqKeUnixFWztzZJBhLj+NmyDugWIb
         ofHXZ4Uv8FFs/A2n44r4ss97msCSCT4FJKcrRauNoomYLZUQG43848JAzNYiZqAc8jES
         nEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=icRWPn80kPnyRQcE9aZ9yZAwzUAD2zFO8keJqJBCH3g=;
        b=n91YUPy8nZKqapXfK6ttl8rFrWmzHasMeVkGdIbrPucnl4kl0qqeHHoIK/yo/m/0XF
         HZCuZNaTy5kUFOZJ0p2J73YBUNRj1FoFpShO4wnfXqkj/hDZ/ua7GP6Cpxit3f0ilmVk
         hh2oZTHQ7JXAAXF6SbsSAeFhDIvmlEM8cyEoH9/mwACpvSFj3BmtG7RyE3qU4Aj5pjxa
         zQ/Sx9r8Lt/ePxfV9WDU18Gbd46D6XeDXQzQRKqZVc05353Q0NlFy3Z5PJapxAEOjMlb
         uEEmdDw0XdOSdrX4SsHTFZKu8J1i3MBEwSUnL23kOqOmObCrAw9SO3hB/NDZbZOoD3kW
         M4wA==
X-Gm-Message-State: APjAAAUgci3DrN85m8PEESHm5O9KzTsJnuAs5KtSXZsCC2lTvltf3cNE
        ymxwMsKCBXVZD9frNxAarGNY9XBqVNiUWIRzXbHh+5JlZDE=
X-Google-Smtp-Source: APXvYqz0VaejoM9e71UB+jKf7lpZI/QpXa/4ieKz5kKPPlfKbRxw021EaE+YRar3NhnP+Y3/qKBa3+T9vMSNe75HuYs=
X-Received: by 2002:a6b:7310:: with SMTP id e16mr3948626ioh.107.1581715409137;
 Fri, 14 Feb 2020 13:23:29 -0800 (PST)
MIME-Version: 1.0
From:   Bruno Macabeus <bruno.macabeus@gmail.com>
Date:   Fri, 14 Feb 2020 21:23:18 +0000
Message-ID: <CANnkH-ViK9qySZGi=xbcE4YDiskhLxDsH21DMxTEHi6=X0EZuQ@mail.gmail.com>
Subject: Feature Suggestion: Allow to enforce "rename" in git while committing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello for all,

initially I posted a question on Stack Overflow asking if is possible
to do something using Git, but seems that there is no away to do that,
and I think that it could be useful in order to improve the
organisation on logs.

My user case is:
- I'm doing a refactor on a project, migrating from JS to TS
- So I need to rename a file from index.js to index.ts (for example)
- Since the TS build steps are different, I also need to change its contents
- Sometimes I need to do so much changes that git thinks that I
removed index.js and created index.ts, but it's wrong, losing its
tracking on logs!

I should not create one commit just renaming the file and on another
commit updating its content, because the project won't build on the
first commit (since the build steps is different on a .ts file). And I
don't want to create a commit that the project can't be built on.

So I think that would be useful explicitly say to git "Hey, you should
forgot the minimum similarity threshold on this file and on this
commit. I renamed this file from index.js to index.ts. You should bind
they".

Is it make sense?

Thank you!
