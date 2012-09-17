From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string_list API: document what "sorted" means.
Date: Mon, 17 Sep 2012 14:17:09 -0700
Message-ID: <7vy5k8s622.fsf@alter.siamese.dyndns.org>
References: <1347895267-5054-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:17:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDigz-00022t-T4
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 23:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab2IQVRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 17:17:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab2IQVRM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 17:17:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA2538D15;
	Mon, 17 Sep 2012 17:17:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wfc0FgkfLEI60mC1b3WAVUZASH4=; b=m+Jy5h
	M/nw1KxZaSMMknfqTbFVSvz67DLWjUPrbX2qOpRzyhyejmO4WOlzKoL4vrTAi0Qd
	hLCSxlwvwJZutFTDMDB5ou6S4UThrl6FX/xHS48P4fWS+ghNxOCbaC3uN28P+dQV
	0t9hrIZttx/I5nZdE5mRY2HTnTH5ZzAd4w87s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rIuMP+jq8KMnv1tEjpizhREECGdwAbT+
	HelSrz+7LOKCihl/Ff16DPnuGjJVWw7p7xUOSwTOflJoE8BL2lo8mhvHoTo6rlsr
	zNj8ypE+lz6CIF8hZdejHFAWKMTlUMerIhPXlzlh0RFZnTVXPP5gDYfbqMW2F6aQ
	/Fjc96TcHV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7F888D14;
	Mon, 17 Sep 2012 17:17:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DA5D8D13; Mon, 17 Sep 2012
 17:17:10 -0400 (EDT)
In-Reply-To: <1347895267-5054-1-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Mon, 17 Sep 2012 17:21:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B518EDC-010D-11E2-8EA2-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205751>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Junio pointed out that the sort order currently used by string_list
> could be considered to be an implementation detail internal to
> string_list.  But the sort order is already visible to the outside
> world (e.g., via iteration or via print_string_list()), so it
> shouldn't be changed willy-nilly.  Therefore, document the current
> sort order as part of the API's contract.
>
> (If, at some future time, somebody wants a string_list that is sorted
> by a different criterion, then the order should be made specifiable
> via a callback function specified by the user.)

As I said in a separate message, we do not give any documented
guarantee on the order the strings comes out of print_string_list(),
other than "if you are using the unsorted list function to insert or
append strings, we won't muck with the order of the items and you
will get your strings back in the order you gave us".  Until we add
a callback that the user can specify at the time of string list
initialization, I do not think it is wise to cast it in stone and
declare it as "shouldn't be changed willy-nilly", unnecessarily
painting us into a corner that we need to expend extra effort to get
out of.

Besides, nobody calls print_string_list() in the first place. I have
always considered it as a debugging aid.
