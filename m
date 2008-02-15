From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Another bench on gitweb (also on gitweb caching)
Date: Sat, 16 Feb 2008 00:19:08 +0100
Message-ID: <200802160019.09490.jnareb@gmail.com>
References: <20080210030919.GA32733@c3sl.ufpr.br> <200802140201.55420.jnareb@gmail.com> <1203029034.4766.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 00:20:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ9qz-00040H-IG
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 00:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761903AbYBOXTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 18:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761771AbYBOXTV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 18:19:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:57163 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761414AbYBOXTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 18:19:18 -0500
Received: by nf-out-0910.google.com with SMTP id g13so457380nfb.21
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 15:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=9BYmDRbsLAzrI0IRBgmbr/MwlsG6IMzf6NDxtlLZ9x4=;
        b=uTkeDWam1LcO8xsgzAxHHlg8nWsjlTjN65mqc0XW1NUemg3H/0PMrhPjCUSRqtYcFoF5yybDpd85J9EPUai10fID0veHYWth3AkBJCCMTqlp9ZXuIJEPWOf2gomDVsTvo2aNcY4Az3LkMLNRqvFD/9t3L/m8ubZ0OQm9gJ+XlFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=U9LjYKd1pHCUB+rIYNzPHUu3kJyKztb9oXwi7R1PvVqXiZLlmPXg86Q98S/uvUVOcWnEvBvNhB1k0vSbK+v/cRo4HfGYGIr9M5iCaPvpiz1BisZGGSbQCKNZwexdpr679fTKr84IW+fjgIlI7XoWL3YWecrc3RahmjubgsxawW0=
Received: by 10.78.133.2 with SMTP id g2mr4557219hud.29.1203117556036;
        Fri, 15 Feb 2008 15:19:16 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.186])
        by mx.google.com with ESMTPS id y37sm7465263iky.7.2008.02.15.15.19.12
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 15:19:14 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1203029034.4766.19.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73995>

On Thu, 14 Feb 2008, J.H. wrote:
> On Thu, 2008-02-14 at 02:01 +0100, Jakub Narebski wrote: 
>> On Wed, 13 Feb 2008, J.H. "Warthog9" wrote:
>>> On Wed, 13 Feb 2008 13:17:46 +0100, Jakub Narebski wrote:
>> 
>> By the way, why did you split into so many modules? I would think
>> that separating into generic modules (like for example commit parsing),
>> HTML generation modules (specifing to gitweb) and caching module;
>> perhaps for easier integration only main gitweb (core version)
>> and caching module would be enough.
> 
> I did it originally for a couple of reasons:
> 
> 1) a single script that's almost 6000 lines long is a little hard to
> handle in a single gulp.  I can appreciate why it's being done that way,
> mainly to simplify installation, but...
> 
> 2) ... I needed something to help me understand the flow of code more -
> ripping it apart was a good way to do it and try and group similar
> functions.

If I remember correctly the "great renaming", renaming subroutines
and a bit of code restructurization (moving subroutines so similar
subroutines are together) came later.

> There is an obvious downside, in retrospect, to me doing it this way - I
> can't track upstream *nearly* as easily as I would like.  Which means
> that the code gitweb-caching is based on is about a year and a half old
> (it has had a major update along the way but that took me two days of
> manually applying patches to get updated)
> 
>> I was thinking about adding caching, using code from your fork,
>> to git.git gitweb, somewhere along the line... I guess I can move
>> it earlier in the TODO list, somewhere along CSS cleanup and log-like
>> views generation cleanup, and using feed links depending on page.
> 
> It's on my todo list as well, basically re-base to current head and
> instead of breaking stuff up like I did in the original, completely redo
> the tree so that I can pull from trunk easier.  Considering I'll have
> some time that I can spend on my OSS projects in the next couple of
> weeks again - I was going to try and get this accomplished and back into
> my tree.

Better you than me. I don't know if I'd have time for it, and obviosly
I don't know as well the caching code.
 
>> Unfortunately cgit is not designed to be gitweb compatibile; it is
>> simplier (which might be considered better), doesn't support the
>> multitude of gitweb views, and unfortunately doesn't understand
>> gitweb URLs.
> 
> Sadly - that makes it more or less unusable to us at this point.  There
> are, I'm sure, a number of links that point back to kernel.org that
> would be nice to not break - if it's really felt that this isn't the
> case I would consider switching, but if gitweb + my caching code works
> it might be better for me to try and get the code merged back into trunk
> and not risk changing infrastructure that's been in place for several
> years now.

Truly, it would be nice if cgit had compatibility mode, accepting gitweb
(or gitweb-like) URLs, and returning similar page. Or at least
mod_rewrite rules to rewrite gitweb URLs to equivalent cgit ones.

>> [...] one should balance between not having cache
>> at all (and spending all the CPU), to caching everything under the
>> sun (and spending all the HDD space). To that one should know which
>> pages are most requested, so they would be cached by having static
>> page to serve; which generate most load / are less requested, so
>> perhaps git commands output would be cached; and which are rare enough
>> that caching is waste of disk space, and hints to caching proxies
>> should be enough.
> 
> To a greater extent, disk is cheap, and load is expensive.  While I
> agree it would be worth spending cpu time to not cache things - thats
> not the way gitweb / git works.  Gitweb forces calls down to disk if
> it's displaying the index page or showing a diff between two
> revisions.

What I mean here was to have caching in gitweb for pages like projects
list, summary for a project, main RSS/Atom feed for a project on one
hand, but just adding Last-Modified: and (weak?) ETag: headers plus
a year expire (or was it half of a year be infinity according to RFC?)
for immutable rarely (I think) accessed pages, like 'blob' view of given
file at given revision, or 'commit' view, or even perhaps 'tree' view
(all for given by immutable sha-1 revision / object-id).

And in the middle ground we could habe saving git command output in
a kind if "git cache", like storing update / change time for each
project; another example would be incremental blame output.

> The problem comes in that git, while fast, is very resource 
> intensive, requiring a lot of ram and a lot of disk seeking - on a very
> busy setup, disk seeking is a killer.  What you want to be able to do
> is take a file and just run it straight out, not have to poke around to
> re-assemble everything and then output.  This is one of the reasons why
> the index page is so painful - it's reassembling bits from *every*
> repository.  It's not cpu that's getting hit, it's the disk and ram
> that's getting hit.

True, the projects list especially with so large number of projects
just have to be cached. It is a pity that due to histerical raisings^W^W
historical reasons called backwards compatibility we cannot just put
projects search page, or projects catalogue (projects divided into
categories) instead of listing of all projects. Or at least divide
projects list in pages... Though the last option is not that good,
unless you somehow can include most commonly requested projects
on the main page.

> So yes - while I agree caching can be expensive, in very high volume
> setups you have to have caching of some sort.  Caching proxies aren't
> smart enough for something like gitweb either, having a caching layer
> directly in gitweb makes a lot more sense - you know what pages need
> caching, which ones don't, what may be hit harder than others, what you
> can have a longer cache timeout, etc on.

I can agree with that.

On the other hand you are duplicating effort what is already done:
selecting what to cache, when to invalidate cache, when to prune / purge
cache etc. But I guess that having gitweb provide hints to caching
engines in the form of Last-Modified: and ETag:, and responding quickly
to If-Modified-Since: and If-None-Match: requests / HEAD requests
might be not enough; and responding to If-* requests might be not easy;
well, not easier than implementing caching inside gitweb.
 
>> [...]
>>> As for the most often hit pages - the front page is by far hit the most,
>>> which should be no surprise to everyone, and it is by far the most
>>> abusive since it has to query *every* project have.  After that things
>>> taper off as people find the project they want and go looking for the
>>> data they are interested in.
>> 
>> But what of those pages are most requested and generate most load?
>> 'summary' page? 'rss' or 'atom' feeds? 'tree' view? README 'blob'?
>> snapshot (if enabled)?
> 
> Right now I don't have explicit statistics on that, though it wouldn't
> be hard to add in an additional file or small database of some sort
> that would track generation times.  

Profiling websites. Debugging websites. I don't think it is easy...

> My gut feeling is the index page is 
> the worst (particularly with the number of trees we have), followed by
> the summary pages, and from there things will fall off dramatically as
> most pages after that may not get hit often.

What about RSS feeds (as compared to summary page for example)?
    
>>>>  How new projects are added (old projects
>>>> deleted)?
>>> 
>>> By and large - left up to the users - if they don't want their tree
>>> anymore they delete it (though I don't know of anyone who has) if they
>>> need another one - they create it.
>> 
>> Bummer. If projects were created by some script (like I think is
>> the case for git hosting facilities, like repo.or.cz, GitHub,
>> Gitorious or TucFamily) we could update projects listing file
>> (so gitweb doesn't need to scan directories), and perhaps even
>> add some gitweb-specific hooks (add multiplexer + hooks).
> 
> At this point the git tree is left up to the user and we have no
> intention of changing it, we don't even force them to turn on the
> post-update hook that will deal with git-update-server-info.
[...]
> They could be useful, but this is completely left up to the tree's
> owner, we provide a location for them to publish their trees, we don't
> want to control or limit how or what they do with those trees.

Do the project list on kernel.org is then generated by scanning
filesystem ($projects_list unset, or set to directory)?


I have asked about this because with projects added, renamed and
deleted by script you can generate / regenerate projects list file
when chaning a project. I guess that you could in theory watch
filesystem for that...

If you can add gitweb's update / post-receive hook you would be able
to update file with "last changed" information, and delete or regenerate
caches for output which depend on the tip of current branch: project
summary, RSS feeds etc.

But if it is truly "no can do", then you have to implement storing
cache and invalidating caches yourself...

-- 
Jakub Narebski
Poland
