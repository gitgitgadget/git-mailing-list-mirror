From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: DOCBOOK2X_TEXI in Documentation/Makefile invalid on some distributions
Date: Thu, 9 Oct 2014 14:40:38 -0500
Message-ID: <CAMsgyKZfH8dphGOmGpYx2PWMARaRT13z0xZfoWSL6UspwHFzuw@mail.gmail.com>
References: <CAMsgyKb-ffkfqRhG-dUkwpnKOcA=3CrZqT57qcqTr+9zm_v2Jw@mail.gmail.com>
	<20141009193504.GD415@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:40:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJZr-0001cf-Ma
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbaJITkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:40:40 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:64939 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbaJITkj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:40:39 -0400
Received: by mail-oi0-f45.google.com with SMTP id i138so4340178oig.32
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j6yZC+SE7ZVjdIEyz/jwxAU1SxZS901lijl7We/hxw0=;
        b=glM9BJQj2gJsIGaBV25jf0r+JBp5b4kwq/TZSIkAKKH+2VR4EA0R5BZnAULTfXxjyQ
         I+4qmDfwAjpYW0H8+YHfeqzXr8xkv7rndhW7dyA0SBS8pbDUUItb2/jeLPsKpQ1GdxwI
         K9PGQvnd5b9A7ar1B3bo8uNhhbzC3Dok0QRU2Y5tBQGvluwADIb+zf0ng23tIWWlvDkZ
         pVlV7W/eXx/S6z/dcOwqr595IxyM9fcPu31EJwPRf63M7eYnbfDxSHfv31I2Ff8fT0KX
         4IjJ4HRe0QeCi7JHdgKo1VrgVJ1F57S9JUk1zzdcK1/4N7BOIPBERJCaWnCqT1V1h//j
         Yt+A==
X-Received: by 10.202.207.79 with SMTP id f76mr256542oig.46.1412883638904;
 Thu, 09 Oct 2014 12:40:38 -0700 (PDT)
Received: by 10.76.33.68 with HTTP; Thu, 9 Oct 2014 12:40:38 -0700 (PDT)
In-Reply-To: <20141009193504.GD415@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

:) Wasn't proposing a patch, that's for sure, was just evincing the
change that worked for me.

I agree INSTALL instructions should be fixed up and/or the
DOCBOOK2X_TEXI should be conditionally assigned in a sane manner.

I'd first want to inspect upstream docbook2X build process and Fedora
docbook2X RPM .spec, to see which name is canonical and how you guys
came up with "docbook2x-texi".

Seems there are now plenty of opportunities for me get my name in
git's AUTHORS list. ;)


On Thu, Oct 9, 2014 at 2:35 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 09, 2014 at 12:53:33PM -0500, Derek Moore wrote:
>
>> Following the INSTALL doc, I was building git with:
>>
>> make prefix=/usr/local all doc info
>
> I wonder if it is actually sane to recommend building "info" for
> newcomers in INSTALL. I do not know if many of the list regulars do so
> (I certainly do not), or if it is part of anybody's testing regimen.
>
>> $ git diff
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index cea0e7a..0e6c70a 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -107,7 +107,7 @@ HTML_REPO = ../../git-htmldocs
>>
>>  MAKEINFO = makeinfo
>>  INSTALL_INFO = install-info
>> -DOCBOOK2X_TEXI = docbook2x-texi
>> +DOCBOOK2X_TEXI = db2x_docbook2texi
>>  DBLATEX = dblatex
>>  ASCIIDOC_DBLATEX_DIR = /etc/asciidoc/dblatex
>>  ifndef PERL_PATH
>
> I don't think we would want to take a patch like this, as it is still
> called docbook2x-texi at least on Debian.
>
> You can override variables with:
>
>   make DOCBOOK2X_TEXI=db2x_docbook2texi ...
>
> or if you want to use it for multiple make invocations:
>
>   echo DOCBOOK2_TEXI=db2x_docbook2texi >config.mak
>
> If we want a patch to make this Just Work out of the box on Fedora, I'd
> suggest looking at config.mak.uname (though I am not sure if there is
> enough information there currently to determine Fedora versus another
> distro), and/or a patch to configure.ac to detect which name we have.
>
> -Peff
