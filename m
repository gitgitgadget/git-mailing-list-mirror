From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 18:25:45 +0700
Message-ID: <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:26:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcaM4-00078s-3Z
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab2KYL0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:26:17 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52988 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab2KYL0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 06:26:17 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so9971202oag.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 03:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uGRlQFkayF3au5NF5dpLhsfL+sWeYLr4RVH6gCFnB0E=;
        b=W/+x9KgfSTNgoqA0uitmfhJY+extxq/+rclUxB+3+HPXdzBC1ofyMfJmNdSZ1QCpE6
         kpCbAj+d3uhWXgTalwAkuJop6YmdIRd73HelhaefayiIUqVq+gKzW0+0+Gmhjdo99MCl
         VoozJ6851LMtNxA9B/pfKbAis7/M0WPyjctwW60YpGgpbX1DX39ppIoG8D7svKd7Eyug
         g2uhsITG7FyDZNaYs7hCnG1QyZUBXi4VYt5b95ANK0OMifvAyN51pT5P4QySqssbfFWH
         tfSUD4Ypg3RYtCx7k5kRCr8icZO6yXAwYJPdUn5Oiit0pSSqIwZK+TCYdr0EPx4p0bxj
         Asvg==
Received: by 10.60.8.103 with SMTP id q7mr6731181oea.70.1353842776444; Sun, 25
 Nov 2012 03:26:16 -0800 (PST)
Received: by 10.182.87.197 with HTTP; Sun, 25 Nov 2012 03:25:45 -0800 (PST)
In-Reply-To: <50B1F684.5020805@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210364>

On Sun, Nov 25, 2012 at 5:44 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On the contrary, there is *constant* traffic on the mailing list about
> incompatibilities between different shell implementations (sh, dash,
> bash, etc), not to mention those in other utilities (sed, grep, etc)
> that one is forced to work with in shell scripts.  Compatibility is a
> *huge* pain when developing shell code for git.  The fact that users
> typically don't encounter such problems is due to the hard work of POSIX
> lawyers on the mailing list correcting the compatibility errors of
> mortal programmers.

I think we still are in the process of moving away from shell-based
commands (not the shell interface), just not enough man power to do it
fast. The only shell-based command with active development is
git-submodule. So most shell PITA is in the test suite.

> The most important issues to consider when imagining a future with a
> hybrid of code in C and some scripting language "X" are:
>
> * Portability: is "X" available on all platforms targeted by git, in
>   usable and mutually-compatible versions?
>
> * Startup time: Is the time to start the "X" interpreter prohibitive?
>   (On my computer, "python -c pass", which starts the Python
>   interpreter and does nothing, takes about 24ms.)  This overhead would
>   be incurred by every command that is not pure C.
>
> * Should the scripting language access the C functionality only by
>   calling pure-C executables or by dynamically or statically linking to
>   a binary module interface?  If the former, then the granularity of
>   interactions between "X" and C is necessarily coarse, and "X" cannot
>   be used to implement anything but the outermost layer of
>   functionality.  If the latter, then the way would be clear to
>   implement much more of git in "X" (and lua would also be worth
>   considering).
>
> * Learning curve for developers: how difficult is it for a typical git
>   developer to become conversant with "X", considering both (1) how
>   likely is it that the typical git developer already knows "X" and
>   (2) how straightforward and predictable is the language "X"?
>   In this category I think that Python has a huge advantage over
>   Perl, though certainly opinions will differ and Ruby would also be
>   a contender.

* We might also need an embedded language variant, like Jeff's lua
experiment. I'd be nice if "X" can also take this role.
-- 
Duy
