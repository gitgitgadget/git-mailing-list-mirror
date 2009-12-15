From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Giving command line parameter to textconv command?
Date: Tue, 15 Dec 2009 09:23:06 -0800
Message-ID: <7vy6l4179h.fsf@alter.siamese.dyndns.org>
References: <20091215071735.6117@nanako3.lavabit.com>
 <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
 <20091215170321.GB21322@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 18:23:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKb7L-00015d-DB
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 18:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760659AbZLORXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 12:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760656AbZLORXS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 12:23:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760655AbZLORXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 12:23:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B5D22A72C2;
	Tue, 15 Dec 2009 12:23:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iGl3LuRypQGyPqP7Zxn0PITOyLc=; b=QZrXyM
	XJL6JjYF+Yp8T3lGIkPgZYVqAETynpJ8+Q6YEU034iQboVGJDgijI/rgrsU6EIxB
	7gjlHsXFd/bN4Hfw/uYERcAzfh4j+At0ldl0PnBAzYZpS9vI5TA7iQxRR0XSjVjE
	juhwUcfo94nnWCzPe/tI2vBOdzrUwP4EXt1R4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fiYyBKGI3xWgs4xKpLTqYIp4t5v/0Yhd
	a13EpAGSpT0JDTReOz/UrRmztJZpxWd4sJJLUg7ZHDpKoNXREW7az0Fryg0An6PP
	WC4oGkKqN6Wr/cfoDtBClg8bCe3bTxue98opgxPotv+cnN0wqpxXZ6li104XE3wB
	EMfU6O8Kj9A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87B19A72C1;
	Tue, 15 Dec 2009 12:23:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 11456A72C0; Tue, 15 Dec 2009
 12:23:07 -0500 (EST)
In-Reply-To: <20091215170321.GB21322@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 15 Dec 2009 12\:03\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 864F704C-E99E-11DE-AD5C-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135292>

Jeff King <peff@peff.net> writes:

> [1] The current textconv interface is really nice for things like just
> using "antiword" out of the box. But I wrote a new interface which can
> be much faster: it calls the textconv filter with the blob name, and
> then the filter is responsible for using cat-file to get at the blob.
> This means the filter can look at only part of a blob (e.g., if we are
> interested in the metadata tags at the beginning of a large media file),
> and it can cache answers as it sees fit, avoiding access to the blob
> entirely.
>
> I need to polish the code a bit and submit it. Obviously this is not
> meant to replace the existing textconv, but rather to supplement it, for
> when "fast and inconvenient" is better than "slow and simple". What is
> the best way to configure this? I can imagine "diff.*.textconvType =
> fast", or also "diff.*.fastTextconv".

"diff.*.blobfilter"?
