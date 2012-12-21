From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: recommendation for patch maintenance
Date: Fri, 21 Dec 2012 22:30:57 +0100
Message-ID: <50D4D511.4010003@gmail.com>
References: <50D475EF.6060303@gmail.com> <7vvcbv1grr.fsf@alter.siamese.dyndns.org> <50D49C81.5060007@gmail.com> <7vip7v1d96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:31:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmABn-0006f4-4K
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 22:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab2LUVbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 16:31:12 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:45593 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab2LUVbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 16:31:11 -0500
Received: by mail-ee0-f43.google.com with SMTP id e49so2720476eek.16
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 13:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=e2ZNkknt/T/mj0FBU6LKMZ3AxHOqZlsniahPlSDBfXE=;
        b=yGf1Cs79z5wj8Uxh8al7Ff+4LJ8u9KW67+fLZ+Qk8BeYaLJ7Nuiu0VsSkyfEYsfEna
         fI8TXIGI/S/eO27rX+oGhX/flHW3ScaZDRvqDdePeERILC8gcK5BfhdbIanUCw/gDqhB
         rolfZjiu09hz2ZYTCdtH5K+i8eM+uHFDhmmmsLaXMvnReSPHf/MCw3k3RBnjSKw5F+Ob
         L7kCGl3A9r1CUUDItPEcwZkVscfCn67uV6dVXO3MPZHFMaeMSJjqAfwclF6KssFLtCpM
         ouFrf8qWN1oXpdERs1zUMSVcM7Ltn4K4xHblgSWecD2Yj5GYyUsc/uTlO/FhhzWWKMhM
         1zag==
X-Received: by 10.14.204.198 with SMTP id h46mr35192050eeo.1.1356125470367;
        Fri, 21 Dec 2012 13:31:10 -0800 (PST)
Received: from [192.168.0.3] ([151.70.200.154])
        by mx.google.com with ESMTPS id b2sm24020755eep.9.2012.12.21.13.31.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 13:31:09 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vip7v1d96.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212011>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 21/12/2012 19:17, Junio C Hamano ha scritto:
> [...]
> Of course you can plan ahead (this is what I usually do when working
> on a series that is not "how about this" throw-away patch I send to
> this list all the time) and name the topic "topic-v1", fork the new
> round "topic-v2", "topic-v3", etc. and do things like
> 
>     $ sh -c 'git diff topic-v2~$1 topic-v3~$1' - 4
> 
> (the point being that then you do ^P or whatever shell command
> history mechanism to recall that line, edit "4" to "3" and rerun the
> comparison for other corresponding ones).
> 

Thanks, this seems fine.
Maybe topic-v2 --> topic/v2 (it looks better to me).

> On a related but different front, I've been thinking about improving
> the "format-patch --subject-prefix" mechanism to make it even easier
> to use.
>
> [...]
>
> What if we added another option, say --reroll $n (or -v$n), to let
> you write:
> 
>     $ git format-patch --cover-letter -v4 -o ./+mp master
> 
> that produces output files named like:
> 
>     ./+mp/v4-0000-cover-letter.txt
>     ./+mp/v4-0001-git-completion.bash.add-support-for-pa.txt
> 
> with the subject '[PATCH v4]' prefix?
> 

I think it is a good idea to reduce the things one have to do by hand.
I, too, was thinking something similar, with a -v$n option.

And, from these few days I have started to follow the mailing list, it
seems that '[PATCH v$n'] is the standard practice.


By the way, I would also like to be able to set the default value for
the --output option in config file; something like:

  [format]
  output = +mp/$(git symbolic-ref --short HEAD)

where the string will be processed by the shell:

   sh -c 'printf "+mp/$(git symbolic-ref --short HEAD)'"

Note that printf is POSIX, and the standard suggests to use it instead
of echo:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html

I have read the affected source code, and it should not be too hard.
What do you think?

I should be able to hack the patch in the weekend, but I'm not sure it
will be accepted.

> Then you can transplant the cover letter material from the cover
> letter from the older iteration to the new cover letter in your
> editor, and sending them out will become
> 
>     $ git send-email ... ./+mp/v4-*.txt
> 
> Hmm?

Seems good.


Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDU1REACgkQscQJ24LbaUT5dgCgismeh+R3B26otuBIXRf/VUiq
+5gAoIR56wVfs8Vw8AAWtim4aor97MXN
=DfeG
-----END PGP SIGNATURE-----
