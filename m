From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Problem compiling git-1.6.4 on OpenServer 6.0
Date: Fri, 07 Aug 2009 16:36:02 -0500
Message-ID: <DHem56NUSFhg2VqQu1N0qVr3U86qJOp4OZZAEwV2Edz0-YuWJpDtgA@cipher.nrlssc.navy.mil>
References: <alpine.LNX.2.00.0908071326250.13290@suse104.zenez.com> <cY-iS6BS6knyjPKeVQI3ZIsIw3A3y5VK1oW-MNzUUztRn8CbeqRdew@cipher.nrlssc.navy.mil> <alpine.LNX.2.00.0908071523550.13290@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 23:36:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZX6o-0004T6-RS
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 23:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbZHGVgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 17:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753843AbZHGVgI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 17:36:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49420 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbZHGVgH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 17:36:07 -0400
Received: by mail.nrlssc.navy.mil id n77La3WQ004827; Fri, 7 Aug 2009 16:36:03 -0500
In-Reply-To: <alpine.LNX.2.00.0908071523550.13290@suse104.zenez.com>
X-OriginalArrivalTime: 07 Aug 2009 21:36:03.0139 (UTC) FILETIME=[10261930:01CA17A7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125229>

Boyd Lynn Gerber wrote:
> On Fri, 7 Aug 2009, Brandon Casey wrote:
>> Boyd Lynn Gerber wrote:
>>> I just tried to compile the latest git and I get this error.
>>>
>>> CC builtin-pack-objects.o
>>> UX:acomp: ERROR: "builtin-pack-objects.c", line 1602: integral constant
>>> expression expected
>>> gmake: *** [builtin-pack-objects.o] Error 1
>>>
>>> I will look into it when I have a bit more time, but this is a heads up.
>>
>> Did you set THREADED_DELTA_SEARCH=1 when you compiled?  That could be the
>> problem.
>>
>> Line 1602 of builtin-pack-objects.c is wrapped in #ifdef
>> THREADED_DELTA_SEARCH,
>> so it is only compiled if THREADED_DELTA_SEARCH has been set.  Also,
>> it's not
>> a new line, it has been around since 2007.
> 
> Removing it and the -pthread allows it to build.  I am now running the
> tests.  The I need to find out why it is being set.

Did you run configure?  which generates a config.mak.autogen file?
There were some changes related to pthreads in configure.ac in March,
and another back in Nov 2008.  Specifically commits 1973b0d7, and
d937c374.

-brandon
