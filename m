From: Avi Kivity <avi@redhat.com>
Subject: Re: git-bisect not working correctly in the kvm.git repository?
Date: Tue, 18 Nov 2008 22:38:04 +0200
Message-ID: <492327AC.9020007@redhat.com>
References: <gfs9hn$hq9$1@ger.gmane.org> <alpine.LFD.2.00.0811171131330.18283@nehalem.linux-foundation.org> <gfsjjp$o42$1@ger.gmane.org> <49226B26.4000807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: walt <w41ter@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:39:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2XLv-00057v-Ua
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 21:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbYKRUiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 15:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbYKRUh7
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 15:37:59 -0500
Received: from mx2.redhat.com ([66.187.237.31]:40176 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbYKRUh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 15:37:59 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mAIKbu0M010524;
	Tue, 18 Nov 2008 15:37:56 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mAIKbsbn003129;
	Tue, 18 Nov 2008 15:37:54 -0500
Received: from mermaid.qumranet.com (vpn-14-29.rdu.redhat.com [10.11.14.29])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mAIKbpQX014802;
	Tue, 18 Nov 2008 15:37:52 -0500
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <49226B26.4000807@viscovery.net>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101285>

Johannes Sixt wrote:
> If you are pretty sure that the bug you are looking for was *not*
> introduced in the branch that was subtree-merged, you can mark it as
> "good" like so:
>
>   $ git bisect start kvm-69 kvm-70 $BRANCH
>
> where $BRANCH is the most recent commit on the subtree-merged branch.
> Watch out that you do *not* accidentally pick the *merge* commit that
> merged the branch in, but the (second) parent[*], the one that was merged
> in.  Then your bisect sequence won't ever end up in that branch.
>   

Unfortunately, it is fairly likely that the bug was indeed introduced by 
the merge, since most of the commits in that repository come via that merge.

It is possible that the bug exists in that branch (which you need to 
build as pure qemu, not kvm), but again, it is more likely that the bug 
is an interaction between a qemu feature introduced during the merge, 
and the existing kvm glue code.

One way around this is to redo the merge from the point git bisect 
suggests, but that is difficult, time consuming, and error prone.  It 
also needs a lot of familiarity with the code.

Fortunately, long term the problem is going away with qemu upstream 
gaining kvm support.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
