From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] t/README: hint about using $(pwd) rather than $PWD
 in tests
Date: Tue, 11 Jan 2011 02:37:29 -0600
Message-ID: <20110111083729.GD9445@burratino>
References: <201012302205.13728.j6t@kdbg.org>
 <201012311711.06989.j6t@kdbg.org>
 <20101231203019.GC5898@burratino>
 <201012312321.31294.j6t@kdbg.org>
 <7v62u8hz01.fsf@alter.siamese.dyndns.org>
 <4D2C09D7.3070700@viscovery.net>
 <4D2C0A5E.7090708@viscovery.net>
 <20110111075441.GB9445@burratino>
 <4D2C11A5.4050709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 09:37:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcZjd-0005s1-Tf
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 09:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab1AKIhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 03:37:41 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56324 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab1AKIhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 03:37:39 -0500
Received: by gxk9 with SMTP id 9so5250535gxk.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 00:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=i/6LvVm/nu1eRyzg4jxLXuWlwXAqGFXBMKBpEq+hAPU=;
        b=N/mFslgkfeNstqGt0EcmynGrL0A8aNPH/tckFFU5/VVfkjN0/dlJ0WbB9Bjh+GEX9f
         iITmj61U/HpmnRdFTNBKZVOyD6EvZkGlyCzY/9LF6STGKUvF+r8PXQ9kTj0kWUq9FOXt
         9T1RYy6QnhA3qwVluiMMR4ERSSj1ejG0yy76E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Hec26QrdfiN3slhB+NMDhRX1hrSYSehW+Ly66NsmPXjoq3JpmrGC9o+s4jzOTVbFGu
         5oo7XccIkrlr+qn9wnad5rkSz5aR8TEkvuoWGfTtPlsK9R8o92C9vYuORM+x9MW4UTh+
         i8NUR2SBMzuukTG7XkMHPJkJsQI0h4JPbXRaA=
Received: by 10.91.182.17 with SMTP id j17mr7253613agp.105.1294735059297;
        Tue, 11 Jan 2011 00:37:39 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id 54sm17836304yhl.32.2011.01.11.00.37.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 00:37:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2C11A5.4050709@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164920>

Johannes Sixt wrote:
> Am 1/11/2011 8:54, schrieb Jonathan Nieder:

>> Perhaps it is also worth explaining the cases where $PWD is needed?
>>
>> 	By contrast, when a passing a path to git or constructing a URL,
>> 	use $PWD.
>
> The first part of the "or" is not true: you can pass the result of $(pwd)
> to a command, and it means the same as $PWD; I would even recommend
> against $PWD so that a reader does not have to wonder "why pass $PWD, but
> check for $(pwd)?"

I _think_ that passing $PWD always gives the right result.  By
contrast, constructions like

	PATH=$(pwd)/bin:$PATH

break iirc.

I suspect that the reader will end up wondering "why does this have to
be so complicated" no matter what.

> The second part I don't know whether it is true: I haven't noticed a
> pattern where people did it the wrong way, therefore, I'don't even know
> whether $PWD is really *always* required. Do *you* know?

24f1136 is one example.  I don't know of any utility that treats

	file://c:/foo/bar/baz

as a URL representing a resource on localhost (and msys bash has no
rewriting rule for it), so in that particular case
(file://$directory), $PWD really does seem to be always required.

>>       It makes a difference on Windows, where
>>
>> 	 - $(pwd) is a Windows-style path such as git might output, and
>> 	 - $PWD is a Unix-style path that the shell (MSYS bash) will
>> 	   mangle before passing to native apps like git.
>
> This information is already included by reference to 4114156ae9.

... but if we can summarize it nicely, we can save the reader a
step, no?

Anyway, what you have already written is useful; clearing up these
details would just be icing on the top.
