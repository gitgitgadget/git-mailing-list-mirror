From: Kevin Ballard <kevin@sb.org>
Subject: Re: git-svn goes into infinite loop rebuilding rev_map
Date: Fri, 16 May 2008 13:48:01 -0400
Message-ID: <4E00E139-E354-4336-8290-51CD1B55017A@sb.org>
References: <4aca3dc20805161015l28d1e4a2u318c1bc23bb5b925@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Daniel Berlin" <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Fri May 16 19:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx437-0002El-Oa
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 19:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbYEPRsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 13:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbYEPRsG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 13:48:06 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:40190 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752012AbYEPRsF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 13:48:05 -0400
Received: from [192.168.0.203] (c-24-91-11-245.hsd1.nh.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id C746EAF935;
	Fri, 16 May 2008 10:48:02 -0700 (PDT)
In-Reply-To: <4aca3dc20805161015l28d1e4a2u318c1bc23bb5b925@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82312>

On May 16, 2008, at 1:15 PM, Daniel Berlin wrote:

> Starting last night, for no particularly obvious reason, git-svn fetch
> (or git-svn rebase or any command that does naything interesting) on
> gcc.gnu.org's repo causes git-svn to do the following:
>
> -bash-3.00$ git-svn fetch
> Rebuilding .git/svn/trunk/.rev_map. 
> 138bc75d-0d04-0410-961f-82ee72b054a4 ...
> Done rebuilding .git/svn/trunk/.rev_map. 
> 138bc75d-0d04-0410-961f-82ee72b054a4
> Rebuilding .git/svn/trunk/.rev_map. 
> 138bc75d-0d04-0410-961f-82ee72b054a4 ...
> <repeat forever>
>
>
> I checked the obvious things. There is no permissions problem, strace
> doesn't show the writes failing, etc.
> git-fsck shows nothing as being obviously wrong.

Are you sure? I just glanced at the code, and it avoids rebuilding i  
the map file exists and is not empty.

> This just suddenly started happening with no obvious reason (we fire
> off git-svn fetch and rebase on the repo when cvs commits happen).
>
> git-log shows the last processed rev was:
>
> commit e66b310fb9a3ddc7ed5143db3c468711c8a36d08
> Author: uros <uros@138bc75d-0d04-0410-961f-82ee72b054a4>
> Date:   Thu May 15 14:38:23 2008 +0000
>
>        * config/i386/sse.md (*vec_concatv2sf_sse4_1): Add "m"  
> constraint
>        to alternative 4 of operand 2.
>
>
>    git-svn-id: svn+ssh://gcc.gnu.org/svn/gcc/trunk@135364
> 138bc75d-0d04-0410-961f-82ee72b054a4
>
>
> I'm happy to provide anything i can to get the problem fixed, but not
> being a git expert, i have no idea what is up here.

What version of git do you have? And you might want to CC Eric Wong <normalperson@yhbt.net 
 > on this.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
