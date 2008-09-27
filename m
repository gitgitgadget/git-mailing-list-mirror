From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 4/4] cygwin: Use native Win32 API for stat
Date: Sat, 27 Sep 2008 20:33:50 +0400
Message-ID: <20080927163349.GE21650@dpotapov.dyndns.org>
References: <20080927084349.GC21650@dpotapov.dyndns.org> <347507080809270851y79764dbcgba1ef5a1d58bdd3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Sat Sep 27 18:35:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjcl7-00073b-Om
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 18:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbYI0Qd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbYI0Qd4
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 12:33:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:40766 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbYI0Qdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 12:33:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so953162fgg.17
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cHEbvpHFByo5a608pTHCb63N+M1XjNd8RyHFZKvzdYw=;
        b=diTZ0WS6fsCu8DTFQBsFU69Mdiz8icVQqxxyMb4hLaLz29G8qUzNbdGaVVNBlKQ4JN
         OHmbCSnoNdG1LvHNugnG5eoN6Gr+net2hq+cslp3pqr7pf8DY1V1HXquud6AetT7NgDJ
         5P5mjwZq+29KLDeRDQ7mSxSF8E6UFUBvg1NJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Nm5J4LoYvgvEWZRZCHJOpK4g3J5H1UBmH6W/zrLEfk/UZk5SPsM3Z3YYGJMrRjBOVD
         dWufUIPyfwLLSoPVB35EJiYz+xfMfHk14kUipTD73qJz1nN+DvDYoXYOjCMIRxAPxM6z
         hqAwOf+T69hspqkcFnr9pgcH8cmPsdU8/XcVY=
Received: by 10.86.1.1 with SMTP id 1mr2371393fga.61.1222533233704;
        Sat, 27 Sep 2008 09:33:53 -0700 (PDT)
Received: from localhost (ppp85-141-151-122.pppoe.mtu-net.ru [85.141.151.122])
        by mx.google.com with ESMTPS id 4sm365741fge.8.2008.09.27.09.33.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 09:33:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <347507080809270851y79764dbcgba1ef5a1d58bdd3e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96914>

On Sat, Sep 27, 2008 at 11:51:24AM -0400, Marcus Griep wrote:
> 
> Overall, looks good, though Alex's comment of using "cygwin.nativestat" may
> be a better descriptor for the config flag.

Perhaps... but I am not sure about policy for options in config file.
core.cygwinnativestat was proposed by Shawn, so I would like to hear
his opinion.

> I also think there is more refactoring that could be done, with there being
> common code paths still existing in MinGW and Cygwin.

I am not sure that there is much common code left: stat structures are
different in MinGW and Cygwin (different fields and their types), and I
do not think having one function with a lot of #ifdef __CYGWIN__ in it
is actual improvement. But you can send a patch on top of mine and let
other people decide if it is a worty goal.

Dmitry
