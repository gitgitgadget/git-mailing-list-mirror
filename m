From: Ferry Huberts <mailings@hupie.com>
Subject: Re: [CGit] [PATCH 0/6] Communicate the repo name to the filter scripts
Date: Sat, 19 Feb 2011 14:54:51 +0100
Message-ID: <4D5FCBAB.6060009@hupie.com>
References: <1297977069-21884-1-git-send-email-mailings@hupie.com> <AANLkTimASPjeHor3R6c=i1xpjftxrg4NnFaLJfReuZ-X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:55:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqnH4-0002J4-4N
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab1BSNy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:54:57 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:50857 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752694Ab1BSNy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:54:56 -0500
Received: from stinkpad.internal.hupie.com (82-197-206-98.dsl.cambrium.nl [82.197.206.98])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 41CC658C993;
	Sat, 19 Feb 2011 14:54:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7
In-Reply-To: <AANLkTimASPjeHor3R6c=i1xpjftxrg4NnFaLJfReuZ-X@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167282>

On 02/19/2011 09:46 AM, Lars Hjemli wrote:
> On Thu, Feb 17, 2011 at 22:11, Ferry Huberts <mailings@hupie.com> wrote:
>> This patch series fixes two bugs and communicates the repo name
>> to the filter scripts.
> 
> Thanks, but I think the current filter invocations with unnamed,
> positional command arguments was a mistake. We should probably fix it
> instead of extending it, taking care not to break backwards
> compatibility.
> 
> The easiest fix would be to add some environment variables:
> * GIT_DIR
> * CGIT_REPO_NAME
> * CGIT_REPO_REL_URL
> * CGIT_REPO_ABS_URL
> * CGIT_BRANCH_NAME
> * CGIT_COMMIT_ID
> * CGIT_PATH_FILTER
> 
> What do you think?
> 
> --
> larsh

I've been thinking about this too and did think about this solution but
also about a solution in which these settings are written to a temporary
file. I have no preference as long as the repo settings are communicated
to the filter script. Writing to a file is probably bad for performance
though.

The patches I sent just plainly solve my own problem and I was hoping a
bit for this discussion :-)

Your proposal sounds reasonable and a good approach.

I'm a bit worried about the GIT_DIR env var, about it conflicting with
the real git env var. It's probably best to rename that one to CGIT_GIT_DIR.

Also, we'd have to be sure that when we set these env vars that they're
only propagated to the filter script we're going to run and not to other
envs: running filter scripts in parallel must not be prevented.


Have you looked at the first 2 patches?
These solve bugs and can be applied regardless of this discussion.


please let me know what you think.


grtz
-- 
Ferry Huberts
