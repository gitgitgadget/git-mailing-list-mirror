From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [WIP/PATCH v3] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Fri, 20 Jun 2008 20:03:55 +0200
Message-ID: <200806202003.55919.jnareb@gmail.com>
References: <1213487844-685-1-git-send-email-LeWiemann@gmail.com> <200806201408.05254.jnareb@gmail.com> <485BB578.3040605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 20:06:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9kyw-00035p-TF
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 20:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbYFTSEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 14:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752939AbYFTSEJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 14:04:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:48026 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbYFTSEI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 14:04:08 -0400
Received: by ug-out-1314.google.com with SMTP id h2so38772ugf.16
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lDal0s9a79QpZ+Hpyk+Ce2w1FORjFXOUhjawW2h82d4=;
        b=MEQsbfEGDau44bQO0NUSWDratw1rgiI1sYbKbTmWHEDRaTx/Hq9JrGmAKCcbr+dmos
         iMEJZMYQQJsNIoFtwziX/7oHj3Nz6t0LL9Ep3Ms9G63H2W4SpCZOrODIX2f8YPQx/7II
         Ji2wZKGcrJU84A7QVzDOLJ2OF0a+ytGaaG06E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tdEPDvVTPwJEW938gnS8zey9WfitAwqOFMB5sYIoXpKwy7LDwLxh23y5vCmJHx+hEF
         4nYRNUMk5rt4wOBxGJtqQVYT9TQK/mNVfCNhk2GsqkOy0aI21QlO5SdFVhb01Red3NMn
         LeANR+ob9bZIi0FhfsWJkOsUaAwd5T9q9j5L4=
Received: by 10.210.39.20 with SMTP id m20mr3365171ebm.126.1213985045332;
        Fri, 20 Jun 2008 11:04:05 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.51])
        by mx.google.com with ESMTPS id b33sm3256977ika.2.2008.06.20.11.04.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 11:04:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <485BB578.3040605@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85668>

On Fri, 20 Jun 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
>>
>> Second, I think it would be better if adding XML checks (RSS, Atom,
>> OPML) would be left as separate commit.
> 
> Sure; FWIW I'm generally in favor of having a large initial commit for 
> new independent files [...]

I just think that having this separate could help bisectability in
the case of errors.

>>> +# set up test repository
>> 
>> I have created this part as a copy of older t9500 gitweb test, thinking
>> about what we might want to test, but the WIP of Mechanize based t9503
>> doesn't have yet tests for those specific features.
> 
> I was thinking about that.  Right now the tests are so generic that you 
> can replace the test repository with anything else as long as it has 
> some commits (and later some tags, etc.).  That's kinda nice.

Well, I've tried to put the cases where something can go wrong, and to
cover wide range of possibilities.  Rename, copy, typechange, merge
commit for testing *diff views, symlink to test 'tree' view, different
types of tags and tagged objects...

What could be added is different types of stage output: filenames with
'*', '+', '=', ':', '?', whitespace, etc.  Checking if submodules
doesn't trip gitweb would be good idea too.
 
> I'm generally not in favor of maintaining any test count plans; they're 
> an unnecessary failure source, and I don't think they buy us much, if 
> anything -- correct me if I'm missing something Perl-specific here.

While they can detect otherwise unnoticed errors, I think most of time
they are error in test counting... so I can agree with that.
 
>> Why do you use shortened SHA1 identifier, instead of full SHA1?
>> Links in gitweb use full SHA1.
> 
> That's for readability in the test output; links get checked anyway, 
> don't they?  If you think we should be testing against full SHA1s, 
> that's fine too.

This would reduce number of operations when crawling gitweb output.

 
[about workaround bug in TWM::CGI when path to application contains
 embedded space].

> ISTR that using cgi(sub ...) gives us problems with untrappable exits in 
> gitweb.cgi (and possibly more things), right?

Actually ->cgi_application(<path>) is implemented using ->cgi(<sub>)
in TWM::CGI.  The bug is that it uses straight "system($application)",
without any quoting, after ensuring that $application is absolute path
(so quoting it beforehand won't work).

> I'm fine with the workarounds we have in place, they don't seem brittle.

They work around the fact that we use 'trash directory', but they
would fail if you run test from the directory which contains spaces,
for example "/home/Lea Wiemann/git/t" (I think this has greater
probability happening on operating systems other than Linux, for
example MS Windows with "My Documents" or "Program Files").

>>> +our $baseurl = "http://localhost";
>>> +our($params, $url, $pagedesc, $status);
>> 
>> I think we can use 'my' here;
> 
> They're used in subroutines, so I believe 'our' is correct here.

Actually 'my' would work here too; the problem with gitweb being
forced to use 'our' to make it work with mod_perl isn't about the
fact that they are global variables, but with initializing them,
as mod_perl wraps whole gitweb in a block (processing requests).
 
>> As to the rest of the test: I think as preliminary test it is a good
>> thing to have.  We can think about what tests to add later (unless you
>> rather have exhaustive test suite now...).
> 
> I'll be writing tests as I go and change parts of gitweb.  I won't be 
> able to write exhaustive tests, but I at least want to make sure that 
> the code I'm changing is covered somehow.

Write test when we notice something breaking seems a common theme
in git development... ;-)

-- 
Jakub Narebski
Poland
