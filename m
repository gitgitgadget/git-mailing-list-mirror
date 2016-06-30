Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C241F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbcF3JoB (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:44:01 -0400
Received: from plane.gmane.org ([80.91.229.3]:58007 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbcF3Jn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:43:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bIYUy-0004n1-Am
	for git@vger.kernel.org; Thu, 30 Jun 2016 11:43:04 +0200
Received: from daw105.neoplus.adsl.tpnet.pl ([83.23.22.105])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 11:43:04 +0200
Received: from jnareb by daw105.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 11:43:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: [RFD] Place to document magic pathspecs like ":/" and pathspec
 handling
Date:	Thu, 30 Jun 2016 11:42:42 +0200
Message-ID: <5774E992.7070905@gmail.com>
References: <577425EF.6030900@gmail.com>
 <CAPc5daVqjhWrJjNX6monHdMTRwimbjz==j9B2FS-nXNCqPDCYQ@mail.gmail.com>
 <57743BFB.9040709@gmail.com> <xmqqy45n1y8a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@ger.gmane.org
Cc:	Git Mailing List <git@vger.kernel.org>
X-Gmane-NNTP-Posting-Host: daw105.neoplus.adsl.tpnet.pl
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqqy45n1y8a.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-29 o 23:28, Junio C Hamano pisze:
> Jakub Narębski <jnareb@gmail.com> writes:
> 
>> But I think it is not the best place to keep this documentation.
> 
> All true.  In case it was not obvious, I didn't mean to say "Here
> you find the information, shut up."  It was "here is a pointer if
> you didn't find it, so that you can use it as a starting point to
> make a better documentation."
> 
> An analogous entity in the world model of Git that appears
> everywhere and is not limited to a single command is the revision
> set calculus.  Where do we describe it and how do we make it
> discoverable?  Can the new way to describe pathspec and pathspec
> magic mimic the way it is done for the revisions?

Is that a trick question? :-P

The revision set calculus is described as a standalone documentation
in the gitrevisions(7) manpage (titled "specifying revisions and
[revision] ranges for Git"... well, the "[revision]" isn't there).
This documentation is also accessible via `git help revisions`,
which is cool.  It is referenced in the "Symbolic Identifiers"
section of the git(1) manual page.

Long time ago the description of revision set calculus was hidden
in the manpage for the plumbing command git-rev-parse, and is still
included in it (the common part is, via "include::revisions.txt[]").

As I wrote:

>>>> Nowadays we have gitcli(7) manual page, but perhaps
>>>> it would be better to create a separate manpage for issues related
>>>> to pathspec handling (of which ":/" is only one part)... but then
>>>> what should it be named?

So we could describe how Git handles pathspecs and pathspec magic
in the new manual page named gitpathspec(7), or gitpaths(7). The
former has the advantage of the name being identical to the entry
in gitglossary(7). The latter has the probable advantage of being
easier for the Git novice to find, and that it could be used to
gather various ways to generate list of files in Git (files in
the working area, files in the staging area aka the index, files
in the revision / tree object, changed files, etc.); the pathspec
in strict sense is about the input. Well, we could have 'manpage
alias' of gitpaths to gitpathspec, or vice versa.

 Sidenote: I wonder if people (especially novices) have problem
 finding relevant documentation, and if adding something like 
 "git apropos <topic>" command ("apropos", or "man -k"), or
 add the '--apropos' option to "git help" would be useful...
 and if it would be easy to create.

The description from gitglossary would be a good start, as would
parts of gitcli and relevant RelNotes. It would need to be linked
from git(1) manpage, and probably also from gitcli.

Now only to start it...
-- 
Jakub Narębski


