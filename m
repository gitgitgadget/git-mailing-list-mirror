From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 00:31:21 +0200
Message-ID: <20100418223120.GB3563@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004180246.18263.jnareb@gmail.com>
 <20100418005917.GO10939@machine.or.cz>
 <201004180324.54722.jnareb@gmail.com>
 <20100418021223.GP10939@machine.or.cz>
 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 00:31:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3d1n-0004lV-S8
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 00:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab0DRWbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 18:31:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39354 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753867Ab0DRWbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 18:31:23 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 34C33125A131; Mon, 19 Apr 2010 00:31:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145253>

Thanks for work on the proposal!

On Sun, Apr 18, 2010 at 02:22:20PM +0530, Pavan Kumar Sunkara wrote:
> 2.How would you measure its success or failure?
> There are two parameters which would majorly determine the success or
> failure of the project.
> 
>    * Splitting gitweb such that there should be no problem with the
> installation of gitweb across cross servers and cross systems.

I believe an important factor in the success of the project is getting
these changes merged upstream in the main Git branch.

If the rest of the project features is not merged (and it *won't* be for
the lack of trying), it will still be reasonably easy to use it as a
third-party modification. However, if the split-up itself will not be
merged, that will have big impact on the usefulness of the whole project
- so I consider this fairly crucial, please don't under-estimate this
part, getting things merged can take as much work as doing initial
implementation of the stuff! You should plan to submit these patches
quite early.

>    * It should be possible that the new gitweb requires less time to
> work on a git repository than any other git client.

I'm sorry, I don't understand this.

> 3.Describe your project in more detail.
> I would like to split the currently 6800 long piece of code in
> gitweb.pl perl script into small files which will result in better
> readability, maintainability and modifiability. The file structure of
> the new gitweb is given below and I will explain the working after it.
> 
> (From now on, I would like to call the actions of gitweb as modules of gitweb)
> 
> a) File Structure:
> 
>    * gitweb.pl -- Main script parsing urls and calling required modules
>    * gitweb.tpl -- The template of the web page (GUI) in which
> modules are embedded
>    * gitweb.css -- The style for the gitweb pages.
>    * gitweb.js -- javascript to make gitweb more interactive
>    * modules (dir) -- directory containing the write and read modules.
>    * lib (dir) -- some basic files like config, error_handler,
> templater, redirecter, htmlHelper etc..
> 
> The current gitweb makefile makes a gitweb.cgi from the perl script
> and requires apache or lighttpd server for it's working. I would like
> to continue this process but the change will be in the gitweb perl
> script. The new script includes config and other basic files, checks
> the URL, parses it, detects the module, manage session and includes
> the proper module. It then retreives the output of the module and
> substitutes it with the gitweb.tpl template file string and gives out
> a proper HTML, CSS web page. It also contains some basic library files
> in the lib directory. The new gitweb uses session variables to track
> some of the variables rather than including them in the url. The write
> modules need not be working in a gitweb installation like repo.or.cz,
> so we will also have an option to disable the write modules.

Frankly, I'm not very excited from this. First, I recommend that you
completely separate splitting of gitweb to smaller pieces (without any
major conceptual changes) both in the proposal and in actual
submissions.

Second, you should justify the introduction of session management and
templating. What is the point and why is it neccessary for your project
goals?

> b) Write modules of the client:
> 
>   1. Add Existing repositories to the gitweb -- This will list the
> given repo into gitweb config
>   2. Create new/Clone repositories into a given path [git init | git
> clone] -- This will create new repo and list it
>   3. Add/Remove/Move files [git add | git rm | git mv]
>   4. Stage/Unstage files [git add | git reset]
>   5. Add files to ignore list when u click on 'Ignore' link
>   6. Discard changes to a file in working copy [git reset]
>   7. Commit to the repository with a log message and an optional
> sign-off [git commit]
>   8. Switch branches [git branch]
>   9. A simple branch merging* [git merge]
>  10. Creating tags [git tag]
>  11. Checkout code to a specific commit or branch or tag [git checkout]
>  12. Push to a remote branch [git push]
>  13. Fetch/Pull from a remote branch [git fetch | git pull]
>  14. Garbage collection [git gc]

Sounds reasonable. What am I missing is a way to edit files through the
web interface. Also, please spec in more detail the difference between
[8] and [11].

>  15. Search for a part of code [git grep]

This is already supported by gitweb. And it's not a "write" operation.
;-)

> c) Read modules of the client: (most of this need not be written, just
> need to be organised)
> 
>   1. See the status of repository [git status]

How will you integrate this with the existing 'tree' action?

>   3. List all the commits with pagination [git log]

Why?

>   4. With every commit we can
>          * Visualise trees [git ls-tree]
>          * Visualise files and diffs [git show]
>          * Visualise annotations [git blame]
>   5. List all branches including remote ones [git branch]
>   6. Search commits, branches, authors etc..

I.e. what we already do?

> d) Usage of the client:
> * Install on intranet - A company when installs this gitweb along with
> some other login and account managing scripts will be able to order
> their employees to login and ask them to work on the code with out the
> security risk of providing ssh access to the git repository host.

Frankly, the net security risk of providing git-shell access is probably
lower than using a web interface. ;-) However, I still see this making
many corporate people happy and opening doors to less canonical Git
usecases - it also enables "zero config" ability to contribute to Git
projects, desirable for less technical users (artists etc.).

> I will try to make sure that the patches to be as small as possible
> and easily reviewable. Also my vacation starts on May 2nd and ends on
> August 1st. So most of the project work will be done during the start
> of the GSoC project rather than in the end.

Great!

> [May 4th week - June 1st week]
> Split the whole code of gitweb into framework structure and setup
> library files along with installation and configuration.

I think this might end up being rather tricky, and would appreciate you
detailing this out a bit more, including some expected dates for initial
patch submissions.

> [July 2nd week]
> Check for any possible and potential security loopholes or bugs

I appreciate that you are thinking about this, though I'm less sure if
this can be efficiently done as a batch job like this.

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
