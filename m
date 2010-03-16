From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] cherry: support --abbrev option
Date: Mon, 15 Mar 2010 18:44:15 -0700
Message-ID: <7v634xyr9s.fsf@alter.siamese.dyndns.org>
References: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>
 <4B9E69A4.2080304@lsrfire.ath.cx>
 <40aa078e1003151530y19f10bf1l852a0e5230b11cb6@mail.gmail.com>
 <4B9EBFEB.5070108@lsrfire.ath.cx>
 <40aa078e1003151650m549bafdbwdd849e23349ce6a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 16 02:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrLpf-0001er-8y
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 02:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367Ab0CPBoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 21:44:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845Ab0CPBoY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 21:44:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE1D3A08D0;
	Mon, 15 Mar 2010 21:44:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XurVpcobRKJahZfOb3yLZFc+rhw=; b=FKuGtQ
	vTwePp4L8DvwuOLNofZfv8gmqFd93dgjjKHSrWAx5Frc8WOHbqeIrJQvAOvqDGvr
	zE17/1g0dgylkXMMDoLOE6YIkdLkXWkr3rCMOM5heI1CkvICihJUlu9PAdE3lK+l
	F/nEpSPHNUCTWB85sx2oory+wj+Jnjqxbk7c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHWNjLop+U3jz+08rKGjsB5zD5GJrNax
	KiVYWfRk6GhCBfRWzVb/qGtDyZoQ8BPDRa2lVX3xXli5TeoqFZK/XI747lrqeg4Z
	cgQw41t+vAQLxoYa1XKXwAayDxCqUhSa8XuoQkv6jmdIavaQp16dlztWIsYtYVBb
	8yqTZjZTOAc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C391A08CF;
	Mon, 15 Mar 2010 21:44:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3FA2A08CE; Mon, 15 Mar
 2010 21:44:16 -0400 (EDT)
In-Reply-To: <40aa078e1003151650m549bafdbwdd849e23349ce6a9@mail.gmail.com>
 (Erik Faye-Lund's message of "Tue\, 16 Mar 2010 00\:50\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70D57068-309D-11DF-9D12-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142290>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> So, basically, ls-files and ls-tree seems to think
> find_unique_abbrev() does not correctly (for this purpose) handle
> abbrev=0. However, show-ref does seem to assume so.

I think this is merely historical; the former two were written way back
before corner case behaviour, namely length=0 case, was cast in stone, and
hence they call f-u-a unnecessarily defefnsively.

.
