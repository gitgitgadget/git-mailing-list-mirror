From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] contrib git-resurrect: find traces of a branch name
 and resurrect it
Date: Thu, 05 Feb 2009 00:38:13 -0800
Message-ID: <7vtz79ffd6.fsf@gitster.siamese.dyndns.org>
References: <7vljsppo14.fsf@gitster.siamese.dyndns.org>
 <1233741858-13099-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:39:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzm0-0001jW-FK
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757025AbZBEIiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756887AbZBEIiW
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:38:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbZBEIiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:38:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B48F796FE3;
	Thu,  5 Feb 2009 03:38:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5AA4096FDE; Thu,
  5 Feb 2009 03:38:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 573C1934-F360-11DD-9CA7-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108538>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> Do you mean something like this?
>> 
>> 	sed -n -e "/^$_x40 $_x40 \($_x40\) Merge .*/ {
>> 		s//\1/p
>>                 q
>>         }"
>
> Yep, precisely.  Thanks!  This indeed gives it a nice speed boost if
> all you want is a topic "resurrection" from pu.
> ...
> +search_merges () {
> +        git rev-list --all --grep="Merge branch '$1'" \
> +                --pretty=tformat:"%P %s" |
> +        sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
> +}

Will apply, but just to let you know, I wrote my example on separate lines
(and with separate -n and -e options for that matter) for a reason.  I
recall some implementation of sed (perhaps older BSDs, but don't quote me
on that) did not understanding semicolon with close brace on the same
line.  It may not be a problem in practice these days, but I do not have
access to many different platforms to check as I used to.
