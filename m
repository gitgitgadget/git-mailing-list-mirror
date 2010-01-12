From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCHv3 3/4 (resent)] gitweb: Optionally add "git" links in
 project list page
Date: Mon, 11 Jan 2010 16:39:39 -0800
Message-ID: <4B4BC4CB.2030409@eaglescrag.net>
References: <1262534850-24572-1-git-send-email-jnareb@gmail.com> <1262534850-24572-4-git-send-email-jnareb@gmail.com> <4B47E06C.9070503@eaglescrag.net> <201001091220.20446.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 01:40:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUUoD-0005t9-DI
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 01:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359Ab0ALAkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 19:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250Ab0ALAkZ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 19:40:25 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:37314 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab0ALAkX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 19:40:23 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.1) with ESMTP id o0C0ddOn019656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 11 Jan 2010 16:39:39 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <201001091220.20446.jnareb@gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Mon, 11 Jan 2010 16:39:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136681>

On 01/09/2010 03:20 AM, Jakub Narebski wrote:
> On Sat, 9 Jan 2010, J.H. wrote:
>> On 01/03/2010 08:07 AM, Jakub Narebski wrote:
>>> From: John 'Warthog9' Hawley <warthog9@kernel.org>
>>>
>>> This adds a "git" link for each project in the project list page,
>>> should a common $gitlinkurl_base be defined and not empty.  The full
>>> URL of each link is composed of $gitlinkurl_base and project name.
>>> It is intended for git:// links, and in fact GITWEB_BASE_URL build
>>> variable is used as its default value only if it starts with git://
>>>
>>> This does make the assumption that the git repositories share a common
>>> path.  Nothing to date is known to actually make use of introduced
>>> link.
>>>
>>> Created "git" link follows rel=vcs-* microformat specification:
>>>   http://kitenet.net/~joey/rfc/rel-vcs/
>>>
>>> Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
>>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>>> ---
>>> I think it might be good idea... but for the fact "Nothing to date is
>>> known to actually make use of introduced link".  What's its intended
>>> use?
>>>
>>> Differences to original version by John 'Warthog9' Hawley (J.H.):
>>> * It doesn't cause syntax error ;-)
>>> * Escaping of attribute value is left to CGI.pm (avoid double escaping)
>>> * $gitlinkurl got renamed to $gitlinkurl_base, now includes git://
>>>   prefix, and defaults to GITWEB_BASE_URL if it begins with git://
>>> * Added description of $gitlinkurl_base to gitweb/README
>>> * Uses rel=vcs-* microformat by Joey Hess
> 
>>>  gitweb/README      |    4 ++++
>>>  gitweb/gitweb.perl |    8 ++++++++
>>>  2 files changed, 12 insertions(+), 0 deletions(-)
> 
> A reminder - this patch series consists of the following patches:
>  [PATCHv2 1/4 (resent)]     gitweb: Load checking
>  [RFC/PATCHv2 2/4 (resent)] gitweb: Add option to force version match
>  [PATCHv3 3/4 (resent)]     gitweb: Optionally add "git" links in project list page
>  [PATCHv2/RFC 4/4 (resent)] gitweb: Makefile improvements
> 
>> Ok I've been debating this as I've been going through the patches, I've
>> got small modifications on top of your patches Jakub for 1 and 2,
>> haven't pushed them yet but they are relatively trivial.  The changes to
>> the first patch sets things up for additional load checkers to be added
>> later on.  
> 
> Good idea, although I think that such addition can be left for a separate
> patch.  

It only set things up for additional checkers, adding a framework for
them to be added. I would agree that other load checkers should be in
additional patches, just trying to make it easy for other later on.

> By the way, are you doing if-elsif fallback chain, trying different
> mechanisms (like '/proc/loadavg', BSD::getloadavg, etc.), or did
> you made get_loadavg() into code reference, i.e. run it with 
> $get_loadavg->(), which has the advantage that the gitweb admin can 
> override it in gitweb config file (including such thing like simply 
> using load average over last 5 minutes, and not over last minute)?

I had set it up using the if-elsif fallback chain.  Not sure that an
admin would be overriding it for the most part, but it probably wouldn't
be hard to do both.  Decent defaults for the general case, and if anyone
wants they can override it afterwards for special cases.

> 
>> The second changes the error message to use/abuse die_error() 
>> vs. doing it's own thing (though I still think this should be on by
>> default).  
> 
> True, the error message could use improvement (and not only using
> its own class instead of abusing 'readme' class, or renaming 'readme'
> class to something more generic).  The problem with error message for
> this is who is the target of this message: is it gitweb administrator
> (who can change gitweb configuration), or is it gitweb user (who need
> to contact web admin).

Admin for sure, this is intended more to be a speed bump that forces the
admin to stop and consider what's happening.  I originally added it
because I ended up in a situation where gitweb didn't match the
installed git and gitweb was dying silently.  I wanted to just give the
admin a better guess at what was going on mainly.

> The problem with this patch is that for it to be useful for protecting
> against silent errors it should be on by default, but OTOH having it on
> by default is quite inconvenient.

Upside is once it's been disabled it should stay disabled.  I'll admit
it's not ideal but it's at least a stop gap in the interim till the
other silent errors get filled in.

> Best solution would be to treat core of this issue, namely eliminate
> silent errors and always provide some message in case of error.

Agreed, this is really just a stop-gap measure.  I would imagine *most*
instalations of gitweb are installed from the distro's package
management so that would likely be upgraded at the same time as git itself.

>> Patch 4 I don't have anything to add or change at this point. 
>>
>> This patch has me pondering and I'm unsure of what I'd suggest, mainly
>> because of the addition of the smart http support meaning that git://
>> and http:// are legitimate and useful links for supporting full git
>> transactions.
>>
>> I may withdraw the patch entirely since the link on kernel.org has been
>> around for years, and I'm unsure if anything actually uses it (though I
>> can see it being useful still).  If it stays I think there's got to be a
>> way to specifically mark a url as being the one to link to vs.
>> defaulting to git:// (or allow for a marking to override the git://) and
>> I need to ponder that.
> 
> Also, it has to be _fast_, I think, i.e. no reading cloneurl and repo 
> config (for gitweb.url) for each repository.
> 
> You can always remove the check for "git://" prefix, and/or take first
> base in @git_base_url_list.

Taking the first one by default may make more sense - I'll try that.

>> I have given some initial thought to converting the $output options I'm
>> currently using to a print <FH> that Jakub is suggesting & exploring.
> 
> It's 'print {$fh}', i.e. use indirect filehandle, not global filehandle.
> 
>> I think all told it's going to be a similarly sized patch, since all
>> output still has to get adjusted (including the things that directly
>> output but don't print).  
> 
> print -> print {$fh} can be separate patch, and it can be checked that
> it produces the same results.  Well print -> $output .= could also be
> separate patch...
> 
>> I'm unsure if there's a real advantage to 
>> either way, other than design preference. My patch (forcing the output
>> to get passed around) moves towards more of a modal style design
>> separating data & layout vs. it's combined nature now, well it's a step
>> in that direction anyway.
> 
> Errr... what?  Forcing buffering (you need to read whole output into
> memory, including for snapshots (uncompressed in case of .tar.gz))
> is IMVHO orthogonal to the issue of separating data & layout.
> BTW. Modern web server interfaces like Rack, PSGI/Plack etc. explicitly
> include streaming support.

The inbuilt streaming support does change things, and I don't think it
ultimately changes my caching engine really anyway - I should have that
change done shortly.

> 
> The advantage of doing 'print {$fh}' is that $fh can be \*STDOUT, can
> be \$buffer, but can be filehandle to (temporary) file on disk, and
> you can even "tee" it, i.e. both write to memory/file, and to STDOUT.
> The number of possible choices / possible improvements is much larger.
> 
> And what is also important it means that people who do not use caching
> do not suffer latency penalty and memory pressure from caching 
> infrastructure they do not use.
> 
> 
> P.S. 
> Subject: [Virus] Exploit.PDF-9669
> X-Virus-Scanned: ClamAV 0.88.7/10275/Fri Jan  8 17:06:46 2010 on shards.monkeyblade.net
> X-Virus-Status: Infected with Exploit.PDF-9669
> X-Original-Subject: Re: [PATCHv3 3/4 (resent)] gitweb: Optionally add "git"
>  links in project list page
> 
> A message sent from <warthog9@eaglescrag.net> to
>         <jnareb@gmail.com>
>         <git@vger.kernel.org>
>         <warthog9@kernel.org>
> contained Exploit.PDF-9669 and has not been delivered.

Clamav on my personal server wigging out and deciding that all kinds of
stuff was PDF viruses, *NO* idea why.  I've had a different problem but
still involving Clamav on kernel.org.  Both had been working fine for
quite some time and the only thing I can think of is that either an
update from clamav went awry, or a date dependent thing triggered and is
causing havoc.

Should have a patch series out in an hour or so.

- John 'Warthog9' Hawley
