Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0603C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30E2206DB
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 00:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgIPA0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:26:09 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgIOOMg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 10:12:36 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MVvGt-1jt7WV1k2v-00RmzD; Tue, 15 Sep 2020 15:54:30 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 3FA7D1E01E8;
        Tue, 15 Sep 2020 13:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fzqIknABOA2I; Tue, 15 Sep 2020 15:54:29 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 030391E01E7;
        Tue, 15 Sep 2020 15:54:28 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id CBACB80518; Tue, 15 Sep 2020 15:54:28 +0200 (CEST)
Date:   Tue, 15 Sep 2020 15:54:28 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] config: option transfer.ipversion to set transport protocol
 version for network fetches
Message-ID: <20200915135428.GA28038@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915130506.GA2839276@coredump.intra.peff.net>
X-Provags-ID: V03:K1:JnwQiqo2O7tWcMvwF18SSFVwNLv5LBsnm9L2kJ7QakqVbAeCv6/
 1jsLP8i5WRFPS1MQxFJcDV6od503NvlrOFzFlVGuEVHWF725e7fpHNh/Gj03s65qYSWCtzD
 XjIUNZUHjPW6aFH8YLp4nzaL9ekQf9YSYDb9pC4i0/dGd1xy1TJytE2O7IY9/lAqwQ5KgUI
 tYAOeJ5qB1mfKTLx6oSdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y5NuIWFCDhY=:GYrq0Bp6DIMsnop/FK0Z0v
 jSOqLe5xubdhdChYMxfxXaAnf1PW0e4yEyqD7UfNPZskYoGmIfidXglj6tBdpG1loXpvjCm6M
 WF4Efgb9eabY1s/GAy/sipsfWMQdBormUsItPcOYkkYZlK8c1BMZZvijfeksJRRtRmNPIU9Rj
 kmhdnp++WCfuqF3Rny2AQJuCnp/7a2PiCCotNzURhOzHGuKBUdGlOjRsspO+fmrhreC+eeZxp
 KZ8NFcb4DDXWQI5YbLz1wpiUKA41Wa4VDP6jlAXd1AUnxWsYeCDXUKX+AsOougIqWTuQ1OZDR
 7vQNE4QFY7yX+QfCRSVuQIKF9demJ1Uxut0/d1QR+yr+G8skuHoTQmlLZJXgUw7m0vNR5A4C0
 CJtT3jwoh0UlnFZnCk3o3WQiiZWWvwuxQmxNDgoLStPfAauZwCA3s7z69dBsVZCij04NSDjmx
 hBi1U4W6ozGK/cdUxi2RrELAsAQVxOu403qPN48IwmarQQ32K6xgJ3xKUmJcfW+PBQ/K9Y8ay
 xFagpE+GeWwQYaA7N/WPHKSmawfOYf3vC9AA1bx977oIk/JSQqMjaGzihHgK7FvndZnRLPfeQ
 0FRI7M0FzRf8+jWmYXwOCxTU/WP9k7GKI4eBL5gmLNv2DL9ERTmr/56LZFVtZtDCJNZ+93mk8
 vqdjREGDCkM1g7WQGF9jxdXpQppdujo1IWrtDraI016eNJtOiXM3NbiBPQm2Fj6GJoQRmefSy
 O9FQWo3acsuVlYT1DSavYU6SfYcC716uyHDkWjMk/gDixZn0vEY8qmVbkmllZ1qxHVXcGDkge
 nTNuzxypwSFWGbUIVB7GR+6LEzn3zZAVyXI12eIrVBG5P/e5YzzA1a08hMEH1GrjcckJGzUCs
 XcESasbw8lqgIaD/VXaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Affecting the transfers caused by git-fetch, the
option allows to control network operations similar
to --ipv4 and --ipv6 options.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
---

Jeff King, Tue, Sep 15, 2020 15:05:06 +0200:
> On Tue, Sep 15, 2020 at 01:50:25PM +0200, Alex Riesen wrote:
> > Sure! Thinking about it, I actually would have preferred to have both: a
> > config option and a command-line option. So that I can set --ipv4 in, say,
> > ~/.config/git/config file, but still have the option to try --ipv6 from time
> > to time to check if the network setup magically fixed itself.
> > 
> > What would the preferred name for that config option be? fetch.ipv?
> 
> It looks like we've got similar options for clone/pull (which are really
> fetch under the hood of course) and push. We have the "transfer.*"
> namespace which applies to both already. So maybe "transfer.ipversion"
> or something?

Something like this?

 Documentation/config/transfer.txt |  7 +++++++
 builtin/fetch.c                   | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index f5b6245270..cc0e97fbb1 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -69,3 +69,10 @@ transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
 	The default value is 100.
+
+transfer.ipversion::
+	Limit the network operations to the specified version of the transport
+	protocol. Can be specified as `4` to allow IPv4 only, `6` for IPv6, or
+	`all` to allow all protocols.
+	See also linkgit:git-fetch[1] options `--ipv4` and `--ipv6`.
+	The default value is `all` to allow all protocols.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 447d28ac29..da01c8f7b3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -118,6 +118,17 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "transfer.ipversion")) {
+		if (!strcmp(v, "all"))
+			;
+		else if (!strcmp(v, "4"))
+			family = TRANSPORT_FAMILY_IPV4;
+		else if (!strcmp(v, "6"))
+			family = TRANSPORT_FAMILY_IPV6;
+		else
+			die(_("transfer.ipversion can be only 4, 6, or any"));
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
-- 
2.28.0.21.g178b32a6fd.dirty
