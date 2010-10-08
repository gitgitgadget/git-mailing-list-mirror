From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fatal: BUG: dashless options don't support arguments
Date: Thu, 7 Oct 2010 22:18:18 -0500
Message-ID: <20101008031818.GC992@burratino>
References: <AANLkTi=xscHHPTBtTJ3uXPO9y9gpQTBF4AWTe47C9njU@mail.gmail.com>
 <AANLkTikqB-EvE6uxgBmutssJoiH2RiPjSxtjbo++Jj-X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Christopher Cameron <christopher.cameron@live.com>,
	Henrik Tidefelt <tidefelt@isy.liu.se>
To: Brian Zitzow <bzitzow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 05:21:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P43Wl-00053G-Ij
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 05:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab0JHDVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 23:21:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47437 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab0JHDVb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 23:21:31 -0400
Received: by yxp4 with SMTP id 4so204758yxp.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MIqfGQO0b23ukUwpI/2FoH8tUWs3ATCVl+WblXWYYso=;
        b=pxJK357tIefd6dWr6O/tcS65p94DneotmGexAkLH9iJkWbTOYDJg0PSqPo7KD5eB2s
         CnTHYVsdxR9RUTo/ZQ6J0kUs/1YIkuu3MOLUPQGMM0kuXwg3oMoJl7z+1d105icMe0u/
         LKh7FfZgTnSb0WxhaZ3YHGYbdXBvpDMxOFaQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HZgrf74hovu4L3oQNoqwr5Dxt3bH0HfcDGipsUyWlFVOW1G9+nA2vz8CSf7fym1nIi
         XwkVExSJLbqYtV2SVr3i70eRz/tkpeFrjWlMUv4j3pRgIRorkuo8GbQ5FyMVpyZj26jW
         NAE+JJAn8eH6hRDBxTk14UrX6R4VtLaoLpvog=
Received: by 10.236.103.137 with SMTP id f9mr3600062yhg.77.1286508090531;
        Thu, 07 Oct 2010 20:21:30 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 75sm1948006yhl.33.2010.10.07.20.21.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 20:21:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikqB-EvE6uxgBmutssJoiH2RiPjSxtjbo++Jj-X@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158471>

[Context:
http://colabti.org/irclogger/irclogger_log/git?date=2010-10-06
http://thread.gmane.org/gmane.comp.version-control.git/128066/focus=145945 ]

Hi Brian,

Brian Zitzow wrote:

> Ki:$ git checkout master
> fatal: BUG: dashless options don't support arguments

Strange indeed.  Here's what I would suggest:

1. For debugging output:

 $ echo 'prefix=/usr/local' >>config.mak; # or whatever prefix you use
 $ git describe
 $ gcc --version
 $ wget 'http://download.gmane.org/gmane.comp.version-control.git/128067/128068'
 $ git am -3 128068
 $ make
 $ bin-wrappers/git checkout m

2. To track down the issue, if you like to read assembler:

 $ make builtin/checkout.s
 $ vi checkout.s

Good luck,
Jonathan
