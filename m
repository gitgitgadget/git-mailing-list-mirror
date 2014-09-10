From: Harry Jeffery <harry@exec64.co.uk>
Subject: [PATCH 2/2] pretty: add %D format specifier
Date: Wed, 10 Sep 2014 23:00:15 +0100
Message-ID: <5410C9EF.9080509@exec64.co.uk>
References: <5410C998.5060701@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:00:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRpvm-0001Yq-SH
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbaIJV76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 17:59:58 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:48960 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbaIJV75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 17:59:57 -0400
Received: by mail-we0-f181.google.com with SMTP id w62so2869277wes.40
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 14:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VqEMRUPKR9K0P8K8CNCV19vQ8jWiAzlmgUDvsmquZEY=;
        b=HcCw4HPH2tYbor/wDk/q090mxhZQW9yLMtzu7h5H4fHXMrv73OULV2TL5Rk1IY/30K
         iiLj6X7gTdxkPMRZf/iHgWmHUXSrmL6Qatb90K7CDzcogXeB/YqoM3FEK+qU2QOC/QgL
         5u6onfjqFveAmjrI5d75QiVmZeNe1vgjNmbFP0pIkhYSBQZIYZDgPQqBWJe87kBJweRS
         nC4caIOanpP9NxtS5qBxDaVYRQzyr3YMZt1xvtYELnwiuOI86Ve8HV63TwFFB2ya5z5U
         7Imn13hcIEcMNCudz4tiALhYfiZecOgaOJ1w5lXMd5wPkmog1XhbMoRY3no1ESs1SwCj
         LIJw==
X-Gm-Message-State: ALoCoQmIVSbXlcWVCT8KL1dTjMsc1We1wd/3Cbx8p+tCHYrqgck8aqb6GyXkfPhr9t8iko+Z23Be
X-Received: by 10.194.191.135 with SMTP id gy7mr8312763wjc.39.1410386396498;
        Wed, 10 Sep 2014 14:59:56 -0700 (PDT)
Received: from [192.168.0.14] (cpc69047-oxfd25-2-0-cust267.4-3.cable.virginm.net. [81.109.93.12])
        by mx.google.com with ESMTPSA id ec2sm3856890wib.19.2014.09.10.14.59.55
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 14:59:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <5410C998.5060701@exec64.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256772>

%d prints decorations wrapped by " (" and ")". %D provides the same
output without the parenthesis, making " (%D)" and "%d" equivalent to
one another.

Signed-off-by: Harry Jeffery <harry@exec64.co.uk>
---
  Documentation/pretty-formats.txt | 6 ++++--
  pretty.c                         | 4 ++++
  2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt 
b/Documentation/pretty-formats.txt
index eac7909..2632e1a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -128,6 +128,7 @@ The placeholders are:
  - '%ct': committer date, UNIX timestamp
  - '%ci': committer date, ISO 8601 format
  - '%d': ref names, like the --decorate option of linkgit:git-log[1]
+- '%D': ref names without the " (", ")" wrapping.
  - '%e': encoding
  - '%s': subject
  - '%f': sanitized subject line, suitable for a filename
@@ -182,8 +183,9 @@ The placeholders are:
  NOTE: Some placeholders may depend on other options given to the
  revision traversal engine. For example, the `%g*` reflog options will
  insert an empty string unless we are traversing reflog entries (e.g., by
-`git log -g`). The `%d` placeholder will use the "short" decoration
-format if `--decorate` was not already provided on the command line.
+`git log -g`). The `%d` and `%D` placeholders will use the "short"
+decoration format if `--decorate` was not already provided on the command
+line.

  If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
  is inserted immediately before the expansion if and only if the
diff --git a/pretty.c b/pretty.c
index e4dc093..a75ad0d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1197,6 +1197,10 @@ static size_t format_commit_one(struct strbuf 
*sb, /* in UTF-8 */
  		load_ref_decorations(DECORATE_SHORT_REFS);
  		format_decorations(sb, commit, c->auto_color, " (", ", ", ")");
  		return 1;
+	case 'D':
+		load_ref_decorations(DECORATE_SHORT_REFS);
+		format_decorations(sb, commit, c->auto_color, "", ", ", "");
+		return 1;
  	case 'g':		/* reflog info */
  		switch(placeholder[1]) {
  		case 'd':	/* reflog selector */
-- 
2.1.0
