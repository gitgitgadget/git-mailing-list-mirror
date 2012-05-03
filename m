From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 0/6] Re-roll of http-proxy-more branch
Date: Thu, 03 May 2012 18:39:37 +0200
Message-ID: <4FA2B4C9.10202@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 17:42:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPyB4-0004nH-Dw
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 17:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539Ab2ECPml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 11:42:41 -0400
Received: from luthien1.mpt.es ([82.150.0.102]:11313 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab2ECPmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 11:42:40 -0400
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id D160625741;
	Thu,  3 May 2012 17:42:27 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id ADD27203CA8;
	Thu,  3 May 2012 17:42:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: D160625741.F0B8F
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336664547.9463@Qpzcslno/v/7kFysb4kr6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196910>

Hi, this is a reroll of http-proxy-more branch melting
the fixup patches and taken into account following Jeff's
comments:

http://article.gmane.org/gmane.comp.version-control.git/195443

But I kept using specific curl options for proxyusername and
password as they proper handle the username to contain special
characters like colon as explained here:

http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTPROXYUSERNAME

and also setting those in set_proxy_auth() function makes for cleaner
code imho, but will change it if you still feel uncomfortable with that.

Looking forward to having this merged..

Thanks!


Jeff King (1):
  http: fix http_proxy specified without protocol part

Nelson Benitez Leon (5):
  http: try http_proxy env var when http.proxy config option is not set
  http: handle proxy proactive authentication
  http: handle proxy authentication failure (error 407)
  http: Avoid limit of retrying request only twice
  http: rename HTTP_REAUTH to HTTP_AUTH_RETRY

 credential.c  |   12 ++++--
 http-push.c   |   24 ++++++------
 http-walker.c |    2 +-
 http.c        |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 http.h        |    4 +-
 remote-curl.c |    4 +-
 6 files changed, 124 insertions(+), 33 deletions(-)

-- 
1.7.7.6
