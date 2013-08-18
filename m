From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git fmt-merge-msg" usage
Date: Sun, 18 Aug 2013 12:40:26 -0700
Message-ID: <7vbo4uokid.fsf@alter.siamese.dyndns.org>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
	<7va9lna48n.fsf@alter.siamese.dyndns.org>
	<520E322F.4040509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 18 21:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8q2-0007pe-PU
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab3HRTkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:40:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563Ab3HRTka (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:40:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EE393AF49;
	Sun, 18 Aug 2013 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=huIbSqTNYIiEf45GhRiXdBZKZZw=; b=S6Z0JI
	Qy21wfpeVyQ95XWlCDpOMVbK2e6Qn46rLvvEffp7TmdKY0l9+p4glHxVhcZKsEpb
	K3yn+n9ojedKk30ntf8Bd2hytKghlGrn2w3BuFE7dsZ3mO2u6QXuz76y6LNIub2Y
	SXM4v7/y8QbSH818Rwf5GDub4Yz8h8rxGS/bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WvGAO0DxCXzCQb5qaLzg44rxxF4Ercb0
	m/bN7k7cylxkD2Lrh8vh5v/oX0X3sAPbPujV0J6HEoToXHuPL2FdxC/TBp44jlXJ
	I0/+AiBpRtsHLqyPg+tuYKwUWiWKkQU2QBgSLaAOVtVZvVGOMQvTwYlED/B2D5Pf
	eTakUVDvRYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76CA23AF48;
	Sun, 18 Aug 2013 19:40:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6F853AF44;
	Sun, 18 Aug 2013 19:40:28 +0000 (UTC)
In-Reply-To: <520E322F.4040509@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 16 Aug 2013 16:07:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 094200E8-083E-11E3-A7BB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232487>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 07/15/2013 11:43 PM, Junio C Hamano wrote:
>> [...]
>> This was a good exercise for git-imerge.[...]
>> 
>> A few things I noticed:
>>  [...]
>> 
>>  - The final step "imerge finish" gave me this ugliness:
>> 
>>      Merge commit 93d9353... into commit cb5d2fc7
>> 
>>    Perhaps you can at least use the initial branch name
>>    "nd/magic-pathspec" I gave you, and use "git fmt-merge-msg"?
>
> I tried to implement this but it is not obvious from the documentation
> (to say the least) how to use "git fmt-merge-msg".  It appears that this
> program takes, on standard input, something like
>
>     <sha1> TAB TAB <text1> LF
>     <sha1> TAB TAB <text2> LF
>     <sha1> TAB TAB <text3> LF
>     ...
>
> (the two TABs are required!).

Correct; fmt-merge-msg is designed to read FETCH_HEAD that can have
'not-for-merge' marker between these two HTs.  <text$N> are also
expected to be in a specific format to explain where the object
being merged described by the line came from.

> But a bit of the magic of these merge messages is how the <text> are
> generated in the first place; e.g.,
>
>     refs/heads/foo -> "branch 'foo'"
>     refs/remotes/bar/baz -> "remote-tracking branch 'bar/baz'"
>
> Is this magic available via any Git commands, or do I have to replicate it?

This is all internal to "fetch" and "git merge", which are the only
things that need to know the specifics.  store_updated_refs() is
where entries in FETCH_HEAD are written.
