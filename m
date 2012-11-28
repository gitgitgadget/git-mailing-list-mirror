From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #09; Wed, 28)
Date: Wed, 28 Nov 2012 13:25:05 -0800
Message-ID: <7vehjdto7i.fsf@alter.siamese.dyndns.org>
References: <7v38ztv6z0.fsf@alter.siamese.dyndns.org>
 <20121128203826.GA9383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:25:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdp8K-0004cr-5a
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 22:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab2K1VZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 16:25:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931Ab2K1VZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 16:25:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9FABA097;
	Wed, 28 Nov 2012 16:25:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ZkigYOvAopnjIABwIszqTyhSRE=; b=lQLxse
	c6avZH2enKZ1dh421LTETn9A3uprKeVfeEzmyw+SyxSdoD7He6NoKQOqebGtjJxa
	XjnCNzNEGSlWHs6lBfffMSa2FGxx7ReEqN+RT0VJ5MoM+sQVF8d1319cxJhXs+yk
	bjS/kqn3yGS9Egt7ROhv1pjQGlrXSj8U2To04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vgWphv5AD68sWu5wYDRE3+6hJBgYkZTs
	mdmU+Cku9jnrRKbjRbybQh+f0pmk+uhz2fQB9mGnf8B88s0gUDVbO9KM1opjY8xe
	T29LZhREHQFE5lHlNeqR5OBev87t5/NHD5kq26ng5BwUdaG3yGXQsLSTFtVmPt3c
	/AiPbtYaHks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5DB6A096;
	Wed, 28 Nov 2012 16:25:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF957A095; Wed, 28 Nov 2012
 16:25:06 -0500 (EST)
In-Reply-To: <20121128203826.GA9383@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 Nov 2012 15:38:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14B20C22-39A2-11E2-AF6E-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210780>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 28, 2012 at 11:54:27AM -0800, Junio C Hamano wrote:
>
>> * jk/fsck-dot-in-trees (2012-11-28) 1 commit
>>  - fsck: warn about '.' and '..' in trees
>> 
>>  Will merge to 'next'.
>
> Do you have an opinion on warning about '.git', as well? It probably
> would make more sense as a patch on top, but I thought I'd ask before
> this got merged to next.

Yeah, it would make sense to reject what we would not record
ourselves when the tools are used in a sane manner.

>> * pf/editor-ignore-sigint (2012-11-11) 5 commits
>>  - launch_editor: propagate SIGINT from editor to git
>>  - run-command: do not warn about child death by SIGINT
>>  - run-command: drop silent_exec_failure arg from wait_or_whine
>>  - launch_editor: ignore SIGINT while the editor has control
>>  - launch_editor: refactor to use start/finish_command
>> 
>>  Avoid confusing cases where the user hits Ctrl-C while in the editor
>>  session, not realizing git will receive the signal. Since most editors
>>  will take over the terminal and will block SIGINT, this is not likely
>>  to confuse anyone.
>> 
>>  Some people raised issues with emacsclient, which are addressed by this
>>  re-roll. It should probably also handle SIGQUIT, and there were a
>>  handful of other review comments.
>> 
>>  Expecting a re-roll.
>
> I'm slowly going through my post-travel/vacation/illness backlog. I hope
> to re-roll this one today or tomorrow.

Thanks.

>> * jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
>>  - config: exit on error accessing any config file
>>  - doc: advertise GIT_CONFIG_NOSYSTEM
>>  - config: treat user and xdg config permission problems as errors
>>  - config, gitignore: failure to access with ENOTDIR is ok
>> 
>>  An RFC to deal with a situation where .config/git is a file and we
>>  notice .config/git/config is not readable due to ENOTDIR, not
>>  ENOENT; I think a bit more refactored approach to consistently
>>  address permission errors across config, exclude and attrs is
>>  desirable.  Don't we also need a check for an opposite situation
>>  where we open .config/git/config or .gitattributes for reading but
>>  they turn out to be directories?
>
> I am not sure about the refactored approach you mention. We
> fundamentally need to treat in-tree attributes and exclude files more
> leniently, because we may find arbitrary paths in the tree.

OK.

> As far as the opposite situation, I do not know if it is worth worrying
> about. If $GIT_DIR/config or $HOME/.config/git/config is a directory,
> that is an error and we should flag it[1]. In-tree is more hazy, but I
> think complaining is still the right thing. You cannot expect to store
> arbitrary crap at .gitattributes inside your tree. If you have crap in a
> file at such a path, we would read it and complain when its syntax is
> not that of a .gitattributes file. We should similarly complain when it
> is a directory.

Yeah, OK.
