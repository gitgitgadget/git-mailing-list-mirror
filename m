From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] blame,shortlog: don't make local option variables
 static
Date: Tue, 14 Jun 2016 01:05:41 -0400
Message-ID: <20160614050541.GA9909@sigill.intra.peff.net>
References: <20160613053203.GB3950@sigill.intra.peff.net>
 <20160613053928.GC23880@sigill.intra.peff.net>
 <CAPig+cQudTwT6H35YgEvxdK9AAn0BwvUC8bi8-DxGYNh9rb_Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 07:05:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCgXt-0006Gs-7E
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 07:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933464AbcFNFFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 01:05:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:54392 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751346AbcFNFFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 01:05:45 -0400
Received: (qmail 5048 invoked by uid 102); 14 Jun 2016 05:05:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 01:05:44 -0400
Received: (qmail 24940 invoked by uid 107); 14 Jun 2016 05:05:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 01:05:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 01:05:41 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQudTwT6H35YgEvxdK9AAn0BwvUC8bi8-DxGYNh9rb_Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297263>

On Tue, Jun 14, 2016 at 12:32:15AM -0400, Eric Sunshine wrote:

> > +       struct string_list range_list = STRING_LIST_INIT_NODUP;
> 
> Related to this series, there's an additional "fix" which ought to be
> made, probably as a separate patch. In particular, in cmd_blame():
> 
>     if (lno && !range_list.nr)
>         string_list_append(&range_list, xstrdup("1"));
> 
> which supplies a default range ("line 1 through end of file") if -L
> was not specified. I used xstrdup() on the literal "1" in 58dbfa2
> (blame: accept multiple -L ranges, 2013-08-06) to be consistent with
> parse_opt_string_list() which was unconditionally xstrdup'ing the
> argument (but no longer does as of patch 1/3 of this series).

Yeah, I'd agree that this is a minor bug both before and after the
series due to the leak. Want to roll a patch on top?

-Peff
