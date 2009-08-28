From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 18:01:28 -0400
Message-ID: <4A9853B8.2090709@gmail.com>
References: <4A97193A.8090502@facebook.com> <20090828060538.GA22416@coredump.intra.peff.net> <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com> <20090828150212.GA6013@coredump.intra.peff.net> <81b0412b0908281000l41c862f9ye52da7251014c4f7@mail.gmail.com> <20090828171552.GA6821@coredump.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 29 00:01:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh9Vu-0000Hh-EF
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 00:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbZH1WBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 18:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbZH1WBd
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 18:01:33 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:61797 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZH1WBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 18:01:32 -0400
Received: by gxk1 with SMTP id 1so2883662gxk.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=V/QqX/qSgXY8+sCUwki/9mdg4IsicvUeGFO/vY4q2Zo=;
        b=ZTtPu7ztd4HGBSBpb5HEbG/kwXfd841CWMoKqcuKO1XW4e7bS2Kfp0licYhsyZeZpB
         K8ICLvYwgt9vyuVOfA9HzFRkOVvG6x4rebkoso5Jx3sl/VUStlCzUSnhmTDL+avhzDpR
         UIR0UFBLJKqVtUgiK7JkfQMqLpmSmsO/QXEcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=HsIoCTo8wX0Wc5tUQ0WZmo2jp9K3d43HZRX9We737UqJl/usi4S2uDnixjIV8ozUty
         FihQ6IVTFM13hMLy23yxpZWqBvAtXF0JAo4ZRh1Ib6jFkrJE61ikmKut8hxjg0Gdnyol
         68f8NWqohRlTO05+vKCqb0dL7riGsB76WEMJ8=
Received: by 10.90.166.2 with SMTP id o2mr1287484age.93.1251496894273;
        Fri, 28 Aug 2009 15:01:34 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 34sm3832320agc.71.2009.08.28.15.01.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 15:01:33 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20090828171552.GA6821@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127356>

Jeff King wrote:
> On Fri, Aug 28, 2009 at 07:00:59PM +0200, Alex Riesen wrote:
> 
>> On Fri, Aug 28, 2009 at 17:02, Jeff King<peff@peff.net> wrote:
>>> But that's the point: you can't do that without a race condition. Your
>>> test gets a sense of the current time, then runs git, which checks the
>>> current time again. How many seconds elapsed between the two checks?
>> How _many_ do you need?
> 
> I don't understand what you're trying to say. My point is that if you
> are checking results to a one-second precision, you need to know whether
> zero seconds elapsed, or one second, or two seconds, or whatever to get
> a consistent result.

To no-one in particular, Gitzilla mumbles "To do this right(tm) would 
probably require LD_PRELOAD magic with a environment variable invocation.
