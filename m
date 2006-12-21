From: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 21:52:09 -0500
Message-ID: <787b0d920612201852u62bb43ebs82d9129a849b0e50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 03:52:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxE2Z-0001qt-CP
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 03:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbWLUCwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 21:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbWLUCwM
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 21:52:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:9658 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161162AbWLUCwL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 21:52:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2460185uga
        for <git@vger.kernel.org>; Wed, 20 Dec 2006 18:52:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MriH0/wdcr2ULOfvrucQhsCV2cRu+oWBm0aMXTdOJESz8hvYaBmW+RLVo+iyoz2H/LBM7bdcg3LRz1yrp+WM3wRlZeIth/Cz2D7Uq4ILWc7FqjHetM5uiy08zb+Z7JXZtYkpDiXbjpsjQgayvsQukK3rjS6VdremoNVGM0/A2Eo=
Received: by 10.78.139.1 with SMTP id m1mr75727hud.1166669529762;
        Wed, 20 Dec 2006 18:52:09 -0800 (PST)
Received: by 10.78.201.13 with HTTP; Wed, 20 Dec 2006 18:52:09 -0800 (PST)
To: junkio@cox.net, merlyn@stonehenge.com, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35010>

Linus Torvalds writes:

> So it would appear that for OS X, the
>
>       #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>       #define _GNU_SOURCE
>       #define _BSD_SOURCE
> sequence actually _disables_ those things.

Yes, of course. The odd one here is glibc.

Normal systems enable everything by default. As soon as you
specify a feature define, you get ONLY what you asked for.
I'm not sure why glibc is broken, but I suspect that somebody
wants to make everyone declare their code to be GNU source.
(despite many "GNU" things not working on the HURD at all)

Define _APPLE_C_SOURCE to make MacOS X give you everything.
