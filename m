From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] git-completion.bash: add support for path completion
Date: Tue, 18 Dec 2012 17:25:44 +0100
Message-ID: <50D09908.6020007@gmail.com>
References: <1355693080-4765-1-git-send-email-manlio.perillo@gmail.com> <7vy5gxnuy1.fsf@alter.siamese.dyndns.org> <50CEFF3A.4050802@gmail.com> <7vzk1clb3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:33:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl076-0006pD-8O
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 17:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273Ab2LRQd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 11:33:27 -0500
Received: from mail-bk0-f50.google.com ([209.85.214.50]:62862 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265Ab2LRQdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 11:33:25 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2012 11:33:25 EST
Received: by mail-bk0-f50.google.com with SMTP id jf3so456640bkc.37
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 08:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=Kb0vCyMqaAFMOmayH5Q/sXwhsw8prOwzIdQcoAMPfbQ=;
        b=m4sDGDxjUoZBETMttyGj6tozpEAd0BeuCiuYXF6NB8C5sl+C1TgFo4VdgzKrKeK3B1
         7skVnCOTQcVa+N9lJ+3VWniAkAw3iuZbbAyk0J6Ay+JC0Cc76u2fozYQrFsGwNuXmPTZ
         bZu2+yY1OP8OXZvIwiZanWL2LynBPoipEPbunM21RtkFOYnqt703uXQp6zww2EyFGo6Q
         KaUnA259K7fPrFenRZRkDTDMUyFVW9xD0AREB8xlVhbLPhevJip8hri9M8il/9myqqaT
         f3Lo7JkUAxllbVURRiHSsBlHdQoGpJWP6qylthtpyeXMxO0O/93fyJxqFkHUrLmOfk8L
         FmzQ==
X-Received: by 10.204.131.76 with SMTP id w12mr990811bks.44.1355847956244;
        Tue, 18 Dec 2012 08:25:56 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id l17sm1845302bkw.12.2012.12.18.08.25.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2012 08:25:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vzk1clb3n.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211759>

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

The patch is ready, however I decided to leave git mv completion simple.
Pressing <TAB> will always try to autocomplete using all cached files.
I have added a note to remember it needs more work.


P.S.:
git-completion.bash has a lot of other things that may be improved:

* adding missing commands
 (as an example, there is strangely no custom support fot "git status")

* completion support for commands like "git checkout" is not complete.
  "git checkout <TAB>" will correctly try to complete the tree-ish,
  however "git checkout HEAD -- <TAB>" will try to complete the path
  using *all* files in the working directory.

  This is easy to fix, using the new functions I have added

* not all long options are supported.
  The script documentation says that only common long options are
  supported, so I'm not sure it is ok to add support for all available
  long options.


Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDQmQgACgkQscQJ24LbaUSw9QCfT1lCH/yjA4Lgmb2nMspNWM3l
hMMAn26UxWesuoOxMbuwhqaypPjkmN84
=Wh4c
-----END PGP SIGNATURE-----
