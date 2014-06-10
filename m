From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/17] store length of commit->buffer
Date: Tue, 10 Jun 2014 17:35:09 -0400
Message-ID: <20140610213509.GA26979@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 23:35:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuThN-0000gG-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbaFJVfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:35:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:41340 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752786AbaFJVfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:35:10 -0400
Received: (qmail 19027 invoked by uid 102); 10 Jun 2014 21:35:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:35:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:35:09 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251242>

Here's a re-roll of the commit-slab series. It fixes the issues pointed
out by Eric and Christian (thanks, both).

It adds two new patches at the beginning to clean up the dangerous
strbufs that we discussed elsewhere. And as a result, silences the
warning from the old 12/15. I even compiled with a working copy of gcc
to confirm. :)

  [01/17]: commit_tree: take a pointer/len pair rather than a const strbuf
  [02/17]: replace dangerous uses of strbuf_attach
  [03/17]: alloc: include any-object allocations in alloc_report
  [04/17]: commit: push commit_index update into alloc_commit_node
  [05/17]: do not create "struct commit" with xcalloc
  [06/17]: logmsg_reencode: return const buffer
  [07/17]: sequencer: use logmsg_reencode in get_message
  [08/17]: provide a helper to free commit buffer
  [09/17]: provide a helper to set the commit buffer
  [10/17]: provide helpers to access the commit buffer
  [11/17]: use get_cached_commit_buffer where appropriate
  [12/17]: use get_commit_buffer to avoid duplicate code
  [13/17]: convert logmsg_reencode to get_commit_buffer
  [14/17]: use get_commit_buffer everywhere
  [15/17]: commit-slab: provide a static initializer
  [16/17]: commit: convert commit->buffer to a slab
  [17/17]: commit: record buffer length in cache

-Peff
