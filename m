From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Add a function string_list_longest_prefix()
Date: Mon, 10 Sep 2012 09:24:17 -0700
Message-ID: <7v1ui9q21a.fsf@alter.siamese.dyndns.org>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
 <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu>
 <7vbohfser4.fsf@alter.siamese.dyndns.org> <504DBA62.3080001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:24:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6mi-0004CG-6n
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab2IJQYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:24:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805Ab2IJQYU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:24:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8FF89FF1;
	Mon, 10 Sep 2012 12:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jMH0gXQV00Ogj2fMby++/TmxuVE=; b=tatb3V
	BcyRNn+s2DJqvXsTk8/IW2HwRiT7Tu3IuihIevN7qUY+wyYDV9sVUA/wwhpMh9KO
	/KCM1toUirj5cBqAFC0w1ztT/Ciz5+JRmdeSiGrZhRCYTDlciJjfW4Tx77F+ZJna
	FbtVJd3+0r1OGuQ/lS6Nl3qcz72tqaOiQRxqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kCQqMmj67BtV8s3kEu2X7ytqBGa9yTko
	2AUUF3xULu8kVZufGd+qpJ2BTt2OMlnREVjJ1s52d+4S9ZsCzscTj8phFwZu2NCq
	sFf6GpglrfLVOHBbvdNreUkEJ3PxZT1feaMAfIB89EfKt3eciuNHSKp0oZ+cyukb
	gdea/k0dJTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 969E69FF0;
	Mon, 10 Sep 2012 12:24:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF1529FEE; Mon, 10 Sep 2012
 12:24:18 -0400 (EDT)
In-Reply-To: <504DBA62.3080001@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 10 Sep 2012 12:01:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8A72458-FB63-11E1-8BB8-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205138>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Another idea: in string-list.h, one could name parameters "sorted_list"
> when they must be sorted as a precondition of the function.

That sounds like a very sensible thing to do.

> But before getting too hung up on finery, the effort might be better
> invested adding documentation for functions that are totally lacking it,
> like
>
>     string_list_clear_func()
>     for_each_string_list()
>     for_each_string_list_item()
>     string_list_find_insert_index()
>     string_list_insert_at_index()
>
> While we're on the subject, it seems to me that documenting APIs like
> these in separate files under Documentation/technical rather than in the
> header files themselves
>
> - makes the documentation for a particular function harder to find,
>
> - makes it easier for the documentation to get out of sync with the
> actual collection of functions (e.g., the 5 undocumented functions
> listed above).
>
> - makes it awkward for the documentation to refer to particular function
> parameters by name.
>
> While it is nice to have a high-level prose description of an API, I am
> often frustrated by the lack of "docstrings" in the header file where a
> function is declared.  The high-level description of an API could be put
> at the top of the header file.
>
> Also, better documentation in header files could enable the automatic
> generation of API docs (e.g., via doxygen).

Yeah, perhaps you may want to look into doing an automated
generation of Documentation/technical/api-*.txt files out of the
headers.
