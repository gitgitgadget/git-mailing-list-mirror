Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349BF20372
	for <e@80x24.org>; Sun, 15 Oct 2017 13:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdJONdt (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 09:33:49 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34738 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdJONds (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 09:33:48 -0400
Received: by mail-oi0-f66.google.com with SMTP id h200so5661697oib.1
        for <git@vger.kernel.org>; Sun, 15 Oct 2017 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IEkrbANNq6/ClmAaZqthHFemINN+SYgaKG3sBixRMYg=;
        b=j9atkQ824slrnfUwWYAtMMEfmJvW2edctCG4FkZoW7DElKTvdAuFIBx9RQ8Hav8d8S
         D6gYqfLSZBXZxilzwMtWx/fdfciyCTVuY+EK5c7kLd4AMFwJZ4iDazBi2Z2LhFi3KHRd
         /1C1c76xo+v8Kb7PuMCoxTbrc4dxne3W6cemuyYx2gSQOh2HXyMwWQaZrnjJRDnwzWqn
         pe/E4Rs5hDVJg8XqjM8IWqJQitmv+kLNwFwIf8oId44SL7anmZQ1GES2OsQ1PRFCvCWZ
         niqWANT+5qMnD6TKvXYdoE4YvonFeTXuTobYBnBvOy2ASB8FrRPbeRX7brcO4aCiNHYF
         lvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IEkrbANNq6/ClmAaZqthHFemINN+SYgaKG3sBixRMYg=;
        b=LvhXfz55oG7tw9HS99ePZ8Hv/w0U/i6NqkrdT7QEydoSneYareIjMxgDPTsA9eZJWa
         xgU68NiaimQlebS1VD4ZjuptITswe7t3wiEUG9Abw+khKx02KXeImQfgOhZ2wWWkAPGM
         NAlUva3XC/pXwVw7PmY3TdC5Cut4c5IA1nDCPxmT0zn/EAPmjCaj4H+pJpKEs1WDhKM3
         bsUkqLRoZ8cqoSWq/nL2vP2yZtnJkzDR6eGwy4htdh/CuRXlu3io1zX/ssws1/KNX5Gg
         VgPiDPhsmuGbdLyyIxrNSjyB4gZgQqwnL5GBJW7ldtdkmmewbjP2fVLlE/zOwA4M+nzC
         9IJA==
X-Gm-Message-State: AMCzsaUR9Bgy512ImM/rjTcTTvyXrABPa432j951i9oX7MzMpBRiXk8C
        u/d4OIc9nwz+9DIlcTFdvkD2kNlnKuJ25oXCcR9HqQ==
X-Google-Smtp-Source: ABhQp+Qt/oWborJpAcnuvfzFethNOMormllpkGJ9wH3/6RROhNA5rfXn170ciddBYjxOQBy2ekfQ9b9OR8RcqfLpQlE=
X-Received: by 10.157.51.38 with SMTP id f35mr3443429otc.39.1508074427662;
 Sun, 15 Oct 2017 06:33:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.4.104 with HTTP; Sun, 15 Oct 2017 06:33:46 -0700 (PDT)
From:   Joris Valette <joris.valette@gmail.com>
Date:   Sun, 15 Oct 2017 15:33:46 +0200
Message-ID: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
Subject: Consider escaping special characters like 'less' does
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pager 'less' escapes some characters when calling 'git diff'. This
is what I might get:

$ git diff --cached
diff --git a/some_file b/some_file
new file mode 100644
index 0000000..357323f
--- /dev/null
+++ b/some_file
@@ -0,0 +1 @@
+<U+FEFF>Hello
\ No newline at end of file

This example is a simple file encoded in UTF-8 *with BOM*.
On the other hand, the built-in git output shows this:

$ git --no-pager diff --cached
diff --git a/some_file b/some_file
new file mode 100644
index 0000000..357323f
--- /dev/null
+++ b/some_file
@@ -0,0 +1 @@
+=EF=BB=BFHello
\ No newline at end of file




You can see 'less' shows <U+FEFF> explicitly, while it is implicit and
hidden with git's built-in output.
Other characters behave the same, like ZERO WIDTH SPACE <U+200B>, and
I believe many others.
This is particularly annoying when there are other changes on the same
line. Here I add ' world!' but also remove the BOM:

$ git diff
diff --git a/some_file b/some_file
index 357323f..6769dd6 100644
--- a/some_file
+++ b/some_file
@@ -1 +1 @@
-<U+FEFF>Hello
\ No newline at end of file
+Hello world!
\ No newline at end of file

Compare with:

$ git --no-pager diff
diff --git a/some_file b/some_file
index 357323f..6769dd6 100644
--- a/some_file
+++ b/some_file
@@ -1 +1 @@
-=EF=BB=BFHello
\ No newline at end of file
+Hello world!
\ No newline at end of file




In the first example I can see both changes, in the second example the
BOM removal is hidden and I won't notice it because there is indeed
another genuine change on the same line.

I'll add a third example with CRLF line-terminators:

$ git diff
diff --git a/some_file b/some_file
index 357323f..dfd6895 100644
--- a/some_file
+++ b/some_file
@@ -1 +1 @@
-<U+FEFF>Hello
\ No newline at end of file
+Hello world!^M

and:

$ git --no-pager diff
diff --git a/some_file b/some_file
index 357323f..dfd6895 100644
--- a/some_file
+++ b/some_file
@@ -1 +1 @@
-=EF=BB=BFHello
\ No newline at end of file
+Hello world!




My thoughts are that git should add this feature and tend towards
less's behavior. A diff output should show as much as possible.
I would happily use 'less' all the time, but unfortunately I don't
think I can. For instance, 'git add --patch', which I use quite often,
prints through git's built-in output, and I miss less's features.

Joris Valette.
