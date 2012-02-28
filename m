From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 0/3] http: proxy support improvements
Date: Tue, 28 Feb 2012 13:50:16 +0100
Message-ID: <4F4CCD88.4000102@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net, sam.vilain@catalyst.net.nz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 14:08:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2MnW-0002F1-RE
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 14:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213Ab2B1NIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 08:08:47 -0500
Received: from luthien1.mpt.es ([213.9.211.102]:39339 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757001Ab2B1NIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 08:08:46 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id B02E9F8717;
	Tue, 28 Feb 2012 12:51:42 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 23B162C4D1;
	Tue, 28 Feb 2012 12:51:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: B02E9F8717.884E7
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331034703.64066@Y3wjfPHXwAos2uE7ps8wAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191730>

[cc'ing jeff king and sam vilain as per git-blame they've
work on http auth and proxy code..]

Hi, my initial motivation for this patch was to add NTLM proxy
authentication so I could 'git clone' from inside my employers
network, but apart from doing that, I also added two more features,
so, so I'm sending three patches which implement the following features:

- Support NTLM proxy authentication (as well as other authentication
methods) by setting CURLOPT_PROXYAUTH[1] to CURLAUTH_ANY.

- Look up environment vars http_proxy and HTTP_PROXY in case git
http.proxy config option is not set. This supports system wide proxy
support in terminals.

- Support proxy urls with username but without a password, in which
case we interactively ask for the password (as it's already done in
http auth code). This makes possible to not have the password written
down in git config files or in env vars.

Thanks!

[1] http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTPROXYAUTH

Nelson Benitez Leon (3):
  http: authenticate on NTLM proxies and others suppported by CuRL
  http: try standard proxy env vars when http.proxy config option is
    not set
  http: when proxy url has username but no password, ask for password

 http.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 48 insertions(+), 2 deletions(-)

-- 
1.7.7.6
