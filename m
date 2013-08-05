From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH 2/3] hooks/post-receive-email: force log messages in UTF-8
Date: Mon, 5 Aug 2013 12:45:43 +0400
Message-ID: <20130805084543.GA11270@ashu.dyn1.rarus.ru>
References: <20130802232118.GB2963@elie.Belkin>
 <20130802232338.GD2963@elie.Belkin>
 <20130804145448.GA15097@dell-note>
 <20130804181440.GA2894@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Alexander Gerasiov <gq@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 10:45:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6GQL-0000bc-BR
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 10:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab3HEIpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 04:45:49 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:48081 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714Ab3HEIps (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 04:45:48 -0400
Received: by mail-la0-f42.google.com with SMTP id mf11so1827252lab.29
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=j5cwWoOEGDzfpa/QfzpB12cGufR30SgTp56Fe8Y4hVQ=;
        b=O/Ozs/VFZLv9OzqzdTtd32qjErp06xX/CZOcK0nCSH/s5Wg6VgpH65hBHQHJV+PVlz
         HRh7qpzvhL080xPfA3owzs8qpIZK9DuCQZC4kFoI1jxTyHGrnssIOqHRHuEI3hUywSdN
         sOpYLABxAkVzpl/5O0FVcUd3Imru9NYQ/p2zP2vNlNDG+Xx3nU/ynctBXneasnq9xzVH
         mt5SZLgFtY2XBMSVW5PH0v0hhn2c72hDbIm5yZOxDxSfXvwRpb8IfdDEltSQ0Sqecc6h
         efsZKCS62duJ9hzTUhp9itGV9UFJBkW1vdPyB/Eaw02kJ7QK3hp7bJbIycYTqhtzPV99
         6ZvQ==
X-Received: by 10.152.29.103 with SMTP id j7mr8023485lah.7.1375692346461;
        Mon, 05 Aug 2013 01:45:46 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id f8sm6487303lbf.5.2013.08.05.01.45.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Aug 2013 01:45:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130804181440.GA2894@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231640>

On Sun, Aug 04, 2013 at 11:14:40AM -0700, Jonathan Nieder wrote:
> Alexey Shumkin wrote:
> > On Fri, Aug 02, 2013 at 04:23:38PM -0700, Jonathan Nieder wrote:
> 
> >>  1. Log messages use the configured log output encoding, which is
> >>     meant to be whatever encoding works best with local terminals
> >>     (and does not have much to do with what encoding should be used
> >>     for email)
> >>
> >>  2. Filenames are left as is: on Linux, usually UTF-8, and in the Mingw
> >>     port (which uses Unicode filesystem APIs), always UTF-8
> >
> > I cannot say exactly if it makes sense for THIS patch, but I'd like to
> > remind about Cygwin port, which definitely does not use UTF-8 encoding
> > (in my case it is Windows-1251) for filenames.
> >
> >> 
> >>  3. The "This is an automated email" preface uses a project description
> >>     from .git/description, which is typically in UTF-8 to support
> >>     gitweb.
> 
> Thanks for clarifying.  So in the context you describe, (1) is
> configurable, (2) is Windows-1251, (3) is unconfigurably UTF-8, and
> there is no way with current git facilities to force the email to use
> a single encoding unless (3) happens to contain no special characters.
> 
> What is the value of the "[i18n] commitEncoding" setting in your
> project?
commitEncoding is equal to filenames' encoding, Windows-1251, of course.

> What encoding do the raw commit messages (shown with
> "git log --format=raw") use for their text, and what do they declare
> with an in-commit 'encoding' header, if any?
Well, despite `git log --help` 
--8<--
raw
           The raw format shows the entire commit exactly as stored in
           the commit object"
--8<--
on a Linux box (UTF-8) I can see "readable" commit messages nevertheless
they are stored in 'Windows-1251' (so they are converted to UTF-8). To
be sure I've checked actual content of them with `git cat-file commit`
Actually, to be honest, I usually use modified version of Git (see
ecaee8050cec23eb4cf082512e907e3e52c20b57) in 'next' branch, that could
affect the results, so I've checked `git log --format=raw` with
unmodified v1.8.3.3 of Git.

But let's go back to the answer to your question. Commit encoding stored
as a header in a raw commit messages is 'Windows-1251'.
> 
> Does everyone on this project use Cygwin?i
This is a "closed" (commercial) project and every developer uses Cygwin,
except me. I use a Linux box as a desktop (mail, IM, web-browsing; but
development goes on Cygwin). And sometimes I run utility scripts
included to that project on my desktop (as far as Linux works with files
much faster than Cygwin does ;))
Also, a Git server is a coLinux box (http://www.colinux.org/) on a
Windows Server 2003, but I guess, it does not much matter here.
>  That should be fine, but
> I'd expect there to be problems as soon as someone wants to try the
> Mingw port ("Git for Windows").
Yep, one of our developers tried to use modern version of TortoiseGit
with MinGW port of Git. That was a failure. As far as since v1.7.9 MinGW
port transcodes filenames to store them internally in UTF-8. This
problem could be solved with converting once that non-ASCII filenames to
UTF-8, but I do not want to use MinGW port. I like Cygwin
"infrastructure" that is more Linux-like than MinGW.
> 
> I wonder if there should be an "[i18n] repositoryPathEncoding"
> configuration item to support this kind of repository.  Then git could
> be aware of the intended encoding of paths, could recode them for
> display to a terminal, and at least on Linux and Mingw could recode
> them for use in filenames on disk.  "repositoryPathEncoding = none"
> would mean the current behavior of treating paths as raw sequences of
> bytes.
I'd be happy if such a setting exists. That could solve many problems
with cross-platform projects with non-ASCII filenames.
Indeed, MinGW port does resolve that problem somehow!
> 
> What do you think?
> Jonathan

-- 
Alexey Shumkin
