From: david@lang.hm
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 17:55:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
References: <4DB80747.8080401@op5.se> <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com> <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org> <7vpqo77dlr.fsf@alter.siamese.dyndns.org> <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net> <7vwrif5q93.fsf@alter.siamese.dyndns.org> <20110427220748.GA19578@elie> <7vsjt35l84.fsf@alter.siamese.dyndns.org> <20110427234224.GA26854@elie> <7viptz5j82.fsf@alter.siamese.dyndns.org>
 <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 02:56:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFFWk-000510-35
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 02:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940Ab1D1A4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 20:56:13 -0400
Received: from mail.lang.hm ([64.81.33.126]:60411 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab1D1A4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 20:56:13 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p3S0twxc017919;
	Wed, 27 Apr 2011 17:55:58 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172300>

On Thu, 28 Apr 2011, Jon Seymour wrote:

> On Thu, Apr 28, 2011 at 10:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>
> I agree. Apologies for confusing things by talking too much about a
> git pm install command.
>
> I think there are 3 levels of functionality. FWIW, I am suggesting
> git-core stops at #2.
>
> 0. unmanaged plugins
>
> git doesn't provide any explicit management of plugins, but will use
> them if finds them.
>
> Without some kind of management, however, you will be forced to dump
> the man pages and scripts
> for the plugins in one place.
>
> This would be very distribution manager unfriendly since there could
> be conflicts galore.

every package manager I know of has no problem with multiple packages 
owning files in one directory.

if the files are named the same thing you will have a conflict, but if the 
files are named the same thing, the commands are probably going to be 
named the same, and so you will have conflicts in any case.

> I guess an unmanaged solution could use separate directories for each
> plugin, but this would imply scanning all these paths each time you
> invoke git. In my view, symbolic links from a dir already
> GIT_EXEC_PATH to plugin directories would be a more efficient way to
> do this.

I think you are overanalyzing the problem

> 1. managed plugins
>
> git provides minimal plugin management functionality. Each plugin has
> its own directory, but an activate step is required to make the plugin
> available to the GIT_EXEC_PATH and GIT_MAN_PATH.
>
> This has the advantage that conflicts between plugins would be more
> readily avoided and is potentially more performant. As Pau suggests,
> this option is much more package manager friendly

I don't see how this will avoid conflicts. what files are you thinking 
that the different plugins will make that won't conflict any more than the 
commands themselves will?

> It probably does require a git plugin command of some kind, however,
> in order to perform the activation step.

only if you think you need a 'installed but not active' mode of operation, 
and I don't understand why you would want that.

David Lang

> 2. managed packages
>
> A meta-package manager for plugins, that delegates plugin installation
> concerns to a platform package manager.
>
> The thing is, you may absolutely hate #2, but if approach #1 is
> adopted by git-core, someone can at least attempt this by, well,
> writing a plugin for it.
>
> jon.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
