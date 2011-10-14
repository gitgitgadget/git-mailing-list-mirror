From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/6] http-auth-early
Date: Fri, 14 Oct 2011 09:40:34 +0200
Message-ID: <cover.1318577792.git.git@drmicha.warpmail.net>
References: <4E9692BF.8040705@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 09:40:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcNt-00061r-P4
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318Ab1JNHko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:40:44 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60059 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918Ab1JNHkn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 03:40:43 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D8CED20BA0;
	Fri, 14 Oct 2011 03:40:42 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 14 Oct 2011 03:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=e0wScfmyswyo15g1+QLUFnsXg
	FA=; b=QjCQH8vYrmypu8WMr9EYCG35QsC7UPYKGZC09I1BDSPkO+4XjI2mhQ3AQ
	T8L3Z5y/z6c529KGRiF1mc6GUQuGMJ+dPz4ATeRdpBI0fOtksqWMdil/raAuK+4C
	UbjMII97zY3+ENTcJZO3GU9A7uhdAyJKbHLJhoN8zP9p/8EF7M=
X-Sasl-enc: ANZF3NJ85C4W5j3PoHxDkEduZzxWE8z2qqWyFyvrNUVb 1318578042
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 59B09483363;
	Fri, 14 Oct 2011 03:40:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.338.g0156b
In-Reply-To: <4E9692BF.8040705@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183546>

Here are the early parts of Jeff's http-auth-keyring series.
It contains only parts which are not using the credential API (which
is still under discussion), so that this can go in (and help users)
and alleviates the pressure on the credential discussion:

Early bits with cleanups to http.c.
Cherry-picked bit for improved prompts ("Username for ..." etc.)
Cherry-pickes bit for using configured pushurls.

I tried to pick/resolve in a way which should help rebasing Jeff's series
on top of this.

Jeff King (5):
  url: decode buffers that are not NUL-terminated
  improve httpd auth tests
  remote-curl: don't retry auth failures with dumb protocol
  http: retry authentication failures for all http requests
  http_init: accept separate URL parameter

Michael J Gruber (1):
  http: use hostname in credential description

 http-fetch.c          |    2 +-
 http-push.c           |   10 +-----
 http.c                |   91 +++++++++++++++++++++++++++---------------------
 http.h                |    2 +-
 remote-curl.c         |    4 +-
 t/lib-httpd.sh        |   10 +++--
 t/t5550-http-fetch.sh |   51 +++++++++++++++++++++++++--
 url.c                 |   26 ++++++++++----
 url.h                 |    1 +
 9 files changed, 128 insertions(+), 69 deletions(-)

-- 
1.7.7.338.g0156b
