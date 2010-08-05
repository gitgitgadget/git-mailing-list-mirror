From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 5 Aug 2010 16:00:18 -0400
Message-ID: <AANLkTinX+wwOqaTVTxsdOhrZXzsXFw819aiND63-ChLG@mail.gmail.com>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
	<20100805001629.GC2901@thunk.org>
	<7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
	<7vhbj9dm6h.fsf@alter.siamese.dyndns.org>
	<20100805173635.GA15760@sigill>
	<7vy6ckdhhu.fsf@alter.siamese.dyndns.org>
	<20100805190653.GA2942@sigill>
	<AANLkTimzn05tvwY=uG6VP6PXDHwA=wS9ECuK_9eWKtSx@mail.gmail.com>
	<20100805192723.GA10435@sigill>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, "Ted Ts'o" <tytso@mit.edu>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 05 22:00:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh6cA-0001SM-M2
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 22:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516Ab0HEUA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 16:00:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49704 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382Ab0HEUAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 16:00:24 -0400
Received: by iwn33 with SMTP id 33so427035iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bIO5f62u8AU63eRxdkQeYrKy3XnyWksse9h/X7EV4tc=;
        b=Nlsss0ll/9IN6HXzd6cnoj7W5kdsrjb85/uVS5nQOwhkrXy/4hhq96uHu1g84U+ZWA
         kjIiVoS8+GxHBE0GhC10RjgjhgofQzsmftWS81ljY2NbhGS4InJ8Tp4nSACQ7cVMY7Np
         9UE5R9o7Y6565ge6wO+MzuJdOUxFrXgBZAwNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WsoEvimHvJ4ZTOSwcH2vOC189nkQlxryP8Yjh8iIla8iaGXqSODfAyZisLw3lilqjW
         oiUTQOZgcRPzsg8s5auVlxq6rHrpmGEAQx7fRkhSeCq84FoUH83kcRmhKNGYyAN3N8Cj
         Ap5l9d9r3IW8StQyIx6RGhd1ylxl3q/mZpvLw=
Received: by 10.231.146.141 with SMTP id h13mr12706483ibv.1.1281038418888; 
	Thu, 05 Aug 2010 13:00:18 -0700 (PDT)
Received: by 10.231.155.74 with HTTP; Thu, 5 Aug 2010 13:00:18 -0700 (PDT)
In-Reply-To: <20100805192723.GA10435@sigill>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152708>

On Thu, Aug 5, 2010 at 3:27 PM, Jeff King <peff@peff.net> wrote:
> I'm not sure rev-list makes the most sense. We already have "show
> commits in X, but not in Y". But I gather you wanted "from a list
> (U,V,W,X), print each that contains Y".

Correct.

> Which is not really a rev-list
> function anymore, as it is not about listing revisions, but rather about
> grepping a list you've given it.

Well maybe, but rev-list will already take a list of revs on stdin and
you can give it --no-walk, so it has already been abused to do more
than strictly list revisions. And what do you call this?

$ git rev-list --branches --no-walk --author=gitster

:-)


> Something like "git for-each-ref --contains" seems more sensible to me,
> though it is not as generic as we could make it (I cannot use an
> arbitrary list of commits to the "haystack", but only ones that have
> refs pointing to them).

Sure, and if I wanted to do that, I could've just created a bunch of
temporary light-weight tags for those commits I was potentially
interested in and then used tag --contains. :-)

So I don't think rev-list is such a bad place after all.

j.
