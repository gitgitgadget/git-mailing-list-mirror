From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] rebase -i: optimize the creation of the todo file
Date: Thu, 08 Mar 2012 12:51:28 +0100
Message-ID: <4F589D40.5060804@viscovery.net>
References: <1331203358-28277-1-git-send-email-domq@google.com> <4F589611.6060106@viscovery.net> <CAJh6GrGch9JHYnGW+K-wxdX9wPRry4Lxi2ysTtt0g9FTF4ThTQ@mail.gmail.com> <CAJh6GrGcr3nOMR7Yrq7g8c-RgQ4FS_FrhcMb+w-nXQO2nic_rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 12:51:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5bsh-0007Sq-LZ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173Ab2CHLvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 06:51:33 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40254 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972Ab2CHLvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 06:51:32 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S5bsW-0004So-Pp; Thu, 08 Mar 2012 12:51:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 81B311660F;
	Thu,  8 Mar 2012 12:51:28 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAJh6GrGcr3nOMR7Yrq7g8c-RgQ4FS_FrhcMb+w-nXQO2nic_rw@mail.gmail.com>
X-Enigmail-Version: 1.3.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192574>

Am 3/8/2012 12:41, schrieb Dominique Quatravaux:
> On Thu, Mar 8, 2012 at 12:36 PM, Dominique Quatravaux <domq@google.com> wrote:
>> On Thu, Mar 8, 2012 at 12:20 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 3/8/2012 11:42, schrieb Dominique Quatravaux:
>>>> +     shortsha1=$(echo $sha1 | cut -c1-7)
>>>
>>>> -             sha1=$(git rev-parse $shortsha1)
>>>
>>> Why do you call it "optimization" when you spend two or three subprocesses
>>> instead of one?
>>
>> echo is a shell internal. "git rev-parse" is two processes just as
>> "cut" and a pipe.
> 
> My mistake, strace git rev-parse revals that this is only one process.
> Still, I think that saving a bunch of filesystem access beats saving
> one fork()... 

Not so on Windows.

But you must look at the repository in any case to avoid truncating the
SHA1 too much, as Thomas pointed out.

-- Hannes
