From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] revert: Allow mixed pick and revert instructions
Date: Thu, 11 Aug 2011 05:08:46 -0500
Message-ID: <20110811100846.GA5012@elie.gateway.2wire.net>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-4-git-send-email-artagnon@gmail.com>
 <20110810151527.GC31315@elie.gateway.2wire.net>
 <CALkWK0mMVgnngU5JB4O+7crCjGCdRnVrbm4jjsgkFFUMeBS9_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 12:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrSCC-00077b-TO
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 12:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059Ab1HKKI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 06:08:56 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:40709 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab1HKKIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 06:08:55 -0400
Received: by iye16 with SMTP id 16so1009023iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=w2V8TO/yt0JeFV6XE8MMSU3bP/12zhvYGpOOOgtsdgc=;
        b=Dl+WbvowSuS9lm+PMt7IpdKnCi5lrrNh8XAXZ4ba/huEW/APLXeOiLn/dDOoL66Gau
         ystPyCU9JKutl5iL2r0b8JbW52HGHsjsqgASsgxh9282O3nuRQzniVI2GeeLI08g88Yi
         CRn7PxiMvsPLagK9B2CFRW7/YN7gLINzfHHLs=
Received: by 10.231.93.135 with SMTP id v7mr12381960ibm.18.1313057335073;
        Thu, 11 Aug 2011 03:08:55 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.ameritech.net [69.209.69.68])
        by mx.google.com with ESMTPS id t14sm1402369ibi.23.2011.08.11.03.08.53
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 03:08:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mMVgnngU5JB4O+7crCjGCdRnVrbm4jjsgkFFUMeBS9_A@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179100>

Ramkumar Ramachandra wrote:

> Good point.  I'm tempted to check (q - p < 40); is there a better way
> to do this by not hardcoding "40" perhaps?

Something like the following seems idiomatic.

	if (q - p + 1 > sizeof(buf))
		return error(...);
	memcpy(buf, p, q - p);
	buf[q - p] = '\0';
