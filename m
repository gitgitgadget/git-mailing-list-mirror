From: Jeff King <peff@peff.net>
Subject: Re: Efficient parsing of `status -z` output
Date: Mon, 9 Mar 2015 02:49:40 -0400
Message-ID: <20150309064939.GA30819@peff.net>
References: <CAMJduDuxBDoJ9_ETY8FCRoANf+taAS7-1acf5CFRGXDFyL72Rg@mail.gmail.com>
 <xmqqlhj7sy7l.fsf@gitster.dls.corp.google.com>
 <CAMJduDvDO4GesL+eru3h1YHrbF5hFmyycX3f4ADQOo+VnD7GDg@mail.gmail.com>
 <20150309061920.GB27128@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthew Rothenberg <mrothenberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 07:49:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUrVb-00026c-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 07:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbbCIGtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 02:49:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:59035 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751330AbbCIGtn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 02:49:43 -0400
Received: (qmail 6786 invoked by uid 102); 9 Mar 2015 06:49:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 01:49:43 -0500
Received: (qmail 4333 invoked by uid 107); 9 Mar 2015 06:49:50 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 02:49:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2015 02:49:40 -0400
Content-Disposition: inline
In-Reply-To: <20150309061920.GB27128@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265131>

On Mon, Mar 09, 2015 at 02:19:20AM -0400, Jeff King wrote:

> We don't turn on copy-detection in "git status" by default (only rename
> detection), and I think you are right that there is currently no way to
> turn it on manually.

Actually, I take it back. We do break-detection in git-status, which can
lead to finding a copy:

  $ git init
  $ seq 1 1000 >file && git add file && git commit -m base
  $ mv file other
  $ echo foo >file
  $ git add .
  $ git status --short
  M  file
  C  file -> other

-Peff
