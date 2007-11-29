From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Wed, 28 Nov 2007 19:59:18 -0500
Message-ID: <474E0EE6.6070107@gmail.com>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>	<Pine.LNX.4.64.0711271617350.27959@racer.site>	<20071128000731.GD9174@efreet.light.src>	<7v8x4jb295.fsf@gitster.siamese.dyndns.org>	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXkp-0007Uw-RT
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759412AbXK2A72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759401AbXK2A72
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:59:28 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:58189 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753112AbXK2A71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:59:27 -0500
Received: by rn-out-0102.google.com with SMTP id s46so2573465rnb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 16:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=zdgIa8wbd1Q1fe5en2fqYLBRTSzO305e+AhmOUMH4oo=;
        b=rljng8ia1KPM1WFVzRSA7Lurh8q/z+7mUk0orAXIWNa2Zhc6M4MzbvcSOiOfrn6DgBtTezdBiiVJOPggtHCGjC/zXB01uauO2IcMa85JB5iPGLwEI3A+e4VO3lCxNXssiWClhm3dYp+UbsM0Y0XF/HeHiuW0JhFfwqn8IhJnmwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eujnLYF8XDVz4zzWLCriYG5UC/cSXrN/MRjtsTGhJkuzDFa/X0wR4TU/Rzl30ydGgR2h1j1ixWrSgPkmWsW3ue293qf3f1uxIG4/2tr7rCjw9qV1Gaz6C5g1EhG3I/ELJ0OYhQvtKXxDpNKqAE2yB7tzSQS7V2Jwt8KyE9dF/q4=
Received: by 10.70.72.11 with SMTP id u11mr562029wxa.1196297966282;
        Wed, 28 Nov 2007 16:59:26 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id i39sm7585730wxd.2007.11.28.16.59.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Nov 2007 16:59:25 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66481>

Junio C Hamano wrote:
[...]
> Would people agree with a rough roadmap like this?
> 
>  - v1.5.4 will ship with gitexecdir=$(bindir) in Makefile.  But the
>    release notes for the version will warn users that:
> 
>    (1) using git-foo from the command line, and
> 
>    (2) using git-foo from your scripts without first prepending the
>        return value of "git --exec-path" to the PATH
> 
>    is now officially deprecated (it has been deprecated for a long time
>    since January 2006, v1.2.0~149) and upcoming v1.5.5 will ship with
>    the default configuration that does not install git-foo form in
>    user's PATH.
> 
>  - Post v1.5.4, start cooking gitexecdir=$(libexecdir)/git-core, aiming
>    for inclusion in v1.5.5, perhaps in Mar-Feb 2008 timeframe.
> 
>  - The release notes for v1.5.5 will warn users that git-foo will be
>    removed in v1.6.0 for many commands and it will be merely an accident
>    if some of them still work.
> 
>  - Post v1.5.5, start cooking the change that does not install hardlinks
>    for built-in commands, aiming for inclusion in v1.6.0, by the end of
>    2008.

So long as there remains the option in the Makefile to install the 
"dashed" commands in $(bindir) for those of us that wish it.
