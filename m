From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Thu, 11 Sep 2008 08:59:29 +0100
Message-ID: <e2b179460809110059i2eca8b07x6d263f06cc8e5d32@mail.gmail.com>
References: <20080907184537.GA4148@regex.yaph.org>
	 <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>
	 <20080910100301.GA27748@regex.yaph.org>
	 <e2b179460809100453r3df4ec8dh3d9bfbbd468c5676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Arjen Laarhoven" <arjen@yaph.org>,
	"Johannes Sixt" <j.sixt@viscovery.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 10:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdh6U-0004LL-86
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 10:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYIKH7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 03:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbYIKH7c
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 03:59:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:50852 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbYIKH7b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 03:59:31 -0400
Received: by rv-out-0506.google.com with SMTP id k40so241015rvb.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JYWJMoKP+qUV9m62MTw4uwvGDbi3tj5+JArCpcaDdng=;
        b=jdDOL54TPYzTyAfkX4RNWEAA6ONx11pupST+OYCBTc/6VchshGRVVuv/ZIJp2547uO
         PBbZsTRH3HrM16QLcZRyw66b5RFrlX3UmymhRZF2DH56Ct++f4zBBg93Qml7rSGdFURf
         wOeDGg5OpBhyDvpoCmz5ibNp4eqwURAtJ1eA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KKKRRoSGTvfe32vAdMTq2hQM0xGEzJRMDeGGmyZxZJywGOxqUoombXfeTb8wuWiIE6
         l26f3VVqg7/ruYtaqDKxIZcR5OECx8oFV3zgqMYi1cYDG5XtylEsO3eW1xYSEQ0NdG9n
         gcPGCCZfUCu4hFbJWaq6Dl1vPx+02ZbfAJHJY=
Received: by 10.140.203.9 with SMTP id a9mr1512113rvg.288.1221119969889;
        Thu, 11 Sep 2008 00:59:29 -0700 (PDT)
Received: by 10.140.143.2 with HTTP; Thu, 11 Sep 2008 00:59:29 -0700 (PDT)
In-Reply-To: <e2b179460809100453r3df4ec8dh3d9bfbbd468c5676@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95591>

2008/9/10 Mike Ralphson <mike.ralphson@gmail.com>:
> 2008/9/10 Arjen Laarhoven <arjen@yaph.org>:
>> On Wed, Sep 10, 2008 at 09:03:05AM +0100, Mike Ralphson wrote:
>>> 2008/9/7 Arjen Laarhoven <arjen@yaph.org>
>>> > The standard libc regex library on OSX does not support alternation
>>> > in POSIX Basic Regular Expression mode.  This breaks the diff.funcname
>>> > functionality on OSX.
>>> >
>>> > Also, I'm sure the problem occurs on more non-Linux systems (or non
>>> > GNU libc systems).  If people who have access to those systems (BSD's,
>>> > HP-UX, AIX, etc) can test it, I'd be happy to add those systems to the
>>> > patch so it can fix for multiple systems at once.
>>>
>>> I can confirm that the issue shown up by your new testcase is also
>>> present in AIX 5.3.
>
>>> Adding -lcompat/regex to COMPAT_CFLAGS as per your Darwin hunk
>>> provokes lots of warnings:
>>
>> I think your problem is a lowercase ell instead of an uppercase i ;-)
>
> Doh. I think my problem is this font! And having not used a language
> with a separate linker since last century.
>
> I guess I picked a really bad patch to try and pick up and test direct
> from gmail. No reflection on your patch, just my workflow.
>
> Having carefully checked the content of the testcase too, I can now
> say this does fix the issue without extra warnings or testcase
> failures on AIX 5.3, so for what it's worth:
>
> Tested-by: Mike Ralphson <mike@abacus.co.uk>

Junio, sorry, I should have made this clear, but as above in the
thread, Johannes Sixt's 'patchlet' is required to be squashed into
3632cfc24, and I think Arjen was going to re-roll the patch.

I can submit the required follow-up, but it really should have J6's S-o-b.

Mike
