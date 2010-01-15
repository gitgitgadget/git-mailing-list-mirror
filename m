From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 0/9] Gitweb caching v5
Date: Thu, 14 Jan 2010 20:29:39 -0800
Message-ID: <4B4FEF33.2040605@eaglescrag.net>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net> <m37hrkdu4k.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 05:31:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVdqV-00074n-On
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 05:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab0AOEaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 23:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957Ab0AOEaX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 23:30:23 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:57039 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab0AOEaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 23:30:22 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0F4Tdww024268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 14 Jan 2010 20:29:39 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <m37hrkdu4k.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 14 Jan 2010 20:29:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137049>

On 01/14/2010 05:40 PM, Jakub Narebski wrote:
> "John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:
> 
>> Afternoon everyone,
>>  
>> This is the latest incarnation of gitweb w/ caching.  This is
>> finally at the point where it should probably start either being
>> considered for inclusion or mainline, or I need to accept that this
>> will never get in and more perminantely fork (as is the case with
>> Fedora where this is going in as gitweb-caching as a parrallel rpm
>> package).
>>
>> That said this brings the base up to mainline (again),
> 
> Could you tell us which commit is the base of this series (like in
> git-request-pull output), i.e. which commit this series is rebased
> against?

This series was based on
git://git.kernel.org/pub/scm/git/git.git
054d2fa05cf0bc55fe1556c9e87d58d67a144f44

http://git.kernel.org/?p=git/warthog9/gitweb.git;a=shortlog;h=refs/heads/gitweb-ml-v5

> 
>> it updates a
>> number of elements in the caching engine, and this is a much cleaner
>> break-out of the tree vs. what I am currently developing against.
> 
> Is caching engine part changed since v2?

Slightly, not dramatically.  Only changes were to modify the caching
engine to deal with the change in output mechanism (I.E. my $output ->
print {$fh})

<snip>
>> John 'Warthog9' Hawley (9):
>>   gitweb: Load checking
> Looks good.
> 
>>   gitweb: change die_error to take "extra" argument for extended die
>>     information
> Commit message could be better (summary should really be shorter), and
> I think there is some indent typo, but otherwise looks good.
> 
>>   gitweb: Add option to force version match
> For me it needs to be disabled in gitweb test suite (t/gitweb-lib.sh),
> if it is enabled by default.  I really like that I can test current
> gitweb without need to recompile git.
> 
> Also it should have tests that it works as intended (both for matching
> and non-matching versions) in t/t9501-gitweb-standalone-http-status.sh

I'll get t9501 cleaned up and make sure that the tests default to
turning it off, and I'll add a test to confirm that this works.

>>   gitweb: Makefile improvements
> Does it differ from my proposal (i.e. gitweb/Makefile doing the work),
> based on your idea ("make gitweb" for Makefile and gitweb/Makefile)?

I think this is taken straight from the version you had, I don't think
I've modified it.

> 
>>   gitweb: add a get function to compliment print_local_time
>>   gitweb: add a get function to compliment print_sort_th
> Those two looks O.K. from what I seen.
> 
>>   gitweb: cleanup error message produced by undefined $site_header
> Shouldn't there be such protection for other such variables, like
> $site_footer and $home_text (and a bit diferent protection against
> undefined $projects_list)?  By the way, how did you arrived at
> undefined $site_header: deafult build configuration leaves it empty,
> but defined.

I would have to go back and figure it out, but it's something I hit
years ago and added that check to keep it from spewing all over my logs.
 Could easily add it to the others mentioned.

>>   gitweb: Convert output to using indirect file handle
> I have alternate solution, using shorter filehandle name (just $out)
> in
> 
>   git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel
>   http://repo.or.cz/w/git/jnareb-git.git/shortlog/refs/heads/gitweb/cache-kernel
> 
> I would have to think a bit about separate handle for binary files;
> I am not sure if it is really required.

For caching you have to have it.  When your outputing the data back from
the cache you need to switch the output mode for the browser to receive
the data properly.  Otherwise the resulting output from the caching
engine is going to be garbage.  The caching engine explicitly stores the
binary files separate from the rest of the response.

>>   gitweb: File based caching layer (from git.kernel.org)
> I am working (time permitting) in spliting this large code drop into
> smaller commits, namely:

first up, is there a reason not to take the caching layer as it stands
while you work on these?  I'm fine with adding test cases for what's
there now if you want, but I guess I'm confused about explicitly wanting
to break these into smaller commits.

>  - href(..., -path_info => 0)          (for cache key)

You actually *really* want to have the full url vs. just the path_info.
 While I accept that this means that you will end up with multiple
copies of data being stored it helps dramatically if you have multiple
sites pointing into the same caching space.  If you happen to have two
distinct trees

http://git.public.com/?p=test.git;a=summary
http://git.private.com/?p=test.git;a=summary

That respectively point to:

/group/public/git/test.git
/group/private/git/test.git

you'll end up squashing the cache files needlessly and erroneously as
what's in the cache file will depend on what last site was hit that
generated the file.

>  - simple file based caching + tests
>  - global expire time + tests
>  - output caching in gitweb            (WIP)
>  - adaptive expiration time            (planned)
>  - tee output / cache write            (planned)

You sadly can't 'tee' the output as this would re-introduce the
stampeding heard problem which is one of the reasons the caching layer
came about in the first place.  Suppose you could give one person the
output but make everyone else wait for the cache to finish writing out,
or have the waiting client processes tail the file while it's generated
but those both seem a little excessive vs. just waiting.

>  - expire time variation from CHI      (planned)
>  - locking for single writer           (planned)
>  - server-side generating info         (planned)
>  - AJAX-y generating info              (wishlist)

If it's helpful I can genuinely devote several more days to this to get
these cleaned up.  Which would save you a fair amount of time in
breaking this up.

- John 'Warthog9' Hawley
