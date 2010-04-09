From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 4/4] Teach checkout-index to recursively checkout
 submodules
Date: Fri, 09 Apr 2010 15:04:10 -0700
Message-ID: <7v8w8w1dwl.fsf@alter.siamese.dyndns.org>
References: <4BBF9D6F.2000006@web.de> <4BBF9ED3.9010502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 10 00:04:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0MJK-0003q6-VD
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 00:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035Ab0DIWES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 18:04:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab0DIWER (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 18:04:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44C2FA9B0D;
	Fri,  9 Apr 2010 18:04:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VLs/v8IjUZ6B6ad86D5fj+s55wA=; b=FrnNJX
	VQ6Vyz+0Ny2ZlIZiF+YTnib3JOHF50e9MvhdF8uo00seHeSKt8A0Xz/nfNWBH2Yi
	osjDP6+NOgdaEDYMcYXXwf7RRNpNfwD/0bn07+biIWJEg56FagSeHZwP/WGEuGG2
	EBEAQL0kxfaGlu/SQW48HdD8ElD60Paoc+tlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=whVbsx8WPbW3o8YcoJlje2A+m0tnOqLw
	njUyN4cothhkXrnpSJoySUKyETQYppLFC4q1QYO0msoOcXbTstAxMxzTinNUYN8V
	i1/j1J3Zum3Sw6G3agtUFAtTK9UbhjICzmOBxf9q2cCbEo+x2iftX76T9uAeeeDZ
	H3FgtNVfY4E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05139A9B0B;
	Fri,  9 Apr 2010 18:04:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EB14A9B09; Fri,  9 Apr
 2010 18:04:11 -0400 (EDT)
In-Reply-To: <4BBF9ED3.9010502@web.de> (Jens Lehmann's message of "Fri\, 09
 Apr 2010 23\:40\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D60434EE-4423-11DF-BFC0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144480>

As a plumbing I would prefer to leave checkout-index as is; script writers
can choose to recurse if they choose to.

This is not limited to checkout-index, but what is the stance of this new
feature on failures from sub-checkout when there are local modifications
in the work tree?  Some parts of the work tree is checked out while the
ones after the failure that sorts later in the alphabetical order will not
be checked out, resulting in an inconsistent state (I am not saying that
it is good or bad---I am trying to see what the users should expect from
this new feature)?
