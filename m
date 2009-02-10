From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Support "\" in non-wildcard exclusion entries
Date: Tue, 10 Feb 2009 07:24:44 -0800
Message-ID: <7vab8upb5v.fsf@gitster.siamese.dyndns.org>
References: <20090210121149.GA1226@pvv.org>
 <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de>
 <20090210125800.GA14800@pvv.org>
 <alpine.DEB.1.00.0902101402230.10279@pacific.mpi-cbg.de>
 <20090210142017.GA16478@pvv.org>
 <alpine.DEB.1.00.0902101525380.10279@pacific.mpi-cbg.de>
 <20090210143742.GB16478@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 16:26:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWuVB-0007ap-JV
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 16:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbZBJPYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbZBJPYy
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:24:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZBJPYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 10:24:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DB66198A66;
	Tue, 10 Feb 2009 10:24:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8C91598A60; Tue,
 10 Feb 2009 10:24:46 -0500 (EST)
In-Reply-To: <20090210143742.GB16478@pvv.org> (Finn Arne Gangstad's message
 of "Tue, 10 Feb 2009 15:37:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F5939B78-F786-11DD-B021-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109255>

Finn Arne Gangstad <finnag@pvv.org> writes:

>> > +cat >.gitignore <<EOF
>> 
>> You probably want to use \EOF here.
>
> I am curious, does it matter? Most of the tests use EOF and not \EOF.

If you want the same shell variable expansion and quoting rules as you get
inside double-quote pair, you would say <<EOF without any quotes.  If you
quote the EOF, no such substitutions happen.

In this particular case, you want what you typed there literally in the
file, so <<\EOF would be more correct, even though \# expands to \#
itself.

IOW, your current list of patterns does not happen to have anything like
$var nor \\ that would make a difference, but to protect future breakages
by people adding more patterns there, it is better to say <<\EOF when you
know you are not asking for any funny expansion to be explicit.
