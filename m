From: Junio C Hamano <gitster@pobox.com>
Subject: Re: two questions about the format of loose object
Date: Mon, 01 Dec 2008 00:25:30 -0800
Message-ID: <7voczws3np.fsf@gitster.siamese.dyndns.org>
References: <493399B7.5000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 09:27:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L748K-0004qi-MV
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 09:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbYLAI0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 03:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbYLAI0j
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 03:26:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYLAI0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 03:26:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F222917DD2;
	Mon,  1 Dec 2008 03:26:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0E2B817DC1; Mon, 
 1 Dec 2008 03:26:07 -0500 (EST)
In-Reply-To: <493399B7.5000505@gmail.com> (Liu Yubao's message of "Mon, 01
 Dec 2008 16:00:55 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C5B744F0-BF81-11DD-BDB4-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102002>

Liu Yubao <yubao.liu@gmail.com> writes:

> In current implementation the loose objects are compressed:
>
>      loose object = deflate(typename + <space> + size + '\0' + data)
>
> In sha1_file.c:unpack_sha1_file():
> 	1) unpack_sha1_header() inflates first 8KB
>         2) parse_sha1_header() gets object's size
>         3) unpack_sha1_reset() allocates a (1+size) bytes buffer and
>            copy the first 8KB without header to it.
>
> * Question 1:
> Why not ...
> * Question 2:
> Why not ...

A hint for understanding why loose objects are compressed is that
packfiles were invented much later in the history of git.

These are both good questions, and it might have made a difference if they
were posed in early April 2005.

At this point, the plain and clear answer to both of these "Why not"
questions is "because that is the way it is and it is costly to change
them now in thousands of repositories people use every day."

In other words, it is not interesting anymore to raise these questions
now, especially as a suggestion to change the system, unless they are
accompanied by arguments that convinces everybody that the cost of such a
change outweighs the benefits, and a clear transition plans how to upgrade
everybody's existing repositories without any pain.
