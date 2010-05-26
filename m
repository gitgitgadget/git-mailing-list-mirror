From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove over-eager caching in sha1_file_name
Date: Tue, 25 May 2010 22:07:13 -0700
Message-ID: <7vtypvqmim.fsf@alter.siamese.dyndns.org>
References: <19441.8259.634019.348195@winooski.ccs.neu.edu>
 <20100522054852.GB29118@coredump.intra.peff.net>
 <20100522064308.GA11335@coredump.intra.peff.net>
 <20100522065942.GB11335@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 26 07:07:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8q3-0005MW-Ld
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab0EZFHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:07:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab0EZFHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:07:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B143B67A9;
	Wed, 26 May 2010 01:07:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=aG0wL0hVtUji9j1iD4FbkMwg4wM=; b=a8GNya3MVO1u2FcP53N5OhV
	DckanUELx7Ujus+L3ZPcNyMPIpP5jdyUuH8dyWBwZHptY//czziYQ09c883lqyf1
	M4e8QZ1bEkCEUhPTLk6fMZ8Dgl28arVTQXVHoA0lee6tcTBBxX5bJYxTEx5G9ktf
	gfGu0Cbd+XS8RGVeN7bU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ZG8XfK2xUrNab/7rksQuNwINXaUdPmsJRLU6BY5798xawMMhr
	u0AzTUhWcLVVySNz51AgfkM2qB7k//Faf4kPkxUFU3j6boFnY/5wxTES/bYhE434
	THHf/z/Su8xnidcX1/b5jKIw5uRpX6WU0s/TzsTllP30qRNyZVgsUXdisE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 307E2B67A6;
	Wed, 26 May 2010 01:07:18 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7181AB67A2; Wed, 26 May
 2010 01:07:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8E97ED3C-6884-11DF-8037-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147736>

Jeff King <peff@peff.net> writes:

> Actually, thinking on it more, micro-optimizing this is really
> pointless. I was thinking that it would get called a lot, so we need to
> care. But the next step is almost certainly to open, mmap, and zlib
> decompress the resulting object, which is way more expensive.
>
> So here it is with caching ripped out. More readable and more robust,
> and I'm sure we can afford an extra strlen() and memcpy() on each object
> lookup.

Makes sense; thanks.
