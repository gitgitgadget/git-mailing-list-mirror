From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git push --track
Date: Fri, 15 Jan 2010 07:27:41 +0900
Message-ID: <20100115072741.6117@nanako3.lavabit.com>
References: <op.u6g8jnixg402ra@nb-04> <20100114154154.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001141130210.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 23:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVYMy-0003VE-D3
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 23:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757701Ab0ANWkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 17:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757606Ab0ANWkG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 17:40:06 -0500
Received: from karen.lavabit.com ([72.249.41.33]:55084 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754379Ab0ANW2U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 17:28:20 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 9243F11B8F5;
	Thu, 14 Jan 2010 16:28:19 -0600 (CST)
Received: from 5130.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id NWLSIAWKDPI0; Thu, 14 Jan 2010 16:28:19 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=r1TE6GMPM9g/xylNBaEpXA8b0fpsD+NTbCPTH88dIVm4ytKovq2C1FTFLkzpKTagm2oeX+yYVz/kGAGFz+J8aaMg4m34o2UoYmqY87l7hEbHGxfqL8PqGI/dcJmcc46w9/NMN5YtF9Si1mOiVzbfRbomLVBghhUFPzlAK88OBBQ=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <alpine.DEB.1.00.1001141130210.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137031>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>

> On Thu, 14 Jan 2010, Nanako Shiraishi wrote:
>
>> Quoting Rudolf Polzer <divVerent@alientrap.org>
>> 
>> > I'd like a feature to automatically "transform" a non-tracking local
>> > branch into a tracking branch on push. A patch to do that is attached.
>> 
>> How well does this take earlier discussions on the same topic into account? For example, did you study the design discussion in
>>   http://thread.gmane.org/gmane.comp.version-control.git/135325/focus=135390
>
> Thank you for looking up that reference.
>
> Do you remember what the outcome was?

I summarized it when I reminded Junio on this topic last time and it is in the same discussion thread: http://thread.gmane.org/gmane.comp.version-control.git/135325/focus=136216

Here is an extended version.

'git branch --will-track origin/topic topic origin/master' was proposed as a way to fork a topic branch at origin's master. Later 'git pull' will merge topic from origin to topic.

This is bad in two ways. It will force users to decide when the branch is created. It will not allow users to configure branch.topic.rebase variable.

'git push --track' was suggested as a way to let users delay that decision.

'git branch --configure' to update the same information for an existing branch was suggested as an alternative UI. An added benefit is that this approach will allow the same option to be used when creating a branch.

'git pull --remember' that remembers the options used from the command line was suggested as a solution in addition to 'git branch --reconfigure'. Users can postpone the decision even more than 'git push --track', and it naturally supports setting branch.topic.rebase with 'git pull --rebase --remember'.  It also has two additional benefits. 'push --track' configures what happens when you 'pull' (counter-intuitive), but 'pull --remember' makes 'pull' to change the setting used by 'pull' (much more natural). Also it does not add the confusing word 'track' to the interface (for a more detailed discussion on 'track', see http://article.gmane.org/gmane.comp.version-control.git/136785).

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
