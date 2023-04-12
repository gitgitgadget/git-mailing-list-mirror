Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AEAC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 19:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDLTy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 15:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDLTyY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 15:54:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490D161B6
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 12:54:09 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 51FB65C00D6;
        Wed, 12 Apr 2023 15:53:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 12 Apr 2023 15:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681329216; x=1681415616; bh=PHqiyXd/H794SS0DLdu9//O2H
        OFGEXb4hgXOVR2QzbU=; b=klMNL3Blj/nmrEtSKNRiMfWmNp92RRWEiSejPa/So
        trygNQUM7VrwpYab3qJj8V2Fi3h3tBywcVKVYaaWK5ipyAL/5fSFblwqDZv9Mlps
        51IpMRlKkr6ysvDTsmrxkJTKk8yPq2X31zzooHXP7a7+z5YdsEljlLkRLI20ohDB
        ltuXNs8iFKoc0ms8eL49tvY0xQm0Jgs7hRH2OSM5/5IjL+hQMVarEjx4gNMHpdxF
        4EZGSVKFh1mQJvTKn3w5ens4njSTO0jmk7yfOC0xDxn8A1Vwb8l8NF0eukF+xvEZ
        nvL4R3k+V1ePfBVv7IFFmMWHT/9ZoVGetejAGvG/u/tJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681329216; x=1681415616; bh=PHqiyXd/H794SS0DLdu9//O2HOFGEXb4hgX
        OVR2QzbU=; b=ZwQVDfG5ygrXDSPARWBc6csv87uLp4Cy5Yqw82RHhU3l7VobM9D
        ZfypYYhvWh/SzJHnUH599Gckj2GoiXHRdvcBs10jAnOn2SIlTy9luqU7UmTFwwHW
        /STxEnkyGyUN/KMsQIPyE03jHwnEQ+iHdNrj/lSQeCSww+aPOK8dtVq/TwGAv8jA
        RzRkn9TUK/S4XxQ3RyU8bz/wqufx54rCFnVVO/weT+9qayhjQEmX3GWRh9lfwKsD
        PySgaC0iKRsGhSigd5GQymYWij0+PjEuq7j5nCyb7vpWhpTdDlE0G7S8DZPpq+3s
        tLsGogYfJ+NbOv3pnxoASalxagiqIL9ZLrA==
X-ME-Sender: <xms:QAw3ZETKsk7gtgq_FhV1J6NBu9E7PoRkdKwAwuZyXBAqOwNVGRqCz2Y>
    <xme:QAw3ZBxTf9oTTRPfgoBLWSVmf4byX5nzcaLHdsgL5bFpGAoAGzFM18PYvwK7YY6AU
    52cyHnOsictXpWs2w>
X-ME-Received: <xmr:QAw3ZB3jEUqyMiYfNk0_r51_tDG5g2e7DzsT-_0F6LM8Y_2sIgP5g3uaEAwq1-yOMcR-B1FdrvrwbVCJir0mgx1fJsYYlKPQNdxO5P3IaYqHI_HXk5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepue
    eiueffuefftefhhfefleelhfeuheettedtheevgeejteehgfevffeugffglefhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:QAw3ZIAtSWXcDRFmUZ01GDEceDps4pRm9tOdcYRLOeGoet8EOPYHAA>
    <xmx:QAw3ZNgjTQ2h3GAz8pDhMlLev-EU-SPCZygwQEaYyDIdhfXqVEzhMA>
    <xmx:QAw3ZErvEtQNTotO1JVT5HVCyeS87p0ViktnY8k1wgDSAkpEVsdm_A>
    <xmx:QAw3ZAvUN7O06J9ZjrGtbTRikrHb-gnRD6SVS7o2CkWmUYhLNR4_Xw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 15:53:35 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        adlternative@gmail.com, christian.couder@gmail.com
Subject: [PATCH v3 0/4] doc: interpret-trailers: don't use deprecated config
Date:   Wed, 12 Apr 2023 21:52:11 +0200
Message-Id: <cover.1681326818.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680548208.git.code@khaugsbakk.name>
References: <cover.1680548208.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace deprecated `command` with `cmd` (patch 3). While visiting this
file also:

• rewrite heredoc examples to use files which are shown with
  cat(1) (patch 1);
• use input redirection instead of using cat(1) piped into `git
  interpret-trailers` (patch 2); and
• fix an example that didn’t work properly (patch 4).

§ Changes in v3

• All patches: drop “Cc” trailers
• Patch 1: Use input redirection instead of `cat msg.txt | git […]`
• Patch 2: New
• Patch 3: Add “acked” trailer
• Patch 4: Tweak commit message

Kristoffer Haugsbakk (4):
  doc: interpret-trailers: don’t use heredoc in examples
  doc: interpret-trailers: use input redirection
  doc: interpret-trailers: don’t use deprecated config
  doc: interpret-trailers: fix example

 Documentation/git-interpret-trailers.txt | 97 ++++++++++++++----------
 1 file changed, 55 insertions(+), 42 deletions(-)

Range-diff against v2:
1:  38f9a4bdf8 ! 1:  fd515ad8b4 doc: interpret-trailers: don’t use heredoc in examples
    @@ Commit message
             interpret-trailers', 2014-10-13)

         Suggested-by: Junio C Hamano <gitster@pobox.com>
    -    Cc: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

    -
    - ## Notes (series) ##
    -    This was one of the suggestions by Junio[1]
    -
    -    > Showing with a separate intermediate file, i.e.
    -    > [snip]
    -    > might make the result slightly easier to follow.  I dunno.
    -
    -    [1]: https://lore.kernel.org/git/xmqqsfdkep2b.fsf@gitster.g/
    -
      ## Documentation/git-interpret-trailers.txt ##
     @@ Documentation/git-interpret-trailers.txt: $ git config trailer.sign.key "Signed-off-by: "
      $ git config trailer.sign.ifmissing add
    @@ Documentation/git-interpret-trailers.txt: $ git config trailer.sign.key "Signed-
      $ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
     -$ git interpret-trailers <<EOF
     -> EOF
    -+$ cat empty-msg.txt | git interpret-trailers
    ++$ git interpret-trailers <empty-msg.txt

      Signed-off-by: Bob <bob@example.com>
     -$ git interpret-trailers <<EOF
    @@ Documentation/git-interpret-trailers.txt: $ git config trailer.sign.key "Signed-
     -> EOF
     +$ cat msg.txt
     +Signed-off-by: Alice <alice@example.com>
    -+$ cat msg.txt | git interpret-trailers
    ++$ git interpret-trailers <msg.txt

      Signed-off-by: Alice <alice@example.com>
      ------------
    @@ Documentation/git-interpret-trailers.txt: Fix #42
     -> message
     ->
     -> EOF
    -+$ cat msg.txt | git interpret-trailers --trailer="help:Junio" --trailer="help:Couder"
    ++$ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <msg.txt
      subject

      message
    @@ Documentation/git-interpret-trailers.txt: Helped-by: Christian Couder <christian
     -> message
     ->
     -> EOF
    -+$ cat msg.txt | git interpret-trailers --trailer="ref:Add copyright notices."
    ++$ git interpret-trailers --trailer="ref:Add copyright notices." <msg.txt
      subject

      message
    @@ Documentation/git-interpret-trailers.txt: Reference-to: 8bc9a0c769 (Add copyrigh
     +subject
     +
     +message
    ++
    ++see: HEAD~2
      $ git config trailer.see.key "See-also: "
      $ git config trailer.see.ifExists "replace"
      $ git config trailer.see.ifMissing "doNothing"
    @@ Documentation/git-interpret-trailers.txt: Reference-to: 8bc9a0c769 (Add copyrigh
     ->
     -> see: HEAD~2
     -> EOF
    -+$ cat msg.txt | git interpret-trailers
    ++$ git interpret-trailers <msg.txt
      subject

      message
    @@ Documentation/git-interpret-trailers.txt: See-also: fe3187489d69c4 (subject of r
     -> Reviewed-by: Z
     -> Signed-off-by: Z
     -> EOF
    -+$ cat commit_template.txt
    ++$ cat temp.txt
     +***subject***
     +
     +***message***
    @@ Documentation/git-interpret-trailers.txt: See-also: fe3187489d69c4 (subject of r
     +Cc: Z
     +Reviewed-by: Z
     +Signed-off-by: Z
    -+$ sed --in-place -e 's/ Z$/ /' commit_template.txt
    ++$ sed -e 's/ Z$/ /' temp.txt > commit_template.txt
      $ git config commit.template commit_template.txt
     -$ cat >.git/hooks/commit-msg <<EOF
     -> #!/bin/sh
-:  ---------- > 2:  12f7b10462 doc: interpret-trailers: use input redirection
2:  ea06be8f5a ! 3:  dc1982f0d0 doc: interpret-trailers: don’t use deprecated config
    @@ Commit message
            better simulate the behavior of `git command -s`,
            'trailer.<token>.cmd' will not automatically execute.”

    -    Cc: ZheNing Hu <adlternative@gmail.com>
    +    Acked-by: ZheNing Hu <adlternative@gmail.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

      ## Documentation/git-interpret-trailers.txt ##
    @@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc
      $ git config trailer.sign.ifexists doNothing
     -$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
     +$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
    - $ cat empty-msg.txt | git interpret-trailers
    + $ git interpret-trailers <empty-msg.txt

      Signed-off-by: Bob <bob@example.com>
    -@@ Documentation/git-interpret-trailers.txt: $ cat msg.txt
    - subject
    -
    +@@ Documentation/git-interpret-trailers.txt: subject
      message
    +
    + see: HEAD~2
     +$ cat ~/bin/glog-ref
     +#!/bin/sh
     +git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14
    @@ Documentation/git-interpret-trailers.txt: $ cat msg.txt
      $ git config trailer.see.ifExists "replace"
      $ git config trailer.see.ifMissing "doNothing"
     -$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
    --$ cat msg.txt | git interpret-trailers
    +-$ git interpret-trailers <msg.txt
     +$ git config trailer.see.cmd "glog-ref"
    -+$ cat msg.txt | git interpret-trailers --trailer=see
    ++$ git interpret-trailers --trailer=see <msg.txt
      subject

      message
3:  14555cf87f ! 4:  f6e5605107 doc: interpret-trailers: fix examples
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>

      ## Commit message ##
    -    doc: interpret-trailers: fix examples
    +    doc: interpret-trailers: fix example

         We need to provide `--trailer sign` since the command won’t output
         anything if you don’t give it an input and/or a
    -    `--trailer`. Furthermore, the example where `msg.txt` already contains
    -    an s-o-b is wrong:
    +    `--trailer`. Furthermore, the message which already contains an s-o-b is
    +    wrong:

    -        $ cat msg.txt | git interpret-trailers --trailer sign
    +        $ git interpret-trailers --trailer sign <msg.txt
             Signed-off-by: Alice <alice@example.com>

             Signed-off-by: Alice <alice@example.com>

    -    A file which only consists of one trailer line is not interpreted as the
    -    original example must have expected. So change the examples to use the
    -    typical “subject/message” file.
    -
    -    Cc: Christian Couder <chriscool@tuxfamily.org>
    -    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    +    This can’t be what was originally intended.

    +    So change the messages in this example to use the typical
    +    “subject/message” file.

    - ## Notes (series) ##
    -    This isn’t just a quirk of this series but also happens on `master`:
    -
    -        $ git config trailer.sign.ifmissing add
    -        $ git config trailer.sign.ifexists doNothing
    -        $ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
    -        $ git interpret-trailers <<EOF
    -        > EOF
    -        $ git interpret-trailers <<EOF
    -        Signed-off-by: Alice <alice@example.com>
    -        > EOF
    -        Signed-off-by: Alice <alice@example.com>
    -
    -        Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    +    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

      ## Documentation/git-interpret-trailers.txt ##
     @@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
    @@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc
      $ git config trailer.sign.ifmissing add
      $ git config trailer.sign.ifexists doNothing
      $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
    --$ cat empty-msg.txt | git interpret-trailers
    -+$ cat msg1.txt | git interpret-trailers --trailer sign
    +-$ git interpret-trailers <empty-msg.txt
    ++$ git interpret-trailers --trailer sign <msg1.txt
     +subject
     +
     +message
    @@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc
     +message
     +
      Signed-off-by: Alice <alice@example.com>
    --$ cat msg.txt | git interpret-trailers
    -+$ cat msg2.txt | git interpret-trailers --trailer sign
    +-$ git interpret-trailers <msg.txt
    ++$ git interpret-trailers --trailer sign <msg2.txt
     +subject
     +
     +message
--
2.40.0
