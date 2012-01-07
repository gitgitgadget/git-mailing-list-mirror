From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: How to deal with historic tar-balls
Date: Sat, 07 Jan 2012 13:18:45 -0600
Message-ID: <4F089A95.9050300@gmail.com>
References: <4EFF5CDA.5050809@gmail.com> <4F05C0E2.4050101@gmail.com> <4F079BA1.3060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: nn6eumtr <nn6eumtr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 20:19:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjbnM-0004An-58
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 20:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab2AGTSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 14:18:49 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:64769 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753180Ab2AGTSs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2012 14:18:48 -0500
Received: by obcwo16 with SMTP id wo16so2935516obc.19
        for <git@vger.kernel.org>; Sat, 07 Jan 2012 11:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sd8uVQX4Apffq/t95V41STgGYVCsGdyD3B0ol78i+sk=;
        b=OzUiQ8kMMIz1JTUlHEXhiaBgJZVY+wI+aRT25lKza7qtPrkRLPz6dfug7sJgPDh59o
         zsAhpy+THImFyjS0U+3hrf9yVOF67R887GoqTpwe2bJTtxB77vhXWihbbhj/ajs0ouSP
         B2LrcGargLrWzrjhC/P2JsvvJwFYiZ6VFbdLk=
Received: by 10.182.54.33 with SMTP id g1mr8963196obp.19.1325963927810;
        Sat, 07 Jan 2012 11:18:47 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id n4sm740993obv.10.2012.01.07.11.18.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Jan 2012 11:18:47 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
In-Reply-To: <4F079BA1.3060907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188083>

On 1/6/2012 7:10 PM, nn6eumtr wrote:
> Thanks for the response, there is lots of good information there.
>
> One clarification - can you track renames in git? I tried using git mv 
> but from the status output it looks like it deleted the old file  and 
> added the new file. I was expecting it to record some sort of 
> indicator of the name change, instead it looks like a short-cut for 
> delete & add, the docs aren't clear if that is the case.
>
(note: top-posting is not advised.)
You are exactly right in your observation:  git-mv is only a shortcut 
for 'remove old then add new'.  Git does not explicitly track 
"renames".  It can detect renames easily in the cases where you really 
just renamed the file and left the contents the same.  Git tracks 
content (and trees) as opposed to files (and file names).  Git stores 
the 'blob', aka 'contents' of files in the object store.  So if you have 
30 files with different names and the exact same contents in your work 
tree they are stored as a single blob in the .git/objects "object 
store".  If some of your "renames" are really "I renamed it and then I 
modified it" then git will have a harder time detecting the "rename" 
depending on how much you modified it.  In such cases what you really 
did is arguably not a "rename" anyway.  You can record your "renames" 
manually in your commit message if appropriate.  If you have 5 minutes 
you can watch this video from the 15:00 min to 20:59 min marks to get an 
explanation of git-mv and rename-detection: 
http://www.youtube.com/watch?v=j45cs5_nY2k (youtube searchstring: 'git 
google tech talks', result: 'contributing with git'.)

v/r,
neal
