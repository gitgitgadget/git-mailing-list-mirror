From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGit bug] git user settings not retrieved when launched for
 Windows explorer
Date: Tue, 07 Oct 2008 19:08:14 +0200
Message-ID: <48EB977E.1030401@lyx.org>
References: <48EB10C8.4070009@lyx.org>	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>	 <48EB49B3.1090509@lyx.org>	 <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>	 <48EB56BA.5020502@lyx.org> <e5bfff550810070948p6a9b2fdcq51f2b1580cef2f4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 19:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnG3y-00071Z-DC
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 19:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbYJGRIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 13:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbYJGRIX
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 13:08:23 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:55902 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbYJGRIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 13:08:23 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id D8440B02F1;
	Tue,  7 Oct 2008 19:08:21 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 6C1A2B0220;
	Tue,  7 Oct 2008 19:08:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <e5bfff550810070948p6a9b2fdcq51f2b1580cef2f4e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97729>

On 07/10/2008 18:48, Marco Costalba wrote:
> On Tue, Oct 7, 2008 at 2:31 PM, Abdelrazak Younes<younes@lyx.org>  wrote:
>    
>> No, 'git config user.name' works fine in any directory, even on the naked
>> Windows console (I mean without msys bash). So that must be something else.
>> I've traced it down to
>> MyProcess::on_finished().
>>
>>     isErrorExit =   (exitStatus != QProcess::NormalExit)
>>                  || (exitCode != 0&&  isWinShell)
>>                  || !errorDesc.isEmpty()
>>                  ||  canceling;
>>
>> At this point we have:
>> exitStatus = NormalExit
>> exitCode = 1
>> isWinShell = false
>> errorDesc.isEmpty() returns true
>> canceling = false
>>
>> Which gives 'isErrorExit = false'. I wonder if the isWinShell test is
>> correct?
>>
>>      
>
> Hi Abdel,
>
> I would think it is correct to return isErrorExit == false
>    

OK.

> The problem is that it seems git config return empty data if run from
> outside git directory...isn't it ?
>    

No, as I said, 'git config user.name' is working just fine outside git 
directory.

Abdel.
