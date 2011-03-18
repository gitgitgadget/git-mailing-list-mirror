From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] revision.c: introduce --min-parents and
 --max-parents
Date: Fri, 18 Mar 2011 14:21:53 -0700
Message-ID: <7v1v24w2dq.fsf@alter.siamese.dyndns.org>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
 <7f2a7d979cd8f6b9fce577994c82f50421575d58.1300459017.git.git@drmicha.warpmail.net> <20110318204854.GA23331@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0h7d-0003Db-OY
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757498Ab1CRVWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 17:22:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757492Ab1CRVWG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 17:22:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 347A44425;
	Fri, 18 Mar 2011 17:23:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ari7uUsR1MI7tvDNZGyvoxoc33k=; b=FGVMFl
	Fy5+sCFASf4a6YvkyJoxhap0w1H3Y6UKLgF6s9Dr0zZYHLTn+ofw9bNqk+C2UQrx
	LfUvYkN8VHqEZpzQqW98Yn7lDLGy2Q0eFhbW0SyPUT/uubXd7lxvhWZqlSoWQPtB
	azhA+JKGgo/f+29OXStr13EqreUuTPqTOlomA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PRJo0B9J7Ny+0GpKzAUYmTarCoqfDLU9
	avNE/v/rKG29J0wEr94b85DxLykodVfp8nANw/ZH2i68BE5qNoYeLKVe/vtfSklv
	B1+qfuvi1n/8E8oBgUvXG6YFwfks8MmZLPQO0NPR1olrRHS5MixaMXHdJjCsK7VL
	eFhp5Sc3hOI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3EE84423;
	Fri, 18 Mar 2011 17:23:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A7E464422; Fri, 18 Mar 2011
 17:23:29 -0400 (EDT)
In-Reply-To: <20110318204854.GA23331@elie> (Jonathan Nieder's message of
 "Fri, 18 Mar 2011 15:48:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB4A2624-51A5-11E0-87DC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169363>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Is there a reason not to choose a convention for which
>
> 	rev.max_parents = 1;
>
> works?

I also hate the peculiar convention used in this patch.  Is it worth this
ugliness to avoid adding a line in init_revisions() to initialize it to
the infinity value?
