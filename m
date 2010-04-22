From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 10:03:25 -0500
Message-ID: <20100422150325.GB4801@progeny.tock>
References: <20100421195822.GX10984@baikonur.stro.at>
 <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
 <20100422121408.GI3211@stro.at>
 <20100422124042.GA1433@progeny.tock>
 <m2hbn37e7q.fsf@igel.home>
 <20100422144433.GB28923@coredump.intra.peff.net>
 <20100422145455.GC28923@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	maximilian attems <max@stro.at>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 17:10:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4y2e-00074o-3k
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 17:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab0DVPKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 11:10:01 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63074 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab0DVPKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 11:10:00 -0400
Received: by pvh1 with SMTP id 1so440184pvh.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bmYDWPjya6IyQrPNeq5yauY9LUSnYi4PaxEbO+IZLJM=;
        b=Ta0T/eO8A2pfX0Kj+U+opNa4+icVJ+ll3BSA0vt5qnsd1SSbpxhj97P5IozZWDTomI
         G76Gx30VJP2r0tU+ssaflM0Sap9XvkN4g6aFuGDSAZ1x0r52KLVI7AtIi6bSyBzeiLYG
         ew5K38/7duvPbq4Qcds1VLZ6p0Elim+BxrF8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hQNJrmi7LMnFMXXPpc/fjjMpxloUdCeJ8EAqBfV+nIoV595++UqEyyU+Q81AxijTg4
         eGvLLdYyjDMFOx4JddvIEEmdK3zrGIGV+0MAXAZm8fuWs2GNXGorwUUXb7bKoOW3LKeX
         LiwJl2xgKUxh6YQqpiqWJrGvgS2Ee6LRpiadI=
Received: by 10.142.250.1 with SMTP id x1mr138848wfh.109.1271948592812;
        Thu, 22 Apr 2010 08:03:12 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v41sm22400wfh.21.2010.04.22.08.03.10
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 08:03:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100422145455.GC28923@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145539>

Jeff King wrote:

> Still looking, but definitely some kind of skew problem.

That explains it, then:

$ git log --format=%cd' %h' 19f5fb7 ^v2.6.34-rc1~200
Sun Jan 24 14:34:07 2010 -0500 19f5fb7
Mon Dec 7 10:36:20 2009 -0500 d2eecb0
Fri Jan 1 01:00:21 2010 -0500 f8ec9d6
Wed Dec 23 07:45:44 2009 -0500 71f2be2
Fri Jan 22 17:40:42 2010 -0500 1f2acb6
Mon Feb 15 20:17:55 2010 -0500 15121c1
Thu Feb 4 23:58:38 2010 -0500 a1de02d

This part of the history is linear.

Is the rule that every commit must be at most one day before each of
its parents?  This should probably be documented somewhere, since it
is possible to override the committer date with GIT_COMMITTER_DATE.

Jonathan
