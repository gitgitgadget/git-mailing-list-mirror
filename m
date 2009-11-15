From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update 'git remote' usage and man page to match.
Date: Sun, 15 Nov 2009 01:08:42 -0800
Message-ID: <7vr5s0qhnp.fsf@alter.siamese.dyndns.org>
References: <32c343770911121715l7507b2d5j8c6cf8cccd1f1a61@mail.gmail.com>
 <20091114071948.6117@nanako3.lavabit.com>
 <32c343770911142034j6cf10e36jbd031c49119973c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9b6T-0001k5-8O
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbZKOJIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 04:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbZKOJIs
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:08:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbZKOJIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 04:08:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 08971991F2;
	Sun, 15 Nov 2009 04:08:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=yxtXhXN2QG8l3z2hjUAyzJ0dUoM=; b=x6ra92h1Z7wVNaqToFlYAiV
	hWUwEkRNhjWCzn6B8z6OVIGvdY18K4MAsEotdApfkOUjmeiGuEolBNvNy01wi+0s
	ZerYWadSFfF1I22bUj45fXq4xBCNzNK9WjvfRz3Q5ktc58apcWHtVops23TwbRUo
	yGbvly1RM0A95kEU+DGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=pB110aJ7VkXjrAXqkCuwqtRLQQ4YAimMeeV5rerAnr8DDMz5C
	uP55bBk5BTx4+/hTiDSL9oZ+cR0kK8nVXjXTrygfTMVU1PO+w1BK72pSg1NOKmPu
	ugZ73mMg/lnEg9CIK8U/cz+2z61Y5Qgqw0i6BZew9TcJHx6tnUSEEkAQnU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CCF51991F1;
	Sun, 15 Nov 2009 04:08:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4E8E6991EF; Sun, 15 Nov 2009
 04:08:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7CF6D2FA-D1C6-11DE-87C5-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132919>

Tim Henigan <tim.henigan@gmail.com> writes:

> On Fri, Nov 13, 2009 at 5:19 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
>>
>> The second change is good but why do you remove -v from the
>> synopsis section? Why is it a good idea? Manual pages for
>> many other commands list --verbose in their synopsis section.
>>
>
> After checking other git operations (fetch, pull, clone, commit, merge, etc)
> I found that none of these other commands document '-v' in the synopsis.
>
> With that in mind, I wondered why it had been listed for 'git remote'.  My best
> guess is that only some of the 'git remote' subcommands are affected by '-v'.
> However, to me it still seems better to only mention it as a general option.
> That way if subcommands add/remote support for '-v', the usage string
> and man page don't need to be updated.
>
> Please note that even with the change, '-v' is still printed as one of the
> general options in the usage string.  I simply removed it from the synopsis
> section.

You noticed a good issue to address.  That is, "git remote -h" output
looks Ok but "git remote add -h" and friends show way suboptimal help.
The current output looks like:

    $ git remote add -h
    usage: git remote [-v | --verbose]
       or: git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name>
       <url>
       or: git remote rename <old> <new>
       or: git remote rm <name>
       or: git remote set-head <name> [-a | -d | <branch>]
       or: git remote show [-n] <name>
       or: git remote prune [-n | --dry-run] <name>
       or: git remote [-v | --verbose] update [-p | --prune] [group]

    add specific options
        -f, --fetch           fetch the remote branches
        -t, --track <branch>  branch(es) to track
        -m, --master <branch>
                              master branch
        --mirror              no separate remotes

As the user already knows "add" is the subcommand she is interested in,
this is insane.

My preference is:

 (1) to drop your change to the synopsis section ("git remote -v" is a
     valid way to get more verbose information, isn't it?);

 (2) to keep the current output of "git remote -h";

 (3) to drop the general description section altogether from "git remote
     add -h" output;

I think this is related to a bigger issue of how we generally would want
to show help in response to "-h", and also in the manual pages.

  http://thread.gmane.org/gmane.comp.version-control.git/129399/focus=129424
  http://thread.gmane.org/gmane.comp.version-control.git/129906/focus=130646
