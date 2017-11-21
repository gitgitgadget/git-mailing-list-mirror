Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C9B202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 05:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbdKUFSc (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 00:18:32 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35192 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdKUFSb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 00:18:31 -0500
Received: by mail-yw0-f173.google.com with SMTP id p74so5249240ywe.2
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 21:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dMrTcAXlYria4YKEt3Tgtrh1PcaFjnySUcFaadJPJcY=;
        b=LqnG/Wx35cSfFtwIa8o1JMyZ2uv/Tv7looFFF9Bf33c4100lI0CdDUPP42+vi3PNlY
         QK4HFFjBKQHKSNzseunaIx+xHRKUY+gTZERWPmEbOUA3IWimWmkPnMX7cMkgx8bpdOZh
         NFpVPWVJnVScbvPgvJ8LLtas7tzLjMgfkSCx4OV1RR4jTu++Pz7W/q+GX+7dMkDxT4YQ
         UCVI2+LKPRRHmTvySmY1IayyBQwTaO3E5qN2+Fbt5UrDmIF65DE7d+nEBRgmZeMYIjbL
         ut1+xr4WjCse5Zfe+EeU0LBY3a+9aW53KVSFeVC9WpSevxc3cShyE1knhi7ZCQwMSjiH
         1lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dMrTcAXlYria4YKEt3Tgtrh1PcaFjnySUcFaadJPJcY=;
        b=GJmjUi1VMDzfzvhoNv0o1ug3nDaqqYl3tvM09xV+cde5W83R5/twkhAstiB75Kr7Dn
         shzn9altSQBPQVbPBLRx89EoWF22q23HnM9D6mnLo9FE3kRrlLEZytfVIVL2GtgY3xTd
         kemKcCY7orTsfPYQkY4OGFu1HNb6/1Fg6gQOZGJ9DY6Y+rqVOc+CYJa+lh+XrElaAPQd
         T9irkTXYPVYsP1fn94/CiDpa+57gs6KQPK5X2mns/T0T+DqI6gRCbW+LI1qUS0pAo6rQ
         XxtvaW0pEdoIdxGfpD5rMSucIWfO4j2zLeajEP5qpbA9FhuyI2IkXjTvYW8qwcfI1lNA
         E1EQ==
X-Gm-Message-State: AJaThX5FOGL3jPLa1fT1BTiFsCRQ5F6Vu4sEOweLg4J+Mzbv74drRO+k
        q5DcUgLhnSQwYRrDKymEKx6GX3UfnSOMgOYB6POjpA==
X-Google-Smtp-Source: AGs4zMZfbM9MEzqagCS6TOz86l3JjQcde+QEqTWrKbGzDQiucEsCivguzn8emaSVSn9yAGAj4Ciy0U64bI22BsZ8aI8=
X-Received: by 10.129.75.22 with SMTP id y22mr5044326ywa.100.1511241510943;
 Mon, 20 Nov 2017 21:18:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.5.138 with HTTP; Mon, 20 Nov 2017 21:18:30 -0800 (PST)
From:   Vladimir Nikishkin <lockywolf@gmail.com>
Date:   Tue, 21 Nov 2017 13:18:30 +0800
Message-ID: <CA+A2iZaLZCMvyb3nbcn=ofVGAPeW2_wRhjOeRRu5q01LuV++Gw@mail.gmail.com>
Subject: core.safecrlf warning is confusing[improvement suggestion?]
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, everyone.

I have the following question.

So I have a fresh git repository after git init, on Windows.

core.autocrlf is true explicitly, and core.safecrlf is true implicitly.

I want to have LF line endings in the repository and CRLF endings in
the working copy. (Because I use windows-exclusive tools to develop.)

But for start I have my code with LF endings, because I got it from a
fellow developer, who develops on UNIX, with LF line endings.

What I expect git to do:
Commit files as is (LF), keep my files in the working directory with
LF, but after issuing 'git checkout master' have them converted to
CRLF (since this is a checkout procedure).

So I put the source in the working directory and tell git to make

git diff --stat

and I see the (ambiguous) warnings:

'warning: LF will be replaced by CRLF in filename.m.
The file will have its original line endings in you working directory.'

How I read them: "even though you have core.autocrlf=true, LF will be
replaced by CRLF and the repository will store CRLF files. However,
after you checkout them again, the CRLFs will be converted back to
LF(because the files will have original line endings in the working
directory.)"

 I feel like it's the opposite of what is actually happening.

So, would it make sense to change the warning message to? :

'warning: When you next checkout this commit, your code will have CRLF
line endings. However, right now your files will not be altered.'

-- 
Yours sincerely, Vladimir Nikishkin
