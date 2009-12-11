From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/6] GITWEB - Separate defaults from main file
Date: Fri, 11 Dec 2009 23:53:09 +0100
Message-ID: <200912112353.11034.jnareb@gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <m3ljh9cy3b.fsf@localhost.localdomain> <4B226C0F.2070407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 23:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJELH-00015B-Hy
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 23:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbZLKWvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 17:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbZLKWvr
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 17:51:47 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:42115 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZLKWvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 17:51:46 -0500
Received: by fxm21 with SMTP id 21so1558870fxm.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 14:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RG8DC3RYr02YDhIU2digCtM/2a3Z/9LpHEnW/pcW16s=;
        b=GGbLkba5akk8SISwLy8vAWqIxrBG6LrVMMohz7lokgF0BCrz0nOMzL4rB1XL4qu5nZ
         K04tVjb1IlQi61Xt3LWOsxET8nsYb2r43QhZfqs1Q+9066CnQcbNYJWCTJiLnanzZWx6
         8RYQ3JzZY7sXkF50BbFwIw2ogYhO+hSl/6cPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Jx9m6AKp+X5pUQwb2GrlThQb3lfMISDeXnM9AUCd7kCBDTuoKaW7ZDLbAaXyOwTezT
         3BuuTYvnB2eYeT+tF/N3HPr4A4YTWUsyOvchZjawsBvAsJqLeVHQhiEXgODa/+A0xpMo
         WvoT8aIrlSqK1L02CRn9l2ZUKgaDbkZ4rP4Fw=
Received: by 10.87.47.35 with SMTP id z35mr2480409fgj.63.1260571911864;
        Fri, 11 Dec 2009 14:51:51 -0800 (PST)
Received: from ?192.168.1.13? (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id 14sm837242fxm.3.2009.12.11.14.51.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 14:51:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B226C0F.2070407@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135106>

On Fri, 11 Dec 2009, J.H. wrote:

>>> This is also a not-so-subtle start of trying to break up gitweb into
>>> separate files for easier maintainability, having everything in a
>>> single file is just a mess and makes the whole thing more complicated
>>> than it needs to be.  This is a bit of a baby step towards breaking it
>>> up for easier maintenance.
>> 
>> The question is if easier maintenance and development by spliting
>> gitweb for developers offsets ease of install for users.
> 
> This would just get dropped into the same location that gitweb.cgi 
> exists in, there is no real difference in installation, and thus I can't 
> see this as an issue for users.

To be more exact you have to know that you have to drop _generated files_,
which means (for this version of patch) gitweb.cgi and gitweb_defaults.pl
(or whatever the generated file with config variables would be named).


ATTENTION!

Your changes would make stop working all gitweb tests.  Currently they
do some magic with generated gitweb config file "$(pwd)/gitweb_config.perl"
set via GITWEB_CONFIG configuration variable to be able to run
_unprocessed_ gitweb/gitweb.perl (without any substitutions).  This
allow to run tests on "live" version of gitweb.

After your changes it would be no longer possible, at least not if we
want to be sure that we test the same version of gitweb as gitweb_defaults.

It would probably mean that we need to move to testing built version,
i.e. gitweb.cgi, not gitweb.perl

>>> ---
>>>  .gitignore                  |    1 +
>>>  Makefile                    |   15 +-
>>>  gitweb/Makefile             |    2 +-
>>>  gitweb/gitweb.perl          |  515 +++++--------------------------------------
>>>  gitweb/gitweb_defaults.perl |  468 +++++++++++++++++++++++++++++++++++++++
>>>  5 files changed, 537 insertions(+), 464 deletions(-)
>>>  create mode 100644 gitweb/gitweb_defaults.perl
>>>
>>>
>>> diff --git a/.gitignore b/.gitignore
>>> index ac02a58..5e48102 100644
>>> --- a/.gitignore
>>> +++ b/.gitignore
>>> @@ -151,6 +151,7 @@
>>>  /git-core-*/?*
>>>  /gitk-git/gitk-wish
>>>  /gitweb/gitweb.cgi
>>> +/gitweb/gitweb_defaults.pl
>> 
>> Hmmm... gitweb/gitweb_defaults.perl as source file, and
>> gitweb/gitweb_defaults.pl as generated file?  Wouldn't it be better to
>> go with the convention used elsewhere in gitweb and use
>> gitweb/gitweb_defaults.perl.in or gitweb/gitweb_defaults.pl.in as
>> source file?
> 
> I think you got confused, the committed file is .perl the generated file 
> is .pl.

Maybe I wasn't entirely clean.  I meant that the committed source file
should perhaps have *.in extension to denote that it is to be processed
via variable substitution, so it would be

  committed file: gitweb/gitweb_defaults.pl.in
  generated file: gitweb/gitweb_defaults.pl
 
or whatever name (*.pm?) we agree on.

>>>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>>>  	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>>>  	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
>>> @@ -1539,7 +1541,7 @@ endif
>>>  	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
>>>  	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
>>>  	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
>>> -	    $(patsubst %.cgi,%.perl,$@) >$@+ && \
>>> +	    $(patsubst %.cgi,%.perl,$(patsubst %.pl, %.perl, $@)) >$@+ && \
>> 
>> Why the slightly inconsistent style ("%.cgi,%perl" vs "%.pl, %perl")?
> 
> Considering that the defaults is more of an include vs. a cgi it 
> probably shouldn't share the standard expected executable suffix, thus I 
> used .pl.  Could just as easily change it to .pm, or something else but 
> I think it would make the most sense to leave things we are expecting 
> the webserver to directly execute as .cgi, and includes as a different 
> suffix.

I was not asking about that, but about

+	    $(patsubst %.cgi,%.perl,$(patsubst %.pl, %.perl, $@)) >$@+ && \

vs

+	    $(patsubst %.cgi,%.perl,$(patsubst %.pl,%.perl,$@)) >$@+ && \

But after thinking about it a bit, and consulting make documentation
(in particular definition of $@ variable) this rule shouldn't work at all.

`$@'
     The file name of the target of the rule.  If the target is an
     archive member, then `$@' is the name of the archive file.  In a
     pattern rule that has multiple targets (*note Introduction to
     Pattern Rules: Pattern Intro.), `$@' is the name of whichever
     target caused the rule's commands to be run.
 
What we need is to run pattern substitution for _two_ files, perhaps
using the for loop.

Also I think the order of substitutions would be better to be reversed:

    $(patsubst %.pl,%.perl,$(patsubst %.cgi,%.perl,$FILE)) >$FILE+

This way the gitweb_defaults file can even have *.perl extension

>> Also wouldn't all replacements be in the new gitweb_defaults file, so
>> there would be no need then to do replacements for gitweb.cgi?
> 
> Not all replacements are done in one or the other, and since it's 
> basically a NOP to perform the full set of replacements on both files 
> that seemed the easiest way to ensure they were done in both places.
> 
>> Oh, I see there is at least one that stayed in gitweb.perl: $version
>> 
> 
> <snip>

O.K.

But Makefile would be (slightly) simpler if replacements were needed only
for single file of two.
 
>>> +# Define and than setup our configuration 
>>> +#
>>> +our(
>>> +	$VERSION,
>>> +	$path_info,
>>> +	$GIT,
[...]
>>> +	$prevent_xss,
>>> +	@diff_opts,
>>> +	%feature
>>>  );
>> 
>> Why this block is required?  Why not have variables defined (using
>> "our") in gitweb_defaults file?
> 
> Wanted to make sure things were properly defined, if in an unexpected 
> state, should a user have gitweb.cgi in place but not the defaults.

In my opinion it actually *makes worse*.  I am not sure if gitweb would
work if the variables are undefined, and you would lose 'undeclared 
variable' warning.
 
>>> diff --git a/gitweb/gitweb_defaults.perl b/gitweb/gitweb_defaults.perl
>>> new file mode 100644
>>> index 0000000..ede0daf
>>> --- /dev/null
>>> +++ b/gitweb/gitweb_defaults.perl
>>> @@ -0,0 +1,468 @@
>>> +# gitweb - simple web interface to track changes in git repositories
>>> +#
>>> +# (C) 2005-2006, Kay Sievers <kay.sievers@vrfy.org>
>>> +# (C) 2005, Christian Gierke
>>> +#
>>> +# This program is licensed under the GPLv2

This header should probably be modified, at least stating what the file
is for.

>>> +
>>> +# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
>>> +# needed and used only for URLs with nonempty PATH_INFO
>>> +$base_url = $my_url;
>> 
>> Why not "our $base_url = $my_url;"?
> 
> same reason as the other 'our' includes above,

See comment above about pre-declaring variables actually making it
worse wrt checking.

> though why this ended up  
> as a separate patch vs. the rest of the file I don't know.

Errr... what you are talking about here?

-- 
Jakub Narebski
Poland
