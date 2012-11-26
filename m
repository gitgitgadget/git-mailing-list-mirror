From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bundle format
Date: Mon, 26 Nov 2012 12:38:17 -0800
Message-ID: <7vvccsqeva.fsf@alter.siamese.dyndns.org>
References: <871B6C10EBEFE342A772D1159D13208537ABF5AB@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Pyeron\, Jason J CTR \(US\)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:38:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5Rx-0000uq-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab2KZUiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:38:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756582Ab2KZUiV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:38:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B1D49EC9;
	Mon, 26 Nov 2012 15:38:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LFYmFIj4yX67831O5AgXLkvTGeA=; b=DbjMng
	ChOAckgaBBdQfe6RhTKTU1qcgM8BvQcHyb/3Ans9bYRo6CiwdvO2LnA+rbz7tMlo
	9CVdOxYd1uM2u86VnjVaOxcAFK6ce8JMoE2BBHBhAd+mS3edasSvzgsRvDoAt/Y0
	ba4nQwELe7bs5+HOfiEw7UU6blVugcf6ufPOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kceIS9K8xQGZgufsKe06WNqrsl9YaFFz
	g1aTUuQqkDC6djdL19Cih74xXYuIArgAOxCDfpDshLKw+AoykQnaWXS9up0CZnVJ
	mFFhEg9AKW97ItAjclMPBkiQcviHw/jLt8RiJXNT18sf2mRejZe0rw9HDC8MZ11J
	wa38na/JK90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 180469EC8;
	Mon, 26 Nov 2012 15:38:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 796F89EC7; Mon, 26 Nov 2012
 15:38:19 -0500 (EST)
In-Reply-To: <871B6C10EBEFE342A772D1159D13208537ABF5AB@umechphj.easf.csd.disa.mil> (Jason
 J. Pyeron's message of "Mon, 26 Nov 2012 19:24:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36847AE6-3809-11E2-88CF-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210482>

"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil> writes:

> In this situation we should assume that the bundle does not have
> any content which is already in the public repository, that is it
> has the minimum data to make it pass a git bundle verify from the
> public repositories point of view. We would then take the bundle
> and pipe it though the "git-bundle2text" program which would
> result in a "human" inspectable format as opposed to the packed
> format[2]. The security reviewer would then see all the
> information being released and with the help of the public
> repository see how the data changes the repository.

The bundle file is a thinly wrapped packfile, with extra information
that tells what objects in the bundle are the tips of histories and
what objects the repository the bundle gets unbundled has to have.
So your "git-bundle2text" would likely to involve fetching from the
bundle and inspecting the resulting history and the working tree
files.
