From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v5 0/5] new roll of proxy improvements
Date: Tue, 13 Mar 2012 15:01:53 +0100
Message-ID: <4F5F5351.8090401@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 14:04:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ROk-00025k-B2
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 14:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab2CMNEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 09:04:13 -0400
Received: from luthien1.map.es ([82.150.0.102]:57905 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab2CMNEM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 09:04:12 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 169E724CE4;
	Tue, 13 Mar 2012 14:03:07 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 877D22C50D;
	Tue, 13 Mar 2012 14:03:01 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 169E724CE4.ECE21
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332248588.69916@XlZgoBdht4myCl9+c0HR3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193017>


The changes from v4 are:
- In patch 1/5, read proxy env var accordingly to the protocol used in
the destination url, so e.g. if url is a https one, we will only read 
https_proxy env var. We also read no_proxy env var so to ignore 
aforementioned proxy env var if no_proxy contains an asterisk ('*') or 
contains the host used in url destination. To make those changes
possible we needed to pass the destination url as a parameter to 
get_active_slot() and get_curl_handle() functions, so that change is
also included in the patch.

- In patch 2/5, added Junio review fixes.

Regards,

Nelson Benitez Leon (5):
  http: try http_proxy env var when http.proxy config option is not set
  http: handle proxy proactive authentication
  http: handle proxy authentication failure (error 407)
  http: Avoid limit of retrying request only twice
  http: rename HTTP_REAUTH to HTTP_RETRY

 http-push.c   |   24 ++++++++--------
 http-walker.c |    2 +-
 http.c        |   84 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 http.h        |    4 +-
 remote-curl.c |    4 +-
 5 files changed, 88 insertions(+), 30 deletions(-)

-- 
1.7.7.6
