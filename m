From: Junio C Hamano <gitster@pobox.com>
Subject: Re: convert crlf to eol on vendor branch overlay
Date: Thu, 07 Apr 2011 21:43:53 -0700
Message-ID: <7vy63l4ak6.fsf@alter.siamese.dyndns.org>
References: <inlsit$scv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 06:44:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q83YN-0000nq-Jf
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 06:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab1DHEoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 00:44:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1DHEoF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 00:44:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0D965C22;
	Fri,  8 Apr 2011 00:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cImdaIpyyptkAL9/Gq6QPHzPyLg=; b=fuFA9j
	I7KU8UORfCM28HAW3PuHVJRva+wu8UyYtvMKuB2ZZAYKy2teZEruvFs+o+BSy/rS
	5pBeNgD1oVDg2Gn4z/W3GIxoVROIbBm3tgzgcu79Vi/ssSulQhqTqa8G0RDnR7lN
	x7WgMA9PHG0ocDeZFBtDhlynio+h7paya+hZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C22Fgo/tPODAdPyWn0Id3RZrcf2lZLJ4
	4EJ8Fy8PihgE/GT56OzmrS0sgDpfB0B4ozhDQcGmBBD/c1THSIas2gY3aho8as64
	5DMhUANc12j0iU0f/suDTyVJ0hYOUz4YhSYc36TM5rVAIw9Do+KtXjZWTxI+/kL/
	Yagrv2Ob2sk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CED165C21;
	Fri,  8 Apr 2011 00:45:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D023F5C20; Fri,  8 Apr 2011
 00:45:50 -0400 (EDT)
In-Reply-To: <inlsit$scv$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Thu, 7 Apr 2011 21:40:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15F9A33C-619B-11E0-AB92-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171103>

"Neal Kreitzinger" <neal@rsss.com> writes:

> How do I convert the eol's to LF?
>
> I tried this:
>
> vi .git/attributes
> SRC/*/* text  (convert these to LF eol on commit)
>
> $ git config core.eol lf (convert "text" attr files to LF eol on checkout)

Instead, how about something like:

  $ git ls-files -z | xargs -0 perl -p -i -e 's/\r$//'

and then:

> $ git add . -A
> $ git commit -m'convert eol'  (should convert CRLF to LF)

?
