From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] mergetool: make Apple's FileMerge available as a merge_tool
Date: Sun, 17 Jun 2007 21:20:54 +0200
Message-ID: <42FEB11E-426D-4B44-9E7E-0E35032CB1B0@zib.de>
References: <11820959413590-git-send-email-prohaska@zib.de> <B12626B9-766E-4EA4-888F-B3E2DA889D15@zib.de> <20070617181200.GA15218@thunk.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 17 21:19:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I00Hu-0001cO-4g
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 21:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761339AbXFQTTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 15:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761208AbXFQTTs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 15:19:48 -0400
Received: from mailer.zib.de ([130.73.108.11]:51736 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760996AbXFQTTr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 15:19:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5HJJioE000333;
	Sun, 17 Jun 2007 21:19:44 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db117e6.pool.einsundeins.de [77.177.23.230])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5HJJh28012782
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 17 Jun 2007 21:19:43 +0200 (MEST)
In-Reply-To: <20070617181200.GA15218@thunk.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50366>


On Jun 17, 2007, at 8:12 PM, Theodore Tso wrote:

> On Sun, Jun 17, 2007 at 06:13:11PM +0200, Steffen Prohaska wrote:
>
>> I wasn't aware of this fact. git-mergetool proposed to use vimdiff
>> although I had preferred the graphical application FileMerge, which
>> would have been launched by opendiff.
>
> Do you know of a way of determining whether or not under MacOS X, a
> program can easily determine whether or not the user is sitting in
> front of the graphical display, as opposed to coming in via an SSH
> connection?

this might do the job:

--- SNIP ---
#! /bin/sh

pid=$$

while [ $pid -ne 1 ] ; do
     command=$(ps -p $pid | tail -n 1 | cut -b 27-)
     echo $command | grep -q sshd && { echo "ssh" ; exit ; }
     echo $command | grep -q Terminal && { echo "local" ; exit ; }
     pid=$(ps -O ppid -p $pid | tail -n 1 | cut -b 6-11)
done

echo "unknown"
--- SNIP ---


> If so, we could use that under MacOS to make the defaults be to use
> opendiff under those circumstances.
>
> Realistically, though, past a certain point we can only be so smart
> with the heuristics.  If you know what you want, you should really set
> the merge.tool config option in your ~/.gitconfig file, and be done
> with it.

Well, I'm done with it. I learned that opendiff and FileMerge are the
same, which I wasn't aware of before.


>> Don't know if my patch makes any sense. Probably a note in the
>> documentation that opendiff launches the GUI would be nice.
>
> Maybe a change so that opendiff is listed as "opendiff (aka
> FileMerge)", perhaps?

perhaps. It wouldn't make things worse.

	Steffen
