From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Thu, 05 Jun 2008 12:29:03 -0700
Message-ID: <7vprqv1y0w.fsf@gitster.siamese.dyndns.org>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
 <alpine.DEB.1.00.0806051946100.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cedric Vivier <cedricv@neonux.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 21:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4LA3-00018f-Aq
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 21:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762109AbYFET3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 15:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762069AbYFET3S
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 15:29:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761669AbYFET3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 15:29:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 750D65D6F;
	Thu,  5 Jun 2008 15:29:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8D6DB5D6C; Thu,  5 Jun 2008 15:29:10 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806051946100.21190@racer> (Johannes
 Schindelin's message of "Thu, 5 Jun 2008 19:47:26 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AE7C9EDA-3335-11DD-BC73-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83961>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 5 Jun 2008, Cedric Vivier wrote:
>
>> Hi everyone,
>> 
>> This small patch makes git display list of branches in natural order.
>> This way, when you name your branches against, for instance, a bug number from
>> some bug-tracking tool, the list will show up in a natural/human/logical order.
>> 
>> Current behavior for "git branch":
>> BUG-1040-doing-bar-is-too-slow
>> BUG-84-calling-Z-with-null-segfaults
>> BUG-900-program-freezes-when-user-click-on-button
>> experimental-feature-X
>> master
>> 
>> With the patch:
>> BUG-84-calling-Z-with-null-segfaults
>> BUG-900-program-freezes-when-user-click-on-button
>> BUG-1040-doing-bar-takes-too-much-time
>> experimental-feature-X
>> master
>> 
>> 
>> Signed-off-by: Cedric Vivier <cedricv@neonux.com>
>> ---
>
> This is not a good commit message.
>
>> @@ -279,7 +280,7 @@ static int ref_cmp(const void *r1, const void *r2)
>> 
>>  	if (c1->kind != c2->kind)
>>  		return c1->kind - c2->kind;
>> -	return strcmp(c1->name, c2->name);
>> +	return strnatcmp(c1->name, c2->name);
>>  }
>> 
>>  static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>
> What about people preferring the status quo?  I think a command line 
> option would be in order.
>
> Also, you _might_ want to provide a test case, so that it does not get 
> broken by accident.
>
> Other than that: nice.

Perhaps, as long as we somehow mark clearly the new files added with this
patch as "borrowed code" and not part of git proper, so that people do not
imitate tons of style issues these files have (header inclusion, Emacs
style -*- mode -*- line at the top, useless typedef of nat_char, macros
whose sole purpose to cast arguments given toupper() to (unsigned char),
"partial change history" in comments, short function definition header
split across two lines, multi-line comments).

What the big license notice comment at the top says sounded Ok to me as
well.
