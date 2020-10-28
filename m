Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74EDC4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E92420796
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOUWnSBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390466AbgJ1X26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgJ1X13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:27:29 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A39C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:27:29 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n15so729327otl.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4gV3y6febuEWDZFQZRkrTTArWNaQf9nYjFaOt7OV2w=;
        b=IOUWnSBhxznANct6CRUli1XBSwKxXJKnBudkiqGULeh3wzKRfehDPurbbs+5ega6ag
         KmRvLsBsNXYDAzEuUlV76OcFHahQVFk1iaxJRKxg/rI7/5ZZD5vj8cPm8HYaUY3Qlsgy
         dBbKyQn49f0uh1gYvFH4ezZf2tGwJIM7s/kXbu6FzUaE0YuhwIocQvv+B4OkmOJbQTDg
         xl1k1AG8yRsfqdpCmFnntXqqCtaGr5oD4PGj+qIeYJ86oL+F/gq4CbKkTq3+Q/VYLpqW
         0eE/PiXFN43zXj7fg1xhkG1VstrlnDya9W+zFjc9Ps5DuGmksG7Ds9sq8LJUA4THvPuQ
         wYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4gV3y6febuEWDZFQZRkrTTArWNaQf9nYjFaOt7OV2w=;
        b=TjAjmyvGpEWHFo1bl59ZzEs7OhraoFcCxjoG+4NSDUEqywquu1VStltSViE9J6le43
         Zi+qayzvqbzoZVEo2boU56p5XjgTt3vX3eT7GvpbVNVNji6uLHNL0Zk4tRuLIDPvWA3g
         Za7YbC4PU2xa/ZRfxA8bv2Kot2pvv+zugS+VJkca+czY1UqIEZVU3RXUmXUHVQDi925l
         j/zTjY/nUQVaHYnF7m/54v/Yl6EdpdRa7wpfSdc0yRLY+dRvLjdBBP0AR+4fBE1bSA/z
         Jp/iR4/aOvKK8qd8ed/ZGplYNkWj44CGgWmHi1opSohkBHL1d0yTGT3KIkmlDIwZPwXF
         MYFg==
X-Gm-Message-State: AOAM533DArrL7T+Vd0melbB1bEjHRmRqK/dtULpOEIUgB2Y+ZOfOlLr6
        1RExzjiQLbwjBqOuRQDclGK0tTfv+tSQZ2z3
X-Google-Smtp-Source: ABdhPJwUaU5kWeHSczCRBH1AojeXhXgUPL6PaCJ+X7QKBEZHfTL5XXOXbZ0ICCPY8GJ4A1ZqAeUcxQ==
X-Received: by 2002:a05:6830:1c3c:: with SMTP id f28mr3793021ote.188.1603850852515;
        Tue, 27 Oct 2020 19:07:32 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p21sm1738283oto.21.2020.10.27.19.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:32 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 11/29] completion: zsh: fix completion for --no-.. options
Date:   Tue, 27 Oct 2020 20:06:54 -0600
Message-Id: <20201028020712.442623-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was introduced in upstream's bash script, but never in zsh's:

  b221b5ab9b (completion: collapse extra --no-.. options)

It has been failing since v2.19.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index f524c6042a..e567062505 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -59,10 +59,32 @@ __gitcomp ()
 	case "$cur_" in
 	--*=)
 		;;
+	--no-*)
+		local c IFS=$' \t\n'
+		local -a array
+		for c in ${=1}; do
+			if [[ $c == "--" ]]; then
+				continue
+			fi
+			c="$c${4-}"
+			case $c in
+			--*=|*.) ;;
+			*) c="$c " ;;
+			esac
+			array+=("$c")
+		done
+		compset -P '*[=:]'
+		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
+		;;
 	*)
 		local c IFS=$' \t\n'
 		local -a array
 		for c in ${=1}; do
+			if [[ $c == "--" ]]; then
+				c="--no-...${4-}"
+				array+=("$c ")
+				break
+			fi
 			c="$c${4-}"
 			case $c in
 			--*=*|*.) ;;
-- 
2.29.1

