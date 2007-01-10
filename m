From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file 
 permission bits)
Date: Wed, 10 Jan 2007 10:34:31 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0701101027480.10339@qynat.qvtvafvgr.pbz>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> 
 <8aa486160612100706y92bc722n93374e394fc58005@mail.gmail.com> 
 <Pine.LNX.4.63.0701091735490.7747@qynat.qvtvafvgr.pbz> <20070110023031.GC30765@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 19:40:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4iN6-0003qq-Il
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 19:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbXAJSkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 13:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbXAJSkW
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 13:40:22 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:45011 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S965004AbXAJSkU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 13:40:20 -0500
Received: from no.name.available by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Wed, 10 Jan 2007 10:40:20 -0800
Received: from wlvims02.corp.ad.diginsite.com (wlvims02.diginsite.com [10.201.10.79]) by blackbird.diginsite.com (Tablus Interceptor) for <git@vger.kernel.org>; Wed, 10 Jan 2007 10:40:17 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Wed, 10 Jan 2007 10:40:15 -0800
X-X-Sender: dlang@dlang.diginsite.com
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070110023031.GC30765@spearce.org>
X-Tablus-Inspected: yes
X-Tablus-Classifications: public
X-Tablus-Action: allow
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36523>

On Tue, 9 Jan 2007, Shawn O. Pearce wrote:

> David Lang <david.lang@digitalinsight.com> wrote:
>> I want to have a tripwire-like system checking the files to make sure that
>> they haven't changed unexpectedly. the program I'm looking at notices inode
>> as well as timestamp and content changed.
>>
>> when you checkout a file from git will it re-write/overwrite a file that
>> hasn't changed or will it realize there is no change and leave it as-is?
>
> If the stat data is current it will leave it as-is.  You can force
> the index to refresh with `git update-index --refresh` or by running
> git status.

I was looking at checkout, not checkin so I'm not understanding how the index is 
involved here.

>> does this answer change if there is a trigger on checkout (to change
>> permissions or otherwise manipulate the file)?
>
> Only if the trigger does something in addition, like force overwrite
> files.  But we don't have a checkout trigger.  So there's no trigger.

we don't have a checkout trigger? I thought that what Linus had suggested for 
permissions was to have a script triggered on checkin that stored the 
permissions of the files, and a script triggered on checkout that set the 
permissions from the stored file.

if there isn't a checkout trigger how would the permissions ever get set?

in my particular case I'd like to have the checkin run a script that produces a 
'generic' version of each file, and the checkout run a script that converts the 
generic version into the host specific version. I already have a script that 
does this work (and (ab)uses ssh to propogate the generic version to other hosts 
and create the host specific versions there), but I was interested in useing git 
to add better version control to the generic versions of the files (I currently 
use RCS on each box to version control the host specific versions)

David Lang
