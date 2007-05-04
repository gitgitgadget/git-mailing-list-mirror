From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 19:17:32 +0200
Message-ID: <81b0412b0705041017l1ceb419j733e9cf3389e9709@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	 <56b7f5510705040153i65ba6260v9fbe7a90e040cab3@mail.gmail.com>
	 <81b0412b0705040217o54d1d028j6e768bdc3eb0bad0@mail.gmail.com>
	 <56b7f5510705040226o14d55b6euda7df1da7ad9b08a@mail.gmail.com>
	 <81b0412b0705040246r5a2726b8g4323cadeacee3aa7@mail.gmail.com>
	 <56b7f5510705040957v4580b6c1xbe767892ada3bcde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 19:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk1PX-0000az-4b
	for gcvg-git@gmane.org; Fri, 04 May 2007 19:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbXEDRRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 13:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbXEDRRg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 13:17:36 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:1753 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161113AbXEDRRe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 13:17:34 -0400
Received: by an-out-0708.google.com with SMTP id b33so900100ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 10:17:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UTA/NERC50bBbe0lV2sHwJN62e9uAig7gLnxABW68yp6F2nuS5TQjVKZU9aWRyOGAeXIz9aJ6RS++23QGwAnAdMjuDtVAdPqK+zm37aQsRiHEBeI0at3vjJspu47zNhPfhKEN/gIWtz38O9AIw9dCnvphDRi34B99Z2jiQw/8Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZvYSHaD8bAVmXRaLOukjJwjGC4/mlbddw+kv2YwNf2Iofjxh3ovZ1Pd3X8H5y6NRLqnHaSeRu9dP6VxZReIh/S2Yj3UcRhJH8ihs1zI8FdUSoMBOvT/d65kXcUxDA7b7mwfTnCdXvXar+iphy93Bap9rZQH48RhFH5qW1dBsrtQ=
Received: by 10.100.247.11 with SMTP id u11mr2934233anh.1178299052198;
        Fri, 04 May 2007 10:17:32 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 10:17:32 -0700 (PDT)
In-Reply-To: <56b7f5510705040957v4580b6c1xbe767892ada3bcde@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46192>

On 5/4/07, Dana How <danahow@gmail.com> wrote:
> > > This all depends on deciding that :relpath should be the (incompatible)
> > > new default, and I'm not sure that's going to happen.
> >
> > If we are to stay that compatible, maybe ":./" for relative paths and the
> > old syntax left to mean top-level would the best choice for now.
>
> Let's summarize so far:  I think everyone's convinced me we need
> to be careful,  so this email will be more tedious than I'd like.
>
> (a) :./relpath clearly inidicates relative path. [Also take :../relpath .]

Ack

> (b) I'd like a more natural way to do :./relpath (e.g. :relpath),
>      or at least a future path to such.
> (c) We would like to avoid new special characters beyond ":".
>      This means everything has to be done with "." and "/".

And new semantics, if possible

> (d) We are left with the following patterns:
>      1. :string

Probably breaks something

>      2. :/string

Taken

>      3. ://string

Ugly (and breaks tab completion)

> [ We need a clear way to say relative, a clear way to say absolute,
> and the current :string can change from absolute to relative some time
> in the future if we so decide. ]
>
> Ideas for (d) 2&3:
> I. Make :/string actually match the RE ^[/]*string,  and ://string a full path.
>    The leading [/]* is a very small change to get_sha1_oneline().
>    [Or change prefixcmp() to strstr() in get_sha1_oneline().]
>    How often do commit messages start with / ?

How often should they start to justify any decision?

> II. Make :/string a full path, and ://string match ^string .
>    Is changing the current :/string to ://string less painful/dangerous?

Johannes?

> III. Make :/string match ^string when string has no slashes,
>     :/string a full path when string does have slashes,
>     and ://string match ^string . Hmm,  seems confusing.

Very/

> Do you use :/string now?  Since it's a case-sensitive exact match,

No. It just exists, AFAICS

> I don't think I'd even use it.
> I find idea (II) most natural: absolute paths have one /,
> and string matches have 2 suggesting an RE.

I think, I'd be convinced by this one too, if not for "//" making
no sense anywhere but root accidentally typed twice.
I'd even sacrifice (or change) the search syntax for good.
