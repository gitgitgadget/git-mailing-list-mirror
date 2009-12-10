From: Nils Adermann <naderman@naderman.de>
Subject: Re: subtree merge tries to merge into wrong directory
Date: Thu, 10 Dec 2009 05:26:14 +0100
Message-ID: <4B207866.2010400@naderman.de>
References: <4B206DCF.90202@naderman.de> <20091210042008.GA3398@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 05:26:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIabg-0001Aa-E9
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 05:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbZLJE0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 23:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbZLJE0M
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 23:26:12 -0500
Received: from naderman.de ([85.119.157.185]:38851 "EHLO naderman.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbZLJE0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 23:26:12 -0500
Received: by naderman.de (Postfix, from userid 65534)
	id CB379BE9B18C; Thu, 10 Dec 2009 04:26:08 +0000 (UTC)
Received: from [192.168.1.3] (e180075127.adsl.alicedsl.de [85.180.75.127])
	by naderman.de (Postfix) with ESMTPA id 07507BE9B183;
	Thu, 10 Dec 2009 04:26:07 +0000 (UTC)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20091210042008.GA3398@gmail.com>
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
   int  cnt   prob  spamicity histogram
  0.00  107 0.020859 0.019727 ################################################
  0.10    3 0.111503 0.022653 ##
  0.20    0 0.000000 0.022653 
  0.30    0 0.000000 0.022653 
  0.40    0 0.000000 0.022653 
  0.50    0 0.000000 0.022653 
  0.60    0 0.000000 0.022653 
  0.70    0 0.000000 0.022653 
  0.80    0 0.000000 0.022653 
  0.90    4 0.992440 0.154842 ##
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135011>

David Aguilar schrieb:
> On Thu, Dec 10, 2009 at 04:41:03AM +0100, Nils Adermann wrote:
>   
>> Following  
>> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html 
>> I have subtree merged a 3rd party library (ezc-reflection) into my  
>> repository (pflow). The prefix I used was lib/ezc/trunk/Reflection. Now  
>> there have been changes to ezc-reflection but merging them into my  
>> repository fails. The merge is attempted in example/ rather than  
>> lib/ezc/trunk/Reflection.
>>
>> I originally set this up with:
>>
>> git remote add -f ezc-reflection /path/to/ezc-reflection
>> git merge -s ours --no-commit ezc-reflection/master
>> git read-tree --prefix=lib/ezc/trunk/Reflection -u ezc-reflection/master
>>
>> Reproduce my problem by executing the following:
>>
>> git clone git://github.com/naderman/pflow.git
>> cd pflow
>> git reset --hard f3e001e3
>> git fetch git://github.com/naderman/ezc-reflection.git master
>> git merge -s subtree FETCH_HEAD
>>
>> As you see this results in:
>>
>> CONFLICT (delete/modify): example/src/doc_comment_parser.php deleted in  
>> HEAD and modified in FETCH_HEAD. Version FETCH_HEAD of  
>> example/src/doc_comment_parser.php left in tree.
>> Automatic merge failed; fix conflicts and then commit the result.
>>
>> As long as I don't make any changes to lib/ezc/trunk/Reflection that I  
>> want to merge I can work around this by simply repeating my original  
>> process like this:
>>
>> git clone git://github.com/naderman/pflow.git
>> cd pflow
>> git reset --hard f3e001e3
>> git fetch git://github.com/naderman/ezc-reflection.git master
>> git merge -s ours --no-commit FETCH_HEAD
>> git rm -r lib/ezc/trunk/Reflection/
>> git read-tree --prefix=lib/ezc/trunk/Reflection/ -u FETCH_HEAD
>>
>> Why does this problem occur and how can I get the merge to work properly?
>>     
>
> I'm not sure, but maybe you can try git-subtree?
> It makes this stuff easier for mere mortals.
>
> http://github.com/apenwarr/git-subtree/
>
> You might need to start redo your repo, but several people have
> had good success with git-subtree.
>   
I actually tried that and I get the exact same problem. From what I 
understand git-subtree really doesn't do anything different than what I 
do anyway.
