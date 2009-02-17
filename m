From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH] filter-branch -d: Export GIT_DIR earlier
Date: Tue, 17 Feb 2009 09:17:28 +0100
Message-ID: <20090217081728.GA3893@lars.home.noschinski.de>
References: <20090216130951.GA3769@lars.home.noschinski.de> <alpine.DEB.1.00.0902161441190.6289@intel-tinevez-2-302> <20090216145137.GA4431@lars.home.noschinski.de> <alpine.DEB.1.00.0902161636040.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:19:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLAS-0001cm-GO
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbZBQIRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbZBQIRc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:17:32 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:56356 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZBQIRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:17:31 -0500
Received: from [87.78.71.97] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZL8z-0002Mp-5Y; Tue, 17 Feb 2009 09:17:29 +0100
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZL8y-0001pS-CJ; Tue, 17 Feb 2009 09:17:28 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902161636040.6289@intel-tinevez-2-302>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110328>

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [09-02-16 18:52]:
>Hi,
>
>On Mon, 16 Feb 2009, Lars Noschinski wrote:
>
>> * Johannes Schindelin <Johannes.Schindelin@gmx.de> [09-02-16 15:42]:
>> > > This fix is not yet ready for commit, as it lacks a test case.
>> > > 
>> > > Writing a test case for this bug, I wonder about the preferred way to use
>> > > a
>> > > directory outside any git repository in a test: Using some directory below
>> > > git/t/ will not work, as (in most cases) git is a git repository.
[...]
>Next try: is it not true that we can check that "$tempdir/backup-refs" 
>is correct, i.e. identical to what 'for-each-ref' outputs for the desired 
>directory?

True.

>So we could make a subdirectory, set up a dummy branch with one commit, 
>call filter-branch with a tmpdir that is in _another_ subdirectory, with a 
>filter that just returns false, so that the tmpdir is not deleted, and 
>verify the contents of $tmpdir/backup-refs, no?

AFAICS $tmpdir is always deleted, filter-branch sets a trap to ensure
this. But using a filter to copy backup-refs elsewhere works. Patch
follows.

  - Lars.
