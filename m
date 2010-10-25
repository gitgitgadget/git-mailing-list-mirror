From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Documentation: refactor config variable descriptions
Date: Mon, 25 Oct 2010 14:44:06 +0200
Message-ID: <201010251444.08780.jnareb@gmail.com>
References: <cover.1287690696.git.trast@student.ethz.ch> <20101022155307.GB5554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 25 14:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAMPf-0001R5-Id
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 14:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab0JYMoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 08:44:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37569 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab0JYMoY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 08:44:24 -0400
Received: by fxm16 with SMTP id 16so2871936fxm.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lutJbwUGm4/jfUHtOACsHL66KLZdFB8YfwDvXhUjnTY=;
        b=F3pib1VFhwU9L+ID7UR60NXvYl+oAM/jlx/A+ARGoj1hohCIcP8TcVzKhLweSOKiBw
         v4O3QG0glj28m9l8OC93Zvr9hdfU1DO3scJS4TjBlfoxSVmv0d/rQuirPEysSVaQNQ0H
         zz0WgJoNsrBqjFjDn+A6j1UXXeO3s9UqlzDRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ctDzOqUbOrGhrzcpwm6t5DK2chhKZC5040fbp+ubfIWb2gJsn1Yyyfzi/3q5q31Ytr
         5SfTcGsAA7J3qUvPr63PNlA/BmW26tpMtZTY4D61WT1NE3rG8FUep0YrS4YuapsUhHfk
         zGSVZ8+7KgEDWnfOHanRLTt4Iv/RgXPQSCqAI=
Received: by 10.103.251.20 with SMTP id d20mr8139973mus.105.1288010662692;
        Mon, 25 Oct 2010 05:44:22 -0700 (PDT)
Received: from [192.168.1.13] (abwi90.neoplus.adsl.tpnet.pl [83.8.232.90])
        by mx.google.com with ESMTPS id d17sm2823154fav.5.2010.10.25.05.44.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 05:44:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20101022155307.GB5554@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159947>

On Fri, 22 Oct 2010, Jeff King wrote:
> On Fri, Oct 22, 2010 at 07:02:28AM +0200, Thomas Rast wrote:
> 
> > This resurrects (finally) the earlier attempt at
> > 
> >   http://mid.gmane.org/cover.1280169048.git.trast@student.ethz.ch
> > 
> > It tries the inverse approach: teaching the script how to find config
> > variable blocks in each manpage, and then linking them from the main
> > list.  (Obviously just inserting them into the main list could also
> > work.)
> > 
> > In other words, it attempts to push out the "original" documentation
> > of each variable from the main list to the individual manpage, which
> > is exactly opposite from v1.
> 
> Thanks for working on this.
 
[...]

> I have two comments on the approach:
> 
>   1. It looks like you're more or less just parsing "::" list keys from
>      all of the manpages. This seems somewhat fragile, as there could be
>      other non-config lists. Can we at least restrict it to
>      CONFIGURATION sections? It would be nice if we could put in some
>      kind of semantic markup, but I'm not sure how painful that would be
>      with asciidoc (we could always resort to comments in the source,
>      but that would probably get unreadable quickly).

The regexp for catching config variables is quite strict, but tests
done with my version of script modifier further to check for 
CONFIGURATION-like sections (matching /^Config/) shown that we have
problems either way.

1. Without checking for CONFIGURATION sections, we have what are 
   probably false positives from gitmodules.txt:

     submodule.<name>.path::
     submodule.<name>.url::
     submodule.<name>.update::
     submodule.<name>.ignore::

   I say *probably* because while gitmodules manpage describes those 
   variables as going into .gitmodules, if I understand it correctly
   those variables can got to .git/config as an override.

2. With checking for CONFIGURATION-like, we would miss the following
   configuration variables:

     http.getanyfile:: (for git-http-backend, in 'SERVICES')
     http.uploadpack:: (for git-http-backend, in 'SERVICES')
     http.receivepack:: (for git-http-backend, in 'SERVICES')

   These are in git-http-backend manpage, in 'SERVICES' section, which 
   probably should be named then 'CONFIGURING SERVICES'.

   BTW, CONFIGURATION-like means:

    * Configuration
    * CONFIGURATION
   
  but also

    * CONFIG FILE-ONLY OPTIONS
    * CONFIGURATION FILE
    * Configuration Mechanism
    * CONFIG VARIABLES
    * CONFIGURATION VARIABLES
    * Configuring database backend

> 
>   2. You recursively follow includes via include::. This means that the
>      make rule is not accurate. E.g., try:
> 
>        rm cmds-mainporcelain.txt config-vars.txt
>        make config-vars.txt
> 
>      which should fail, as we actually depend on cmds-mainporcelain.txt.
>      Doing it accurately and automatically would mean making .depend
>      files for make.

We do that: see 'doc.dep' target in Documentation/Makefile.  We just
need for this target to also add dependencies for config-vars.txt
(perhaps separate mode for make-config-list.perl, or perhaps 
build-docdep.perl should be config-vars-src.txt aware...).

> 
>      But I wonder if the recursive lookup is really required. Some of
>      the includes with config files can just go away (e.g.,
>      merge-config.txt is included only by config-vars-src.txt and
>      git-merge.txt; it can just be merged straight into git-merge.txt
>      once this system exists).

merge-config.txt is the only included file with config variables.
Other includes does not contain config variables.  And because 
merge-config.txt is also included in config-vars-src.txt, therefore
the whole recursive lookup is not necessary.

Note however that make-config-list.perl only creates minimal documentation,
just link(s) to appropriate mapage(s).  Include-ing merge-config.txt both
in git-merge.txt and config-vars-src.txt means that we have merg config
variables defined in git-config(1) manpage, which I think is nice to have.

>      Others, like pretty-formats.txt, should, 
>      IMHO, get their own user-visible page. Right now with your script
>      you get[1]:
> 
>        format.pretty::
>                The default pretty format for log/show/whatchanged command,
>                See linkgit:git-log[1], linkgit:git-show[1],
>                linkgit:git-whatchanged[1].
> 
>      but I would rather see[2]:
> 
>        format.pretty::
>                See linkgit:gitpretty[7].

Actually the above block describing `format.pretty` is from beginning in
config-vars-src.txt, and is not added / created by said script.

> 
>      [1]: I assume the single line of block description is an error in
>           your script.

Hmmm?

-- 
Jakub Narebski
Poland
