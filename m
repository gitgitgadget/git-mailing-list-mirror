Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A79C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 20:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjEAUFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 16:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjEAUFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 16:05:22 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1122685
        for <git@vger.kernel.org>; Mon,  1 May 2023 13:05:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A15FE32004E7;
        Mon,  1 May 2023 16:05:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 01 May 2023 16:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1682971513; x=1683057913; bh=3TdLrwKC00bYIhO9XQ1SCNDaL
        KnziZzZddc0zKPY/9E=; b=X/km3imfkd7ExVqHf2V6WDadjJvNx7lBPm5VvSzUs
        MpS0cB1ZT0fMa+/QTwwLcsXTYSeqONf0jTwwxWjQwdRkfD1Af4jwg8zj5frYNTq+
        /QCkNJRLl3ugKvgNHtTk0VgzO+0q13UHUgZt3+Sq3AIfN6Gz0xfujFZtABLTgMI4
        AMb0VlMm/20UoOwkVioiAkRQEbM1MynGNDpk0C4VJ+IHE/jZxJe9WiGBaJBscelM
        ppJ6pWcHVcxbOd7AE6WLaE9WE5DBVPFjIy8JTcVWNc3JDOKZKOXNXemymgctlv5R
        moDtQZhMTrHsRUa1vgmkpMXRkgNfLBHmjOestRiaREnjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682971513; x=1683057913; bh=3TdLrwKC00bYIhO9XQ1SCNDaLKnziZzZddc
        0zKPY/9E=; b=PclfVo2Nk78vLJXdsmiPcpI9IsdzhsdVc9pCleyDLIJAyrlpObY
        UqLidLES0QQmPo2bDMrQb3LsD92gyna/wz2bEJ/UP5w3vpFjuzK5iD5saaODVGiQ
        pmOS0s5QV+ke5ernvtq9+2rcm+L7ys6amCvNRsXG4YySkI103KY8AQJCt9ftaXbz
        rcBKjFU02P60HopAvQvIpGoScVRaeaS5dwun7gxKhPqoSub0WIT3boSMUH8B8nAE
        5l3hftjNLSrOSQthW/D+I1xd7rdgRUfmJbWm/HxdaktHtdE5fppiHz9/S200vgu5
        r3UMjsryxnRRkWSJQDhKiwGsX9pOYzilcEw==
X-ME-Sender: <xms:eRtQZHhPWtUFxTGm7uvu2rE-MNQKx42TW0WZJ16FX_dplApcEn4ZN_c>
    <xme:eRtQZEDCb5VzlWqapMnbkDQ905SHFFo07B6WVCb6mOhBkXK1xoXDv12lZKfVul1R5
    x6A0wbsngs0AcDznw>
X-ME-Received: <xmr:eRtQZHGNe5MfbzkaWyKGZkF5_P3Lzz5--6UIFJl796pMCd8nARj2cPxF6v3N1Dwc3dxyR5Orj1EYZ2B_DQfBJb3UUSIAeS-vMojwmeNanN0WDh4Ilq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepue
    eiueffuefftefhhfefleelhfeuheettedtheevgeejteehgfevffeugffglefhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:eRtQZEQrvnMyKGMPODDhcPauooEqtSP2YxbfmPUZLA1TKpvgRXOzyQ>
    <xmx:eRtQZExIyznUyHUAhv1Y0OMjJ55mXtyiW7LO7Cs5WUFyTEbT0JoPQg>
    <xmx:eRtQZK6seE3LvVU0Sv6lR4d8kw_9EYFjCSicOYw3UvNTdgMqEsHspA>
    <xmx:eRtQZKaHaIgnyopC_UcEqIS0MuHeW1di75U1ypgOnJgO0wzjvtzoIA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 16:05:13 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v4 0/4] doc: interpret-trailers: don't use deprecated config
Date:   Mon,  1 May 2023 22:02:37 +0200
Message-Id: <cover.1682970213.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
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

§ Changes in v4

• Patch 1: Use `/dev/null` instead of `empty-msg.txt`
• Patch 2: Expand commit message

Kristoffer Haugsbakk (4):
  doc: interpret-trailers: don’t use heredoc in examples
  doc: interpret-trailers: use input redirection
  doc: interpret-trailers: don’t use deprecated config
  doc: interpret-trailers: fix example

 Documentation/git-interpret-trailers.txt | 97 ++++++++++++++----------
 1 file changed, 55 insertions(+), 42 deletions(-)

Range-diff against v3:
1:  fd515ad8b4 ! 1:  149dcf964c doc: interpret-trailers: don’t use heredoc in examples
    @@ Documentation/git-interpret-trailers.txt: $ git config trailer.sign.key "Signed-
      $ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
     -$ git interpret-trailers <<EOF
     -> EOF
    -+$ git interpret-trailers <empty-msg.txt
    ++$ git interpret-trailers </dev/null

      Signed-off-by: Bob <bob@example.com>
     -$ git interpret-trailers <<EOF
2:  12f7b10462 ! 2:  32483aa635 doc: interpret-trailers: use input redirection
    @@ Metadata
      ## Commit message ##
         doc: interpret-trailers: use input redirection

    +    Use input redirection instead of invoking cat(1) on a single file. This
    +    is more straightforward, saves a process, and often makes the line
    +    shorter.
    +
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>


      ## Notes (series) ##
    -    Link: https://lore.kernel.org/git/xmqqbkk44qbo.fsf@gitster.g/
    +    Junio suggested expanding the commit message:
    +    https://lore.kernel.org/git/xmqqjzyg7qdw.fsf@gitster.g/

      ## Documentation/git-interpret-trailers.txt ##
     @@ Documentation/git-interpret-trailers.txt: $ cat msg.txt
3:  dc1982f0d0 ! 3:  9ea4c4f916 doc: interpret-trailers: don’t use deprecated config
    @@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc
      $ git config trailer.sign.ifexists doNothing
     -$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
     +$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
    - $ git interpret-trailers <empty-msg.txt
    + $ git interpret-trailers </dev/null

      Signed-off-by: Bob <bob@example.com>
     @@ Documentation/git-interpret-trailers.txt: subject
4:  f6e5605107 ! 4:  95760aafe8 doc: interpret-trailers: fix example
    @@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc
      $ git config trailer.sign.ifmissing add
      $ git config trailer.sign.ifexists doNothing
      $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
    --$ git interpret-trailers <empty-msg.txt
    +-$ git interpret-trailers </dev/null
     +$ git interpret-trailers --trailer sign <msg1.txt
     +subject
     +
--
2.40.1
