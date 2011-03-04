From: Dietmar Winkler <dietmarw@gmx.de>
Subject: Re: [Bug] %[a|c]d placeholder does not respect --date= option in
 combination with git archive
Date: Fri, 04 Mar 2011 11:10:36 +0100
Message-ID: <4D70BA9C.1080902@gmx.de>
References: <4D6F5FA8.5030105@gmx.de> <20110303151019.GC1074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 11:10:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvRyC-0006GE-7S
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 11:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759391Ab1CDKKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 05:10:42 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:50779 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759144Ab1CDKKl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 05:10:41 -0500
Received: (qmail invoked by alias); 04 Mar 2011 10:10:38 -0000
Received: from pc88180.hit.no (EHLO [128.39.88.180]) [128.39.88.180]
  by mail.gmx.net (mp017) with SMTP; 04 Mar 2011 11:10:38 +0100
X-Authenticated: #223389
X-Provags-ID: V01U2FsdGVkX1/qX/1glSHqT8ROZRZLCT/wwqawtb2mJqjiX82xHX
	6GxlRSNr670WlK
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.5.0
In-Reply-To: <20110303151019.GC1074@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168434>

Jeff and list,

Den 03. mars 2011 16:10, skrev Jeff King:
> I am not sure that this is a bug. The log.date parameter is about the
> log command, not necessarily other format substitutions. 

Well in
http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html it says:

  "The placeholders are the same as those for the option
--pretty=format: of git-log(1), except that they need to be wrapped like
this: $Format:PLACEHOLDERS$ in the file."

And in git log the list includes (besides the various date formats) also

 %ad: author date (format respects --date= option)
  ...
 %cd: committer date *

*) actually here the string "(format respects --date= option)" is
missing. Otherwise what committer date format are we speaking about ;)

So either the documentation should make clear that the substitution will
*not* work or (and this would be preferable) fix the substitution so
that it works as documented.

> I remember at some point discussing extending the specifier syntax to
> allow things like "%(ad,date=short)", but it was never implemented. I
> think that would be the cleanest way to do what you want.

Yes that would be even better since it would give one the freedom of
defining different format for the subsitutions  in different places in a
project. Shame it was not accepted.

> The second cleanest would be adding an archive.date variable. Which is
> much simpler, obviously. But I think making "log.date" start applying to
> archive substitutions is going to surprise some people and possibly
> break their setups.

How should this surprise people? If the used %ad they would have
expected a configuration depended substitution to start with. If they
wanted a log.date *independent* substitution they should have (according
to the documentation) some of the other formats (e.g., %ar, %ai, ...).
So I don't really see this as a reason for not fixing this bug.


/Dietmar/
