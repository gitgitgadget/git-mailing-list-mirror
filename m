From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Sun, 19 May 2013 00:33:12 -0700
Message-ID: <7vsj1jzao7.fsf@alter.siamese.dyndns.org>
References: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
	<1368793403-4642-3-git-send-email-artagnon@gmail.com>
	<7vfvxlw055.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 09:33:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udy7Y-0006f0-Bv
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 09:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab3ESHdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 03:33:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193Ab3ESHdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 03:33:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 623A31B5E3;
	Sun, 19 May 2013 07:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/gQPAYYseAKc7Oxnhdl+4Ad2DBc=; b=dG/p6Y
	F7FuFBY9Q74Hj6Wats3QaQ/54/8H41UHoaKyQfIg6oDCIaqpvh1cE0gEtpnvvy0i
	UtWaj+ysxQ0Buyu5Y+jES8wGjgJV8hojOXahwT5n0YRM313cIjEvYHjJwcwlVEx2
	9RhAvjmcpEG4NkBzRzSkjHtiCiVjp6sn+B2fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lMx3y6/j4zCyWaZWr7lBfB6AsmuEt7Dg
	lDPGHTBS+xagbTEi9JW9t3ZIu1fPfUa1Y50bnuU4C3wTIAl1jz6mAG1TdQDDdJj1
	0RGYEFImWBlG+lQ7NdE947Vk7dhl+AvqXtfMjSk4GLBP2tMDJsny7Clbn30qdKM/
	OcSuXlBoszo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 558D11B5E2;
	Sun, 19 May 2013 07:33:14 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95CC91B5DF;
	Sun, 19 May 2013 07:33:13 +0000 (UTC)
In-Reply-To: <7vfvxlw055.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 17 May 2013 18:24:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D19BE34-C056-11E2-8607-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224823>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> ...
>>  -G<regex>::
>> -	Look for differences whose added or removed line matches
>> -	the given <regex>.
>> +	Grep through the patch text of commits for added/removed lines
>> +	that match <regex>.  `--pickaxe-regex` is implied in this
>> +	mode.
>
> The same comment on differences vs commits apply to this.
> ...
> it will _not_ apply to users of -G.

s/.$/ unless they say --pickaxe-regex./; so -G does not imply it at
all.

> "grep through", if the reader knows "grep", with "match <regex>", it
> is crystal clear that this expects a regular expression.  And that
> is the only thing that makes -G and --pickaxe-regex superficially
> related.

s/^The description begins with /;  Sorry, but I couldn't write
complete sentences on a bus ;-)

>> -This transformation is used to find filepairs that represent
>> -changes that touch a specified string, and is controlled by the
>> --S option and the `--pickaxe-all` option to the 'git diff-*'
>> -commands.
>> -
>> -When diffcore-pickaxe is in use, it checks if there are
>> -filepairs whose "result" side and whose "origin" side have
>> -different number of specified string.  Such a filepair represents
>> -"the string appeared in this changeset".  It also checks for the
>> -opposite case that loses the specified string.
>> -
>> -When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves
>> -only such filepairs that touch the specified string in its
>> -output.  When `--pickaxe-all` is used, diffcore-pickaxe leaves all
>> -filepairs intact if there is such a filepair, or makes the
>> -output empty otherwise.  The latter behaviour is designed to
>> -make reviewing of the changes in the context of the whole
>> -changeset easier.
>
> This part is impossible to review on a bus, so I won't comment in
> this message.
>
> Why did you even have to touch the paragraph for --pickaxe-all?
> That applies to both -S and -G.  I thought it would be just the
> matter of slightly tweaking the introductory paragraph (which was
> written back when there was only -S), keeping the second paragraph
> for -S as-is, and insert an additional paragraph for -G before
> --pickaxe-all.

Now I see that the paragraph for --pickaxe-all needs to be touched;
the original talks about "touch the specified string", which only
applies to -S and needs to be adjusted.

So here is my attempt of clarifying it.

	This transformation is used to find filepairs that represent
	two kinds of changes, and is controlled by the -S, -G and
	--pickaxe-all options.

	The "-S<block of text>" option tells Git to consider that a
	filepair has differences only if the number of occurrences
	of the specified block of text is different between its
	preimage and its postimage, and treat other filepairs as if
	they did not have any change.  This is meant to be used with
	a block of text that is unique enough to occur only once (so
	expected the number of occurences is 1 vs 0 or 0 vs 1) to
	use with "git log" to find a commit that touched the block
	of text the last time.  When used with the "--pickaxe-regex"
	option, the <block of text> is used as a POSIX extended
	regular expression to match, instead of a literal string.

	The "-G<regular expression>" option tells Git to consider
	that a filepair has differences only if a textual diff
	between its preimage and postimage would indicate a line
	that matches the given regular expression is changed, and
	treat other filepairs as if they did not have any change.

	When -S or -G option is used without "--pickaxe-all" option,
	only filepairs that match their respective criterion are
	kept in the output.  When `--pickaxe-all` is used, all
	filepairs intact if there is such a filepair, or makes the
	output empty otherwise.  This behaviour is designed to make
	reviewing of the changes in the context of the whole
	changeset easier.
