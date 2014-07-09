From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Wed, 9 Jul 2014 01:10:40 -0400
Message-ID: <20140709051040.GB2318@sigill.intra.peff.net>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Yi EungJun <eungjun.yi@navercorp.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:10:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4k9Y-00061N-Sf
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 07:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbaGIFKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 01:10:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:58479 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718AbaGIFKm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 01:10:42 -0400
Received: (qmail 22630 invoked by uid 102); 9 Jul 2014 05:10:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 00:10:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 01:10:40 -0400
Content-Disposition: inline
In-Reply-To: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253062>

On Wed, Jul 09, 2014 at 12:54:06AM +0900, Yi EungJun wrote:

> From: Yi EungJun <eungjun.yi@navercorp.com>
> 
> Add an Accept-Language header which indicates the user's preferred
> languages defined by 'LANGUAGE' environment variable if the variable is
> not empty.
> 
> Example:
>   LANGUAGE= -> ""
>   LANGUAGE=ko -> "Accept-Language: ko; q=1.000, *; q=0.001"
>   LANGUAGE=ko:en -> "Accept-Language: ko; q=1.000, en; q=0.999, *; q=0.001"
> 
> This gives git servers a chance to display remote error messages in
> the user's preferred language.

Should this also take into account other language-related variables? I'd
think $LC_ALL, $LC_MESSAGES, and $LANG would affect it, too.  Are
colon-separated values a standard in $LANGUAGE? I have never seen them,
but I admit I am not very knowledgeable about localization issues.

Also, we do we need to do more parsing? My $LANG is set to en_US.UTF-8.
The encoding part is presumably uninteresting to the remote server.  I
also wonder if there are support functions in libc or as part of gettext
that can help us get these values.

-Peff
