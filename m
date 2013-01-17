From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 6/8] git-remote-testpy: hash bytes explicitly
Date: Thu, 17 Jan 2013 22:30:50 +0000
Message-ID: <20130117223050.GL4574@serenity.lan>
References: <cover.1358448207.git.john@keeping.me.uk>
 <66c42ff65eddde494f40d0a582e89a081b4ab8e8.1358448207.git.john@keeping.me.uk>
 <7vtxqftulq.fsf@alter.siamese.dyndns.org>
 <20130117210048.GI4574@serenity.lan>
 <7v622vtplm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:31:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvxzW-0006b7-6Q
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 23:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab3AQWbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 17:31:00 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:59472 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab3AQWbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 17:31:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 7FD0B6064FE;
	Thu, 17 Jan 2013 22:30:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C0gutL8XOnL0; Thu, 17 Jan 2013 22:30:59 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id 13B6F6064D3;
	Thu, 17 Jan 2013 22:30:59 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id E0FCB276DFB;
	Thu, 17 Jan 2013 22:30:58 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4UMEogkjvhjS; Thu, 17 Jan 2013 22:30:58 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id E91A1330E33;
	Thu, 17 Jan 2013 22:30:52 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v622vtplm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213886>

On Thu, Jan 17, 2013 at 02:24:37PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
>> You're right - I think we need to add ", errors='replace'" to the call
>> to encode.
> 
> Of if it is used just as a opaque token, you can .encode('hex') or
> something to punt on the whole issue, no?

Even better.  Are you happy to squash that in (assuming nothing else
comes up) or shall I resend?

>>>>  git-remote-testpy.py | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/git-remote-testpy.py b/git-remote-testpy.py
>>>> index d94a66a..f8dc196 100644
>>>> --- a/git-remote-testpy.py
>>>> +++ b/git-remote-testpy.py
>>>> @@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExporter
>>>>  from git_remote_helpers.git.importer import GitImporter
>>>>  from git_remote_helpers.git.non_local import NonLocalGit
>>>>  
>>>> -if sys.hexversion < 0x01050200:
>>>> -    # os.makedirs() is the limiter
>>>> -    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
>>>> +if sys.hexversion < 0x02000000:
>>>> +    # string.encode() is the limiter
>>>> +    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
>>>>      sys.exit(1)
>>>>  
>>>>  def get_repo(alias, url):
>>>> @@ -45,7 +45,7 @@ def get_repo(alias, url):
>>>>      repo.get_head()
>>>>  
>>>>      hasher = _digest()
>>>> -    hasher.update(repo.path)
>>>> +    hasher.update(repo.path.encode('utf-8'))
>>>>      repo.hash = hasher.hexdigest()
>>>>  
>>>>      repo.get_base_path = lambda base: os.path.join(
