From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] name_decoration cleanups
Date: Tue, 26 Aug 2014 06:20:51 -0400
Message-ID: <20140826102051.GA4885@peff.net>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
 <20140825133550.GE17288@peff.net>
 <CAP8UFD2FAfg5GenJXOkOsjU9vmCO3R3Difp6-mrP_cp4zXQENg@mail.gmail.com>
 <20140825150028.GA28176@peff.net>
 <xmqq8umcmnmo.fsf@gitster.dls.corp.google.com>
 <20140825193519.GH30953@peff.net>
 <xmqqha10l1g2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 12:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMDs9-0006Id-84
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 12:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934586AbaHZKU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 06:20:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:59043 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932941AbaHZKUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 06:20:55 -0400
Received: (qmail 9276 invoked by uid 102); 26 Aug 2014 10:20:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 05:20:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 06:20:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqha10l1g2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255883>

On Mon, Aug 25, 2014 at 02:11:09PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Aug 25, 2014 at 11:26:39AM -0700, Junio C Hamano wrote:
> >
> >> Good digging, and I agree that it should use the FLEX_ARRAY for
> >> consistency.
> >
> > I can produce a patch, but I did not want to steal Arjun's thunder.
> 
> Hmph, would it have to overlap?  I think we can queue Arjun's patch
> with +1 fix and FLEX_ARRAY thing separately, and they can go in in
> any order, no?

I more meant my suggestion to use add_name_decoration consistently. That
fixes the r->type thing _and_ replaces Arjun's patch. Fixing FLEX_ARRAY
on top is just gravy. :)

Here's the patch series I was thinking of:

  [1/3]: log-tree: make add_name_decoration a public function
  [2/3]: log-tree: make name_decoration hash static
  [3/3]: log-tree: use FLEX_ARRAY in name_decoration

I almost added a 4/3 to convert "name_decoration" to
"commit_decoration", since that is how it is used (and name_decoration
is somewhat vague). But we actually do annotate other non-commit objects
that refs point to, as well. I'm not sure there is a way to _show_ them
currently, but I'd just as soon leave it as-is.

-Peff
