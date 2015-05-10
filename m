From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Sun, 10 May 2015 19:12:45 -0400
Message-ID: <20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
 <CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
 <20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
 <20150509040704.GA31428@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 11 01:13:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YraPZ-000174-VD
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 01:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbbEJXNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 19:13:06 -0400
Received: from tbsaunde.org ([66.228.47.254]:43000 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbbEJXNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 19:13:05 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id C1184C072;
	Sun, 10 May 2015 23:13:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20150509040704.GA31428@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268752>

On Sat, May 09, 2015 at 12:07:04AM -0400, Jeff King wrote:
> On Fri, May 08, 2015 at 10:03:41PM -0400, Trevor Saunders wrote:
> 
> > On Fri, May 08, 2015 at 05:29:42PM -0700, Stefan Beller wrote:
> > > On Fri, May 8, 2015 at 4:46 PM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
> > > > its rather silly especially considering the next line contains the
> > > > full hash again.
> > > 
> > > Maybe we can omit it altogether then?
> > 
> > SO we'd print something like
> > 
> > the first bad commit is
> > Commit abcdefabcdefabcdefabcdefabcdefabcdefabcd
> > Author foo@ba.com
> > 
> > blah blah blah
> > 
> > ? That seems reasonable to me.  If we're going that far does it also
> > make sense to drop printingthe lines about which trees have changed and
> > just print the commit message / author / hash?
> 
> Yeah, I have always found bisect's output somewhat silly. It prints the
> "--raw" diff output, which is not incredibly useful. And then to top it
> off, it does not feed the "--recursive" switch to the diff, so you don't
> even get to see the real list of changed files.

 So, fun fact it doesn't actually always print the raw diffoutput if
 there is no diff, for example a merge where both sides only touched
 different files as in test 40 in t6030.

> (Actually, it looks like all this is generated in bisect.c:show_diff_tree,
> so it would have to be written in C; but it should be pretty easy to
> tweak the display options).

yeah, that seems pretty straight forward, but I'm not really sure what
to do about this case where no diff is printed, I guess I should figure
out what bits need to be set for the commit to be shown anyway.

Trev
