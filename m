From: Junio C Hamano <gitster@pobox.com>
Subject: Re: add -e, was Re: What's cooking in git.git (Apr 2009, #02; Sun,
 12)
Date: Tue, 14 Apr 2009 11:40:33 -0700
Message-ID: <7vhc0r3wpq.fsf@gitster.siamese.dyndns.org>
References: <7vvdp9w9l1.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904141943060.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 20:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltnaw-0007aZ-Kt
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 20:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758322AbZDNSkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 14:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758274AbZDNSkl
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 14:40:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758267AbZDNSkk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 14:40:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 27410F3C1;
	Tue, 14 Apr 2009 14:40:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 86B1EF3C0; Tue,
 14 Apr 2009 14:40:35 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904141943060.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 14 Apr 2009 19:48:55 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF85E602-2923-11DE-9733-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116552>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 12 Apr 2009, Junio C Hamano wrote:
>
>> * js/add-edit (Wed Apr 8 23:30:24 2009 +0200) 1 commit
>>  - git-add: introduce --edit (to edit the diff vs. the index)
>> 
>> I am Ok with the general idea, but the error detection needs to be more 
>> robust than merely relying on --recount.
>
> You mean something like saving an extra copy of the patch, and checking if 
> common or removed lines were either removed or kept intact?

No, editing a removed line and changing it to an unchanged line is
perfectly fine.

I was thinking more about people touching the lines near the hunk boundary
(e.g. insert a new line at the beginning of the hunk) which would not be
compatible without --unidiff-zero hack while applying, and --unidiff-zero
hack should not be used if we care about the correctness.
