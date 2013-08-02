From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query
 filenames with spaces
Date: Fri, 2 Aug 2013 13:05:29 -0700
Message-ID: <20130802200529.GA2963@elie.Belkin>
References: <20130801201842.GA16809@kitenet.net>
 <20130802064003.GB3013@elie.Belkin>
 <20130802105402.GA25697@sigill.intra.peff.net>
 <20130802115906.GA9183@sigill.intra.peff.net>
 <7vtxj8oxin.fsf@alter.siamese.dyndns.org>
 <20130802172804.GB11329@sigill.intra.peff.net>
 <7vmwp0osic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Joey Hess <joeyh@debian.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 22:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Lba-0005hI-NJ
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 22:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab3HBUFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 16:05:38 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:45270 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3HBUFh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 16:05:37 -0400
Received: by mail-pd0-f173.google.com with SMTP id p11so1029070pdj.32
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=B5RpPRsbo3eDXHVHSQ0P0S//lAUV93lwCNezS568MOo=;
        b=AFkej9ekDbUBFxfPPrQvXXOJg05o7lU5BlySophOc1iQCY24SLHMEvikvdt0RcGQ8G
         bynnnFV2HPCrKUgdm1A+aR3P1gbVWD2Ps/GuT9FRJbErgRm831WmmE0rBG9sp2MQOciB
         AAOFCiizM4qsmUhg/W4V48kW3OhnOLjnz9MOF+rz8YMSWHpSqJtTbeZBOmXwAUNlCaWJ
         1dKAjiSuwFJ/9QjPj0s8ASeZfY9rRJ+91SsX7IEhuKtj45rbfCkwZE8JqvFNyV1i5Ml1
         j+tUouO1WMwKfiDfKW15CtSSd0p9a2ctyPsRik13F6Fe/K7mp/Jd3+6m+nylMVla2mNz
         s6fA==
X-Received: by 10.66.182.166 with SMTP id ef6mr12120174pac.35.1375473936924;
        Fri, 02 Aug 2013 13:05:36 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id yk10sm12116252pac.16.2013.08.02.13.05.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 13:05:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmwp0osic.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231537>

Junio C Hamano wrote:

> Here is what is on top of the revert that has been pushed out on
> 'pu'.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> To remain backwards compatible, we cannot split on whitespace by
> default, hence we will ship 1.8.4 with the commit reverted.
[...]
> It might be more robust to have something like "-z" to separate the
> input elements. But this patch is still a reasonable step before
> having that.  It makes the easy cases easy; people who do not care
> about %(rest) do not have to consider it, and the %(rest) code
> handles the spaces and newlines of "rev-list --objects" correctly.

Another idea for the future might be to start rejecting refnames
starting with a double-quote '"', which would make it safe to treat a
leading quote-mark as the start of a C-style quoted string.  But
currently that would technically be a breaking change, making "-z"
more useful in the meantime.

I think several commands already don't deal well with filenames with
newlines.  I hope POSIX forbids them (with some suitable migration
plan) soonish and even wouldn't mind if git were taught to refuse to
track them.

Thanks,
Jonathan
