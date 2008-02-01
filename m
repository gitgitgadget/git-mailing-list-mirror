From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's name.
Date: Fri, 1 Feb 2008 01:17:07 +0100
Message-ID: <200802010117.08295.jnareb@gmail.com>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br> <m3bq728y4o.fsf@localhost.localdomain> <alpine.LSU.1.00.0801311110280.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 01:17:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKjbM-0000xb-Jx
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 01:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbYBAARS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 19:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755565AbYBAARS
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 19:17:18 -0500
Received: from hs-out-0708.google.com ([64.233.178.243]:3251 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753012AbYBAARQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 19:17:16 -0500
Received: by hs-out-2122.google.com with SMTP id 54so751271hsz.5
        for <git@vger.kernel.org>; Thu, 31 Jan 2008 16:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=xCxoAsXbVLkXpPi1uYWZIJRAoP+QMzcKvHvh7cwbZos=;
        b=JJ6QCvDt48ij33775R+zf9shW946+d/2S11W4smRfHsTTKu8pfz/VflCjuKGDZryAzbdqTX4hNBB/j2AV6OBOuKALSNgfa+q9Cn5mAGMFv/0P+ckTfh5DaNnDy/9mMOo30ilV08xC4+PVMKEpXliAvO9P1FURJ9dpQHOAWLWGxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c7HnM5ygCI/MPgam5oY2EERLnMuXbinf/kDTlBj9RSSHAjbI/P/HtUNUXbc++w72mVyQ5lcIBFVODiVqxIa+Rld88Pby0AgeFspWUV+Egk87aCIAlg0xGlfYZUn6wVLPMzbUI5DiInMVrsaUK4ZRJn5oNFWKKNLYmvhN5h3mFvc=
Received: by 10.114.209.1 with SMTP id h1mr3201285wag.115.1201825034801;
        Thu, 31 Jan 2008 16:17:14 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.248.93])
        by mx.google.com with ESMTPS id g17sm6226889nfd.10.2008.01.31.16.17.11
        (version=SSLv3 cipher=OTHER);
        Thu, 31 Jan 2008 16:17:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0801311110280.23907@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72143>

On Thu, 31 Jan 2008, Johannes "Dscho" Schindelin wrote:
> On Wed, 30 Jan 2008, Jakub Narebski wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> 
>>> Rephrasing to be constructive (but remember, this is all post 1.5.4).
>>> 
>>>  * we would need for historical reasons to keep supporting
>>>    description and cloneurl for some time.  There may be some
>>>    others, but the goal should be to deprecate and remove these
>>>    ad-hoc one-file-per-piece-of-information files.
>>> 
>>>  * we also need for historical reasons to keep supporting some
>>>    other stuff found in $git_dir/config of the project.
>>> 
>>> If the config reading interface in gitweb is reasonably fast and 
>>> cheap, we can move the existing description/cloneurl to gitweb config 
>>> when deprecating them.  New ones such as "owner" would naturally fit 
>>> there.
>> 
>> Currently gitweb parses repo config file _once_, using one call to 
>> git-config -z -l.
>> 
>> We could simply add description to the projects_list file, but it will 
>> be a bit backwards incompatibile change.
> 
> Not if you say "the config overrides the description/cloneurl file", i.e. 
> when there is a description or a cloneurl from the config, don't even 
> bother to stat the single-line files.

Errr... what I wanted to say there is instead of current format of
'projects_list' file which is:
  <URI-encoded project path> SPC <URI-encoded owner> LF
add also project description to that file, so the format would be
  <URI-encoded project path> SPC <URI-encoded owner> SPC
    <one-line project description> LF
(project description doesn't need to be URI encoded). This means
avoiding reading $git_dir/description (and in rare cases also avoiding
gitweb.description in $git_dir/config).

This is of course a bit backwards incompatibile.

> That would help transition, and still be backwards compatible.  (BTW this 
> resembles what we did for the .git/remotes/* -> .git/config transition.)

Note that some of info is needed for 'projects_list' view, and some only
for the 'summary' view.  For the 'projects_view' page we would want to
avoid, I think, calling "git config -z -l" per repository (or opening
$git_dir/config file and [limited] parsing it inside gitweb in Perl,
like git-cvsserver does).  For 'summary' view we want usually to read
repo config file for features nevertheless, and is only once per
web-page, so we don't avoid it then.

Currently for 'projects_list' view we have, when $projects_list is
a directory (this includes situation when it is undef, and fallbacks
to $projectroot):
 1. Call git-for-each-ref to get last modification time
 2. Read $git_dir/description file for description (which is generated
    by default template, so is usualy present, if in useless form),
    fallback to git-config / reading $git_dir/config, gitweb.description
 3. Check owner of $git_dir (stat + getpwuid)

With the addition of $git_dir/owner and gitweb.owner we would have
 3'. Read $git_dir/owner file, usually not present,
     fallback to gitweb.owner (which means reading and parsing
     repo config!),
     fallback to $git_dir owner (stat + getpwuid)
so after consideration I think that adding gitweb.owner is a bit of
a stupid idea from performance point of view, at least till we have
'projects_list' caching. Only $git_dir/owner would be better.
 
BTW. what about filesystems where file / directory does not have
an owner?


Another solution would be using $projectroot/.gitconfig, with simplified
syntax easy parseable by Perl, with gitweb.<repo path>.<config>, where
<config> is limited to 'description', 'owner' and 'url', and 
gitweb.description for fallback description, gitweb.owner for fallback
owner and owner for set of repositories, gitweb.baseurl for base URLs
(gitweb.<repo>.url = gitweb.baseurl/<repo>).

This would limit repo paths to not have embedded newlines in them, but
this is not I think serious limitation :-)

-- 
Jakub Narebski
Poland
