From: Jeff King <peff@peff.net>
Subject: [PATCH 0/9] handle alternate charsets for remote http errors
Date: Wed, 21 May 2014 06:25:24 -0400
Message-ID: <20140521102524.GA30301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 12:25:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3iJ-0002RY-DA
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbaEUKZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:25:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:56397 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751801AbaEUKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:25:28 -0400
Received: (qmail 32111 invoked by uid 102); 21 May 2014 10:25:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 05:25:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 06:25:24 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249780>

As of commit 426e70d (remote-curl: show server content on http errors,
2013-04-05), we relay any text/plain errors shown by the remote http
server to the user. However, we were lazy back then and left this TODO
in place:

       /*
        * We only show text/plain parts, as other types are likely
        * to be ugly to look at on the user's terminal.
        *
        * TODO should handle "; charset=XXX", and re-encode into
        * logoutputencoding
        */

This series actually implements that, along with a few other cleanups.

  [1/9]: test-lib: preserve GIT_CURL_VERBOSE from the environment
  [2/9]: strbuf: add strbuf_tolower function
  [3/9]: daemon/config: factor out duplicate xstrdup_tolower
  [4/9]: http: normalize case of returned content-type
  [5/9]: t/lib-httpd: use write_script to copy CGI scripts
  [6/9]: t5550: test display of remote http error messages
  [7/9]: remote-curl: recognize text/plain with a charset parameter
  [8/9]: strbuf: add strbuf_reencode helper
  [9/9]: remote-curl: reencode http error messages

-Peff
