From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] graph API: Added logic for colored edges
Date: Sun, 12 Apr 2009 11:45:08 -0700
Message-ID: <7vk55p7lu3.fsf@gitster.siamese.dyndns.org>
References: <7vocv6is9g.fsf@gitster.siamese.dyndns.org>
 <20090409222238.GA16573@linux.vnet>
 <7vhc0u9s86.fsf@gitster.siamese.dyndns.org>
 <b2e43f8f0904121043o425ac311ib32c18625fac2c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 20:47:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt4hq-0000X2-WB
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 20:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbZDLSpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 14:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbZDLSpT
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 14:45:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbZDLSpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 14:45:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1DCAEB2C;
	Sun, 12 Apr 2009 14:45:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E3407EB2B; Sun,
 12 Apr 2009 14:45:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10D07024-2792-11DE-B7BE-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116386>

Allan Caffee <allan.caffee@gmail.com> writes:

>> > +const unsigned short GIT_NOT_A_COLOR = -1;
>>
>> That (-1) is an unusual value for an *unsigned* short variable.
>
> Perhaps you would prefer USHRT_MAX?  I noticed that none of the existing
> code #includes limits.h.  Is it safe to assume this header is present?

I expected to see something like 

	#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors)+1)

	write_with_color(...) {
                if (c->color < COLUMN_COLORS_MAX)
                        add color prefix;
                add string
                if (c->color < COLUMN_COLORS_MAX)
                        add color suffix;
	}

instead, actually, and was a bit surprised with (-1).
