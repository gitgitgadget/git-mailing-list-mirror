From: Phil Hord <hordp@cisco.com>
Subject: Re: git-svn with big subversion repository
Date: Wed, 02 Mar 2011 23:13:44 -0500
Message-ID: <4D6F1578.3000203@cisco.com>
References: <C992EE5B.CBFB%jkristian@linkedin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Kristian <jkristian@linkedin.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 05:14:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuzvO-00015W-VX
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 05:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758118Ab1CCENq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 23:13:46 -0500
Received: from sj-iport-2.cisco.com ([171.71.176.71]:28723 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757807Ab1CCENq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 23:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1406; q=dns/txt;
  s=iport; t=1299125626; x=1300335226;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=3Jr1ttUM1eCmnWQEOhplQ8n9eTojzet4JTSwN0eUKu4=;
  b=FnTdlgtDZHCiURXanAgmMOCz/Hd/hKCEQDMLe/fJz5rpaf/wn8cO4iOu
   BsDTgwP18ywMlnd6q4rEI1ViyGOQQZnzo+lDwIYrhxuSq9G/yyQn/DCjA
   oJc3w2ookfFBBnBJtLGssV/Nml4+8APIWgF1ZMswQ2zy8lvgqtW0lgwoz
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAFekbk2rR7H+/2dsb2JhbACmcnSiZ5t6hWEEhReHD4NA
X-IronPort-AV: E=Sophos;i="4.62,257,1297036800"; 
   d="scan'208";a="316712942"
Received: from sj-core-2.cisco.com ([171.71.177.254])
  by sj-iport-2.cisco.com with ESMTP; 03 Mar 2011 04:13:45 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by sj-core-2.cisco.com (8.13.8/8.14.3) with ESMTP id p234Djl5000499;
	Thu, 3 Mar 2011 04:13:45 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <C992EE5B.CBFB%jkristian@linkedin.com>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168374>

On 03/01/2011 09:43 PM, John Kristian wrote:
> How do you recommend using git to work with branches of a large, busy
> subversion repository? In general, how can small teams use git for their
> tasks, and use subversion to coordinate with a larger organization?
>
> git-svn has some trouble, I find. For example, this tries to copy the entire
> repo starting with revision 1:
>
> git svn clone --stdlayout svn+ssh://server/repo/project
>
> This would take weeks, I estimate for my subversion repository.
>
> Choosing a subset of the repository enables git svn clone to cope, but then
> git svn fetch will stall after processing a few revisions.  For example:
>
> git svn clone --no-follow-parent --no-minimize-url \
>  --branches=branches \
>  --ignore-paths="^(?!branches/(TEAM_|RELEASE_))" \
>  -r $BASE svn+ssh://server/repo/project
> git svn fetch --no-follow-parent # stalls
>
> I don't why it stalls. I guess it's doing something that requires processing
> the entire subversion repository.

My initial git-svn clone took several days and many restarts.  It was
much faster on my laptop.  I found out later I had a flaky router and it
was dropping about 20% of my packets.  Replaced the router and the clone
dropped to a reasonable couple-of-hours.   Is it just me?

You can optimize by cloning specific paths inside the svn repo and then
merging in git later.

Phil
