From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 4/3] gitweb: Incremental blame (proof of concept)
Date: Thu, 11 Dec 2008 09:28:09 -0800 (PST)
Message-ID: <m3r64ehba7.fsf@localhost.localdomain>
References: <20081209223703.28106.29198.stgit@localhost.localdomain>
	<20081210200908.16899.36727.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 18:35:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LApS2-0007qB-JS
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 18:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666AbYLKReW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 12:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756660AbYLKReW
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 12:34:22 -0500
Received: from mail-bw0-f13.google.com ([209.85.218.13]:36248 "EHLO
	mail-bw0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651AbYLKReU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 12:34:20 -0500
Received: by bwz6 with SMTP id 6so2537508bwz.13
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 09:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=IVAc2VkPcx9M4MQFPC+PWkL6f7Gru86BxhAYO6AtklA=;
        b=XRoN0rmFgMXWnGAtw+kt2ow7mWmAKM/K+m/OuogXvhmmvB2KTCUo53bq8yg8Bi60fN
         NfWel6j924ervYn+dLqxVGLXkWsCUbaw/0tVP6oSTPa1ZWvVcR9ZEL0SfAHx6VKiw+Zj
         7NB+f5VGo41OsFHzivvc/N9dLIGDGWv4vCPNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Oa1agtViP1ChlC+5uM7w2+lNHmAg2wVSFxlbspdTHSDuL8J98adQMduV21UvQjc4hm
         fYdHtj/BgIFwoS++eO3U7gmZ7XKZGM5M3yf7RO4EdjCYxppNqNZFKC8DIs3eHGRp0vT7
         l8tV7GylRtrt2A/ZnUurt+l3NPKHIgrfYKynM=
Received: by 10.103.193.12 with SMTP id v12mr1248174mup.23.1229016490696;
        Thu, 11 Dec 2008 09:28:10 -0800 (PST)
Received: from localhost.localdomain (abvq79.neoplus.adsl.tpnet.pl [83.8.214.79])
        by mx.google.com with ESMTPS id i5sm2016163mue.16.2008.12.11.09.28.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Dec 2008 09:28:09 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBBHS2Tw024253;
	Thu, 11 Dec 2008 18:28:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBBHS0o3024250;
	Thu, 11 Dec 2008 18:28:00 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081210200908.16899.36727.stgit@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102808>

Jakub Narebski <jnareb@gmail.com> writes:

> This is tweaked up version of Petr Baudis <pasky@suse.cz> patch, which
> in turn was tweaked up version of Fredrik Kuivinen <frekui@gmail.com>'s
> proof of concept patch.  It adds 'blame_incremental' view, which
> incrementally displays line data in blame view using JavaScript (AJAX).

[...]
> Patch by Petr Baudis this one is based on:
>   http://permalink.gmane.org/gmane.comp.version-control.git/56657
> 
> Original patch by Fredrik Kuivinen:
>   http://article.gmane.org/gmane.comp.version-control.git/41361
> 
> Snippet adding 'generated in' to gitweb, by Petr Baudis:
>   http://article.gmane.org/gmane.comp.version-control.git/83306
> 
> Should I post interdiff to Petr Baudis patch, and comments about
> difference between them? [...]

Here is the list of differences between Petr Baudis patch and the one
I have just send.  No interdiff, as it is artificially large because
previous patch was based on much older version, so ranges does not
match.

Bugs I have made:
 * I forgot to make some changes for git-instaweb.sh to have support
   for incremental blame, namely dependency of 'git-instaweb' target
   in Makefile on gitweb/blame.js, and lack of the following line in
   git-instaweb.sh:
        gitweb_blamejs $GIT_DIR/gitweb/blame.js

 * Pasky's patch added support for href(...,-partial_query=>1) extra
   parameter, which ensured that gitweb link had '?' in it, and used
   it to generate 'baseUrl' parameter for startBlame.  I have
   misunderstood what baseUrl is about, and used $my_url there, while
   it is partial URL for blame links: it is projectUrl.

   Therefore links in blame table current 'blame_incremental' would
   not work. I'm sorry about that, I thought I have checked it...

Intentionally omitted features:
 * In patch this one is based on there was fixBlameLinks() JavaScript
   function (put directly in the HTML head inside <script> element),
   which was used in body.onLoad event to change 'a=blame' to
   'a=blame_incremental' in links marked with class="blamelink".

   First, this IMHO should be put as separate patch; you can test
   'blame_incremental' view by hand-crafting gitweb URL.  Second, it
   would be not enough in current gitweb, as action can be put in
   path_info. So either fixBlameLinks() should be made work in both
   cases, or it should be done in different way, for example adding
   'js=1' for all links, or doing JavaScript redirect from 'blame'
   view (although this way we won't be able to view ordinary 'blame'
   view without turning off JavaScript).

Differences in coding of the same features:
 * In Pasky's patch git_blame (then named git_blame2) and
   git_blame_incremental were just wrappers around git_blame_common;
   in this patch git_blame_data is also wrapper (to avoid duplicating
   permissions and parameter checking code).

 * Instead of calculating title string for "Commit" column cell, and
   necessary data for each row, we now calculate it once per commit
   and save (cache) in 'commits' associative array (hash).

   This is a bit of performance improvement, similar to the one in 
     "[PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()"
   for 'blame' view in gitweb. It is just using Date() and string
   concatenation, and not extra fork.

 * Variables holding manipulated elements are named a bit differently,
   and calculated upfront:
      td_sha1   instead of  tr.firstChild
      a_sha1    instead of  ahsAnchor
      a_linenr  instead of  lineAnchor

 * There were a few of style changes in gitweb/blame.js; for example
   it is used the following style of function definition

      function functionName(arg1, arg2) {

   thorough the code.

Fixes for bugs in Pasky's patch, and changes related to changes in
ordinary 'blame' output: 
 * handleResponse function was called only from XMLHttpRequest
   onreadystatechange event. Not all browsers call onreadystatechange
   each time the server flushes output (Firefox does that), so we use
   a timer to check (poll) for changes.

   See http://ajaxpatterns.org/HTTP_Streaming#Refactoring_Illustration

 * The 'linenr' link was to line number commit.srcline, while it
   should be to (commit.srcline + i), as commit.srcline is _start_
   line in group, and not the line equivalent to current line in
   source.

   This might be thought a (mis)feature, and not a bug, though.

 * Currently 'blame' view uses single cell (with rowspan="N") spanning
   the whole group of lines blaming the same commit, instead of using
   empty cells for subsequent lines in group.  Therefore instead of
   setting "shaAnchor.innerHTML = '';" to make subsequent cells in
   "Commit" ('sha1') column empty (or rather to make link element <a>
   in cell empty), we use "tr.removeChild(td_sha1);"

   This change was made necessary by changes in the 'blame' view.
   This also meant that the code checking if lines are in the same
   group has to be changes; it was refactored into startOfGroup(tr)
   function.

 * The title for cells in "Commit" column used UTC (GMT) date and time
      'Kay Sievers, 2005-08-07 19:49:46'
   instead of the localtime format used currently by 'blame' view:
      'Kay Sievers, 2005-08-07 21:49:46 +0200'
   Current code uses neither, but 'commit'-like format:
      'Kay Sievers, 2005-08-07 19:49:46 +0000 (21:49:46 +0200)'

New features (in short):
 * 3-coloring of lines with blame data during incremental blaming
 * Adding author initials below shortened SHA-1 of a commit
   (if there is place for it, i.e. if group has more than 1 row)
 * progress indicator: progress info and progress bar
 * information about how long it took to run 'blame_data',
   and how long it took to run JavaScript script

-- 
Jakub Narebski
Poland
ShadeHawk on #git
