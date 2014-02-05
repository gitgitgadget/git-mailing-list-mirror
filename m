From: Jeff King <peff@peff.net>
Subject: Re: [Bug] branch.*.merge interpreted too strictly by tracking logic
Date: Wed, 5 Feb 2014 15:50:30 -0500
Message-ID: <20140205205030.GA16394@sigill.intra.peff.net>
References: <xmqqa9e67atv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:50:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9Qp-0007Hy-9Q
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbaBEUug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 15:50:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:45298 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754190AbaBEUuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 15:50:32 -0500
Received: (qmail 18254 invoked by uid 102); 5 Feb 2014 20:50:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 14:50:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 15:50:30 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa9e67atv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241658>

On Tue, Feb 04, 2014 at 02:49:16PM -0800, Junio C Hamano wrote:

> Let's tell these branches that they are both supposed to be building
> on top of 'master'.
> 
>     : gitster track/master; git config branch.foo.remote .
>     : gitster track/master; git config branch.foo.merge refs/heads/master
>     : gitster track/master; git config branch.bar.remote .
>     : gitster track/master; git config branch.bar.merge master
> 
> The difference between the two is that 'foo' spells the @{upstream}
> branch in full (which is the recommended practice), while 'bar' is
> loose and asks for 'master'.

Is it legal to put an unqualified ref there? A wise man once said[1]:

  > Actually, it is broken in a lot of places. for-each-ref relies on
  > the same code as "git status", "git checkout", etc, which will all
  > fail to display tracking info. I believe the same code is also used
  > for updating tracking branches on push. So I'm not sure if it was
  > ever intended to be a valid setting.

  It wasn't.  Some places may accept them gracefully by either being
  extra nice or by accident.

I don't recall us ever doing anything after that. I don't have a problem
with making it work, of course, but I am not sure if it is really a bug.

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/121671
