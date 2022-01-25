Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3272C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 12:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383845AbiAYMkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 07:40:09 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39879 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229755AbiAYMhj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Jan 2022 07:37:39 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 11B505C0112;
        Tue, 25 Jan 2022 07:37:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 25 Jan 2022 07:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=xkzUTNeW9zAHAjuux/n+9oms9Fb1q+
        PACNsVYbQIcwQ=; b=lLblaOUiwsyfpcSGX/Cmm7+HiRBHaM89TFXj8hiazJQ5QK
        SdwNDB4qcmgrGZ5pYcMB3InivhIp+7OUn3uFuw2jKsSGm7sRsbv1nXag70O/AXNw
        mkLYNNR6WpKht++SysuV7GFNegOoTKr0KYsByG6301c/xCTlcGhLnOVsw2y3XuY2
        i4khy0/cZaqmxtp4VRYmM1RwXG3ETGm4OOwz645R8WvYktTfoBsslBlvJxzujMU3
        KLr22mdet1NYyQP3uFRZbWm6P7/FD7DuH/MSBbbDxA9AY65pg4G96BlSsm3vPUPM
        pspGyf5g+PH3WIdDanchecHAt1ZVICKV8I6qrRaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xkzUTN
        eW9zAHAjuux/n+9oms9Fb1q+PACNsVYbQIcwQ=; b=BflJtFt7IXIJvB4Vleng0/
        u1ZK88JbM8XjO0aGptdB6YUPgOkvqeQyzVCoOR+zTO3PtWbQMTmKShckcjJSED7X
        qY99tzsKL4mOskxHi+7M3n9U4Z0ZK43nMnlopATncLATw9SaAhUQjJqZ0Khl2OYg
        w/bpU+ybzfigGBhKhLTDncz2w13Rz/2OfTqOg7jCdtcjIAjspCNU1lSP8xClJtp0
        7njCVApHxlkhedv8xHZdB1xQOEtVR35iR6ZZPA6ce/AU+ZQHOI/Sa4i+ubemGIL3
        ktHWAqI6ZM4qj5VSTe6wQTPKGXsYHPk4hb5gtqojkVmIpMlDMdz6xWecms5v1fSg
        ==
X-ME-Sender: <xms:C-_vYThAIW7AjcALzoycyLxFMDg2EuKyn4mzbVtkpZgbwUQ0Z7qM2g>
    <xme:C-_vYQDEcM-iYm9-ASgn99E8AfUUHUDgdj-QwYWn9aJVKyDd6HcJ7yOt8LxoPLeyQ
    tqdTsZEgRBsdT9nEho>
X-ME-Received: <xmr:C-_vYTHMe0qaWw10EuW__KkZz0y5Pka4j7dwPdn_HJr9cIoDi5op-IMPhWoqU3hG44RjnbaWTZ2hg3cMglr45vgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdelgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefirhgvghcujfhurhhrvghllhcuoehgrhgvgheshhhurhhrvghl
    lhdrnhgvtheqnecuggftrfgrthhtvghrnhepueetvdeiffdugeegheduhedtudefleejhe
    dttdetvdetfefhveekueduleehtdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:C-_vYQRjOfD6aW8w9WDvui9eRL_m9T52W5cMA4xr4bL-nxBPY6F5CA>
    <xmx:C-_vYQyFWNPTjE_p-qFXU5N6LKAQageMWNgV94a_tqL2co6d5BgEWw>
    <xmx:C-_vYW4KMBT9bab00YKyN6ALZcqhbkizuf_UUTKUDCK4qdYQ2ceTRg>
    <xmx:DO_vYWbeKZg3KA9bS4VBNMFHCOhWwe5GHS4OugyVVHoOd2rsHsol0g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jan 2022 07:37:31 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Greg Hurrell <greg@hurrell.net>
Subject: [PATCH 1/2] docs: Fix bad whitespace in Documentation/config/pgp.txt
Date:   Tue, 25 Jan 2022 13:37:15 +0100
Message-Id: <20220125123716.66991-2-greg@hurrell.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220125123716.66991-1-greg@hurrell.net>
References: <20220125123716.66991-1-greg@hurrell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Greg Hurrell <greg@hurrell.net>
---
 Documentation/config/gpg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 0cb189a077..abfabd6d62 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -37,7 +37,7 @@ gpg.minTrustLevel::
 gpg.ssh.defaultKeyCommand::
 	This command that will be run when user.signingkey is not set and a ssh
 	signature is requested. On successful exit a valid ssh public key is
-	expected in the	first line of its output. To automatically use the first
+	expected in the first line of its output. To automatically use the first
 	available key from your ssh-agent set this to "ssh-add -L".
 
 gpg.ssh.allowedSignersFile::
-- 
2.35.0

