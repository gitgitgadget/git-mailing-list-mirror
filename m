From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 3/3] cache-tree: Write index with updated cache-tree after
 commit
Date: Tue, 01 Jul 2014 06:26:19 +0200
Message-ID: <53B2386B.4060802@web.de>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com> <1404173597-24713-3-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 06:27:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1pes-0007n4-Hl
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 06:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbaGAE07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 00:26:59 -0400
Received: from mout.web.de ([212.227.17.11]:61061 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbaGAE06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 00:26:58 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M8iPI-1WwII81CfM-00CBOX; Tue, 01 Jul 2014 06:26:56
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1404173597-24713-3-git-send-email-dturner@twitter.com>
X-Provags-ID: V03:K0:RS68dCgbZhpdcrdqzFmcAiiKhVQf9ojWeHGOCXvUIhQdqHpWDhw
 vrs5gcGKiIec4rqOu+/m/mGwcaFWM+FYHUJ6CJmBZz2v3bcS9EQ2a88AZaib4I2rhK5JFe5
 zxr8KUhdFTE2qqlkuntkZPuH1vwOwEurOWl5OV2BKR2OugEgHNRddR0qxtXfTSmWegBDoxq
 +u3chysE+8SjvwzMxr77Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252708>

[]

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 5383258..d50acb8 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -16,8 +16,31 @@ cmp_cache_tree () {
  # We don't bother with actually checking the SHA1:
  # test-dump-cache-tree already verifies that all existing data is
  # correct.
+generate_expected_cache_tree () {
+	if [ -n "$1" ]
+	then
+		local dir="$1/"
+	else
+		local dir="$1"
+	fi

I think the Git test cases prefer "test" over "[]":

	if test -n "$1"
	then
		local dir="$1/"
	else
		local dir="$1"
	fi

And should there be a && after the "fi" ?
And as test -n tests for a non-zero string,
could we write like this (and drop the local ?)?

	if test -n "$1"
	then
		dir="$1/"
	else
		dir=""
	fi
