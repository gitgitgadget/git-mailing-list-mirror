From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Sun, 17 Sep 2006 14:11:46 -0700
Message-ID: <450DBA12.3070700@gmail.com>
References: <4509A7EC.9090805@gmail.com>	<7vu03a2po8.fsf@assigned-by-dhcp.cox.net> <4509B954.60101@gmail.com>	<7v8xkl26kb.fsf@assigned-by-dhcp.cox.net> <450AEDBF.9050307@gmail.com> <7vvenm3h9f.fsf@assigned-by-dhcp.cox.net> <450D9847.4080308@gmail.com> <eek5l4$kaa$1@sea.gmane.org> <450DA99F.8000009@gmail.com> <eekb4o$5nj$1@sea.gmane.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 23:11:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP3vd-0003un-DA
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 23:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWIQVLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 17:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWIQVLu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 17:11:50 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:13689 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965103AbWIQVLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 17:11:50 -0400
Received: by py-out-1112.google.com with SMTP id n25so5043180pyg
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 14:11:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HFwDjL+/GrAxnHgLdlOVi83f9cgoAYfp5KWBCwMVMYmIRKnHLIUltW57sAODiu8CKb70rHB4rr5jG25huChoYZqVAMaww8pc/mzOVJHsi4KIdQHmlLHPRFo0rSUuS43EHyrq5gmfcr6DvVDrgsNFtH0G/Xb2RDeBdamCDcPYKeI=
Received: by 10.65.51.16 with SMTP id d16mr14677358qbk;
        Sun, 17 Sep 2006 14:11:49 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.86.89])
        by mx.gmail.com with ESMTP id e15sm10269qba.2006.09.17.14.11.47;
        Sun, 17 Sep 2006 14:11:48 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eekb4o$5nj$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27204>

Jakub Narebski wrote:
> A Large Angry SCM wrote:
>> Jakub Narebski wrote:
>>> A Large Angry SCM wrote:
>>>
>>>> There is no fundamental reason Git can not support partial 
>>>> checkouts/working directories. In fact, there is no fundamental reason 
>>>> Git can not support operations on partial (sparse?) repositories in both 
>>>> space (working content/state, etc.) and time (history); it's just a 
>>>> matter of record keeping[*1*]. That isn't how the Linux kernel 
>>>> developers want to use their VCS but it _is_ how others want to use
>>>> theirs. 
>>> There is perhaps not much trouble with partial checkouts, but there is
>>> problem with partial _commits_, at least for snapshot based SCM 
>>> (as opposed to patchset based SCM). 
>> By "partial commit" I take it you mean a commit with only partial 
>> information about the new (content) state? If so, the missing 
>> information about the new state can be assumed to have not changed from 
>> the previous recorded state (commit).
> 
> That of course assumes that 1) the whole state is recorded somewhere
> (perhaps in the repository); so the partial checkout saves space only if
> repository compress really well, 2) there are no merges outside checked out
> part.

1) The TREE objects leading to the objects that are 
added/deleted/changed objects are required. TREEs not leading to the 
added/deleted/changed objects are not required, only their IDs. That is 
sufficient to commit the changes in a partial checkout.

2) Obviously, only the part checked out can be worked on. If you want to 
merge changes to some other part, you will need that part, and possibly 
a mergebase.
