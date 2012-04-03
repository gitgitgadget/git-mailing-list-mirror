From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Tue, 3 Apr 2012 13:48:03 -0500
Message-ID: <20120403184803.GH15589@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <2487557.B8qfnaixh3@flomedio>
 <20120402205659.GA13725@burratino>
 <2576556.3d3popQR3z@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 20:48:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF8mJ-0008QC-SX
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 20:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab2DCSsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 14:48:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54612 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab2DCSsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 14:48:17 -0400
Received: by gghe5 with SMTP id e5so18989ggh.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ihy+CV7APn4PmZiXDDXAg2Ci10ERzk9POqA1ALgMdI8=;
        b=bxnkyf9jnwkjtEyzDBdefN3WGWQ3aM9baegtFpih/oXVvHYdcQ6ZpCDed4J9HihRNu
         PNPAlnDzrc419fITyZTtCpytzolbPZoZCVsic3+QIqAEXQx6U2FtXsNFsIJI6nnklQDe
         s0OPtPt6Khs9aypRsxXtJKkXLhvnO9Tzcc/jQ+q/XlyC9bLkyurUg7T1bp6aeEVqVtoE
         TgcBvafMpgDoLk7cceNpvASUuFIsXpTGa8GXxEnwlFBF0x4kpEiOJ34l1PZ+h97kFoVS
         XsWolY63Lk3NMqNpe3GeZl0DGeyw/kapgnW+noL3J1ZuTjU2VPWQp4isiAIm/wZeDlvS
         q+HA==
Received: by 10.50.186.197 with SMTP id fm5mr3008984igc.23.1333478895850;
        Tue, 03 Apr 2012 11:48:15 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i6sm16144377igq.3.2012.04.03.11.48.14
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 11:48:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2576556.3d3popQR3z@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194637>

Hi,

Florian Achleitner wrote:

> You know I'm rather new to this topic. I've used svn and git, I know what git 
> plumbing is about, but I haven't used plumbing commands to write something 
> into git yet. So I can't tell from experience if it would be good or not, 
> compared to fast-import.

Yes, no problem.  I think the question of using fast-import or other
commands is not a fundamental one.

> So please explain what's the advantage/disadvantage of which design decision.
> That makes it easier to get the point.

The main advantages of using fast-import are:

 - it's faster (assuming it works correctly) :)
 - there are backends for version control systems other than git
 - remote helpers can declare the export/import capabilities to support other
   version control systems, instead of declaring fetch/push and supporting
   only git

However, whatever tools you use, the immediate idea is to transfer
data between a Subversion repository and a Git repository, and the
problems to be solved are the same.

[...]
> I'm also not yet familiar with svn's internals and what properties they use
> for what.
> So there are several questions I simply don't have an answer for.
> I know that you have discussed several issues in a huge lot of mails on this
> list. I'm watching and learning currently.

The svnbook at http://svnbook.red-bean.com/, the Subversion lists at
<http://subversion.apache.org/mailing-lists.html>, and the #svn-dev
IRC channel on freenode
<http://colabti.org/irclogger/irclogger_logs/svn-dev> are the best
resources I know for questions in that vein.

I also learned a lot from looking at the dump format that "svnadmin
dump" spits out, since it matches Subversion concepts pretty well.  It
is documented at

  https://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt

Some basic design questions are covered in the thread starting at

  http://thread.gmane.org/gmane.comp.version-control.git/159054

> Jonathan wrote about a script "floating around". What's that?

I think you mean the marks-to-notes converter.  One version is at

  http://thread.gmane.org/gmane.comp.version-control.git/163395/focus=168514

[...]
> On Monday 02 April 2012 16:30:14 Ramkumar Ramachandra wrote:

>> Are you planning to extend svn-fe to do the mapping, write it as a
>> separate program, or write it into the remote helper? I personally
>> don't mind if the mapping is done in Perl (like in git-svn or SBL) as
>> opposed to C; mapping is just parse-intensive.
>
> I personally don't like Perl. :p (I would use python if i need a scripting 
> language).
> As far as I've seen, svn-fe is a 5-liner calling functions in vcs-svn/. So I 
> thought there is no point of piping something through svn-fe in the remote-
> helper. I thought I would use those functions like svn-fe does.
> I thought about vcs-svn/ being a library for svn interaction that the remote-
> helper, and svn-fe, and svn-fi (?) are using.

Yes, I think when Ram added vcs-svn/ to the main git repository, the
intent was to make it a library that some git-remote-svn.c could use
directly.

[...]
> On Monday 02 April 2012 15:57:00 Jonathan Nieder wrote:

>> The word "new" makes me worried that you'd be throwing away whatever
>> work already exists. :)
>
> Probably I missed something. 
> But all I've seen that is directly a remote-helper is a bash script which 
> basically calls a pipeline from svnrdump | svn-fe | fast-import [2]. 
> I'm not planning to write a longer program in bash. (I personally use bash 
> only for things that fit on one terminal height).
>
> Bash and Perl are not my favourites ;)

I think that's fine.  It's a prototype, and it has -alpha in its name
to make sure people understand there are no compatibility guarantees
which avoids constraining us.  What I was more worried about is
throwing away discoveries made in the previous design and starting
over.

Jonathan
