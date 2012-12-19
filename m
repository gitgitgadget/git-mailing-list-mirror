From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] git-completion.bash: add support for path completion
Date: Wed, 19 Dec 2012 23:02:08 +0100
Message-ID: <50D23960.4070108@gmail.com>
References: <1355693080-4765-1-git-send-email-manlio.perillo@gmail.com> <7vy5gxnuy1.fsf@alter.siamese.dyndns.org> <50CEFF3A.4050802@gmail.com> <7vzk1clb3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:02:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlRin-0004E1-Cm
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 23:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600Ab2LSWCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 17:02:21 -0500
Received: from mail-wg0-f54.google.com ([74.125.82.54]:64063 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab2LSWCT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 17:02:19 -0500
Received: by mail-wg0-f54.google.com with SMTP id fg15so1233235wgb.9
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 14:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=HZwhSx5gWrltCfdEbw9Ce2wURx/ZlqFDw0uCwxHMAyI=;
        b=RplKROvwECaoG9KMf7TboATVTGqeQ56/2WpLHFb7f5XLnXQukqPyXJOrf5bUCuFHoR
         1Zd1WxvseR6QkfTM0GB3+6nYz+LKQ12pqMx3DXAaTISr93rE/ezAovtvXHB2cC2+fMAS
         Xywm2QkWq0qL5Oa5gRuH+AoAcfbCwA13xGsCZyd9UvESsXVKJDaE7QCs8sqJqcnb531G
         9bZ5puEAqEjNLAlxkwHQBRB8g5r/LsAFxuYiA9OS620xKWSoVNldukaoR6Nm93iHJEKK
         JFY6kRUy2Fi3YZVyigAxHVxX55Sob+pJY46XWiPtuQM2GBal4B6xVeiBcv2B+BcpRCDV
         Uljg==
X-Received: by 10.194.143.35 with SMTP id sb3mr14069180wjb.30.1355954538518;
        Wed, 19 Dec 2012 14:02:18 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id fv2sm22458405wib.4.2012.12.19.14.02.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 14:02:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vzk1clb3n.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211856>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 17/12/2012 20:42, Junio C Hamano ha scritto:
> [...]
>>> I am not sure how you would handle the last parameter to "git mv",
>>> though.  That is by definition a path that does not exist,
>>> i.e. cannot be completed.
>>
>> Right, the code should be changed.
>> No completion should be done for the second parameter.
> 
> I deliberately wrote "the last" not "the second", as you can do
> 
> 	$ mkdir X
>         $ git mv COPYING README X/.
> 
> You do need to expand the second parameter to README when the user
> types
> 
> 	git mv COPYING REAMDE X
> 
> then goes back with \C-b to "M", types \C-d three times to remove
> "MDE", and then finally says <TAB>, to result in
> 
> 	git mv COPYING README X
> 

Assuming X is a new untracked directory, do you think it is an usability
problem if an user try to do:

	git mv COPYING README <TAB>

and X does not appear in the completion list?

As far as I know, the solution is to only support custom expansion the
first parameter, unless the user will do something like:

	git mv COPYING README -- <TAB>


Regards  Manlio

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDSOWAACgkQscQJ24LbaUSOnACfds93RtX1CDOeGbwCGM5/N8HI
yVwAn0AZEO6rE083gKgFimGIbiRTyN5Z
=z7K5
-----END PGP SIGNATURE-----
