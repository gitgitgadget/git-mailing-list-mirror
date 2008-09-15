From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Mon, 15 Sep 2008 12:40:53 +0200
Message-ID: <200809151240.54495.jnareb@gmail.com>
References: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 12:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfBX3-0001rm-GW
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 12:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbYIOKlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 06:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbYIOKlD
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 06:41:03 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:21563 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYIOKlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 06:41:01 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1011927gvc.37
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UvAqvGMxeI3SzTEpEre8LdF0zeAamthlzXpiDFBqxmU=;
        b=C/YmkNc8R2zjUdnhVD9afHoyXfW5IYIXIJVgWAhy3TU5JmBbXsuZGD+Wfnneng+d1t
         tM6hAHO0IzPPNuJV7IDUMnjlC6KEyS4MjRioUuA5aLdskD5o1mw0psQ+uHRHx1WpSIEq
         yU7/063MZ26GmdHNc0/b8e65dWPykmGcQUZHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lrRWX4nR/1vR39Gmz1b0YRKOOxmSaGLdlZifnRvvbyqAPA4FRKmokhie5uwq6yRLKU
         cIHwOhB46zuBagiJAa+2cH6u74N2y+fOWfIDvxUeCEFOXaPfGuq3uahpDeoM0RmAegsK
         AeUsZEjgTByowLXjmCS9+mEEepj8p8CKS0SYA=
Received: by 10.86.58.3 with SMTP id g3mr3990551fga.58.1221475259373;
        Mon, 15 Sep 2008 03:40:59 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.248.215])
        by mx.google.com with ESMTPS id d4sm17117739fga.5.2008.09.15.03.40.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Sep 2008 03:40:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95897>

[I don't see mails I am replying to on GMane interface to git mailing
 list, so threads might be broken. Strange... Perhaps too long lines
 were cause of rejection by anti-SPAM vger filter?]

On Mon, 15 Sep 2008, Duy Nguyen wrote:
> On 09/15/2008 "Jakub Narebski" <jnareb@gmail.com> wrote:

> > > +Narrow works by applying your rules to the index, marking which
> > > +file you need and which file you need not. Modified/Unmerged
> > > +files cannot be marked unneeded. Unnecessary files will be
> > > +removed from working directory.  Note that after this step,
> > > +removed files can still be added to working directory when they
> > > +are needed by any git command. For example, when you have a merge
> > > +conflict, conflicted files will be checked out on working
> > > +directory and will no longer be marked "unneeded".
> > 
> > This paragraph I think need some more love...
> > 
> > So the "checkout rules" are meant to mark which paths are "wanted"
> > or "needed", and we would like to have in the checkout, and which
> > files are "unwanted" or "not needed" ("unneeded"?) and we want to
> > not have them present in working directory; something akin to accept
> > and deny rules, isn't it?
> 
> Yes. But rules will be gone, only the results remain. I don't
> save/reuse rules. 

Ah. I understand. The options are only to select which files to check-out
(which are "wanted"), and which we do not want and mark with "no-checkout"
bit ("unwanted").
 
> > What are the rules, does all files except those marked explicitely
> > as needed are unneeded, or do you have to first mark all files as
> > unneeded?
> > 
> > How would the following table look like:
> > 
> >   working directory  || needed       | not needed    |
> >   ----------------------------------------------------
> >   file is absent     || checkout     | no change     |
> >   file is present    || no change    | removed       |
> >   file is modified   || conflict     | conflict?     |
> 
> Looks better than my description. Though it would be "no change" for
> "file is modified/needed" case. There should be another line for
> unmerged entries.  

Now I am not sure about the line with 'file is modified', because even
in simple full checkout case there are different situations dealing with
checking out of index (and '-f' option), and switching to other branch
(and '-m' option).
 
Doesn't unmerged simply mean ignore "no-checkout" bit?

> > > +
> > > +New files after merges will always be "needed". You can also
> > > +apply rules when switching branches to avoid unwanted new files.
> > 
> > Does it mean that if merge brings some new files, then those
> > files would be "needed" (without "no checkout" bit)?

And as far as I understand the same for simple checkout, and for "2-way
merge" checkout.

> Yes.

Perhaps: new entries appearing in index have "no-checkout" bit unset
(cleared).  Or perhaps in addition, as clarification.

> > What does it mean this sentence about switching branches:
> > how does partial/sparse/narrow checkout rules change when
> > switching to other branch (which, like 'html' and 'todo'
> > branches in git repository, can be completely unrelated)?
> 
> Recall above I say rules are not saved. When you switch branches,
> files that are needed will still be and stay in workdir. New files
> will always appear in workdir ("needed"). If two branches are
> completely unrelated, all files will be new so you get full workdir.   

Thanks. Now I understand: new entries in index are always with
"no-checkout" bit unset, regardless how they got there.
  
> > > +Narrow spec will be used to specify how you want to narrow your
> > > +checkout. It is a list of pathspecs separated by colons. Each
> > > +patchspec specifies what files should be checked out on working
> > > +directory. Pathspec can contain wildcards and is relative to
> > > +current working directory. Usually asterisk (*) does not match
> > > +slashes. If a pathspec is prefixed by a plus sign (+), then
> > > +any asterisk will match anything, even slashes.
> > 
> > First, does this mean that you can specify paths containing colons
> > (':') only using --add-path and --remove-path, or does it mean that
> > you cannot specify paths containg colon ':' (which should be rare)
> > at all as checkout limiter / checkout narrowing rule?
> 
> You cannot do othat explicitly unfortunately. You can work-around using
> wildcard though. 

Couldn't you simply escape ':', i.e. write for example Git\:\:Tag.3pm,
or Eichten_PRD21\:313,1980_erratum.tex, or \:0.log, or perhaps
kmail/jnareb@gmail.com\:@pop.gmail.com\:995, or even something like
Mail/inbox/cur/1194202360.32296.mprnq\:2,S, in the same way like you
can escape other special characters, for example wildcard characters
like '\*' for '*' and '\?' for '?', and of course '\\' for '\'?
 
> > Second, wouldn't it be better to use '**' to match also '/'?
> > Changing meaning of '*' using per-path flag seems a bit bad.
> 
> It would be better. But I don't see any way but duplicating fnmatch()
> implementation and modify it to support '**' so I made a compromise.
> Will make another patch for '**' support and see how bloat the code
> will be.   

Well, the alternative would be to tell in commit message _why_ you
choose that (for implementation reasons), and perhaps give an example.

BTW. does '+' prefixed pathspec means that '?' can match '/', directory
separator?
 
-- 
Jakub Narebski
Poland
