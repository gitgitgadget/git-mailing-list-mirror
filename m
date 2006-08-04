From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 10:50:48 -0400
Message-ID: <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 16:51:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G910p-000174-3w
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 16:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbWHDOuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 10:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWHDOuw
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 10:50:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:6277 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161247AbWHDOuv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 10:50:51 -0400
Received: by wr-out-0506.google.com with SMTP id i21so9294wra
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 07:50:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nxkXzRiVlLbBHHR1wgy7jwHAJHpNKuSyDJpaJ1yhLZlpVPtqP/K/KIpWKWP7seUzVljrEIuCWJEV3W+CCZfKiovC19jSxuUKyB3kOTsHnF1PK+XCQ71DrFLaj8jqv1hit2pmFHy05mWqayhbfJWFKew34ZgJcQzhbnupbb+6pAM=
Received: by 10.78.183.15 with SMTP id g15mr1566108huf;
        Fri, 04 Aug 2006 07:50:49 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Fri, 4 Aug 2006 07:50:48 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24792>

The whole problem with CVS import is avoiding getting IO bound. Since
Mozilla CVS expands into 20GB when the revisions are separated out
doing all that IO takes a lot of time. When these imports take four
days it is all IO time, not CPU.

Could repack-objects be modified to take the objects on stdin as I
generate them instead of me putting them into the file system and then
deleting them? That model would avoid many gigabytes of IO.

It might work to just stream the output from zlib into repack-objects
and let it recompute the object name.  Or could I just stream in the
uncompressed objects? I can still compute the object sha name in my
code so that I can find it later.

-- 
Jon Smirl
jonsmirl@gmail.com
