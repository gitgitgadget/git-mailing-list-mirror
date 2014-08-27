From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/6] clean up author parsing
Date: Wed, 27 Aug 2014 03:55:03 -0400
Message-ID: <20140827075503.GA19521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 09:55:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMY4W-00018A-UN
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 09:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbaH0HzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 03:55:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:59878 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751617AbaH0HzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 03:55:06 -0400
Received: (qmail 14215 invoked by uid 102); 27 Aug 2014 07:55:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 02:55:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 03:55:03 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255982>

This is a re-roll of my series from June:

  http://thread.gmane.org/gmane.comp.version-control.git/252055

The goal is to clean up some ad-hoc parsing code. Besides reusing code,
this fixes some memory leaks, fixes some bad pointer math in
determine_author_info, and protects us against getenv() implementations
that use a static buffer.

This iteration incorporates feedback from the Eri[ck]s (particularly the
last patch, which is much simplified). In addition, I dropped the patch
that converted split_ident's pairs of pointers into a struct. It caused
quite a bit of noise through the code base, and only saved us a few
lines in the end (actually no lines -- it just made a few lines
shorter).

The original was also based on another pending series in 'next', which
has since graduated to master. This one is based directly on master.

  [1/6]: commit: provide a function to find a header in a buffer
  [2/6]: record_author_info: fix memory leak on malformed commit
  [3/6]: record_author_info: use find_commit_header
  [4/6]: use strbufs in date functions
  [5/6]: determine_author_info: reuse parsing functions
  [6/6]: determine_author_info: copy getenv output

-Peff
