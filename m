From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] expanded hook api with stdio support
Date: Tue, 03 Jan 2012 13:44:45 -0800
Message-ID: <7vliposboy.fsf@alter.siamese.dyndns.org>
References: <1325207240-22622-1-git-send-email-joey@kitenet.net>
 <1325207240-22622-2-git-send-email-joey@kitenet.net>
 <4EFD88CB.3050403@kdbg.org> <7vsjjwtvf1.fsf@alter.siamese.dyndns.org>
 <20120103200642.GH20926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Joey Hess <joey@kitenet.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 03 22:44:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiCAA-0000qk-OB
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 22:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab2ACVou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 16:44:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab2ACVos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 16:44:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFE697AE8;
	Tue,  3 Jan 2012 16:44:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ldiy4bgoDPNVcmrj/LH7745E1c=; b=cXEQXu
	0cKBCrHhPodf3cI54KZgncj3YPrdLTx34Jo3unjHmE5P5jGfbX2NKqIW377QBJjJ
	KrvaD0klkM2wUBGjwq0fhq4ioBbv+4xoGmP6rNNgrlKGkM3ZDYKKKQT5vAO0V18E
	031CuT1L4UEwXo9knxzkJbCrOa4UNgZD1cujg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lIBg+73YJnqaOH+Wat4qWB9QDtUOn5PX
	2MaJVSej7ZBB62H7PD/C+/9AbzwFILWfYSH7Bnrs7ybG/+u/kYQ88L2ooMRdwHiJ
	Z8k7rJOQAWEXWjCY26/ASBJyi/lYxCWX4uTq5qbt/gOVX9gVW/RXCl0GCjnwGNbu
	6WComcNedzU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5E347AE7;
	Tue,  3 Jan 2012 16:44:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AD857AE5; Tue,  3 Jan 2012
 16:44:47 -0500 (EST)
In-Reply-To: <20120103200642.GH20926@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jan 2012 15:06:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27E9F342-3654-11E1-BD9D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187899>

Jeff King <peff@peff.net> writes:

> The credential helper code could potentially have the same deadlock.
> Possibly also clean/smudge filters.
>
> Maybe it could even be part of the run-command interface?

Hmm, that smells like the right thing to do.
