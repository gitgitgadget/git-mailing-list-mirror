From: Clemens Buchacher <drizzd@aon.at>
Subject: renaming pathspec_prefix (was: Re: [PATCH v2] commit: allow partial commits with relative paths)
Date: Sun,  4 Sep 2011 12:41:58 +0200
Message-ID: <1315132921-26949-1-git-send-email-drizzd@aon.at>
References: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 12:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ABw-0004qP-OY
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 12:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab1IDKoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 06:44:38 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:4462 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754039Ab1IDKoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 06:44:37 -0400
Received: from localhost (p5B22E851.dip.t-dialin.net [91.34.232.81])
	by bsmtp.bon.at (Postfix) with ESMTP id B394613004D;
	Sun,  4 Sep 2011 12:44:34 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180676>

On Tue, Aug 02, 2011 at 02:31:47PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > diff --git a/setup.c b/setup.c
> > index 5ea5502..2c51a9a 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -264,6 +264,38 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
> >  	return pathspec;
> >  }
> >  
> > +const char *pathspec_prefix(const char *prefix, const char **pathspec)
> > +{
> 
> As a public function, this sorely needs a comment that describes what it
> does. More importantly, when I tried to come up with an example
> description, it became very clear that this neither prefixes anything to
> pathspec, nor prefixes pathspec to anything else.
> 
> As an internal helper in ls-files implementation it was perfectly
> fine that the function was slightly misnamed, but if you are making it
> into a public API, we should get its name right.
> 
> Perhaps "common_prefix()"?
> 
> Don't you also want to consolidate dir.c:common_prefix() with this?

Yes. This should do it:

[PATCH 1/3] remove prefix argument from pathspec_prefix
[PATCH 2/3] consolidate pathspec_prefix and common_prefix
[PATCH 3/3] rename pathspec_prefix -> common_prefix and move to

> What happens when pathspec has the recently introduced magic elements,
> e.g. ':/' that widens the match to the whole tree?

If I understand correctly that is resolved in get_pathspec. And
pathspec_prefix (now common_prefix) is called later.

Clemens
