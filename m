From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git add --intent-to-add: do not let an empty blob
 committed by accident
Date: Mon, 01 Dec 2008 01:24:11 -0800
Message-ID: <7vhc5os0xw.fsf@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
 <20081128192033.GF23984@spearce.org>
 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
 <7vk5an4cba.fsf_-_@gitster.siamese.dyndns.org>
 <7vvdu72nq9.fsf@gitster.siamese.dyndns.org>
 <7vk5an2nil.fsf_-_@gitster.siamese.dyndns.org>
 <20081130191444.GC10981@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 10:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L752w-0002t3-T7
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 10:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbYLAJZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 04:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbYLAJZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 04:25:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYLAJZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 04:25:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69ED783CDF;
	Mon,  1 Dec 2008 04:25:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BE0F083CD9; Mon,
  1 Dec 2008 04:24:13 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EF1F578A-BF89-11DD-A73E-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102008>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 28, 2008 at 07:56:34PM -0800, Junio C Hamano wrote:
> ...
>>  	case WRITE_TREE_UNMERGED_INDEX:
>> -		die("%s: error building trees; the index is unmerged?", me);
>> +		die("%s: error building trees", me);
>
> This caught me by surprise while reading, but I assume the rationale is
> "now there is a new, different reason not to be able to build the trees,
> so our guess is less likely to be correct". I wonder if we can do better
> by actually passing out a more exact error value (though it looks like
> we will already have said "foo: not added yet" by that point anyway, so
> maybe it is just pointless to say more).

The places that detect the "unmerged" (and then newly added "intent-only")
entries already have issued error messages in the codepath that leads to
this error.

>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>
> Why in t3701?

Good question.  Brain fart, perhaps.
