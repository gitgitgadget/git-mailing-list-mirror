From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 14] autoconf: Added --with/--without for openssl, curl, expat to ./configure
Date: Sat, 01 Jul 2006 00:32:41 +0200
Organization: At home
Message-ID: <e848pr$cca$1@sea.gmane.org>
References: <200606290301.51657.jnareb@gmail.com> <200606301708.19521.jnareb@gmail.com> <200606301711.39635.jnareb@gmail.com> <200606302345.17045.jnareb@gmail.com> <1151704626.12008.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jul 01 00:33:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwRY5-0007Ut-7N
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 00:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWF3WdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 18:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWF3WdE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 18:33:04 -0400
Received: from main.gmane.org ([80.91.229.2]:7058 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751371AbWF3WdC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 18:33:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FwRXa-0007Jr-W4
	for git@vger.kernel.org; Sat, 01 Jul 2006 00:32:46 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 00:32:46 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 00:32:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23021>

<posted & mailed>

Pavel Roskin wrote:

> On Fri, 2006-06-30 at 23:45 +0200, Jakub Narebski wrote:
>> I'm not autoconf/m4 expert: could anyone tell me how to uppercase
>> PACKAGE name, so one could write MY_PARSE_WITH(openssl)?
> 
> I don't quite understand what you want, but you could check m4_toupper.

Thanks. It works great. GIT_PARSE_WITH is now:

AC_DEFUN([GIT_PARSE_WITH],
[[PACKAGE=m4_toupper($1); \
if test "$withval" = "no"; then \
    GIT_APPEND_LINE(NO_${PACKAGE}=YesPlease); \
  elif test "$withval" != "yes"; then \
    GIT_APPEND_LINE(${PACKAGE}DIR=$withval); \
  fi; \
]])# GIT_PARSE_WITH

>> How to add [=PATH] to --with-PACKAGE option description in a way
>> which does not screw up AS_HELP_WITH calculations. I could use
>> @<:@=PATH@:>@ which transforms to [=PATH], but AS_HELP_WITH counts
>> number of characters in source I think.
> 
> Try another pair of square brackets as quotes for literal contents.  In
> this case, use [[=PATH]]

I suspect that AS_HELP_WITH does some strange quoting, or stripping. Both
[=PATH] and [[=PATH]] produces =PATH in ./configure --help output.
When using @<:@=PATH@:>@ I get [=PATH], but the description of option begins
line below.

>> +# MY_PARSE_WITH(PACKAGE)
> 
> By the way, it's better to use a prefix other than MY.  I thing
> GIT_PARSE_WITH would be great.

Any ideas for name of MY_APPEND_LINE(LINE)/GIT_APPEND_LINE(LINE) macro,
which as a result adds line to output (e.g. LINE = "NO_CURL=YesPlease")?

Thanks for all suggestions
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
