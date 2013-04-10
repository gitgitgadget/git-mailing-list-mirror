From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 18:23:34 -0400
Message-ID: <20130410222334.GC6930@sigill.intra.peff.net>
References: <20130410202456.GF24177@sigill.intra.peff.net>
 <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net>
 <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com>
 <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com>
 <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
 <20130410215658.GC6215@sigill.intra.peff.net>
 <CALkWK0=Y-pO3+g21PLCWOxx+M-7fSmp2FedMBtZ68PWU_TOHDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 00:23:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ3Qn-0006Kg-VV
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 00:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936600Ab3DJWXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 18:23:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39364 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935524Ab3DJWXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 18:23:41 -0400
Received: (qmail 8861 invoked by uid 107); 10 Apr 2013 22:25:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 18:25:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 18:23:34 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=Y-pO3+g21PLCWOxx+M-7fSmp2FedMBtZ68PWU_TOHDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220788>

On Thu, Apr 11, 2013 at 03:41:33AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > It's not that it's not potentially useful. It's that it may be
> > surprising and annoying to users who did not want that.
> 
> Besides, I'm not able to imagine one scenario where this is the wrong
> or annoying thing to do.  Can you provide an example?

To flesh out my earlier example:

  $ git clone https://github.com/upstream/project.git
  $ cd project
  $ hack hack hack; commit commit commit
  $ git tag -m 'something of note' my-tag
  $ git remote add me https://github.com/me/project.git
  $ git config branch.master.remote me
  $ git tag -m 'something of note'
  $ git push master my-tag

My intent there is publish both master and mytag, but my-tag goes to
origin. It's obvious if you think carefully about (and know) the rules,
and it's user error. But what fault do we take for designing a feature
that causes confusion?

Maybe I am the only one who might make that mistake, and it is a
non-issue. But I would be much happier if git said "hey, are you sure
you wanted to push to two different remotes?". At least by default.

-Peff
