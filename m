From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] strbuf: add strbuf_tolower function
Date: Thu, 22 May 2014 09:42:54 -0400
Message-ID: <20140522134253.GA16408@sigill.intra.peff.net>
References: <20140522094251.GA14994@sigill.intra.peff.net>
 <20140522094424.GB15255@sigill.intra.peff.net>
 <CAP8UFD0PkA_VokFpRkdaKE2UW1AtL6mCY2bOSxOCqX_C9wB=OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 15:43:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnTGt-000342-LE
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 15:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbaEVNm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 09:42:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:57371 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752353AbaEVNmz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 09:42:55 -0400
Received: (qmail 25752 invoked by uid 102); 22 May 2014 13:42:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 08:42:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 09:42:54 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD0PkA_VokFpRkdaKE2UW1AtL6mCY2bOSxOCqX_C9wB=OQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249902>

[re-adding list cc]

On Thu, May 22, 2014 at 03:16:45PM +0200, Christian Couder wrote:

> > +void strbuf_tolower(struct strbuf *sb)
> > +{
> > +       char *p;
> > +       for (p = sb->buf; *p; p++)
> > +               *p = tolower(*p);
> > +}
> 
> Last time I tried a change like the above, I was told that strbufs are
> buffers that can contain NUL bytes. So maybe it should be:
> 
>        for (p = sb->buf; p < sb->buf + sb->len; p++)
>               *p = tolower(*p);

Hah. I wrote it like that originally, and in review was asked to switch
it. I agree that it might be worth keeping strbuf functions 8bit-clean.
The original intent of the strbuf code was to make C strings easier to
use, but I think we sometimes use them as general buffers, too.

-Peff
