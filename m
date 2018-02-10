Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1398A1F576
	for <e@80x24.org>; Sat, 10 Feb 2018 08:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbeBJI4A (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 03:56:00 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36777 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJIz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 03:55:59 -0500
Received: by mail-oi0-f51.google.com with SMTP id 24so7833863oij.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 00:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=iOiEnqgYgvnw6605MjR6I/gMwFvea2QkXVyHR4nVZTk=;
        b=sZ3KE6vEPzhmYPx0Y1u+c/CZLUCnLMCw0OxRqbD2qp4vfMOA8V/y0F/8ktdxARJBz9
         S6eh2IePU1cSYdqKbZXjfFd30EGex0PGAh7KyC4tEWQ4CB77y4c60iCUaw/wmBeQpc6E
         ntOeeMEBNW+OSjY7vD3uagThbBNm4otgnvtrSUMuczzW/jah/8HnZkiyjhdXe6ycVJ8C
         CFeWBJmNsLNKczHIeXvkQx7v+f6yzyU5sZ7mMlKvdDOyWgjN80AsmVRNAl2ovdpvsWjB
         JyLNgIPCkuQsYSxFYLFbzT4mvhYJjgUlRUkeXzgnXFljP40KDS60fx8Yr7WUemLsgfOj
         GO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=iOiEnqgYgvnw6605MjR6I/gMwFvea2QkXVyHR4nVZTk=;
        b=ePiLvIuxvLS2kGhDB7hxfpO4gPr3QbaPsUZqAmb1qWfW7v47Y76ogTZHbPyHGG+b8x
         8WN0ivkjgyQz3SJwEaEq/vwUAtZl6HLU8hInQanCURyKbqPFKxGY9YTBNLUGl0Xyn/y8
         Wh7efDrVvCPlDRdO9TNvvj6II9X2NuXH6jFWI9XQnJAZ4ICAaXU2Qnj9s1xjIS5yAgjx
         TrbcxdKjqgEYq7xasjX9Aaf9glC88DP+n6bZMSUaklqKayQcQzL8HRzWkgLWwrk1Gkfg
         7U8Ej6LpfMhTrXmY/XYCjMJ/e3SjGfU99qoF6u/d8+1uBvjTN3OmSbBQ6OejbR00VFAa
         ANNA==
X-Gm-Message-State: APf1xPDEbBm2X5bB+E+csSLrc6fo8XpCVUTM5xD31WjyJKsqFuUXZklT
        GqpLGl8OrZJ+c3IoZg1FKRjmxRXQ742uzPPnfqFsfW59
X-Google-Smtp-Source: AH8x225xcjhOTRVEPgMPyTn0MkAzl4Ri3eaVd9q/+PUxNGJ8KJW9kCiG/DVIN9QUt6CrhEUtRMb/rKTrpfA2crXSOVo=
X-Received: by 10.202.199.130 with SMTP id x124mr3562200oif.85.1518252958662;
 Sat, 10 Feb 2018 00:55:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.57.24 with HTTP; Sat, 10 Feb 2018 00:55:58 -0800 (PST)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 10 Feb 2018 03:55:58 -0500
Message-ID: <CAH8yC8nodewYm-J3ye5Lnq-Zf9JziejL8L3TxTEwVoq8hD--HA@mail.gmail.com>
Subject: Crash when clone includes magic filenames on Windows
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm seeing this issue on Windows: https://pastebin.com/YfB25E4T . It
seems the filename AUX is the culprit. Also see
https://blogs.msdn.microsoft.com/oldnewthing/20031022-00/?p=42073 .
(Thanks to Milleneumbug on Stack Overflow).

I did not name the file, someone else did. I doubt the filename will be changed.

Searching is not turning up much information:
https://www.google.com/search?q=git+"magic+filenames"+windows

Does anyone know how to sidestep the issue on Windows?

Jeff
