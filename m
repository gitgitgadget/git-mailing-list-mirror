From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2009, #05; Mon, 16)
Date: Tue, 17 Feb 2009 10:39:07 -0800
Message-ID: <7v1vtw6h84.fsf@gitster.siamese.dyndns.org>
References: <7vfxid8phr.fsf@gitster.siamese.dyndns.org>
 <m3wsbps708.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZUs5-0001AH-Te
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 19:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbZBQSjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 13:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbZBQSjO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 13:39:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbZBQSjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 13:39:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 300F42B560;
	Tue, 17 Feb 2009 13:39:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C8DE2B557; Tue,
 17 Feb 2009 13:39:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4525EBF0-FD22-11DD-A724-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110435>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> ----------------------------------------------------------------
>> [New Topics]
>> 
>> * gb/gitweb-base (Sun Feb 15 10:18:36 2009 +0100) 1 commit
>>  - gitweb: fix wrong base URL when non-root DirectoryIndex
>> 
>> Should this go in 1.6.2-rc2?
>
> Isn't it in master already?

Yeah, I merged it, didn't I.  Sorry for the noise.

>> * jc/add-p-unquote (Mon Feb 16 22:43:43 2009 -0800) 1 commit
>>  - git-add -i/-p: learn to unwrap C-quoted paths
>
> It might be considered bugfix, but IIRC it is still cooking,
> so perhaps it wouldn't be absolutely ready for 1.6.2

The informal policy I have during release freeze period is to fix only
regressions.  "We've lived with this bug for a long time, we can live one
cycle longer and it is safer to do so than pushing out a fix that risks to
break things unexpectedly".

>> [Stalled and may need help and prodding to go forward]
>> 
>> * jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
>>  + blame: show "previous" information in --porcelain/--incremental
>>    format
>>  + git-blame: refactor code to emit "porcelain format" output
>>
> It would be nice to have for gitweb... especially if it is a merge
> commit that gets the blame (which I guess should happen only for 'evil
> merge' case).

Will then move to "perhaps 'master' after 1.6.2" list, but the line number
logic needs to be revisited, especially taking into account what was said
in a recent discussion thread.

>> * db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
>>  - Support fetching from foreign VCSes
>>  - Add specification of git-vcs helpers
>>  - Add "vcs" config option in remotes
>> 
>> The "spec" did not seem quite well cooked yet, but in the longer term I
>> think something like this to allow interoperating with other SCMs as if
>> the other end is a native git repository is a very worthy goal.
>
> I wonder what are the limitations: I guess that importer has to be
> incremental (and probably store additional info, or at least cache
> it).  IIRC the example was for Perforce; much more interesting would
> be to have example for Subversion, I guess.

We have a working git-svn.  As a demonstration, a one that works with git
would be more interesting.

>> * cc/replace (Mon Feb 2 06:13:06 2009 +0100) 11 commits
>>  - builtin-replace: use "usage_msg_opt" to give better error messages
>>  - parse-options: add new function "usage_msg_opt"
>>  - builtin-replace: teach "git replace" to actually replace
>>  - Add new "git replace" command
>>  - environment: add global variable to disable replacement
>>  - mktag: call "check_sha1_signature" with the replacement sha1
>>  - replace_object: add a test case
>>  - object: call "check_sha1_signature" with the replacement sha1
>>  - sha1_file: add a "read_sha1_file_repl" function
>>  - replace_object: add mechanism to replace objects found in
>>    "refs/replace/"
>>  - refs: add a "for_each_replace_ref" function
>> 
>> I think the code is much cleaner than the first round, but I am not
>> convinced it is doing the right thing in the connectivity traverser.  
>> Independent review sorely needed.
>
> This is certainly something that it would be nice to have.

"Nice to have" we probably all know (otherwise it would not have been
queued).  Independent review is sorely needed.

>> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>>  - gitweb: Optional grouping of projects by category
>>  - gitweb: Split git_project_list_body in two functions
>>  - gitweb: Modularized git_get_project_description to be more generic
>> 
>> Design discussion between Jakub and Sebastien seems to have stalled, but
>> Jakub seems to be taking this over.
>
> The fact that discussion stalled is largely my fault as reviewer
> wanting for this series to do too much 'by the way' changes, and
> preparation for further changes.
>
> I don't know when I would have time to actively work on this, but I
> have it in my repository, so it wouldn't vanish
>
>   git://repo.or.cz/git/jnareb-git.git gitweb/category
>   http://repo.or.cz/w/git/jnareb-git.git?a=shortlog;h=refs/heads/gitweb/category

Thanks.

>> * jc/fsck (Fri Jan 30 02:33:47 2009 -0800) 4 commits
>>  - fsck: three levels of validation
>>  - verify-pack: add --quick
>>  - verify_pack(): allow a quicker verification for a pack with
>>    version 2 idx
>>  - pack-check.c: minor formatting fix to match coding style
>> 
>> J6t has a good point that if this had any value then medium level should
>> replace the default.  I am tempted to actually dropping this as a failed
>> experiment.
>
> I recall that medium level wasn't that much faster, isn't it?

Yes, that is why I am inclined to drop it.
