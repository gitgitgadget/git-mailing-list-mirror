From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #02; Mon, 14)
Date: Tue, 15 Oct 2013 13:05:28 -0700
Message-ID: <20131015200528.GE9464@google.com>
References: <20131014184524.GW9464@google.com>
 <20131015001231.GA9464@google.com>
 <xmqqiowye66r.fsf@gitster.dls.corp.google.com>
 <20131015191656.GD9464@google.com>
 <525D9A96.6050209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Anders Kaseorg <andersk@MIT.EDU>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 15 22:05:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWAs4-0007z4-F6
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 22:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759608Ab3JOUFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 16:05:32 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:59261 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759439Ab3JOUFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 16:05:31 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so9318221pbc.9
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2bZxWjeIJeXZdqT09/Ibt+SM4xLV0mWNqYMVkVr/e+k=;
        b=bdW3gMJ/LEfr3l3CkTXlG+v7Kr0e7D3bO6gyHMgQh7t7a+YGE+pmPT0G3EVfPFV0yq
         BTjBgVbn45l0eRBTFacgoZbIIUVKN1L2YQ3Q/oPfqXcGuZei9cYzblln12bX+ComrsIB
         OReXCrQFLCHB2IT5R8wr7TZoT6bHqyXlLxePRGTg58/EcewnWXNEE5ydh+SGWNKUtiUn
         da6Mql9CCIhL/z1M4hSMZY75+i/DpYhQhQ5hzPv7Uu6gp+vWY0xZRb6gsTjBn2KKMH6Q
         BxhkMYUllvgW598gnF4U01zOyOgyJdiQepUaQm1thHI985qzjkxIDcD5O2AbPWZqemC/
         TdKw==
X-Received: by 10.68.125.198 with SMTP id ms6mr40994099pbb.98.1381867531483;
        Tue, 15 Oct 2013 13:05:31 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 7sm101120963paf.22.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 13:05:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <525D9A96.6050209@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236198>

Jens Lehmann wrote:
> Am 15.10.2013 21:16, schrieb Jonathan Nieder:

>> So I suspect this will fix more scripts than it breaks, though it may
>> still break some. :/
>
> Hmm, I'm really not sure if we should do this or not.

What convinced me was Anders's observation that the current behavior
can have very bad consequences if a script is passing untrusted input
in multiple arguments to git submodule foreach.

I still haven't found any examples that pass input intended for the
shell to git submodule foreach in multiple arguments.  I suspect no
one will notice, except that some scripts (like libreoffice's "g")
start to work better when passed arguments containing shell
metacharacters.

> And maybe only change that on a major version bump where people should
> not be terribly surprised about such a change in behavior and are more
> likely to read release notes?

Ok with me, but please don't make it 2.0. :)

[...]
>                                                                E.g. at
> $dayjob we have foreach commands running in the shell execution for
> quite some jobs on our Jenkins server; nobody would see any warnings
> there until we'd have the reason to dig deeper int the logs because
> something breaks.

Yes, I think that's typical.  Warning to stderr probably wouldn't
help.

Thanks,
Jonathan
