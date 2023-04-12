Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12ABC77B73
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 19:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDLT5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 15:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDLT5i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 15:57:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9111FFC
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 12:57:36 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 444265C00D6;
        Wed, 12 Apr 2023 15:57:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 12 Apr 2023 15:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681329456; x=1681415856; bh=pztcFc9X2ktTHsUCMLfQM4LuJ
        evaMQWgCH0tivhknt8=; b=nBgE/tcwrNQ9GEGIUDidXsbkvc9tfxvZh3/iZFu5g
        ylAu5xvJMg3m4FMLctI68n7BzldVbm/S2MDjWVYnnNzMc8pcnYGeFXaXiLOht935
        JB0BlAmLweVaGj7tGIu//L7iacJaez0QHIg43+w3sHAVmFHuMdN+OVwk78w4gXnR
        6o95f03XA2W6YbLjhEeFK5bH9dV4fNhTtRgsxZuI4/xq8kwxoygOjtpPylMO7Reb
        /KTZbF4HmCBw+3Sai5xYyehZeRoQmt+gfoQNO061PL4HQwtimYsxxQQbhsyFL1BP
        AUYELlm9DPR/x2eD4aI9/X+ZgX2HbmrCs744CGj4zzpxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681329456; x=1681415856; bh=pztcFc9X2ktTHsUCMLfQM4LuJevaMQWgCH0
        tivhknt8=; b=YmUF0fWxhrFJB4AWOoApTySQKo6CN4Xg7pafdHYVodXDyU2b82l
        DQnDydLxdDpa5qNfFpFGHutoaRO91shZrLVniIBOeDRRweiiNW1nw42573EC8wjX
        LQoNKnSmc20FsUSxvxIxRAfu70B7HyJbIsg108bnnxM8PTaxtqCPJNXtLTfX/BNa
        4tidTBRZoQGjgHeKsdG6w+2FlHROEMi42JxGFo8mOWQArLnXicfSwM95YsrIkZoA
        Bi/p146iLJgFGZyajQdP21KPuXwJltVLZffOG+cAVTANoJ8m+7aws3Y/8i3+ZQZ9
        f7ndbJ0wxorIAfOvpmrUAMU+hEy0j9bNtJg==
X-ME-Sender: <xms:MA03ZEQsJPPAARITdc5sJfh5FU2hPCA_7ub0BOjSkn4047aqpN69HPU>
    <xme:MA03ZBwN0hR1ZwgGfBDAngRSTW5RWHrNnQZ_f6Da4vSBi_Bpmmhd6rIZYk77Iz0V4
    pFWWtBTfBC00O9z8Q>
X-ME-Received: <xmr:MA03ZB0VZ-p3OPHx26W8m7xESQi6jksvkTrd7PYBO6TKvrPxDA0Ata05YrY9zf5qWcm9TGC65YseLdRU317lXc10VeCWVcgecEkaWx3XOIJuS50OZSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:MA03ZIB3e0w7gc1HO76KTg0qdeGfsuEhHhfeHjJ87blD7hdJ2bJf3Q>
    <xmx:MA03ZNilMuRL0W_RfKmRLAYupuj9aYvpvcgkHz139k9PoAn3FnAcnA>
    <xmx:MA03ZEpJl15lKnmbDlLJmwlRa8YYDmpjm2iqRjtiCh380THJeoM98g>
    <xmx:MA03ZCvOX5vl1oDgUxVcIc0ZYSUIryEtwak87BnndaqImunalv_2TA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 15:57:34 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        adlternative@gmail.com, christian.couder@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] =?UTF-8?q?doc:=20interpret-trailers:=20don?= =?UTF-8?q?=E2=80=99t=20use=20heredoc=20in=20examples?=
Date:   Wed, 12 Apr 2023 21:52:12 +0200
Message-Id: <fd515ad8b4b7c04aea9f332f47a660350d91fd57.1681326818.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681326818.git.code@khaugsbakk.name>
References: <cover.1680548208.git.code@khaugsbakk.name> <cover.1681326818.git.code@khaugsbakk.name>
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
index 22ff3a603e..15d34b983f 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -326,13 +326,12 @@ $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
 $ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
-$ git interpret-trailers <<EOF
-> EOF
+$ git interpret-trailers <empty-msg.txt
 
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
2.40.0

