From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2011, #07; Wed, 24)
Date: Thu, 25 Aug 2011 15:22:49 -0700
Message-ID: <7vhb55i11i.fsf@alter.siamese.dyndns.org>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
 <20110825202057.GB6165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 00:23:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwiKB-0005JU-TH
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 00:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab1HYWWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 18:22:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499Ab1HYWWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 18:22:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D0CC5485;
	Thu, 25 Aug 2011 18:22:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PIBEzhwZqKM4hgcjt02BMmc/O4U=; b=v4ssz3
	UuEUYu77WriLVPsckirkrC6LjYNGzdqHPSnkqHVHsy4dS0vYdqvh93SfqTi/5tOP
	9dP4cLBRx+LLyHhT2V/MmCPRmIvuXY7V0Sz9w5CxRicR4EX9gYEwTw4d5VjWhu/r
	wbHWC9xsu9lEXhoMtRUoiQpzRUJDad/sWtXsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=opcdGnrfVInxQL+oTkr6pwtGwByJCh5Y
	xMYpLVviJsFXauhv2PFy019fKGpLlQ8C6KrTWHO2RdmhnAzBDClaG4I2KjLOuN+1
	7eQ0djNz8jG6hPCqRyx2VjbDi+Uk8cO4ZyEqi/Jk1b0ulfx6AILj/OmdTNq2fCDJ
	WGCpbgsoY34=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4464D5484;
	Thu, 25 Aug 2011 18:22:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6CDD5483; Thu, 25 Aug 2011
 18:22:50 -0400 (EDT)
In-Reply-To: <20110825202057.GB6165@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 25 Aug 2011 16:20:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4D4C388-CF68-11E0-BFC6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180130>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 24, 2011 at 05:09:09PM -0700, Junio C Hamano wrote:
>
>> * jk/add-i-hunk-filter (2011-07-27) 5 commits
>>   (merged to 'next' on 2011-08-11 at 8ff9a56)
>>  + add--interactive: add option to autosplit hunks
>>  + add--interactive: allow negatation of hunk filters
>>  + add--interactive: allow hunk filtering on command line
>>  + add--interactive: factor out regex error handling
>>  + add--interactive: refactor patch mode argument processing
>> 
>> Needs documentation updates.
>
> I think Duy already mentioned this, but you may want to update your
> "what's cooking" note: it needs not just doc updates, but code to
> actually pass the options along from real git commands that use
> add--interactive, like add, checkout, reset, and stash.

Thanks. Also tests are lacking, too. Although I do not necessarily see the
lack of integration with anything but "add" a show-stopper (I consider
"-p" to chekout, reset and stash are "nice to have"), you are correct that
"add -i" and then choosing '[p]atch' gets very confused with

    Patch update>> 
    Use of uninitialized value in split at /git/git-pu/libexec/git-core/git-add--interactive line 742, <STDIN> line 3.
    Unknown option: --
    usage: git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
               [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
               [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
               [-c name=value] [--help]
               <command> [<args>]
    Unknown option: --color
    usage: git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
               [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
               [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
               [-c name=value] [--help]
               <command> [<args>]

So it certainly seems not ready for the prime time.

>> * jk/generation-numbers (2011-07-14) 7 commits
>>  - limit "contains" traversals based on commit generation
>>  - check commit generation cache validity against grafts
>>  - pretty: support %G to show the generation number of a commit
>>  - commit: add commit_generation function
>>  - add metadata-cache infrastructure
>>  - decorate: allow storing values instead of pointers
>>  - Merge branch 'jk/tag-contains-ab' (early part) into HEAD
>> 
>> The initial "tag --contains" de-pessimization without need for generation
>> numbers is already in; backburnered.
>
> So...what next? I don't really like leaving the contains traversal
> as-is.

Hmm, honestly speaking, I do not see much problem with it. My knee-jerk
reaction is to go with 1.a and if we really want to do something 1.b
perhaps but I suspect "these are bogus" cache wouldn't be so useful by
itself and we may need a bit more information.

>> * jk/http-auth-keyring (2011-08-03) 13 commits
>>   (merged to 'next' on 2011-08-03 at b06e80e)
>>  ...
>> Not urgent; will not be in 1.7.7.
>
> I'm OK with holding this off for another round. I'd really like to get
> more feedback from third-party helper writers. ...

I actually do not think the lack of finer-than-host level granularity a
problem we need to solve before moving forward. IIRC, when accessing
"http://github.com/frotz" and "http://github.com/nitfol", you would key
the authentication material with something like "http://github.com" (or
was it "http:github.com"? the details do not matter for the purpose of
this discussion). If another site that has multiple independent userbases
within the same host, i.e. the user "xyzzy" at "http://gotheb.com/frotz"
and the user "xyzzy" at "http://gotheb.com/nitfol" need to be treated as
separate identities, it obviously is not enoug to use "gotheb.com" as the
look-up key for the authentication material, but in such a case, the user
knows an important piece of information that git can never figure out by
itself, namely, where the authentication domain boundary lies.

We need to add "auth-domain" support, perhaps from the command line option
and configuration, if we ever need to support such a site.

We can consider what you already have as the default case for a more
general "we cut off at the hostname and take that as the auth-domain
boundary unless told otherwise". We may not have the way to "tell
otherwise" yet, but as long as we are reasonably confident that we know
how to extend the system in a backward compatible way, it is not a
show-stopper.

The primary reason why I wanted to hold this topic off was because of the
frequency of bug report we saw this round to topics _after_ they hit the
"master" branch, indicating that not many people are testing "next" during
the development cycle as they used to in olden days.
