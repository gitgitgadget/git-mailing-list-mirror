Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70C31F667
	for <e@80x24.org>; Tue, 22 Aug 2017 17:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdHVRtV (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 13:49:21 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34449 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdHVRtU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 13:49:20 -0400
Received: by mail-qt0-f194.google.com with SMTP id p13so5310264qtp.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=xMH6i9bjCIezRrNHXm9TTo7RuVLji1W3OkESn1Qx8V4=;
        b=C7g+Qa7tWe9FtFkhurQF9q10SP6cRQ30YMuhez+veZ1FjSZoln99h+AYPTGoaXKnq5
         cR9SvN4bJYkQF7q6Dmfb/2j6six698LPmKEICwlpv5zE2aiF/sTcTeuUnHhOpU2VomJP
         fxlOY9Bb2JdcyWnG0qoJ0yDiADXFl+V/kI+pqRdqhODRM0eYtpidPYvkgmZIXRI23Kjp
         CnSTGo23j0T2PqihLbI3st65sLQqju4nohWM5WUb5GMskx9xxj1n17Oz1Xzk7Kb64h28
         8iUzLW6AqMnVy22TIGcVoEkgJpxW0wwfroeb9Xl185tIZ/M6MwPzd4D3/vr+GZFG+kqW
         S95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=xMH6i9bjCIezRrNHXm9TTo7RuVLji1W3OkESn1Qx8V4=;
        b=edy2tIrbX82UTnmt9xbze36USr2oU8+tXmEscfFAOWPl3gWX0d1BvK1ZqMNDIOgdd9
         dG7QEY2ObMIOU0s13D4UDk9fEy+WO3hUp7M6/wqaP9vq52wZiMWd91rV9/dNGWhCOrMT
         m6tqY2SwlOtvSwBpmxfTrc/9McxKvfcOISLm41/ZBTtTblABeK4gUzYUwOJ77V2fmijf
         ie7N1p1zCH5HJMYG5wSlbstgMcEyzufr9D8b848CRWtWxnUvkkY0msukE/yJRnN7cU2Y
         XkupD/OVpL00T1J9R996PfRnR/OenLkbqJY5765h/mvfon0KocNEMne0dsI/e8sNzEkp
         5bsA==
X-Gm-Message-State: AHYfb5i63tMrdFN/KmWnl1s/CsFIwpYY/pHPWUqO5VoaMxGNKKZxREaC
        nuRd2B4c/W1Fs4igL1s=
X-Received: by 10.237.40.6 with SMTP id r6mr2112132qtd.140.1503424159788;
        Tue, 22 Aug 2017 10:49:19 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id h21sm10402965qta.58.2017.08.22.10.49.19
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Aug 2017 10:49:19 -0700 (PDT)
Date:   Tue, 22 Aug 2017 13:49:18 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Subject: Cannot checkout after setting the eol attribute
Message-ID: <20170822174918.GA1005@megas.kitware.com>
Reply-To: mathstuf@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I specified the `eol` attribute on some files recently and the behavior
of Git is very strange.

Here is the set of commands to set up the repository used for the
discussion:

    git init
    echo $'dos\r' > dos
    git add dos
    git commit -m "dos newlines"
    echo "dos -crlf" > .gitattributes
    git add .gitattributes
    git commit -m "add attributes"
    echo "dos eol=crlf" > .gitattributes
    git add .gitattributes
    git commit -m "set eol attribute instead"

The following behaviors are observed:

  - `git reset --hard` does not make the working directory clean; and
  - `git rebase` gets *very* confused about the diffs in the working
    tree because `git stash` can't reset the working tree;

There are probably other oddities lingering about as well. If I commit
what Git thinks is the difference, the diff (with invisibles made
visible) is:

    % git diff | cat -A
    diff --git a/dos b/dos$
    index fde2310..4723a1b 100644$
    --- a/dos$
    +++ b/dos$
    @@ -1 +1 @@$
    -dos^M$
    +dos$

Seen in 2.9.5 and 2.14.0.rc1.

--Ben
