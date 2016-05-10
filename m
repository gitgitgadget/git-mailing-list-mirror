From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v8 0/3] Add support for sending additional HTTP headers (part
 2)
Date: Tue, 10 May 2016 09:08:15 +0200 (CEST)
Message-ID: <cover.1462863934.git.johannes.schindelin@gmx.de>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 09:08:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01mb-0003nI-LW
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbcEJHIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 03:08:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:63822 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbcEJHI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 03:08:29 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LfC00-1bO8Bj3nnk-00omPn; Tue, 10 May 2016 09:08:16
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462774709.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:nDApE/qXIm26SPQNXH+122ONy+S3TRyq1LnjeCdB9aDndFQSP5h
 hFu9lGNMUKvyECvhpkRGXXyKvehKWICqlKLCkd3iKMNhu55nx9kWZcekI7ZmKX4C4AEP31l
 dul4FiTIQzmK6nxXRTTqm7a0uBadlRJHx9a58vRaJUsOL7t3a5G9X1zUbTiXaIhBcsk8jJ3
 eRYURs2tM4LwFbMmMlUfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h9+0Pz0wSPQ=:Xea7UFhXi1HFWhmTG51dwf
 cS+qq8EQEtszsn4QjKvcugXMVaW8YvQFPol+LNIth5jVF/Xao+3pa3bnUaPVd4aHtL9+/Iaq4
 YWYt43QAoD18RXUcNDx7+NOG3cgJfha+z0QkpSg0DvcWsdLxQRhr4Es28MtnyqXKR+oc0UA/G
 gN7/xY14I2K/CPP61FCXi0PWfVetupwwOnqv3gCpZVvTOqgeKJiC4S5+hxt2vyRPEvbm6h3R3
 hxl0DtTOUX1GWNplACZ4dWkM2qLKhiwUfjhfHDJCjCElVTXkQf5LF9+o6JvmCqE6Bx2M6KhRL
 Xlzsmy1kJOoVGcl9n1sJMlH7vL87kVO4kPcZIhT/fe1SzJWEBuNYO1k1YlCOBoYZyhnwajSYQ
 j3FNdcGUsRXQGfy/mQh56I67QyR4/tsgbBPNsQnJp+gagSHIjpoqVI0SaiVGOsNGiChJi4Kq5
 rGm7Hwby8N9WD+tx40ENoZ3xPFmlEf8aNMjpjo+gnPQbPhxZkWO4WdC2k21gAm0bl6FaFqRdk
 4uz99VsLB+h23kyO2W/JIZKnWCMDMrGAi7Lj+7LFu4XjRZvxLizq3yy9ztCoXLR0mrfQN3t79
 gnUXP6OC+d4clrn/Bo0yCPRyBevBhgldTcPoFkxQ6ku8cdOJH37EltdyItfbA/Ek474oO1o4/
 kn9Cst8ZvjjFKJ+hQs8FUBqna0Q/3I/GEDwZNBs3p84yQnbQRu03nDMd2JLtELHm3IrHwETdl
 byLOuwqy723phOVtGRO39yBCe5P0GaPURPBbRetote/D/b2wJpo1S3XiAe6UJOoCd7LwuUJP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294105>

My use case is an army of build agents that need only limited and
selective access to otherwise private repositories.

The first part already made it into `master`, this is the remainder.

This iteration is based on 'jk/submodule-c-credential' and therefore
converted the original config-sanitizing patch into a test-only patch.
This iteration also replaces the "ugly" comment with the explanation
preferred by Junio.


Johannes Schindelin (3):
  tests: adjust the configuration for Apache 2.2
  t5551: make the test for extra HTTP headers more robust
  submodule: ensure that -c http.extraheader is heeded

 t/lib-httpd/apache.conf     | 16 ++++++++++++----
 t/t5551-http-fetch-smart.sh | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 6 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/extra-http-headers-v8
-- 
Interdiff vs v7:

 diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
 [no longer applies; skipped]
 diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
 index 29b34bb..018a83a 100644
 --- a/t/lib-httpd/apache.conf
 +++ b/t/lib-httpd/apache.conf
 @@ -133,8 +133,12 @@ RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302
  RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
  
  # Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
 -# And as RewriteCond unfortunately lacks "not equal" matching, we use this
 -# ugly trick to fail *unless* the two headers are present.
 +# And as RewriteCond does not allow testing for non-matches, we match
 +# the desired case first (one has abra, two has cadabra), and let it
 +# pass by marking the RewriteRule as [L], "last rule, do not process
 +# any other matching RewriteRules after this"), and then have another
 +# RewriteRule that matches all other cases and lets them fail via '[F]',
 +# "fail the request".
  RewriteCond %{HTTP:x-magic-one} =abra
  RewriteCond %{HTTP:x-magic-two} =cadabra
  RewriteRule ^/smart_headers/.* - [L]

2.8.2.463.g99156ee
