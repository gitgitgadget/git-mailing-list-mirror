From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] make sure a pattern without trailing slash matches a
 directory
Date: Tue, 26 Mar 2013 15:08:01 -0400
Message-ID: <20130326190801.GD26462@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:08:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZEa-00030J-6N
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab3CZTIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:08:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40549 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab3CZTIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:08:06 -0400
Received: (qmail 6395 invoked by uid 107); 26 Mar 2013 19:09:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 15:09:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 15:08:01 -0400
Content-Disposition: inline
In-Reply-To: <1364323171-20299-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219185>

On Tue, Mar 26, 2013 at 11:39:31AM -0700, Junio C Hamano wrote:

> From: Jeff King <peff@peff.net>
> 
> Prior to v1.8.1.1, with:
> 
>   git init
>   echo content >foo &&
>   mkdir subdir &&
>   echo content >subdir/bar &&
>   echo "subdir export-ignore" >.gitattributes
>   git add . &&
>   git commit -m one &&
>   git archive HEAD | tar tf -
> 
> the resulting archive would contain only "foo" and ".gitattributes",
> not subdir.  This was broken with a recent change that intended to
> allow "subdir/ export-ignore" to also exclude the directory, but
> instead ended up _requiring_ the trailing slash by mistake.

Yeah, I think that is fine. I'd just squash this test and description
into the previous patch, though (I do not care about dropping my commit
count by 1).

And of course,

Signed-off-by: Jeff King <peff@peff.net>

> A pattern "subdir" should match any path "subdir", whether it is a
> directory or a non-diretory.  A pattern "subdir/" insists that a
> path "subdir" must be a directory for it to match.

s/diretory/directory/

-Peff
