From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 1/2] submodule: document handling of relative superproject
 origin URLs
Date: Wed, 23 May 2012 23:45:05 +0200
Message-ID: <4FBD5A61.1030101@web.de>
References: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com> <1337791554-31294-2-git-send-email-jon.seymour@gmail.com> <4FBD4F68.90305@web.de> <7vvcjmzjkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 23:45:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXJN2-000655-Ac
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 23:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878Ab2EWVpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 17:45:14 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:47556 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589Ab2EWVpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 17:45:07 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id 84B321AE9B79B
	for <git@vger.kernel.org>; Wed, 23 May 2012 23:45:06 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.160.4]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0Lxx0G-1S1VIc0Auy-015L9h; Wed, 23 May 2012 23:45:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vvcjmzjkv.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:Ywv7VdM6YjwitPvYPsEhHYe3gfXtCB48X2o8wjKajt5
 1zrZNi5Wx1JZzWGTQ8AWpq0aFwKmcQ0sQh4XWs7XtpYc+b51oU
 DNeJaUyV8m2+ZG+AyritTxSCnJqyK3s4qFIQ2bp0MG8NbQffrl
 nrHqIgGDe4vzHUoM1QPC0n8sU3tu7Go2vgEy4DFQ5N09Z4q96N
 vtVTlXZXJGoIKWsYpB/jQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198326>

Am 23.05.2012 23:14, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> Am 23.05.2012 18:45, schrieb Jon Seymour:
>>> These tests document how submodule sync and init handle various
>>> kinds of relative super project origin URLs.  The submodule URL
>>> path is ../subrepo.
>>>
>>> 6 cases are documented:
>>>   foo
>>>   foo/bar
>>>   ./foo
>>>   ./foo/bar
>>>   ../foo
>>>   ../foo/bar
>>
>> Nice test coverage!
> 
> I recall correctly, the original use case for relative URL entries in the
> .gitmodules file (to be copied to .git/config as submodule.$name.path) was
> so that by looking at the top-level, the locations of the origins for
> submodule repositories can be known from where the top-level was cloned.
> The above cases do not seem to be relevant, so in the sense, they are of
> secondary importance (and I do not find the "sneakernet tool" example
> convincing---the sneakernet tool that is distributed in the scenario can
> be written differently so that it does not require the other repositories
> to be named relative to it).

Remember this patch series is not about relative /submodule/ urls but
relative /superproject/ urls, so the .gitmodules file is not involved
here. But while reviewing 2/2 I started to suspect I was a bit too hasty
judging the coverage, as I realized only "git submodule init" and "git
submodule sync" are tested. "git submodule add" should also be tested
here to make sure it behaves well too (and only when the tests cases are
not split across two commits they can be properly reviewed). My remark
aimed at the attempt to test all possible relative paths in at least two
depths, which I deem very helpful to find problems early.

> As long as you and submodule stakeholders believe this is a reasonable
> addition and does not break the existing use cases, I am perfectly fine
> with it, though.

Me thinks relative /superproject/ urls starting with ./ or ../ should
work just fine (which they don't right now). And if relative superproject
urls inside the superproject are handled too without too much hassle I
won't argue against it, even though I'm not convinced of the use case
either.
