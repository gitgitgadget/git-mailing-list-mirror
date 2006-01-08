From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 08 Jan 2006 00:16:51 -0800 (PST)
Message-ID: <tnx64os3xri.fsf@arm.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 16:32:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwLTk-0007fW-QS
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 16:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWAJPcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 10:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWAJPcB
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 10:32:01 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:44699 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932187AbWAJPb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 10:31:59 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k0AFVW6s022098;
	Tue, 10 Jan 2006 15:31:32 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Tue, 10 Jan 2006 15:31:31 +0000
To: len.brown@intel.com
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com> (Len
 Brown's message of "Sun, 8 Jan 2006 02:47:30 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 10 Jan 2006 15:31:31.0996 (UTC) FILETIME=[EEDAC5C0:01C615FA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14423>

"Brown, Len" wrote:
>>I _really_ wish you wouldn't have those automatic merges.
>>
>>Why do you do them? They add nothing but ugly and unnecessary 
>>history, and in this pull, I think almost exactly half of the
>>commits were just these empty merges.
>
> Is it possible for it git, like bk, to simply ignore merge commits
> in its summary output?

As Junio suggested, you can have a look at StGIT
(http://www.procode.org/stgit/) for a different workflow. There is a
tutorial both on the web and in the doc/ directory but, anyway, it is
pretty similar to Quilt only that the patches are GIT commits.

In principle, you keep all the patches in a stack whose base is the
HEAD of Linus' kernel. You can indefinitely modify/push/pop the
patches and, once you are happy with the state of the stack, ask Linus
to pull using standard GIT commands (or mail them with 'stg
mail'). You can afterwards pull the latest changes from Linus using
'stg pull'. This operation pops the patches you have, advances the
base of the stack (so no "merge" message) and pushes your patches
back. Since pushing is done with a three-way merge, it detects whether
there are any upstream modifications to your patches (if not, all the
patches should become empty and safely removed from the stack).

You can also have a branch for upstream merges only and you can easily
cherry-pick patches or commits from other branches. This is quite
useful if you want to continue the work on your development branch
until Linus merges your patches.

-- 
Catalin
