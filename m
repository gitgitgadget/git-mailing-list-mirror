From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC resend] diff-options: make --patch a synonym for -p
Date: Thu, 13 May 2010 09:59:00 +0100
Message-ID: <1273741140.2516.15.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 10:59:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCUGC-0000Dh-5p
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 10:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab0EMI7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 04:59:07 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43729 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0EMI7F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 04:59:05 -0400
Received: by mail-ww0-f46.google.com with SMTP id 18so677039wwi.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=mTI3Ps7gpcCo71o1nCEbtc7RvjcHBvJ1Z1IutJO1nCI=;
        b=R7Ab+lP1rZWE5PllEwS+YHgI71C+TB0d8ToFx+7L93w+DP96gbPfSyI/h3t1iQNFZh
         APveZLyXelNWitGE6gTumE+UWhU0+htp1JCe8u1/4N+xf4/YOq0W5D/GoDKF/9T9bq5M
         eB2Tov82WQip8cErf5LNX9A72jzRYLAO1A7k4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=DRg1qV+M+vqttIDNQh9EROkawKvfvogEgHiGtp2ZXOUdFa+rAmYwYQg58cElx9eVkO
         Q/KZg2g00U+NcY0kl3ZQ5TeNWblnlADYj99Msu+KWSi8mXWCwJ8XNyVamKGyizdqgfc8
         JtVYl9wC/2CxoOkOkap7PqgTZZC5N17buUT4g=
Received: by 10.227.129.85 with SMTP id n21mr7871818wbs.194.1273741142451;
        Thu, 13 May 2010 01:59:02 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id k13sm524544wed.23.2010.05.13.01.59.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 01:59:01 -0700 (PDT)
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146980>

Here we simply make --patch a synonym for -p, whose mnemonic was "patch"
all along.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---

Re-sending, as this seems to have slipped under the radar last time.
In case a justification is non-obvious: -p has always meant "patch", and the
synonym (-u) has a long-form. I always find myself typing out the long-form
--patch, only to be surprised that it doesn't exist. This patch seeks to
correct what I can only assume was an oversight.

 Documentation/diff-options.txt |    1 +
 diff.c                         |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c9c6c2b..4a96859 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -21,6 +21,7 @@ endif::git-format-patch[]
 ifndef::git-format-patch[]
 -p::
 -u::
+--patch::
 	Generate patch (see section on generating patches).
 	{git-diff? This is the default.}
 endif::git-format-patch[]
diff --git a/diff.c b/diff.c
index d0ecbc3..8ea9f97 100644
--- a/diff.c
+++ b/diff.c
@@ -2722,7 +2722,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	const char *arg = av[0];
 
 	/* Output format options */
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
+	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch"))
 		options->output_format |= DIFF_FORMAT_PATCH;
 	else if (opt_arg(arg, 'U', "unified", &options->context))
 		options->output_format |= DIFF_FORMAT_PATCH;
