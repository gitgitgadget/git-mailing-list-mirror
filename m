From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4] Speed up git tag --contains
Date: Wed, 6 Jul 2011 01:56:23 -0500
Message-ID: <20110706065623.GB14164@elie>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 06 08:56:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeM2D-00081K-Ec
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 08:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab1GFG42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 02:56:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54675 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab1GFG42 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 02:56:28 -0400
Received: by iyb12 with SMTP id 12so5848681iyb.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 23:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KRlG7E0RXHuH6xeiAoOqI1Pqb3DKe8hlQv8vGl30xxo=;
        b=MUQcySlXYUzBeEgIUHdtkyHZrKtF7cMM35rbkHk2JSK0eTw/6yct63IjspuiPpzNXq
         LjYjg+tlQY38gWgJBT6dMhATmOYGqeAHtjbG5Hruk5T5/xujHlrm8p6AA6UJJWbZ0nMR
         lNLkMtibHTaZSP1NWyunDunEpl+9uEKPPmaB4=
Received: by 10.42.162.73 with SMTP id w9mr2955568icx.417.1309935387354;
        Tue, 05 Jul 2011 23:56:27 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id e1sm8455052icv.20.2011.07.05.23.56.25
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 23:56:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110706064012.GA927@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176643>

Jeff King wrote:

> The problem is that existing objects don't have this generation number.
> It's easy to calculate, though, and we could in theory use a notes-cache
> to store it externally. Obviously the complexity and performance aren't
> going to be as good as if it were just in the commit object, but we're
> sadly 6 years too late to make that decision.

I am still digesting the rest of what you wrote, but wouldn't this be
easy to do today?  One could just use a notes-cache while prototyping
and if it seems to work well, introduce new loose and packed object
formats that include a field for the cached generation number.
