Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 524BC2095E
	for <e@80x24.org>; Fri, 24 Mar 2017 10:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdCXK2D (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 06:28:03 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33420 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdCXK2C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 06:28:02 -0400
Received: by mail-vk0-f43.google.com with SMTP id d188so10450032vka.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Va+ExWopT3TnMBDEWuvQ3dkpJ6JwOOFhbwGntqyBfbQ=;
        b=BsNsa1d9K8FVzo8ZZj6EpKOhqfNHJu2vug5N6X767cCfwD8ZEJZ/H23cYQA06tdLI0
         HnuC6qnQ/Tyj3xa5R1dSYJg2EI2k3T0bAnqKyPRS9sOEHfybmvCygw7212uG6jCac5L6
         vMS5p4swGv8Vi8Mt9pmBtBYwBNdEWeGLxPPMOO4vm1ioRmfcK6V4jghII7+iuGMAqEls
         pueh1Ol/2M+919dNO5d1SpDpPkyMEleXQ1M6Dwf02GyIjIYM7qdkeqHcX6539G9a4rDB
         M+k0drzeAgOhG8bOzxmhWuVC1RUlHVux9DcsZe/YWEEa//IP+y+Mw9GuXYV6n8x9xEAu
         Tu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Va+ExWopT3TnMBDEWuvQ3dkpJ6JwOOFhbwGntqyBfbQ=;
        b=M2zyaZ9OuFMjzbaIxX9p1IDk3+1JeFEkvEqUfdWFcT1QMrlwkr4KEflbN5fQqHIJwo
         Qr9etzUntiUewuH5Uc/eBKWNHBKa33rfyq86EhblFOScPMHRGteM5SYZJek6mDnPTxYJ
         G6Q6OBC7G/sg8JLgeAW/Xzuwt6U8bhDM29Bln++vZuulDcgta28wkR/o1NYe/DnpmiV5
         a+HJG2GLAiO7cN+TsA06Z4yvBYD+AL3qBUNuF0rHLhQTqMIrVE2u9RhWiLN5FsdTikaC
         /DRSWDVAqUFaCJpmiBZiCGR80YfDOdYv/434/ioxMEye8069K3B4Kv7kWzvX8KyRiljD
         0fSQ==
X-Gm-Message-State: AFeK/H0h1cZp6Nn7KhaGO/ISU9qCqr7vX6Ueym4aVguLs0oBjb5O4P+i9GqWd/uRGqMJOjtkOk7nCsbx/zIhaQ==
X-Received: by 10.31.125.204 with SMTP id y195mr3569565vkc.59.1490351280800;
 Fri, 24 Mar 2017 03:28:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.84.212 with HTTP; Fri, 24 Mar 2017 03:27:20 -0700 (PDT)
From:   Joan Aguilar <joan.aguilar.lorente@gmail.com>
Date:   Fri, 24 Mar 2017 11:27:20 +0100
Message-ID: <CAG+Y4s8m2MqA0yAiZFzv2bAx7g5xktNRb=S-Ej0tvMwU-Un0Og@mail.gmail.com>
Subject: report on a possible bug: git commit -p myfile.py unexpected output
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there

this is the first bug report of my life and I am not a native English
speaker so, first of all, I would like to apologize for my English
skills and the report itself (if it is not precise enough).

I have already read this 'guidelines'
http://www.chiark.greenend.org.uk/~sgtatham/bugs.html and I will try
to attach to them as much as I can.

What System I am running:
* Linux 4.9.0-1-amd64 #1 SMP Debian 4.9.6-3 (2017-01-28) x86_64 GNU/Linux
* git version 2.11.0. Well actually, according to the apt-get install
output (of course after apt-get update) -> git is already the newest
version (1:2.11.0-2).
* VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Feb 13 2017 00:56:16)
Included patches: 1-197, 322

What happened:
I was working on my git repository yesterday and did a lot of changes
in the file myfile.py. After a little bit of testing I was ready to
commit them. I decided not to commit all of them at once (because
these are non related changes), but instead I decided to use the -p
option (as I always do in this case). For the first patch I decided to
commit only all methods I have removed because these are not needed
anymore. So my Idea was to jump from hunk to hunk and split them
(using 's') to select (with 'y') only the parts I wanted to commit,
ie, lines I had removed because they are not useful for me anymore. So
I went for it and I did:

git commit -p myfile.py

Until this point all went as expected. The first hunk was printed in
the console and the it waited for my decision. As always. After a
couple of hunks I realized it was not possible to split all of them in
a proper way (to select only removed lines) because new methods were
mixed up with the old ones. So I cancel the process (ctrl + c) and
started again using 'e' instead to manually edit the hunks.

So I repeated the last command: git commit -p myfile.py but this time
I only used 'y', 'n' and 'e'. All in all I edited ('e') two big hunks.
By doing this, the default editor (vim in my case) opened showing the
hunk and with the instructions in how to edit at the bottom.
Everything as used to be. Until this point all went as I expected.

In the two hunk I edited I did the same. I removed all + lines by
deleting them and I make some - lines as context. Like explained in
the bottom of the file.

When I was done with each of the hunks, I saved and closed the editor.
No error was produced (I sometimes make mistakes while editing a hunk
and know you can get an error (patch does not apply) here, but in this
case were no errors there so the next hunk was printed and the commit
procedure kept going.

When I was done with all hunks, the editor (vim) started again to
write the commit message. I wrote (something like) this:

    myfile.py -> old unused methods removed...

    1) mymethod1
    2) mymethod2
    3) mymethod3
    4) mymethod4
    5) mymethod5

Yes, not the best commit ever ;) but enough for us in this case.
Anyway, I saved it and close the editor and I was surprised by the git
output.

[master 96d1c24] myfile.py -> old unused methods removed...
 1 file changed, 182 insertions(+), 302 deletions(-)
 rewrite myfile.py (60%)

What?? I thought to myself... Insertions?? This can't be true? I
removed all + lines, my idea was to commit only deletions... What did
I wrong?

To check this I did
* git show 96d1c24
and I saw only red minus lines , ie, deletions. As I expected.

To check it twice I used tig too.

tig showed the same for this specific commit
myfile.py | 120
---------------------------------------------------------------------------------------------------------------------
1 file changed, 120 deletions(-)

Conclusion:
After these two checks I am sure I did what I intended to do. What I
do not understand is the output of git when I was done with the
commit.

Maybe is just me, because I do not understand how git commit -p when
using 'e' to edit hunks works. But as user I would expect to see only
deletions in the output message if I am picking only deletions.

If this is a bug, I hope you can reproduce it on your system. If not,
do not hesitate to contact me for further information.


Kind regards,

Joan Aguilar
--
Joan Aguilar Lorente
