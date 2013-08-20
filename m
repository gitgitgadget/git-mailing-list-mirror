From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 13:45:05 -0400
Message-ID: <20130820174505.GA10106@sigill.intra.peff.net>
References: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com>
 <878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
 <52137A63.3010609@googlemail.com>
 <871u5o785o.fsf@linux-k42r.v.cablecom.net>
 <52137F59.2030103@googlemail.com>
 <20130820161237.GA4332@sigill.intra.peff.net>
 <xmqqob8s7033.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 19:45:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBpzZ-00074Q-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 19:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab3HTRpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 13:45:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:39094 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab3HTRpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 13:45:11 -0400
Received: (qmail 31615 invoked by uid 102); 20 Aug 2013 17:45:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 12:45:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 13:45:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqqob8s7033.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232621>

On Tue, Aug 20, 2013 at 10:18:08AM -0700, Junio C Hamano wrote:

> As you mentioned, merge gives readable merge log messages, but it
> deliberately uses the real URL, not your personal nickname for the
> remote when writing the title line of a merge, i.e.
> 
> 	Merge [branch <x> of ]<repoURL>
> 
> so it would be helped by the repository abbreviation.  It probably
> was an oversight that we did not extend it to the rest of the log
> family.

Ah, yeah, I suppose git-pull will still do that. I was thinking of a
direct git-merge of a tracking branch, which would end up with:

  Merge remote-tracking branch 'origin/master'

whereas "git pull origin master" in the same case would say:

  Merge branch 'master' of git://github.com/gitster/git

Still, I do not think anybody but the kernel is using it. Most people
simply have shorter URLs that do not need abbreviated (e.g., the GitHub
one shown above). And searching for instances on GitHub yields only the
kernel:

  https://github.com/search?q=repo-abbrev+path%3A.mailmap&type=Code

Anyway, I am not proposing ripping the feature out. It just seems like
it does not have a lot of users, and it is not worth worrying much about
trying to extend it.

-Peff
