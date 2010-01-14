From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 3/3] Smart-http tests: Test http-backend without curl
 or a webserver
Date: Thu, 14 Jan 2010 06:27:52 +0100
Message-ID: <4B4EAB58.6040901@alum.mit.edu>
References: <20100102214107.GO6914@spearce.org> <1262468639-8847-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 06:28:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIFW-0004KG-H7
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab0ANF17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365Ab0ANF17
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:27:59 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58471 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0ANF16 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:27:58 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.128] (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5RquU032687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jan 2010 06:27:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <1262468639-8847-1-git-send-email-tarmigan+git@gmail.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136930>

Tarmigan Casebolt wrote:
> This reuses many of the tests from the old t5560 but runs those tests
> without curl or a webserver.  This will hopefully increase the testing
> coverage for http-backend because it does not require users to set
> GIT_TEST_HTTPD.
> 
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>

I'm not sure which version of this patch is currently committed, but in
any case test t/t5560-http-backend-noserver.sh is broken for me in
"next".  According to git-bisect, the guilty commit is

fd0a8c2e6428acb883bf4707de54b3e026c57455 'Smart-http tests: Test
http-backend without curl or a webserver'

I'm not familiar with this part of the code and I haven't done any
special setup (e.g., I have not set GIT_TEST_HTTPD, whatever that is).
Simply checking out, "make"ing, then running
t5560-http-backend-noserver.sh results in 13/14 failures starting with
test 2:

> 
> * expecting success: 
> 	log_div "refs/heads/master"
> 	GET refs/heads/master "404 Not Found"
> 
> --- exp	2010-01-14 05:21:34.000000000 +0000
> +++ act	2010-01-14 05:21:34.000000000 +0000
> @@ -1 +1 @@
> -Status: 404 Not Found
> +Status: 500 Internal Server Error
> * FAIL 2: direct refs/heads/master not found

This failure is on Ubuntu Linux 8.04 "hardy".

Please let me know if I am doing something wrong or if you would like
any more information.

Michael
