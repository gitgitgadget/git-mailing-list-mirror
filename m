From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git find (was: [RFC PATCH v3 8/8] --sparse for porcelains)
Date: Tue, 18 Aug 2009 18:00:38 +0200
Message-ID: <200908181800.42136.jnareb@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <200908180825.55289.jnareb@gmail.com> <fcaeb9bf0908180735s583bfdcajc354723c9faa48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:01:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdR7R-0005sU-Gc
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbZHRQAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbZHRQAx
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:00:53 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:61957 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbZHRQAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:00:52 -0400
Received: by fxm11 with SMTP id 11so374724fxm.39
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=f7COBnV67iatBWxScIEg0snEaW68By2QiLzJdasVWxc=;
        b=ERWFot0WjIS3QuLVNJuzpy7wOAJP/cA4/HLWlJSSrcTgRw+xPi3bFwWsdfPfDxYLVV
         Fp4r7z41+CtG7qwdZs5WAIEqr+yjpfbqZkJt+57LIF2I+jiXLg9eKzEVeQ1oBYgfHwYz
         9mv9hpztuj4hYyB/ZcwRMqVUOHTL7Bbn9XeYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D4aUeuxk1Cfu51IdMDtFZ4wnNrICIEvXnkLdPSveQvFs1vo4g9NjjywCrVJWtob9zF
         eNWKnSlazZyUUB3YDG7LkSaCxpx2DkrWWzb9oXYmTtrXf6UUEva8Z0X7hfYv8wQPstiV
         O9e/6rmapVnsOOsZXUWCip4svTpMRpdX5Ajo4=
Received: by 10.103.50.36 with SMTP id c36mr1962724muk.135.1250611251273;
        Tue, 18 Aug 2009 09:00:51 -0700 (PDT)
Received: from ?192.168.1.13? (abvz12.neoplus.adsl.tpnet.pl [83.8.223.12])
        by mx.google.com with ESMTPS id u26sm24992182mug.51.2009.08.18.09.00.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 09:00:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0908180735s583bfdcajc354723c9faa48@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126404>

On Tue, Aug 18, 2009, Nguyen Thai Ngoc Duy wrote:
> On Tue, Aug 18, 2009 at 1:25 PM, Jakub Narebski<jnareb@gmail.com> wrote:
> >
> > Well, I also think that it would be nice and useful to have "git find"
> > in addition to current "git grep".
> 
> Can you make a draft on how you want "git find" to be? Except the
> "-exec" part, Git allows us to search using various commands
> (ls-files, rev-list, log). I don't think a single "git find" can cover
> them all. I was thinking about putting more find-options to search
> commands we already have. ls-files would support -exec, for example.

Both git-rev-list and git-ls-files are plumbing, not porcelain.  Among
tools / commands you have mentioned only git-log is porcelain.

You need to process output of git-ls-files if you want to use more
complicated search criteria. 

> 
> A few things that I'd love to have supported:
>  - --depth for ls-files (probably all pathspec-as-argument commands)
>  - logical combination of search criteria
>  - unified blob locator. git-show understands SHA-1:/path/to/blob
> syntax. What if git-log can output using similar syntax, then feed
> them to git-grep in order to grep through (across commits)?

Draft specification for git-find.  git-find, like git-grep, searches
the filesystem dimension, and not time dimension like git-log.

git-find(1)
===========

NAME
----
git-find - Search for files in a repository

SYNOPSIS
--------
'git find' [--cached] [-z|--null] [(<tree> | <path>)...] [<expression>]

OPTIONS
-------
--cached::
        Instead of searching in the working tree files, check
        the blobs registered in the index file.

EXPRESSIONS
-----------
The expression is made up of options (which affect overall operation rather
than the processing of a specific file, and always return true), tests
(which return a true or false value), and actions (which have side effects
and return a true or false value), all separated by operators. `--and`  is
assumed where the operator is omitted.  If the expression contains no
actions other than `--prune`, `--print` is performed on all files for which
the expression is true.

OPTIONS
~~~~~~~
--max-depth <levels>::
        Descend  at  most levels (a non-negative integer) levels of 
        directories below the command line arguments.   `--max-depth 0`
        means only apply the tests and actions to the command line 
        arguments.

--min-depth <levels>::
        Do not apply any tests or actions at levels less than levels 
        (a non-negative integer).  `--min-depth 1` means process all
        files except the  command line arguments.

TESTS
~~~~~
--false::
        Always false.

--true::
        Always true.

--name <pattern>::
--iname <pattern>::
--path <pattern>::
--ipath <pattern>::
        [Entire] Filename matches glob.

--regex <expr>::
--iregex <expr>::
        Entire file name matches regular expression.

--lname <pattern>::
--ilname <pattern>::
        True if the file is a symbolic link whose contents match glob.

--size <n>[<unit>]::
        True if the file uses N units of space, rounding up.

--empty::
        File is empty and is either a regular file or a directory.

--type <C>::
        True if file is of type C: 'd' for directory, 'f' for regular
        file, 'l' for symbolic link, 's' for submodule, 'x' for 
        executable regular file (replaces `-perm` from 'find').

ACTIONS
~~~~~~~
(--exec | --ok) <command> ;
        Execute command; true if 0 status is returned.

(--execdir | --okdir) <command> ;
        Like `--exec`, but the specified command is run from the 
        subdirectory containing the matched file.

--print::
--print0::
--printf <format>::
--fprint <file>::
--fprint0 <file>::
--fprintf <file> <format>::
        True; print the full file name.

--prune::
        True; if the file is a directory, do not descend into it.

--quit::
        Exit immediately.


OPERATORS
~~~~~~~~~
--and::
--or::
--not::
( ... )::
        Specify how multiple expressions are combined using Boolean
        expressions.  `--and` is the default operator.

-- 
Jakub Narebski
Poland
