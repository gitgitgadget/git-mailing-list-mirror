From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Git counterpart to SVN bugtraq properties?
Date: Tue, 01 Oct 2013 13:58:53 +0200
Message-ID: <524AB8FD.2060104@syntevo.com>
References: <51E69612.6020201@syntevo.com> <20130717133357.GB2337@serenity.lan> <5249ACCB.5090007@syntevo.com> <20130930185513.GS9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 01 13:59:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQybX-0005gC-FU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 13:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377Ab3JAL67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 07:58:59 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:47920 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3JAL66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 07:58:58 -0400
Received: from [217.91.110.92] (helo=[192.168.93.201])
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1VQybP-000154-GC; Tue, 01 Oct 2013 13:58:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130930185513.GS9464@google.com>
X-Enigmail-Version: 1.5.2
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235656>

On 30.09.2013 20:55, Jonathan Nieder wrote:
> Hi,
> 
> Marc Strapetz wrote:
>>> On Wed, Jul 17, 2013 at 03:03:14PM +0200, Marc Strapetz wrote:
> 
>>>> I'm looking for a specification or guidelines on how a Git client should
>>>> integrate with bug tracking systems.
> [...]
>> Finally, I've created a minimal spec which is sufficient to parse and
>> display issue IDs:
>>
>> https://github.com/mstrap/bugtraq/blob/master/specification.txt
> 
> Neat. :)
> 
> It reminds me a little of Gerrit's commentlink functionality, though
> that tries to solve a different / more generic problem (automatic
> linking in commit messages in general, not just to bug trackers):
> https://gerrit-review.googlesource.com/Documentation/config-gerrit.html#_a_id_commentlink_a_section_commentlink

Thanks, that's an interesting pointer. I have included some of the ideas
in this new draft (section 2 and new section 3):

https://github.com/mstrap/bugtraq/blob/wip/specification.txt

> Some projects use more than one bug tracker.  For example, a distro
> might have its own bug tracking system and also sometimes make commits
> that refer to the upstream bug tracker.  I don't think that's
> important to necessarily address in the first version of a project
> like this, but thought I should mention it to help plans for the
> future.

I'd even say it's a good idea to prepare for multiple configurations
right from the beginning :) I've changed that in the draft as well.

> Gerrit keeps its configuration in a file named "project.config" in the
> tree associated to the refs/meta/config commit so a single
> configuration can be applied to the entire repository.  Which
> .gitbugtraq file should take effect in a repository with multiple
> branches?

Actually, if the configuration changes over time, .gitbugtraq does not
work well, at least when working with older commits. However, the
advantage of this regular file is that users will get it automatically
when cloning a repository for the first time and they will get updates
to this file on Pull as well. So the Bugtraq configuration works out of
the box.

To set up refs/meta/config, you have to be a Git expert, IMO. And --
more important -- a user (or the client) needs to invoke additional
commands to receive the configuration (or updates of the configuration).
Nevertheless I see the advantages of this singular file as well. So I'm
not sure, how to proceed here.

-Marc
