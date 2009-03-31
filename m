From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bsd group semantics
Date: Tue, 31 Mar 2009 10:32:14 -0700
Message-ID: <7veiwd61k1.fsf@gitster.siamese.dyndns.org>
References: <20090331112637.GA1910@coredump.intra.peff.net>
 <7vvdpp6623.fsf@gitster.siamese.dyndns.org>
 <20090331160842.GA9019@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:34:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LohqU-0006Uv-G9
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 19:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbZCaRcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 13:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbZCaRcX
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 13:32:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbZCaRcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 13:32:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F7B9A68F8;
	Tue, 31 Mar 2009 13:32:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 50C0CA68F5; Tue,
 31 Mar 2009 13:32:16 -0400 (EDT)
In-Reply-To: <20090331160842.GA9019@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 31 Mar 2009 12:08:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3631AD2-1E19-11DE-A2C9-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115290>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 31, 2009 at 08:55:00AM -0700, Junio C Hamano wrote:
> ...
>> Ideally the test should be checking if the subdirectory is owned by the
>> same group as the toplevel, but that is rather hard to correctly arrange,
>> as it depends on the set of groups the user who runs the test belongs to,
>> how the git work tree is set up (if it is owned by his primary group or a
>> secondary), etc.
>
> Shouldn't that just be:
>
>   perl -e 'sub group { return (stat(shift))[5] }' \
>        -e 'exit group($ARGV[0]) == group($ARGV[1]) ? 0 : 1' \
>        a b
>
> ?

My point was if I belong only to my personal group and git.git work tree
is owned by junio.junio to begin with, you would never be able to notice
any breakage with such a test.
