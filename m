From: Gustavo Narea <gnarea@tech.2degreesnetwork.com>
Subject: Re: Multiple checkouts active for the same repository
Date: Mon, 27 Sep 2010 11:33:32 +0100
Organization: 2degrees Limited
Message-ID: <4CA072FC.3020004@tech.2degreesnetwork.com>
References: <4C9C6F8B.3090806@tech.2degreesnetwork.com> <14b089955184bbb677b6434993682403@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Sep 27 12:33:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0B1k-0005f4-6A
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 12:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123Ab0I0Kdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 06:33:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51793 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab0I0Kdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 06:33:37 -0400
Received: by wyb28 with SMTP id 28so3692408wyb.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 03:33:35 -0700 (PDT)
Received: by 10.216.232.229 with SMTP id n79mr5952231weq.52.1285583615782;
        Mon, 27 Sep 2010 03:33:35 -0700 (PDT)
Received: from [192.168.0.69] (mail.2degreesnetwork.com [62.172.190.17])
        by mx.google.com with ESMTPS id v44sm3466627weq.28.2010.09.27.03.33.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 03:33:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9pre) Gecko/20100217 Lightning/1.0b1 Shredder/3.0.3pre
In-Reply-To: <14b089955184bbb677b6434993682403@212.159.54.234>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157322>

Hello,

Thanks! I've given git-new-workdir a try and it seems to be what I was
searching for.

 - Gustavo.

On 24/09/10 16:33, Julian Phillips wrote:
> On Fri, 24 Sep 2010 10:29:47 +0100, Gustavo Narea
> <gnarea@tech.2degreesnetwork.com> wrote:
>> Hello.
>>
>> We're currently migrating from another DVCS, which allows us to have
>> working copies of each branch in separate directories, so that their
>> code can be used simultaneously. However, I haven't found a way to do
>> this with Git, at least not an easy way. Can you please help me?
> 
> The git-new-workdir script to be found in contrib/workdir allows multiple
> working copies to share the same repository - though there are some
> caveats:
> 
>  1) uses symbolic links, so doesn't work on Windows
>  2) the working copies are not aware of each other, so if you change a
> checked out branch from another working copy you have to remember to git
> reset your working copy before doing anything with it to get it back in
> sync with the branch
>  3) you have to remember not to delete the actual clone
>  4) the working copies are not aware of each other, so it is possible for
> objects needed by one working copy to get pruned from another one
> 
> Personally, I use this script all the time to checkout multiple branches
> at the same time taking care to stay away from the issues above, and
> everything hums along nicely.
> 
>> We are a team of Web developers and testers working on an application.
>> There are always a few development branches and a stable branch, and
>> testers need all the branches with the very latest code available at all
>> times.
>>
>> The way we handle it at the moment is very simple because the server
>> hosting the remote repository is the same that hosts the deployed
>> instances of each branch, so when we push to the remote repository, the
>> code for each site is automatically updated.
>>
>> We use the following structure:
>> /srv/repositories/project/branch1
>> /srv/repositories/project/branch2
>> /srv/repositories/project/branch3
>>
>> Is there any simple way to do this with Git? I can only think of two
>> options that involve hooks:
>>
>>     * Have a hook that exports each branch to a directory like
>>       /srv/repositories/project/branchN
>>     * Have one Git repository per branch, so that each repository have a
>>       different checkout active. Then the main remote repository will
>>       have post-receive hooks that trigger a pull on each individual
>>
>> I'm not particularly happy with either way. Is there a better solution?
> 


-- 
Gustavo Narea.
Software Developer.
2degrees, Ltd. <http://dev.2degreesnetwork.com/>.
