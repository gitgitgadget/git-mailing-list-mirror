Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD2C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 19:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDCTYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 15:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCTYF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 15:24:05 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD11E7C
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 12:24:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 311123200495;
        Mon,  3 Apr 2023 15:24:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Apr 2023 15:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680549842; x=1680636242; bh=W+EDktMXHs9yOLuVKaVrlVXPm
        hLb9jlE3pxfmyEbKc4=; b=j8FtfaY7OdRx04QLHJrxacbWun4aHNQXAC1O2Ee2H
        aRcQjli+kQg05X5W8ymG4IMJvmikmtAhZwDw2Hux9mq0PZlcxLQUj3zg/BbP/rhL
        MFZFBxvb0tCSur05PrNI4JYaFKuW2YjTr5+sORij2gPe/oKjoOF+z2nfGcuYNaqY
        1n63pkfhyEAFC1yBsesCaX33kmDwFr2cVDH8b1xc1cYFUSTe5cbDkkTWeEOeKQ/Q
        aLlwruys1Wkn0ScDGnmpGAgx6H9cUZPn7Msme8NXZWyPqh/BeWccL6CWAVakpHT9
        9yui00UK5RXWAOL/mR0myPcoqFXV0+VMoT+liNJxbd07w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680549842; x=1680636242; bh=W+EDktMXHs9yOLuVKaVrlVXPmhLb9jlE3px
        fmyEbKc4=; b=RSmzrtKyk30ojyc6NqIIUy7BRpdaXJz+uQ8XoQW1ZwPvMpmDeeA
        HXoLVP1mvD9zw61AAnIY4+s+1qVVA3e0debq1BNmoSA40cmxUlb1c89Q4XUlcgFB
        +zdArqJ8j0aaPSSb1T4zpy2kleoS7V6HSX5bAECVQ3J/TN2VXqRPYseMGFzQsNZx
        bmIkxIqdEI3R+nuyeb28KJzQDLoKwiG349E4bDzIu5dTIxw9GZlAvJNQRLsvGRIE
        12jgJS8kthgEaqRmoOra1C3k1rk5cGs1TeuyX6NmFYZa3fSKOzXCNmU3dbpOBSUO
        ZX+8sz1S3yq3LPsNYmNhlBxojieuRHAEU3Q==
X-ME-Sender: <xms:0icrZNEmLkwf3wBQOXsLz_PZCSNIj4pqR8xAM5tmCCNgaT3o_lcHHko>
    <xme:0icrZCVpKDU1fpjmvT0sChtaHEIgzgeAjbxjnvXQVwMEk5HxPLnZULBl1ES8SUI8U
    qArJK28CDqTedONww>
X-ME-Received: <xmr:0icrZPJaKOyUCEqdTUUSMCYHSOVHJoEDPoT22hbIhe8qldf1wrz7JhyIlgbFpbUdajMyxvf2FvDpyD2Zrtpy8ggwviCXyzzs51LEdrCYvHJp5D4GAI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepue
    eiueffuefftefhhfefleelhfeuheettedtheevgeejteehgfevffeugffglefhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:0icrZDGR38Yf8uvcVze3Y97U8p5TbfljxX1yOl8ooETc6BAbjBwIfQ>
    <xmx:0icrZDWcEh0K5PX-AmZJqUN3-6lP-vidE1zsv2XUjTTjOV39bqLuxg>
    <xmx:0icrZOO8BpGwtpB1hSqXXxOvpJumnY79ASlHIZ3Yfok07D_D7eiB9g>
    <xmx:0icrZOS7phANGOTpHvPcIvWbOgVq59LAug8cg65F5lBY7i9SrxT-xA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 15:24:01 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, rybak.a.v@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] =?UTF-8?q?doc:=20interpret-trailers:=20don?= =?UTF-8?q?=E2=80=99t=20use=20heredoc=20in=20examples?=
Date:   Mon,  3 Apr 2023 21:21:59 +0200
Message-Id: <38f9a4bdf89f854c30a7b708e955e2089b031c13.1680548650.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680548650.git.code@khaugsbakk.name>
References: <20230331181229.15255-1-code@khaugsbakk.name> <cover.1680548650.git.code@khaugsbakk.name>
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
Cc: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    This was one of the suggestions by Junio[1]
    
    > Showing with a separate intermediate file, i.e.
    > [snip]
    > might make the result slightly easier to follow.  I dunno.
    
    [1]: https://lore.kernel.org/git/xmqqsfdkep2b.fsf@gitster.g/

 Documentation/git-interpret-trailers.txt | 72 +++++++++++-------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 22ff3a603e..dbbb6815c3 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -326,13 +326,12 @@ $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
 $ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
-$ git interpret-trailers <<EOF
-> EOF
+$ cat empty-msg.txt | git interpret-trailers
 
 Signed-off-by: Bob <bob@example.com>
-$ git interpret-trailers <<EOF
-> Signed-off-by: Alice <alice@example.com>
-> EOF
+$ cat msg.txt
+Signed-off-by: Alice <alice@example.com>
+$ cat msg.txt | git interpret-trailers
 
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
+$ cat msg.txt | git interpret-trailers --trailer="help:Junio" --trailer="help:Couder"
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
+$ cat msg.txt | git interpret-trailers --trailer="ref:Add copyright notices."
 subject
 
 message
@@ -402,17 +399,15 @@ Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
   commit that is related, and show how it works:
 +
 ------------
+$ cat msg.txt
+subject
+
+message
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
+$ cat msg.txt | git interpret-trailers
 subject
 
 message
@@ -427,22 +422,21 @@ See-also: fe3187489d69c4 (subject of related commit)
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
+$ cat commit_template.txt
+***subject***
+
+***message***
+
+Fixes: Z
+Cc: Z
+Reviewed-by: Z
+Signed-off-by: Z
+$ sed --in-place -e 's/ Z$/ /' commit_template.txt
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
2.40.0

