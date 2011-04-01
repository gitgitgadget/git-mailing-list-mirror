From: =?UTF-8?B?SmVhbi1GcmFuw6dvaXMgQnVyZGV0?= <jfburdet@revelate.com>
Subject: Re: Problem using git-filter-branch to move tree when repository
 name contains space
Date: Fri, 01 Apr 2011 23:49:04 +0200
Message-ID: <4D964850.3050800@revelate.com>
References: <4D95E182.6030903@revelate.com> <20110401144107.GA3103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 23:50:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5mEC-0004Dm-Eo
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 23:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955Ab1DAVtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 17:49:55 -0400
Received: from mail-server-02.titaninternet.co.uk ([85.232.47.149]:37918 "EHLO
	mail-server-02.titaninternet.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756932Ab1DAVty (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 17:49:54 -0400
Received: from xdsl-188-155-127-11.adslplus.ch ([188.155.127.11] helo=[127.0.0.1])
	by mail-server-02.titaninternet.co.uk with esmtpa (Exim 4.69)
	(envelope-from <jfburdet@revelate.com>)
	id 1Q5mDp-0006l6-M6; Fri, 01 Apr 2011 22:49:37 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <20110401144107.GA3103@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170627>

What you suggested solved my problem. What a fast answer ! 6minutes !
Thanks,

JF.

On 01.04.2011 16:41, Jeff King wrote:
> The problem is that GIT_INDEX_FILE is an absolute path that contains the
> repo name. So it needs to be quoted in the mv command. This should work:
> 
>   git filter-branch --index-filter \
>     'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
>       GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
>         git update-index --index-info &&
>      mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD
> 
> -Peff
> 
> 
