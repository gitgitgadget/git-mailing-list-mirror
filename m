From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] revert: Free memory after get_message call
Date: Sun, 14 Aug 2011 11:15:52 -0500
Message-ID: <20110814161552.GM18466@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 18:16:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsdM6-0006fL-I2
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 18:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab1HNQQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 12:16:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44461 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640Ab1HNQP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 12:15:56 -0400
Received: by ywf7 with SMTP id 7so2820823ywf.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tRkB/VC00J07aJe8cMEqHsfaU1Lng2y/ReFOBQ80YQI=;
        b=E07SiIRnXJPtByn0txT1l5Hz/hjVkNm58scr/2qKJb84K7/dOBbf1RBhcfgWJg3IJ5
         uZEiG3LsZT/5QKsy27fKZbw2TLaYoDuPMBJ1bwELk0THlJmA3xNy8c3uN0OHfvC8fQGK
         ORsvXT8UCmRTbXgTkIu+ZcQk9CFosy5PntU0M=
Received: by 10.236.75.193 with SMTP id z41mr9602047yhd.15.1313338555652;
        Sun, 14 Aug 2011 09:15:55 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-108-227.dsl.chcgil.ameritech.net [68.255.108.227])
        by mx.google.com with ESMTPS id o2sm6180896yhl.71.2011.08.14.09.15.54
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 09:15:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313310789-10216-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179333>

Ramkumar Ramachandra wrote:

> The format_todo function leaks memory because it forgets to call
> free_message after get_message.  It is a potentially big leak, because
> fresh memory is allocated to store the commit message message for each
> commit.  Fix this.

Reading this, I think, "why does formatting an insn list require all
these heavy memory allocations?".  So while the patch looks good to
me, I start to wonder if something using find_commit_subject()
directly would not be easier.
