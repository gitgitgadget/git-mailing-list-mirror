From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Itches with the current rev spec
Date: Fri, 26 Apr 2013 10:43:51 +0200
Message-ID: <517A3E47.6010606@viscovery.net>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com> <20130426101946.433f2d12@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Fri Apr 26 10:44:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVeGB-0006Xe-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599Ab3DZIn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 04:43:58 -0400
Received: from so.liwest.at ([212.33.55.23]:32589 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab3DZIn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 04:43:56 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UVeG0-00068Q-F5; Fri, 26 Apr 2013 10:43:52 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CE9D31660F;
	Fri, 26 Apr 2013 10:43:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130426101946.433f2d12@chalon.bertin.fr>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222513>

Am 4/26/2013 10:19, schrieb Yann Dirson:
>> 2. git rebase -i master fails unless I've rebased my branch on top of
>> master.  I always wished I could do the equivalent of 'git rebase -i
>> master..', but I can't.  Can we give the A..B syntax a new meaning in
>> the context of rebase, namely $(git merge-base A B)? 
> 
> If I understand well, you're refering to a problem that also annoys me,
> ie. using "rebase -i" to just edit your local commits, without rebasing
> onto the lastest revision on the upstream branch, right ?  That is, just
> another wart of having a single command for arguably-different use cases,
> or of having the single-argument version of rebase use that argument for
> 2 very different things (cut-off point and destination), but I won't try
> to address either of these today :)
> 
> In that case, what about just adding a new flag to "rebase -i", that would
> prevent the single-argument to be interpreted as destination ?  I really
> consider this a workaround for a suboptimal CLI, but since we don't want
> to change the rebase CLI before at least 2.0, that could fill the gap for now.
> 
> As for the flag itself, what about --here ?  Obviously it would only be
> meaninglful together with -i, and be exclusive with --onto.

How about this:

Allow alternative spelling of

   git rebase -i master topic

like this:

   git rebase -i master..topic

(as always, the default for topic is HEAD).

Then by extension (cf. git diff, where A...B shows the diff between the
mergebase and B)

   git rebase -i master...topic

would rebase onto the mergebase, which in practice will be the fork point
of topic, i.e., a "non-rebasing rebase".

-- Hannes
