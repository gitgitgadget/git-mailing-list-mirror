From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Git-1.6.0.2-preview20080921 on Windows
Date: Mon, 22 Sep 2008 07:46:35 +0200
Message-ID: <568A44C2-97A5-4DF4-8B45-36BE175E7782@zib.de>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de> <bb6f213e0809211119t3c2bc6e8x3342bd33bef38916@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 07:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KheKW-000406-NS
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 07:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbYIVFqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 01:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYIVFqY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 01:46:24 -0400
Received: from mailer.zib.de ([130.73.108.11]:45574 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbYIVFqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 01:46:24 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8M5kEwj004351;
	Mon, 22 Sep 2008 07:46:20 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9004c.pool.einsundeins.de [77.185.0.76])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8M5kDgD015750
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 22 Sep 2008 07:46:14 +0200 (MEST)
In-Reply-To: <bb6f213e0809211119t3c2bc6e8x3342bd33bef38916@mail.gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96448>


On Sep 21, 2008, at 8:19 PM, Alexander Gavrilov wrote:

> On Sun, Sep 21, 2008 at 9:30 PM, Steffen Prohaska <prohaska@zib.de>  
> wrote:
>> Git-1.6.0.2-preview20080921 for Windows is available at
>>
>>   http://code.google.com/p/msysgit/downloads
>>
>> The version installed is based on Junio's current  
>> 'maint' (cc185a6a8a)
>> plus the patch series I sent today, see
>>
>>  http://article.gmane.org/gmane.comp.version-control.git/92605
>>
>> The new installer is not yet featured on the msysgit homepage,  
>> because
>> the installer contains the new "libexec/git-core" layout, which has  
>> not
>> been tested much.  I'll wait a few days to see if the new layout  
>> works.
>> If hear nothing bad, I'll move the "Featured" flag to 1.6.0.2.
>
> You forgot to merge my build of the Cygwin kill utility for MSys.
> Available here:
>
> http://repo.or.cz/w/msysgit.git?a=log;h=refs/heads/mob

Apologies.  I'll include it in the next release.


> Also, when I start git-gui from an empty repository, or try to amend
> the root commit, I get:
>
[...]
>
> I get the same error if I simply run 'git mktree' as well.


This is fixed by:

diff --git a/mktree.c b/mktree.c
index e0da110..9545c96 100644
--- a/mktree.c
+++ b/mktree.c
@@ -70,6 +70,9 @@ int main(int ac, char **av)
         unsigned char sha1[20];
         int line_termination = '\n';

+       if (argv[0] && *argv[0])
+               git_extract_argv0_path(argv[0]);
+
         setup_git_directory();

         while ((1 < ac) && av[1][0] == '-') {


I'll create an updated installer soon.

	Steffen
