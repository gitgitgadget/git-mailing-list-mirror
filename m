From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: query: picking dependant commits from a latest tree
Date: Tue, 03 Apr 2012 11:55:27 -0500
Message-ID: <4F7B2B7F.8050308@gmail.com>
References: <20120327095504.GM1806@localhost.localdomain> <4F75DF56.10902@gmail.com> <20120403040001.GQ1766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>
To: Shiraz Hashim <shiraz.hashim@st.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 18:55:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF715-0005Vn-3r
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 18:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab2DCQza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 12:55:30 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65377 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab2DCQz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 12:55:29 -0400
Received: by yenl12 with SMTP id l12so1895492yen.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kNsIoVUDhvdmDWwf0Rz2sdxeqyOYJ1EBJJn1X5Qzz5c=;
        b=c/zKgMojZs1nmeTkm7Hw0uX5IJotGL2OdxM6AKA+qQUcWKkzlEMg9ceTttydhIO4pG
         CJ40z7k8EN1bqTOhhVVT3O700f/t9Z2vHuEtb2YJjk4syyqy3AaryZZECy1T0UEn9OVa
         ZcV/FS0RohTIZZksbL0nZoeu/Hldnic8VRDJ0yqq4FzP+63sNyzNQfAyUJ7jB1YHO3SV
         u8+GPGIuQOUopjHI9HQ4WSnhmi+9gOfGClt6udNf0PvOHPnjdNY4TkvqUvmtl64H+tYl
         9vLYHVJ3uzmGyDAB4UDyxLWs5tGSON+5VnYsE2m6Sx5mcJBWX0CctDAC5zrFn+33iSQK
         q21A==
Received: by 10.60.32.210 with SMTP id l18mr19919559oei.1.1333472129032;
        Tue, 03 Apr 2012 09:55:29 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id t5sm17280552oef.10.2012.04.03.09.55.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 09:55:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <20120403040001.GQ1766@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194632>

On 4/2/2012 11:00 PM, Shiraz Hashim wrote:
> On Sat, Mar 31, 2012 at 12:29:10AM +0800, Neal Kreitzinger wrote:
>> On 3/27/2012 4:55 AM, Shiraz Hashim wrote:
>>> If I try to pick commits from a latest tree for a particular feature
>>> then what is the best way to find out all dependant commits.
>>>
>>> So for example for the commit which I want to pick there are 10 other
>>> commits around that file but some affect other files which themselves
>>> have several commits which I must apply.
>>>
>>> Is their a way to do this efficiently ?
>>>
>> You're assuming all dependencies reside in the same commits or in common
>> files.  If the changes in a commit are dependent on the previous commit
>> and they do not share any of the same files then what you are proposing
>> is not going to catch that.
> You are right, but this would perhaps be caught during tests. But in
> the first place how can I find dependent commits to pass build test.
>
Theoretically, all the ancestors of a commit are dependencies.  When you 
cherry-pick you run the risk of not getting dependencies.  That will be 
up to you to figure out.  Different software has different dependency 
scenarios.  IMO, you will analyze what yours specifically are and then 
perhaps submit more specific examples to the newsgroup.  There are many 
possibilities.

Just one example is that you would have to write a script that scans 
your all programs in your commit for called programs and then 
interrogates history to see of any of the called programs were changed 
in other commits.  Of course you would have to repeat that and it could 
be quite extensive.  You would also have to git-grep repo history for 
all callers of programs changed in your commit.  Of course you would 
have to repeat that and it could be quite extensive.  Git is not going 
to do this for you.  You can use git to do powerful interrogations to 
aid you in this.  Even after all of that, someone has to review the 
results and make judgement calls on which dependencies matter and which 
ones don't.  This is where your own knowledge or that of senior 
(system-wise) people has to make judgement calls.  Human knowledge of 
your software is the best first approach at assessing commit 
dependencies, and then supplement it with git interrogations if you have 
any remaining questions or doubts.

v/r,
neal
