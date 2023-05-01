Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA80C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 20:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjEAUFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 16:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjEAUFf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 16:05:35 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B56D26B6
        for <git@vger.kernel.org>; Mon,  1 May 2023 13:05:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7C1E632009A0;
        Mon,  1 May 2023 16:05:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 01 May 2023 16:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1682971533; x=1683057933; bh=MZf/MG3lv1cPp1JWbPT3Wnumx
        JACiJ+LvMo0ocy68jo=; b=eDVdwdzsOJxnghoR4qjZun9IIoJDCEEgB7nHO2gOP
        W15CLiL8pzf60n1V15hsyt9YyK2J2nk6LmV+EfQpMPjuunBBX737yb8NHPFqhCUb
        Wc6MLyrZ7SgJa7DWxYEeWwY081LybGvpvs+e9wwtDQkAFkJorFo8pA7oZB3XgVZl
        Jz5SSdrANh+QKTfeTt66aX2VPRWC+JjVgb2lk2T+JNAYQCtP5AyvHdAINOzJ/77H
        Kjz125K/M/c2xKmtP/3cpcukoLgy7pbzbS6qFgameeX8JNRtCrYjG829yq4oMD1c
        CT+gpqGgozcVxAPRy9cB+nUWygbQ0cdcXnbsl+Bp2XcGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682971533; x=1683057933; bh=MZf/MG3lv1cPp1JWbPT3WnumxJACiJ+LvMo
        0ocy68jo=; b=J0el/Hd5lcwdnTnSn0eLyvzxenB3zz+CYEaxjDhbfdiBxaOY0HP
        tXMvZO490RJGKU+SuvZqiNSWB8MQ2f0IUmI6aTHjxAY7AvVk8vPs6AZbYcwgCIMa
        l/l14RdLnlvbBZqiEXbeAi9vUEtHS1E4BfxL8212UaMufDeQlF1QSjLEBOOne2Ow
        ypFy07HLGjEC16LfXOTQ821DucTFFFo8t58Jzb9nHd9rBnJNQm8lZ14tAz9d+0pf
        YouCUP+37yNYEmuAcQdpksTqfopKBKw+CootVIo0aNBve9F/c2XKHlYKfsjB+bve
        Af3GyO1+yn17v3Z94y+1gcovgCH6jX5qJPg==
X-ME-Sender: <xms:jRtQZAKXwGjEHq30MPVQmL8sahaFHmZM1yStlXBlV8lL69XNYfENc8A>
    <xme:jRtQZAI0etsIOJhueodZ7pNpC8M3gSUcXBCKTq-dgt2WrIZ_JuJnSrtYIR9qQWfyN
    0KRdkIjbY5TN_1M8w>
X-ME-Received: <xmr:jRtQZAtJ-uKQU2Xl1l7l3A5c2lSTSEqVqbv-Ox-FSNec7B3uGHXZNGiELXOkgHU6R75Vy8d1uUrTIP7W9glV05xl3JkBZOLRfQxS5mrhBQ1xekat_t8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:jRtQZNZnOKdTOQ_LccZ-M0-8cNJhkWqLb1u-4WlBPBaA3LFHcsT_Mw>
    <xmx:jRtQZHY-2mmdbrX3m5AlIRFobuR8-dnvyzi7gFu5O7T2hrLHYGaqRQ>
    <xmx:jRtQZJA4uY-MNk8l2RBJO-tABxb5H51_hCNWf9NJHu6xxqrrBFYotg>
    <xmx:jRtQZOxXCJ7Xk-LCeSzbDguVtR1LYPN-Nl3-Rf8GbbtDZPxJEaWRQg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 16:05:32 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/4] =?UTF-8?q?doc:=20interpret-trailers:=20don?= =?UTF-8?q?=E2=80=99t=20use=20heredoc=20in=20examples?=
Date:   Mon,  1 May 2023 22:02:38 +0200
Message-Id: <149dcf964cb0ff056b8bb454602b07b316725400.1682970213.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1682970213.git.code@khaugsbakk.name>
References: <cover.1680548208.git.code@khaugsbakk.name> <cover.1682970213.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This file contains four instances of trailing spaces from its inception
in commit [1]. These spaces might be intentional, since a user would be
prompted with `> ` in an interactive session. On the one hand, this is a
whitespace error according to `git diff --check`; on the other hand, the
raw documentation—it makes no difference in the rendered output—is just
staying faithful to the simulation of the interactive prompt.

Let’s get rid of these whitespace errors and also make the examples more
friendly to cut-and-paste by replacing the heredocs with files which are
shown with cat(1).

[1]: dfd66ddf5a (Documentation: add documentation for 'git
    interpret-trailers', 2014-10-13)

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-interpret-trailers.txt | 74 +++++++++++-------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 22ff3a603e..4f4eb7a7fc 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -326,13 +326,12 @@ $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
 $ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
-$ git interpret-trailers <<EOF
-> EOF
+$ git interpret-trailers </dev/null
 
 Signed-off-by: Bob <bob@example.com>
-$ git interpret-trailers <<EOF
-> Signed-off-by: Alice <alice@example.com>
-> EOF
+$ cat msg.txt
+Signed-off-by: Alice <alice@example.com>
+$ git interpret-trailers <msg.txt
 
 Signed-off-by: Alice <alice@example.com>
 ------------
@@ -357,15 +356,14 @@ Fix #42
 $ cat ~/bin/glog-find-author
 #!/bin/sh
 test -n "$1" && git log --author="$1" --pretty="%an <%ae>" -1 || true
+$ cat msg.txt
+subject
+
+message
 $ git config trailer.help.key "Helped-by: "
 $ git config trailer.help.ifExists "addIfDifferentNeighbor"
 $ git config trailer.help.cmd "~/bin/glog-find-author"
-$ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <<EOF
-> subject
->
-> message
->
-> EOF
+$ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <msg.txt
 subject
 
 message
@@ -382,15 +380,14 @@ Helped-by: Christian Couder <christian.couder@gmail.com>
 $ cat ~/bin/glog-grep
 #!/bin/sh
 test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
+$ cat msg.txt
+subject
+
+message
 $ git config trailer.ref.key "Reference-to: "
 $ git config trailer.ref.ifExists "replace"
 $ git config trailer.ref.cmd "~/bin/glog-grep"
-$ git interpret-trailers --trailer="ref:Add copyright notices." <<EOF
-> subject
->
-> message
->
-> EOF
+$ git interpret-trailers --trailer="ref:Add copyright notices." <msg.txt
 subject
 
 message
@@ -402,17 +399,17 @@ Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
   commit that is related, and show how it works:
 +
 ------------
+$ cat msg.txt
+subject
+
+message
+
+see: HEAD~2
 $ git config trailer.see.key "See-also: "
 $ git config trailer.see.ifExists "replace"
 $ git config trailer.see.ifMissing "doNothing"
 $ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
-$ git interpret-trailers <<EOF
-> subject
-> 
-> message
-> 
-> see: HEAD~2
-> EOF
+$ git interpret-trailers <msg.txt
 subject
 
 message
@@ -427,22 +424,21 @@ See-also: fe3187489d69c4 (subject of related commit)
   to add a 'git-version' trailer:
 +
 ------------
-$ sed -e 's/ Z$/ /' >commit_template.txt <<EOF
-> ***subject***
-> 
-> ***message***
-> 
-> Fixes: Z
-> Cc: Z
-> Reviewed-by: Z
-> Signed-off-by: Z
-> EOF
+$ cat temp.txt
+***subject***
+
+***message***
+
+Fixes: Z
+Cc: Z
+Reviewed-by: Z
+Signed-off-by: Z
+$ sed -e 's/ Z$/ /' temp.txt > commit_template.txt
 $ git config commit.template commit_template.txt
-$ cat >.git/hooks/commit-msg <<EOF
-> #!/bin/sh
-> git interpret-trailers --trim-empty --trailer "git-version: \$(git describe)" "\$1" > "\$1.new"
-> mv "\$1.new" "\$1"
-> EOF
+$ cat .git/hooks/commit-msg
+#!/bin/sh
+git interpret-trailers --trim-empty --trailer "git-version: \$(git describe)" "\$1" > "\$1.new"
+mv "\$1.new" "\$1"
 $ chmod +x .git/hooks/commit-msg
 ------------
 
-- 
2.40.1

