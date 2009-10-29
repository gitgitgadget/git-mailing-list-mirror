From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Thu, 29 Oct 2009 01:31:17 +0100
Message-ID: <20091029003117.GA18299@localhost>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-27-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 01:31:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3IvT-0002mi-1q
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995AbZJ2Ab3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbZJ2Ab3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:31:29 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:62094 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988AbZJ2Ab2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:31:28 -0400
Received: by ey-out-2122.google.com with SMTP id 9so332341eyd.19
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=nbvOEMH+RpEqMvF8tby6DwlDNi93WnWxAlKXcZPqEgI=;
        b=mGB2FoHTLyfxDHk5LGfioDX6BW/WUu94PYw/RO7dx8w6u4lmZz4v1wK0PfGbdZ2ByH
         77OUO0Br77pqHT5+bSWk0J3Qs/4MdrQzlCy3NGZkDkfp5kqLVZg3J2LeIspbJsjdEjHd
         RLNOyPDCDIuml9Sm4/E4PWo1SnHyDBAywmlAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Q6z4zJm+IfMLufj8t3wPGuzDrfKK1PtKhEx4kt4ULSx+OAmjoqA4zILiBpSgVfxIBq
         BgoWPynKD4z+Or0lFnWkCy5/6M23xc4Yid83U4PSvDZ7KVVJ2d8Yp4AJBgKsyPp99CW/
         vFslalwOFrfoocHWlzwZcF9tjrWBczdk35bd8=
Received: by 10.211.132.3 with SMTP id j3mr1599889ebn.54.1256776292218;
        Wed, 28 Oct 2009 17:31:32 -0700 (PDT)
Received: from darc.lan (p549A7F29.dip.t-dialin.net [84.154.127.41])
        by mx.google.com with ESMTPS id 1sm10763967ewy.49.2009.10.28.17.31.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 17:31:31 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N3Iv7-000517-O3; Thu, 29 Oct 2009 01:31:17 +0100
Content-Disposition: inline
In-Reply-To: <1256774448-7625-27-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131546>

On Wed, Oct 28, 2009 at 05:00:48PM -0700, Shawn O. Pearce wrote:

> --- /dev/null
> +++ b/t/t5541-http-push.sh
[...]
> +LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}

This should be 5541. We need different ports to be able to run the tests
simultenously.

> --- a/t/t5550-http-fetch.sh
> +++ b/t/t5550-http-fetch.sh

There is also a http port related bug in t5550. I'm attaching the patch
below. Maybe you want to squash this in here.

> --- /dev/null
> +++ b/t/t5551-http-fetch.sh
[...]
> +LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}

Ditto, 5551.

Clemens

-->o--
Subject: [PATCH] set httpd port before sourcing lib-httpd

If LIB_HTTPD_PORT is not set already, lib-httpd will set it to the
default 8111.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5540-http-push.sh  |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 5c0f4d7..ea46d1e 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -9,17 +9,16 @@ This test runs various sanity checks on http-push.'
 
 . ./test-lib.sh
 
-ROOT_PATH="$PWD"
-LIB_HTTPD_DAV=t
-LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
-
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
 then
 	say "skipping test, USE_CURL_MULTI is not defined"
 	test_done
 fi
 
+LIB_HTTPD_DAV=t
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
+ROOT_PATH="$PWD"
 start_httpd
 
 test_expect_success 'setup remote repository' '
-- 
1.6.5.1.208.gd7b37
