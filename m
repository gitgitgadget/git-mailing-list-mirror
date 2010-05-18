From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitk (or tcl/tk) slow to start?
Date: Tue, 18 May 2010 09:04:09 +0200
Message-ID: <4BF23BE9.7010401@drmicha.warpmail.net>
References: <19441.8527.606063.296769@winooski.ccs.neu.edu>	<4BF12DA6.9090709@drmicha.warpmail.net> <19441.64268.762782.215315@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue May 18 09:04:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEGqk-0005vJ-9a
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 09:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709Ab0ERHER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 03:04:17 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34961 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754364Ab0ERHEQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 03:04:16 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ED4DEF7557;
	Tue, 18 May 2010 03:04:05 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 18 May 2010 03:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=EqYPTaOsMxmQ6Nz2Udl0S96bwSo=; b=O7lO9U/UvCtFBZ5cNVdFIe67c4AJM2vm9C7NIsoiareJ839TAE9lq6xyWJvnvTXQRQatuFVrIym+x9yflGe4rmFWIXK5On3y3q6QKy3GTdrup47Oz6sPUAlow8o2fHPK4DRiJzCbc/BQe45ISJZEQGu46jtBvmH0zjLdja0ZIlE=
X-Sasl-enc: BCJZEpO0tQtI8zMnavIsrWcXn1/qc0WMUQQArBFZZ+lD 1274166241
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6E67D4D09E7;
	Tue, 18 May 2010 03:04:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <19441.64268.762782.215315@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147272>

Eli Barzilay venit, vidit, dixit 18.05.2010 04:27:
> On May 17, Michael J Gruber wrote:
>> Eli Barzilay venit, vidit, dixit 17.05.2010 12:58:
>>> Every time I run gitk when I didn't use it for a while, it takes a
>>> long time to start (more than 30 seconds) with no visible cpu load.  I
>>> tried to strace it, and the result shows that the time is spent
>>> stat()ing my whole /usr/lib directory:
>>>
>>>   ...
>>>   stat("/usr/lib/libelf-0.131.so", {st_mode=S_IFREG|0755, st_size=87496, ...}) = 0
>>>   stat("/usr/lib/libungif.so.4", {st_mode=S_IFREG|0755, st_size=2444, ...}) = 0
>>>   stat("/usr/lib/libtiff.so.3.8.2", {st_mode=S_IFREG|0755, st_size=360268, ...}) = 0
>>>   ...
>>>
>>> Is this expected?  Anything that can be done to avoid it?
>>
>> I don't expect stat'ing /usr/lib to take 30s. How large is it (file
>> size and count)?
> 
> I've done some more counting -- the most number of system calls (as
> tracked by strace) are 2968 reads, 4582 lstats, and 6520 stats.  And
> it looks like it's recursively scanning /lib, /usr/lib, and /usr/share
> for all *.tcl files.  stracing `wish' shows 11000 l/stats -- so I
> guess that the problem is there and not in gitk.  Trying wish on a
> fedora 12 machine, I see only ~350 {,f,l}stat64 calls, and gitk starts
> as fast as I'd expect it to.
> 
> Oh well, I was hoping that someone knows some bit that needs flipping
> or updating to get it to work faster -- I guess it's one more reason
> to finally upgrade the F7 machine...
> 

I guess that was truly wish-ful thinking :)

[You can try and recompile an F12 wish.srpm on F7, of course.]

Sorry,
Michael
