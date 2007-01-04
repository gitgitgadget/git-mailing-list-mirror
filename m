From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 4 Jan 2007 13:47:08 +0100
Message-ID: <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 04 13:47:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2S0E-0006Eo-C8
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 13:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbXADMrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 07:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbXADMrL
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 07:47:11 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:49980 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964782AbXADMrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 07:47:09 -0500
Received: by wr-out-0506.google.com with SMTP id 68so801315wri
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 04:47:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ceiM7NdV0un2E0V/fwQ1EPb4x+hXtWCl+d6taq0Q/EM40o3rJ4UdD4gI6Arzer+ThimP0+kkmsfncHMfqchrgNOL91b2/v746HRSPSJsFBbjPY1no7YZeFJsoZ4yHPjjaveNCwBHWtXODbaqHUUHMivgFx+w1tIDN4ShB4/sy6I=
Received: by 10.78.170.17 with SMTP id s17mr3909827hue.1167914828181;
        Thu, 04 Jan 2007 04:47:08 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 4 Jan 2007 04:47:08 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35929>

On 1/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > Johannes, I remember suggesting to do index flush for all
> > entries instead for every entry. It is already quite time ago,
> > but ... was there any reasons for not doing this?
>
> I wanted to be on the safe side, and eventually look through the code
> again for possible problems.
>
> I think what you did is safe, since you moved the call from
> process_entry() to its sole caller, merge_trees().

Me too, just wondered why didn't we do this back then.
Anyway, my "monster-merge" and the builtin tests pass with
no visible problems.

> However, I was wondering if the index has to be written at all.
> I expect the written index (except the last one, of course) to have no
> user...

Good question...
