Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C6F1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 12:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbdBFMiO (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 07:38:14 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36835 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbdBFMiM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 07:38:12 -0500
Received: by mail-qk0-f173.google.com with SMTP id 11so53113225qkl.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 04:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uEDenmbu1T6eh6vlv5luLPWwF5WKgCn6jMbZMgHSf7Y=;
        b=nHlCIZJ4RUmfMuqn7Fsgi06C1EsF6+BG69XlyVhJLRAwE0u5x5Ztu1NTrMGPGJNZ6O
         8XNN7VkD5D9Hw54zuVwdP1ktWKG6AKmqzWaM7cSkHD8bzyYfnIgYRQhC8wLRe740PZI+
         GW0uCE7nYhB0yaIrCVLBb+5icD1coRU2B/3fJjDs03EbM/Nk99qPquhkhoBSHCQDyBLT
         pRyLceEUfdBTF+gzXGdP32PslAsog12bQoC4sJvNajXWRuXlCeUI+8kImoNrhFuTBRDn
         6NJLzYXucTmb6Awigmoo/tczsfHSSZz2rJmnSfUDz1tcVJQUxiSGKzVtCLDJ5XjuabiU
         Wgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uEDenmbu1T6eh6vlv5luLPWwF5WKgCn6jMbZMgHSf7Y=;
        b=o8hwewhxwetH9vsmxGW7cIVnqNAisR7Xo+VX8GCwU+I/eVXOPszhaXGflF2Kwcy9cr
         QZSMh9jwXHc/rCLYbcf+ArFJsiApwrcXEphnKl/jXIttUi2RzoRQs/AVf2OOIXiI+x/H
         jiKHwolhbsZ8Ao75DPlp9ytgK4mMNIC2+06vhic51P8Eqz8wMUPpAL6UoZxx+IHk5tmY
         dxIIBed1t8gVgEQoXuyPSYUZXB4IDGVUsj0DHVnHpcaXb/6w7jY+HHgA14fttlGWsgAr
         VpljgHdZzWr6BWzHxTZryRU7yNxp6lX7aQjsqL1uesbixPLy2i/TEubkt4O8dPzzfcR8
         WLZg==
X-Gm-Message-State: AMke39mUBZaL0BjY/yAeUHiAZ/WisVu3dHFvUW5LDxsswhMqUzWLQTZqXs6tb5HdtiM/Zs+lY4oJb6LT3xA+fg==
X-Received: by 10.55.148.71 with SMTP id w68mr8843462qkd.130.1486384681525;
 Mon, 06 Feb 2017 04:38:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.226 with HTTP; Mon, 6 Feb 2017 04:38:01 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 6 Feb 2017 06:38:01 -0600
Message-ID: <CAOc6etZ7iuPKRQkYSZDrDRW0hxbu1aYMRuzB1iXAPv+EEnXJEg@mail.gmail.com>
Subject: A little help understanding output from git blame --reverse
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

While doing some research developing difflame I found some output from
git blame --reverse that I can't quite understand. Perhaps another set
of eyeballs could help me.

I'm "difflaming" HEAD~100 (02db2d0421b97fcb6211) and HEAD
(066fb0494e6398eb). Specifically file abspath.c.

If we diff (as in plain old git diff) HEAD~100..HEAD we can see that
line 63 (from HEAD~100 revision) was deleted between HEAD~100 and
HEAD:

@@ -58,86 +95,136 @@ blah blah
                       goto error_out;
       }

-       strbuf_reset(&sb);
-       strbuf_addstr(&sb, path);
-
-       while (depth--) {
-               if (!is_directory(sb.buf)) {


So, if I do a "reverse" blame operation on the file, I would expect to
see the last revision where that line was _present_ on the file:

c5f3cba126  61)         strbuf_reset(&sb);
c5f3cba126  62)         strbuf_addstr(&sb, path);
066fb0494e  63)
c5f3cba126  64)         while (depth--) {
c5f3cba126  65)                 if (!is_directory(sb.buf)) {

line 63 shows up as if it had been last present on the file on
revision 066fb0494e, which is HEAD, which kind of doesn't make a lot
of sense to me because given that the line is not present on the file
on HEAD (as we can guess from diff output) it means it was "forcefully
present" on some previous revision (and that's what I would expect to
see reported on blame --reverse output).

What am I missing? Thanks in advance.
