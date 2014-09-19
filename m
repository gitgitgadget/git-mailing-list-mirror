From: Jakob Stoklund Olesen <stoklund@2pi.dk>
Subject: Re: git svn's performance issue and strange pauses, and other thing
Date: Fri, 19 Sep 2014 06:44:00 -0700
Message-ID: <DE2A36B7-69F2-46CA-89FC-C2038F08179A@2pi.dk>
References: <1411025993.80693.YahooMailBasic@web172304.mail.ir2.yahoo.com> <20140919082529.GA32459@dcvr.yhbt.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 15:50:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUyaD-0005RK-0a
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 15:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365AbaISNoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 09:44:44 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:55817 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbaISNon convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2014 09:44:43 -0400
Received: from homiemail-a48.g.dreamhost.com (sub5.mail.dreamhost.com [208.113.200.129])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 22E2F8BF54
	for <git@vger.kernel.org>; Fri, 19 Sep 2014 06:44:43 -0700 (PDT)
Received: from homiemail-a48.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a48.g.dreamhost.com (Postfix) with ESMTP id DB4854F806A;
	Fri, 19 Sep 2014 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=2pi.dk; h=references
	:mime-version:in-reply-to:content-type:content-transfer-encoding
	:message-id:cc:from:subject:date:to; s=2pi.dk; bh=1zjDYVe3sy8o2N
	WCGvE9vgIbweY=; b=t72JlagQO7pPHKqUkATm//RmVCtsfwAcL2GlNwdLjTZs3J
	MC0VQQvWIbHbETpTdB2Y7ZX1XHq+LKKKutoPShD/3AkeYlaSWymVgKeT9ZcxhMlw
	MFhzxiPsN90+0Z1Po5d2/WXloiYrFPcqfm8XXgqzj2SBysqvpaQ5R/uwaZSd8=
Received: from [33.170.56.119] (mcf2036d0.tmodns.net [208.54.32.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: stoklund@2pi.dk)
	by homiemail-a48.g.dreamhost.com (Postfix) with ESMTPSA id A513A4F805B;
	Fri, 19 Sep 2014 06:44:07 -0700 (PDT)
In-Reply-To: <20140919082529.GA32459@dcvr.yhbt.net>
X-Mailer: iPhone Mail (11D257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257286>



> On Sep 19, 2014, at 1:25, Eric Wong <normalperson@yhbt.net> wrote:
> 
> Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> 
>> -  I know I can probably just "read the source", but I'd like to know
>> why .git/svn/.caches is even larger than .git/objects (which supposedly
>> contains everything that's of interest)? I hope this can be documented
>> towards the end of the man-page, for example, of important parts
>> of .git/svn (and what not to do with them...), without needing to
>> 'read the source'. Here is part of "du" from a couple of days ago:
>> 
>> 254816    .git/objects
>> 307056    .git/svn/.caches
>> 332452    .git/svn
>> 588064    .git
>> 
>> The actual .git/config is here - this should be sufficient info for
>> somebody looking into experiencing the issues I mentioned above.
> 
> IIRC, the caching is unique to mergeinfo, so perhaps Jakob's patches
> help, there, too.

IIRC the caches are used for memoization, and with my two patches applied it doesn't improve performance much.

You could try removing the memoization after applying my patches.

Thanks,
/Jakob