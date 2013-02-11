From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-bisect.txt: clarify that reset finishes bisect
Date: Mon, 11 Feb 2013 09:04:02 +0100
Message-ID: <5118A5F2.6000007@drmicha.warpmail.net>
References: <5e23d4c420f150b700dd5100bffb38d32f874200.1360439176.git.git@drmicha.warpmail.net> <20130210014900.GA7682@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andreas Mohr <andi@lisas.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 09:04:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4oNW-0004V6-GF
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 09:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab3BKIEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 03:04:06 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52799 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181Ab3BKIEC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2013 03:04:02 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 782C720B1B;
	Mon, 11 Feb 2013 03:04:01 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 11 Feb 2013 03:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=V37EXmjj68BLmEfiAdGv30
	AYOUg=; b=ZXZ1PROJFZsa7ZMDY9dmyTUgG8UoRuBpBC5/4OPY1a/I6KSyDAqGaT
	Kp60sd8akQfDo+KAu3Wk8u1iw87aITm5mQPPpqE4o/8IdNQverxdtngBzK00CxZ3
	MI/e0tXIbSQW8eItzF+UZjtgrOnJk2DTVV3exoOIp0dJlVkxKyN6I=
X-Sasl-enc: qMrgN0K2YZNvBGaHnWyrrZRnEOee3LqGq2XCA6tpmEtL 1360569841
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C0AA98E097E;
	Mon, 11 Feb 2013 03:04:00 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130210014900.GA7682@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216022>

Jonathan Nieder venit, vidit, dixit 10.02.2013 02:49:
> Hi,
> 
> Michael J Gruber wrote:
> 
>> "reset" can be easily misunderstood as resetting a bisect session to its
>> start without finishing it. Clarify that it actually finishes the bisect
>> session.
> 
> FWIW,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Addressing Andreas's original concern about the discoverability of
> 'git bisect reset' would presumably require doing two more things:
> 
>  1. adding an example of the normal bisection workflow to the EXAMPLES
>     section
> 
>  2. training users to look to the EXAMPLES section
> 
> That is, something like the below.  But I'm not happy with it, because
> it just runs over the same material as the current Description
> section.  Maybe the current tutorial material could be moved to
> examples and replaced with something terser that fleshes out the
> descriptions in "git bisect -h" output.  What do you think?
> 
> diff --git i/Documentation/git-bisect.txt w/Documentation/git-bisect.txt
> index e4f46bc1..b89abd78 100644
> --- i/Documentation/git-bisect.txt
> +++ w/Documentation/git-bisect.txt
> @@ -356,6 +356,54 @@ $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
>  This shows that you can do without a run script if you write the test
>  on a single line.
>  
> +* Bisect to find which patch caused a boot failure:
> ++
> +Install a recent kernel:
> ++
> +------------
> +$ cd ~/src/linux
> +$ git checkout origin/master
> +$ make deb-pkg # or binrpm-pkg, or tar-pkg
> +$ dpkg -i ../<name of package> # as root (or rpm -i, or tar -C / -xf)
> +$ reboot # as root
> +------------
> ++
> +Hopefully it fails to boot, so tell git so and begin bisection:
> ++
> +------------
> +$ cd ~/src/linux
> +$ git bisect start HEAD v3.2 # assuming 3.2 works fine
> +-------------
> ++
> +A candidate revision to test is automatically checked out.
> +Test it:
> ++
> +-------------
> +$ make deb-pkg # or binrpm-pkg, or tar-pkg
> +$ dpkg -i ../<name of package> # as root (or rpm -i, or tar -C / -xf)
> +$ reboot # as root
> +-------------
> ++
> +Record the result:
> ++
> +-------------
> +$ cd ~/src/linux
> +$ git bisect good # if it booted correctly
> +$ git bisect bad # if it failed to boot
> +$ git bisect skip # if some other bug made it hard to test
> +-------------
> ++
> +Repeat until bored or git prints the "first bad commit".  When
> +done:
> ++
> +-------------
> +$ git bisect log >log # let others pick up where you left off
> +$ git bisect reset HEAD # exit the bisecting state
> +-------------
> ++
> +At any step, you can run `git bisect visualize` to watch the
> +regression range narrowing.
> +
>  * Locate a good region of the object graph in a damaged repository
>  +
>  ------------
> 

[BTW, sorry for failing to set --in-reply-to in the patch e-mail. Need
to get that automated somehow.]

I did not use "stop" for the exact reasons that Junio mentioned. Just
throw in a third alternative: "quit" may convey that it's not possible
to ressume, without sounding as "exceptional" as "abort" does. After
all, it's the normal end to a bisect session much unlike "--abort" for
rebase, for example.

As for the example, we have an example section, and we could simply
throw in "git reset" lines there. I would even amend my patch with that;
the great git-bisect.txt refactoring I'd definitely leave to someone else.

Michael
