From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: place temporary packs under .git/objects/pack/
Date: Tue, 19 Oct 2010 09:33:49 -0700
Message-ID: <7vocaq16s2.fsf@alter.siamese.dyndns.org>
References: <1287474040065-5649864.post@n2.nabble.com>
 <cbdf4787ddaccd7105ab1661529a98257d61179b.1287481801.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Marat Radchenko <marat@slonopotamus.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 19 18:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8F8b-0005fu-Nu
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 18:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840Ab0JSQd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 12:33:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab0JSQd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 12:33:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C77EE0F99;
	Tue, 19 Oct 2010 12:33:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3SvBVof5OFD0mX9GRlSwYGx5dmY=; b=cmiS7kzhEDhCeEuuhCHuoXT
	w/86UgrZyyALzx98k/P+w0wKJUeL6xFkjGejZoBosB1xvUQzdjEBi5tmAMM52QYW
	n95XwFLLY0A7HPu8UQ80Y87KKVun0Xiiu6L0c24eiyvBiJExnh27RNXAzvYd0KkW
	IXzP+2VJJI4l7nlXa4NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=l6X4PqB6RvrT9tfrjt86TC/bxEA2QWcJrPmGSprPFv2wVfApq
	mCRL4aF3BVitOPTtpNPGm7rg/CbQa0hUTO4g86FBE8iyapdEPcKbubm/WGi8ret6
	UKLJDUUZouXBX8dWcHkh5psoav7/Q7pAI0qabmYCWwHYbJg2pDYpbyzDCM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 292DDE0F98;
	Tue, 19 Oct 2010 12:33:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A63AE0F97; Tue, 19 Oct
 2010 12:33:50 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A99DBD18-DB9E-11DF-8A6D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159337>

Thomas Rast <trast@student.ethz.ch> writes:

> git-pack-objects is already careful to start out its temporary packs
> under .git/objects/pack/ (cf. 8b4eb6b, Do not perform cross-directory
> renames when creating packs, 2008-09-22), but git-repack did not
> respond in kind so the effort was lost when the filesystem boundary is
> exactly at that directory.
>
> Let git-repack pass a path under .git/objects/pack/ as the base for
> its temporary packs.
>
> This means we might need the $PACKDIR sooner (before the pack-objects
> invocation), so move the mkdir up just to be safe.
>
> Also note that the only use of *.pack is in the find invocation way
> before the pack-objects call, so the temporary packs will not suddenly
> show up in any wildcards because of the directory change.

Looks good; thanks.
