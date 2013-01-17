From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 6/8] git-remote-testpy: hash bytes explicitly
Date: Thu, 17 Jan 2013 21:05:06 +0000
Message-ID: <20130117210506.GJ4574@serenity.lan>
References: <cover.1358448207.git.john@keeping.me.uk>
 <66c42ff65eddde494f40d0a582e89a081b4ab8e8.1358448207.git.john@keeping.me.uk>
 <7vtxqftulq.fsf@alter.siamese.dyndns.org>
 <20130117210048.GI4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 22:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvwea-0002Xj-VD
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 22:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab3AQVFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 16:05:17 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:50294 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab3AQVFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 16:05:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5FAD6606587;
	Thu, 17 Jan 2013 21:05:15 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kxsbeuvR6sc9; Thu, 17 Jan 2013 21:05:15 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id DAAE260656B;
	Thu, 17 Jan 2013 21:05:14 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id B831E276DFE;
	Thu, 17 Jan 2013 21:05:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9TS2nOc9UsPa; Thu, 17 Jan 2013 21:05:14 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 9E40E276DFB;
	Thu, 17 Jan 2013 21:05:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130117210048.GI4574@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213879>

On Thu, Jan 17, 2013 at 09:00:48PM +0000, John Keeping wrote:
> On Thu, Jan 17, 2013 at 12:36:33PM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>>> Under Python 3 'hasher.update(...)' must take a byte string and not a
>>> unicode string.  Explicitly encode the argument to this method as UTF-8
>>> so that this code works under Python 3.
>>>
>>> This moves the required Python version forward to 2.0.
>>>
>>> Signed-off-by: John Keeping <john@keeping.me.uk>
>>> ---
>> 
>> Hmph.  So what happens when the path is _not_ encoded in UTF-8?
> 
> Do you mean encodable?  As you say below it will currently throw an
> exception.

Now my brain's not working - we shouldn't get an error converting from a
Unicode string to UTF-8, so I think this patch is OK as it is.

> > Is the repo.hash (and local.hash that gets a copy of it) something
> > that needs to stay the same across multiple invocations of this
> > remote helper, and between the currently shipped Git and the version
> > of Git after applying this patch?
> 
> It's used to specify the path of the repository for importing or
> exporting, so it should stay consistent across invocations.  However,
> this is only an example remote helper so I don't think we should worry
> if it changes from one Git release to the next.
