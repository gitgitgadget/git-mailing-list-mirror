From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 7/7] t/README: Add a note about the dangers of coverage chasing
Date: Sun, 25 Jul 2010 19:52:45 +0000
Message-ID: <1280087565-24671-8-git-send-email-avarab@gmail.com>
References: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 21:53:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od7GR-00040o-Cw
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab0GYTx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 15:53:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49624 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab0GYTxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 15:53:15 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so646045ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=URE2b4jou/HtmeYYAZyyKOpoJ7PezrxRLO9VQMcBqVM=;
        b=L14Ej9UDS9Ndps/iiPCjpWa1U1+Yh8d8LkbmA1mf/H8eTD8Zs1VGQ2RxLA1KAtxOS2
         mjmYeRS0VDsRZiJKP6PzEAXcrLcVGN/AGdy2LHlw4kgYpY53FU+vhxIXLce8Vqw6/I/H
         NGdXCs6kdAkXXPPdxQTGYRq4vxcr3Tvg/awfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sP8+RVTCvqxVUkvTQEuRDJHlLWJ2dwGtgix19L042ji/rPIsTMVswNxbY+1ooGo5ro
         66gIkn4LsXoyYiIgCQ7sb+hPsbKN5eqnhCgD2wPfBCAwYnWB6F1aF8uaxYx5EhVrc6vn
         OhZRgBaxvWya+/kIkhp4a10r1CMZmMTnBB5SM=
Received: by 10.213.15.135 with SMTP id k7mr2911062eba.39.1280087595243;
        Sun, 25 Jul 2010 12:53:15 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm4369452eei.19.2010.07.25.12.53.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 12:53:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151787>

Having no coverage at all is almost always a bad sign, but trying to
attain 100% coverage everywhere is usually a waste of time. Add a
paragraph to explain this to future test writers.

Inspired-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Jonathan doesn't particularly like this one. I have no particular
preference, just trying to get across the point that you shouldn't
cargo-cult-coverage.

 t/README |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 15d4b52..4fe8d50 100644
--- a/t/README
+++ b/t/README
@@ -271,6 +271,15 @@ Do:
  - Check the test coverage for your tests. See the "Test coverage"
    below.
=20
+   Don't blindly follow test coverage metrics, they're a good way to
+   spot if you've missed something. If a new function you added
+   doesn't have any coverage you're probably doing something wrong,
+   but having 100% coverage doesn't necessarily mean that you tested
+   everything.
+
+   Tests that are likely to smoke out future regressions are better
+   than tests that just inflate the coverage metrics.
+
 Don't:
=20
  - exit() within a <script> part.
--=20
1.7.0.4
