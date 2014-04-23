From: Jeff King <peff@peff.net>
Subject: Re: How to trim the fat on my log graphs
Date: Wed, 23 Apr 2014 16:44:44 -0400
Message-ID: <20140423204443.GA20379@sigill.intra.peff.net>
References: <CAHd499Bq07mPTR=h-5Gj=NuEQ9WLnK2wL5nxTNMe=LFnKHmvzA@mail.gmail.com>
 <xmqqtx9l2ggp.fsf@gitster.dls.corp.google.com>
 <CAHd499AovROt2fVAvh-ST9Vb7Hq8LpUS68i4eXWZaNszuKeUfg@mail.gmail.com>
 <xmqqha5k0x8c.fsf@gitster.dls.corp.google.com>
 <CAHd499Cw8=FMctRA49MUi+vP2gvMyXH9WgcfCKK_MrKDEOfvjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:45:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd42O-0004OX-47
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbaDWUou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:44:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:37037 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932397AbaDWUoq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:44:46 -0400
Received: (qmail 30679 invoked by uid 102); 23 Apr 2014 20:44:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Apr 2014 15:44:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2014 16:44:44 -0400
Content-Disposition: inline
In-Reply-To: <CAHd499Cw8=FMctRA49MUi+vP2gvMyXH9WgcfCKK_MrKDEOfvjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246891>

On Wed, Apr 23, 2014 at 02:59:26PM -0500, Robert Dailey wrote:

> I referred back to the documentation for --decorate:
> 
> --decorate[=short|full|no]
> Print out the ref names of any commits that are shown. If short is
> specified, the ref name prefixesrefs/heads/, refs/tags/ and
> refs/remotes/ will not be printed. If full is specified, the full ref
> name (including prefix) will be printed. The default option is short.
> 
> since default is short, and its documented to exclude tag names, I
> would expect them to not be there. I also tried removing it to test
> but i saw no difference; tag names are still visible.

Are you reading that as "if short is specified, then refs whose names
are prefixed with refs/heads, refs/tags, etc will be omitted entirely
from decoration"?

The intent is "if short is specified, then a ref whose names has the
prefix of refs/heads, refs/tags, etc, will have that prefix removed when
showing it".

IOW, the options are:

  $ git log -1 --no-decorate | head -1
  commit 0bc85abb7aa9b24b093253018801a0fb43d01122

  $ git log -1 --decorate=short | head -1
  commit 0bc85abb7aa9b24b093253018801a0fb43d01122 (HEAD, tag: v1.9.2, origin/maint)

  $ git log -1 --decorate=full | head -1
  commit 0bc85abb7aa9b24b093253018801a0fb43d01122 (HEAD, tag: refs/tags/v1.9.2, refs/remotes/origin/maint)

If that's the confusion, feel free to suggest better wording for the
documentation.

-Peff
