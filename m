From: larsxschneider@gmail.com
Subject: [PATCH v2] convert: legitimately disable clean/smudge filter with an empty override
Date: Fri, 29 Jan 2016 09:21:36 +0100
Message-ID: <1454055697-6742-1-git-send-email-larsxschneider@gmail.com>
Cc: tboegi@web.de, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 09:21:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP4JO-0008BC-Fi
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 09:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbcA2IVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 03:21:41 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33259 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbcA2IVk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 03:21:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id r129so8377862wmr.0
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 00:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cqgL7SH3i+liOQouLvNLUTR67sD4T1yHd7Ee4tCrA/0=;
        b=PmdA+SGjF4gdTjopvetSkBx61RGHmX6tuQrumahi9tsI/7SE2uS1tItxgZm1qzIyFS
         pNRYKOVfrMFshn/Cql2kag7MKvBfsH3N6KZJLpLFbNJn+2Pe80p1+DbrjHOfvOV7vbUm
         tLyM+9GuC+2XgVutVMpXB/zAiZxApiQ+pOXi2DTWKy9KnYXyz8Lz9uhCQVD+JW2yx8E/
         IsSQNDR4RoRYkf/aHDZodq81ajAFHFrI+Wp6eiHzPLI6Si5Uu/BlFov/gf68OIwbG+pS
         5Q1paTZSyLaevzRqxmy4v0TB/Y5+luPL6Wo4F+14JbpgXFIjXMHS70g0a53TbgnU7Q9S
         qDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cqgL7SH3i+liOQouLvNLUTR67sD4T1yHd7Ee4tCrA/0=;
        b=YfnkQ5ayCBhm2L2/PlOl1lOCSWfwFHMSXb074VbPwPsSzpcqUFECsmgrucf+F0YXD1
         gn0dSRyhk0uIGi72CR4K8wWbf0YkVcSUPEc4dyRaI/TU4is3gZ2ImvPt76AinJzlcobZ
         rureUrGugMwZNcVRQnE0t7oKoVCnHbdb+276ExV+sj1Qk+LRYUCmiKIBgRKhzPGUvPWF
         FQvWhtDFjdA1RywwBkbPaOydXiCHn1HEb0970gEcr4YWQzXYgA9d1l01mC+ZOI26hJaK
         XUh8MXzZxMQgXnH9S7U+DkC5yQehKc6KfwEQIqFUWl1lEG4SCKv/LMxoVPXghXNzzcYH
         ngcA==
X-Gm-Message-State: AG10YORZD2i3NAQzQg7I6O6wa66hXZjkjw+2R1japYiZVHYeFBy1UocRqooMe6THhmF3Cg==
X-Received: by 10.28.45.151 with SMTP id t145mr7929322wmt.88.1454055699844;
        Fri, 29 Jan 2016 00:21:39 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA916.dip0.t-ipconnect.de. [80.139.169.22])
        by smtp.gmail.com with ESMTPSA id i5sm14457681wja.23.2016.01.29.00.21.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jan 2016 00:21:38 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285071>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v1:
* improve commit message (Thanks Junio & Torsten)
* check for empty filter strings in apply_filter to catch all use cases (Thanks Peff)
* use more idiomatic style to check for an empty string (Thanks Eric)
* use test_config/test_config_global to set configs (Thanks Eric)
* use test_must_be_empty to check for empty err file (Thanks Eric)

Cheers,
Lars


Lars Schneider (1):
  convert: legitimately disable clean/smudge filter with an empty
    override

 convert.c             |  2 +-
 t/t0021-conversion.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

--
2.5.1
