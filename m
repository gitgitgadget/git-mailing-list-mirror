From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] revert: Don't remove the sequencer state on error
Date: Thu, 11 Aug 2011 14:20:47 -0500
Message-ID: <20110811192047.GE2277@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 21:23:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qraqu-0001sd-51
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 21:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab1HKTUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 15:20:53 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:52918 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab1HKTUw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 15:20:52 -0400
Received: by yie30 with SMTP id 30so1541039yie.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S3/zZLLWSUYwzha2UPSVsFSisAPmR2uq7BqKK4xYNwU=;
        b=qzffXJ132a/3NiFvM0q7LsGWE7ZYWcWWHUvRU3hnr6ZZGN3nCYSy0cVLizuq9r6oas
         O/d91mH0eKMfKC+iqVrMopYYlToHF1+bFxFJKZPA9XDFzcfIM38S3cg1DvJ+jhd2U/Mg
         zZKAtP49fp+95vR+ygdHa6v/Dx4clTtHODXEY=
Received: by 10.151.123.5 with SMTP id a5mr953713ybn.382.1313090451476;
        Thu, 11 Aug 2011 12:20:51 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.ameritech.net [69.209.69.68])
        by mx.google.com with ESMTPS id o4sm1306207ybc.15.2011.08.11.12.20.49
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 12:20:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313088705-32222-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179136>

Ramkumar Ramachandra wrote:

> The cherry-pick/ revert machinery now removes the sequencer state when
> do_pick_commit returns a non-zero, and when only one instruction is
> left in the todo_list.  Since do_pick_commit has a way to distinguish
> errors from conflicts using the signed-ness of the return value,
> utilize this to ensure that the sequencer state is only removed when
> there's a conflict and there is only one instruction left in the
> todo_list.

I'm having trouble parsing this.  Is the idea of this one to mitigate
some of the problems with the "remove sequencer state when a conflict
is encountered in the last commit" hack, by suppressing such behavior
when there is an internal error rather than a conflict?  Why bother,
when the behavior is suppressed altogether later in the series?
