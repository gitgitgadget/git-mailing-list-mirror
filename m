From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/17] Name local variables more consistently
Date: Sun, 26 Aug 2012 10:39:06 -0700
Message-ID: <7vvcg5v9hh.fsf@alter.siamese.dyndns.org>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <1345709442-16046-5-git-send-email-mhagger@alum.mit.edu>
 <20120823083918.GB6963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 19:39:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5gnv-00010w-DE
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 19:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab2HZRjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 13:39:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab2HZRjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 13:39:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8F2C852F;
	Sun, 26 Aug 2012 13:39:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bY0Cq+h9KUAhoB35gYuIauBJS3I=; b=TNusrR
	CaP2/p8gPz4QkjmwODmPirxaPHwpTNMb4ua/ntMekse/bNiWAZxYuc6Y/xkQeH/L
	pP6Olz/pLfbQ0HbojDyZ9ZrD6ter81AB4YB573VTBx9gBIo3/eFP3MWzErEkVyiY
	H5AV3P5QuOQeTx1VtJbx/FznVOAwGhvJZQGHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=paaFP9SXjUeeE/uMRi3OH8c+Rd5b1NzL
	BDMnGcKRpHQykp1eeMcv7ocEuioW2xJjxkLH5Al8XLqUjT+sHgYYIARfFwCHmam5
	sBVAi6RMxisoEo1y92HaEVW+H3nGe7LbHT4RnyxuTV9asv9hhOkU9CrA8fdQd6xj
	ki6MPSbf4Y4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6DB0852E;
	Sun, 26 Aug 2012 13:39:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15DC1852D; Sun, 26 Aug 2012
 13:39:07 -0400 (EDT)
In-Reply-To: <20120823083918.GB6963@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 23 Aug 2012 04:39:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F02CCA6E-EFA4-11E1-AD53-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204301>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 23, 2012 at 10:10:29AM +0200, mhagger@alum.mit.edu wrote:
>
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>> 
>> Use the names (nr_heads, heads) consistently across functions, instead
>> of sometimes naming the same values (nr_match, match).
>
> I think this is fine, although:
>
>> --- a/builtin/fetch-pack.c
>> +++ b/builtin/fetch-pack.c
>> @@ -521,7 +521,7 @@ static void mark_recent_complete_commits(unsigned long cutoff)
>>  	}
>>  }
>>  
>> -static void filter_refs(struct ref **refs, int nr_match, char **match)
>> +static void filter_refs(struct ref **refs, int nr_heads, char **heads)
>>  {
>>  	struct ref **return_refs;
>>  	struct ref *newlist = NULL;
>> @@ -530,12 +530,12 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>>  	struct ref *fastarray[32];
>>  	int match_pos;
>
> This match_pos is an index into the "match" array, which becomes "head".
> Should it become head_pos?
>
> And then bits like this:
>
>> -			while (match_pos < nr_match) {
>> -				cmp = strcmp(ref->name, match[match_pos]);
>> +			while (match_pos < nr_heads) {
>> +				cmp = strcmp(ref->name, heads[match_pos]);
>
> Would be:
>
>   while (head_pos < nr_heads)
>
> which makes more sense to me.

Using one name is better, but I wonder "heads" is the better one
between the two.

After all, this codepath is not limited to branches these days as
the word "head" implies.  Rather, <nr_thing, thing> has what we
asked for, and <refs> has what the other sides have, and we are
trying to make sure we haven't asked what they do not have in this
function.

And the way we do so is to match the "thing"s with what are in
"refs" to find unmatched ones.

So between the two, I would have chosen "match" instead of "heads"
to call the "thing".
