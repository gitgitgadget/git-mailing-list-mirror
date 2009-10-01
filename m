From: Peter <vmail@mycircuit.org>
Subject: Re: gitignore: how to exclude a directory tree from being ignored
Date: Thu, 01 Oct 2009 16:48:05 +0200
Message-ID: <4AC4C125.10609@mycircuit.org>
References: <4AC48D5F.6060401@mycircuit.org> <4AC4A310.8000507@viscovery.net> <4AC4A7EF.9030002@mycircuit.org> <4AC4AD25.5010708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 01 16:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtMx9-0002x7-Bx
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 16:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbZJAOsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 10:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbZJAOsF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 10:48:05 -0400
Received: from mailfe15.tele2.ch ([212.247.155.200]:47167 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932639AbZJAOsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 10:48:04 -0400
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=L3Mu2x56dNAA:10 a=vWKxTcPCt1ggqAQrsOHYvw==:17 a=MBpIpUXns03lCyNLSFMA:9 a=udQ_Q4gWd26S0puaJcgA:7 a=9mS96L1BBEvjfqxoX52f-L5o2lMA:4 a=WWxEoZngsMS8IGK7:21 a=Tfu0JG40XsO_ovg4:21
Received: from mail.mycircuit.org (account cxu-8g8-ypb@tele2.ch [188.155.226.135] verified)
  by mailfe15.swip.net (CommuniGate Pro SMTP 5.2.16)
  with ESMTPA id 570556611; Thu, 01 Oct 2009 16:48:06 +0200
Received-SPF: none
 receiver=mailfe15.swip.net; client-ip=188.155.226.135; envelope-from=vmail@mycircuit.org
Received: from [192.168.1.193] (unknown [192.168.1.193])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "p_email", Issuer "192.168.2.2" (verified OK))
	by mail.mycircuit.org (Postfix) with ESMTP id 1B33ACFA43;
	Thu,  1 Oct 2009 16:48:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
In-Reply-To: <4AC4AD25.5010708@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129395>


>> 1) I can't have just one .gitignore file in the root dir, if I want to
>> _recursively_ inverse the exclude pattern for a sub dir tree.
>>     
>
> No, it's not the inversion of the pattern, but the slash (if it is not at
> the end) that makes the pattern non-recursive.
>
>   
from the gitignore manpage:
 >> If the pattern ends with a slash, it is removed for the purpose of 
the following description, but it would only find a match with a 
directory. In other words, foo/ will match a directory foo and paths 
underneath it, but will not match a regular file or a symbolic link foo 
(this is consistent with the way how pathspec works in general in git). <<

Doesn't this mean, that if I say:
vendor/
matches the directory and ( recursively ) the paths underneath it.?
And, consequently:
!vendor/
inverse the exclusion for vendor ( that is: include ) and everything 
that is contained in it ? ( This is obviously not the case, but this is 
what I would expect )

>> In this case, I have to put individual .gitignore files in the sub trees
>> I want to re-include.
>>     
>
> If you have only the directory vendor/ with no further interesting
> subdirectories, then you can use my first suggestion. But if you have your
> *.exe and *.o distributed over several directories of different depths
> below vendor/, then it might be easier to have a separate
> vendor/.gitignore with recursive patterns (i.e. that do not contain a slash).
>
>   
This works for me ( I have indeed distributed them over several dirs )
>> 2) In order to see what will be staged, I have to use the :
>> git ls-files -o --exclude-standard
>> instead of :
>> git ls-files -o -i --exclude-from=.gitignore
>> because the latter won't consider .gitignore patterns in subtree
>>     
>
> After reading the documentation, I don't know, and I won't try now ;-)
>
>   
At least it seams to work here ..
> -- Hannes
>   
Thanks !
