From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 2/3] config: add 'type' to config_source struct that
 identifies config type
Date: Tue, 16 Feb 2016 22:07:07 +0000
Message-ID: <56C39D8B.3060700@ramsayjones.plus.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-3-git-send-email-larsxschneider@gmail.com>
 <20160215174218.GB26443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sschuberth@gmail.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: Jeff King <peff@peff.net>, larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 16 23:07:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVnmC-0007lN-KU
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 23:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbcBPWHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 17:07:14 -0500
Received: from avasout07.plus.net ([84.93.230.235]:52072 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcBPWHN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 17:07:13 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id KA791s0044mu3xa01A7As8; Tue, 16 Feb 2016 22:07:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8 a=Cwv7g3hokbWumf5GGGwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160215174218.GB26443@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286440>



On 15/02/16 17:42, Jeff King wrote:
> On Mon, Feb 15, 2016 at 11:17:45AM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> Use the config type to print more detailed error messages that inform
>> the user about the origin of a config error (file, stdin, blob).
>>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  cache.h                |  6 ++++--
>>  config.c               | 36 +++++++++++++++++++++++++-----------
>>  submodule-config.c     |  4 ++--
>>  t/t1300-repo-config.sh |  8 +++++++-
>>  t/t1308-config-set.sh  |  4 ++--
>>  5 files changed, 40 insertions(+), 18 deletions(-)
> 
> Looks good to me.
> 
> -Peff
> 

Hi Lars,

Could you please squash this into your patch.

Thanks!

ATB,
Ramsay Jones

-- >8 --
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Date: Tue, 16 Feb 2016 21:35:41 +0000
Subject: [PATCH] config: avoid declaration missing prototype warnings

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 cache.h  | 4 ++--
 config.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 3ff94dc..7f1fa65 100644
--- a/cache.h
+++ b/cache.h
@@ -1546,8 +1546,8 @@ extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
 extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
-extern const char *current_config_type();
-extern const char *current_config_name();
+extern const char *current_config_type(void);
+extern const char *current_config_name(void);
 
 struct config_include_data {
 	int depth;
diff --git a/config.c b/config.c
index f1efba8..0a35323 100644
--- a/config.c
+++ b/config.c
@@ -2414,12 +2414,12 @@ int parse_config_key(const char *var,
 	return 0;
 }
 
-const char *current_config_type()
+const char *current_config_type(void)
 {
 	return cf && cf->type ? cf->type : "cmdline";
 }
 
-const char *current_config_name()
+const char *current_config_name(void)
 {
 	return cf && cf->name ? cf->name : "";
 }
-- 
2.7.0
