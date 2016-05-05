From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v4 01/11] add fetch-pack --diag-url tests for some corner
 cases
Date: Fri, 6 May 2016 06:52:29 +0900
Message-ID: <20160505215229.GA31157@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
 <1462265452-32360-2-git-send-email-mh@glandium.org>
 <xmqqzis7nn02.fsf@gitster.mtv.corp.google.com>
 <20160503224830.GA21973@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:52:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayRCK-00030i-M7
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbcEEVwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:52:37 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:42880 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755959AbcEEVwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:52:36 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1ayRC9-00086z-Dd; Fri, 06 May 2016 06:52:29 +0900
Content-Disposition: inline
In-Reply-To: <20160503224830.GA21973@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293710>

On Wed, May 04, 2016 at 07:48:30AM +0900, Mike Hommey wrote:
> On Tue, May 03, 2016 at 09:07:41AM -0700, Junio C Hamano wrote:
> > Mike Hommey <mh@glandium.org> writes:
> > 
> > > t5603-clone-dirname uses url patterns that are not tested with
> > > fetch-pack --diag-url, and it would be useful if they were.
> > >
> > > Interestingly, some of those tests, involving both a port and a
> > > user:password pair, don't currently pass. Note that even if a
> > > user:password pair is actually not supported by git, the values used
> > > could be valid user names (user names can actually contain colons
> > > and at signs), and are still worth testing the url parser for.
> > 
> > I am not sure about the last part of this (and the tests in the
> > patch for them).  When you are constrained by the Common Internet
> > Scheme Syntax, i.e.
> > 
> >     <scheme>://<user>:<password>@<host>:<port>/<url-path>
> > 
> > you cannot have arbitrary characters in these parts; within the user
> > and password field, any ":", "@", or "/" must be encoded.
> > 
> > Which maens that for the purpose of the parser you are modifying,
> > you can rely on these three special characters to parse things out
> > (decoding after the code determines which part is user and which
> > part is password is a separate issue).
> 
> t5603-clone-dirname contains a test for e.g. ssh://user:passw@rd@host:1234/
> That's the basis for these additions. Whether that should work or not is
> besides what I was interested in, which was to have a single test file to
> run to test my changes, instead of several.
> 
> Strictly speaking, this patch is not necessary, because it only covers
> things that I found while breaking other tests.
> 
> So, there are multiple possible ways forward here:
> - Completely remove this patch for v5 of the series.
> - Remove the user:passw@rd cases because of the @.
> - Remove the user:password cases because we do nothing with the password
>   anyways.
> - A combination of both of the above.

Any opinions on this?

Mike
