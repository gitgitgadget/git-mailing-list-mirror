From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Sat, 29 Dec 2007 16:19:37 -0800
Message-ID: <7vodc99gpy.fsf@gitster.siamese.dyndns.org>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
	<8763yof9lg.fsf@gollum.intra.norang.ca>
	<Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<20071225044202.GO14735@spearce.org>
	<7v4pe5nt8m.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712291426500.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 01:20:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8luV-0001WG-RZ
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 01:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbXL3ATq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 19:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbXL3ATq
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 19:19:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbXL3ATp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 19:19:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 029D5552A;
	Sat, 29 Dec 2007 19:19:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 57C485529;
	Sat, 29 Dec 2007 19:19:39 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712291426500.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 29 Dec 2007 14:31:14 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69339>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  		echo "# This is a combination of $COUNT commits."
>> -		sed -n "2,\$p" < "$SQUASH_MSG"
>> +		sed -e 1d -e '2,/^./{
>> +			/^$/d
>> +		}' <"$SQUASH_MSG"
>
> If I read this correctly (haven't tested), then _all_ empty lines are 
> removed from the SQUASH_MSG, right?  This is not what I want.

That is no what I wanted either.

"1d" removes the "# This is a combination of <$n> commits." from
the previous round, "2,/^./{ ... }" says apply what's in {} to
lines from second line to the first non-empty line, and what's
in {} is to remove empty ones.

> Unfortunately, I am unable to provide a proper patch with proper testing 
> right now,...

That's Ok.  Seeing what the patch already in front of you does
would be less time consuming.
