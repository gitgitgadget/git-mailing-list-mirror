From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Mon, 21 Mar 2011 13:59:15 -0700
Message-ID: <7voc54nqak.fsf@alter.siamese.dyndns.org>
References: <4D81C1AA.5010008@morey-chaisemartin.com>
 <7v1v254ma7.fsf@alter.siamese.dyndns.org>
 <7vhbb1320t.fsf@alter.siamese.dyndns.org> <4D87B51A.4060609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:59:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1mCL-00028x-IK
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab1CUU73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 16:59:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab1CUU71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:59:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45B8B4D04;
	Mon, 21 Mar 2011 17:01:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RfDfdIltQRqRFCyfuJalrrK420M=; b=MEgdI1
	VQB47LIOzPA9207GwwjJUjydNgd/YZcmVkb2tlGnHQPr/d9pRf6G5iXcCQrVMGGO
	iedAytyBchauDk9g9hHxHRsOSjW46Zxtj+07BcgWzTZ4/IZvLY8cSZblgFvmCcTk
	ka5m602Iej6uBcQL9siHWdWlmdNBhfe3vmEYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bW0kV7RAVaNLUKaGmZTX3aUjKqjWrD++
	eQXTyrtRiiAuDfqfwmWbMI0+O3dtlArCXyqVJMD3ohtuyn8B18CbImRofgtrInb6
	OYcYtr6JgTMcVvL2ci2h0cyLnuWcSWFCk26dtNePq5+Xg/nVpbHbFPyncjB7z83v
	o3rDS6+6GiI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01D754CFF;
	Mon, 21 Mar 2011 17:01:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A79754CFD; Mon, 21 Mar 2011
 17:00:56 -0400 (EDT)
In-Reply-To: <4D87B51A.4060609@web.de> (Jens Lehmann's message of "Mon, 21
 Mar 2011 21:29:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 541DAF00-53FE-11E0-A8DE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169671>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I do think status does have something to report here. First its job is to
> list all submodules, so currently unmerged submodules should show up too,
> and then it tells the user something about the state of the submodule. So
> I would propose to print a line for the submodule starting with a special
> character that tells the user the submodule has a merge conflict. We
> could e.g. use a '*' here (additionally to '-' for uninitialized and '+'
> for those submodules where the HEAD differs from the commit recorded in
> the superproject).

Thanks.

As everybody knows, you are a lot more deeply involved in this than I do,
so please take the discussion and implementation from here.  For example,
I don't know if '*' or 'U' is more intuitive, and I'd rather not have to
make such decisions ;-)
