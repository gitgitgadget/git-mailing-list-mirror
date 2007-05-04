From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Fri, 4 May 2007 02:42:45 +0200
Message-ID: <200705040242.46156.jnareb@gmail.com>
References: <loom.20070502T111026-882@post.gmane.org> <f1b806$nc7$1@sea.gmane.org> <20070503010312.GF4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Panagiotis Issaris <takis.issaris@uhasselt.be>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 04 02:38:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjlod-0006WO-G6
	for gcvg-git@gmane.org; Fri, 04 May 2007 02:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767539AbXEDAi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 20:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767535AbXEDAi2
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 20:38:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:16036 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767539AbXEDAi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 20:38:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so560816uga
        for <git@vger.kernel.org>; Thu, 03 May 2007 17:38:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AS0tuhoIUOtBEIoTlpb7dr8GMMZupOrUnkTXAXApBnTxkqpZS0R9MuIC0ad2NVkwR1OmnF3pfnVJYKa0YIf6YdP89ikbtR9IVWgkZdg2O2Iw31r6d5JPzEHwN+spNcdfhbCsglInmB02ceZx2oKyQuCP+TKuHVl9qmonbngxu9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HKPlNbtS8NVOAiSi89fvsVX0e3oHg7EWEiXtm2BWYNcJ1ankwdtk3skD4/AiU9O8wWpGhmRdHg5iBXUBph/JbmwJYrywLFOVN+PCPRDb4mT76/JtR6ayf953Ei+StKKVzKgsoV2drCJ0tLcJYAXVXU2qbtX2eXQ08S0lPDX11iw=
Received: by 10.66.244.11 with SMTP id r11mr2304594ugh.1178239105779;
        Thu, 03 May 2007 17:38:25 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id 53sm3438879ugd.2007.05.03.17.38.23;
        Thu, 03 May 2007 17:38:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070503010312.GF4489@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46124>

Petr Baudis wrote:
> On Thu, May 03, 2007 at 01:48:26AM CEST, Jakub Narebski wrote:

>> About removing a commit: assume that you have the following history
>> The problem exists _only_ if somebody based his/her work on commit
>> C or its descendant, i.e. original D, E commits. He/she would have
>> to rebase his/her work on top of _changed_ (moved) commits D' and E'.
> 
> "_Only_"?
> 
> I think it's just totally unsustainable to do this history rewriting in
> an "upstream" git repository. You will get horridly confused, then
> frustrated and then just move from software development to beekeeping.

Perhaps I should have said: "There always would be problems if somebody
based his/her work on commit C or its descendant..."

But there are some times when you can rewrite history without bad
consequences. 

You can without any problems rewrite _unpublished_ commits; if one for
example pushes to public repo once per day, or few times a week,
there is time to remove a commit, or amend a commit, or change commit
deeper in a history. Or even use StGIT to manage patches, and change
their sequence, add patch in the midle of patch series, split or join
patches, all that working on creating 'a perfect patch [series]'.

You can rewrite a branch which never would be published, like feature
branches in git.git repository (which are visible only via 'pu' -- proposed
updates branch, which is meant to have history rewritten). Or you can
announce that given branch might be rewritten, and not to base any work
on it (well, you can, but you always should rebase before sending).


Because there always are, and always will be problems if somebody would
base work on series including now removed commit, even if SCM need not
to rewrite history to remove a commit [*1*]. And with history rewriting
even more so, for example accidental inclusion of removed commit.

Besides I think it would be better to teach blame to ignore reversion
commits (for example based on first line of commit message) than to mess
with the history. Note also that git has more tools for forensic analysis
than git-blame; blame / annotate was added later because people are used
to it (and it is I think better than any other, because it can detect
moving and copying code blocks). The primary examining tools are history
browsing limited to specified pathspec, and pickaxe i.e. searching for
commits which changed given line.

Footnotes:
----------
 [1] Git began as content adressed filesystem, where each object is named
     by its contents (or rather cryptographics hash function of contents).
     This results in hash (object id) of commit identifying whole lineage
     of it, and makes signing specified commit (using signed tag)
     identifying / signing whole history.

-- 
Jakub Narebski
ShadeHawk on #git
Poland
