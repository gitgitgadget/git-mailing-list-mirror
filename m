From: Alexander Miseler <alexander@miseler.de>
Subject: Re: [RFD] make rebase abort to original branch, not rebased branch
Date: Sun, 13 Mar 2011 16:27:43 +0100
Message-ID: <4D7CE26F.9070608@miseler.de>
References: <alpine.DEB.2.00.1103122253560.15442@debian> <7vmxkzijpt.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1103131013370.15442@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 16:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PynCy-00073A-7R
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 16:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab1CMP1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 11:27:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:62151 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab1CMP1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 11:27:45 -0400
Received: from [192.168.22.13] (f055019155.adsl.alicedsl.de [78.55.19.155])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Le960-1QHLlY0cH6-00ptGS; Sun, 13 Mar 2011 16:27:40 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <alpine.DEB.2.00.1103131013370.15442@debian>
X-Provags-ID: V02:K0:uJxZo5mCHEVbtgwGDzO4zmd8jgtzH88EDQWqLFt4mXt
 xsvPQczQl9dQiBdJ1inukFG+LJsiXz+Am1fvMRFvOb1BDV4iit
 stgVjAdXcAAUjFs3ukEm8uXMVdj45rfTh7+vig3a44zvzAa/id
 2uLLUmH5r+/C/cHax+yvqCTvqf7Hpb554pYr8/scob3zA3qx1g
 BGYMij6gBLSKpQpWhjQMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168969>

>>> In most cases, this is just a small annoyance, since it's usually
>>> quick and easy to manually switch back to the original
>>> branch. However, I have run into at least two cases where it has been
>>> a bit more annoying:
>>>
>>>  1. When on a detached HEAD and running "git rebase HEAD topic", if
>>>     you abort the rebase, you will have to look up the old commit in
>>>     the reflog.
>>
>> Doesn't this merely show a bad discipline? What were you envisioning to
>> do to your detached HEAD state if the rebase were to succeed? IOW, if the
>> state was so precious, why did you decide to switch to topic and rebase it
>> onto that state, without marking?
> 
> This usually happens when I see something that looks a bit suspicious
> in one of my own commits on my topic branch. I then check out that
> commit to have a look and perhaps run some test. If I find something
> broken, I would fix it and either amend the commit or create a new
> commit on top. I would then run "git rebase --onto HEAD HEAD~1 topic"
> or "git rebase HEAD topic", respectively. If the merge conflicts turn
> out to be bigger than I expected, I may decide to abort and to instead
> create a new branch for the commit(s) until I find time/energy.

This can be easily fixed for your own repository by installing a pre-rebase hook that force-sets a temporary branch (named e.g. "pre-rebase") to the current commit before starting the rebase. I can highly recommend having such a hook, it's damn useful.
