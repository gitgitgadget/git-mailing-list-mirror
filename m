From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fixup-builtins: remove unused cruft
Date: Fri, 28 Jun 2013 12:45:45 -0400
Message-ID: <20130628164545.GB9127@sigill.intra.peff.net>
References: <1372434379-24085-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 18:45:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usbo1-0007Tx-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 18:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab3F1Qpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 12:45:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:49632 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab3F1Qpt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 12:45:49 -0400
Received: (qmail 9441 invoked by uid 102); 28 Jun 2013 16:46:55 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Jun 2013 11:46:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2013 12:45:45 -0400
Content-Disposition: inline
In-Reply-To: <1372434379-24085-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229213>

On Fri, Jun 28, 2013 at 09:16:19PM +0530, Ramkumar Ramachandra wrote:

> The fixup-builtins script is only used by an unused remove-dashes target
> in the Makefile: remove that along with the script.

I am not sure of this justification. If you read the commit message from
36e5e70, which introduced the target, it was meant to be run manually as
part of migrating away from dashed forms.

Running it today does still uncover some places that could be tweaked.
However, I note that it also has a lot of false positives (e.g.,
removing dashes from places that are not commands, like filenames or
config options). It also produces crappy output for documentation (if we
do want to change dashed mentions, we would probably want to switch
git-foo to `git foo` with some kind of quoting to make it more obvious).

So I think it is probably a good idea to remove it, but the
justification is not "this is unused cruft", but more like:

  This script was added in 36e5e70 (Start deprecating "git-command" in
  favor of "git command", 2007-06-30) with the intent of aiding the
  transition away from dashed forms. However, nobody is really working
  on that transition, and even if they did, this tool will probably lead
  them in the wrong direction, as it produces a large number of
  questionable changes.

-Peff
