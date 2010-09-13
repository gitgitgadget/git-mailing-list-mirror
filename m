From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Mon, 13 Sep 2010 16:14:54 -0700
Message-ID: <7v7hipb5ht.fsf@alter.siamese.dyndns.org>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil> <7vy6bajvnd.fsf@alter.siamese.dyndns.org> <1094265482.7527324.1284144028114.JavaMail.fmail@mwmweb047> <AANLkTinMf-_vk2-gRazf-8FNykZoNbVwmu_+c+5ht8rY@mail.gmail.com> <1258122337.8606899.1284400767503.JavaMail.fmail@mwmweb047> <150763691.8130046.1284401891268.JavaMail.fmail@mwmweb048>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 14 01:15:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvIF2-0000re-Vj
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 01:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab0IMXPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 19:15:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab0IMXPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 19:15:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C76FBD6358;
	Mon, 13 Sep 2010 19:15:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mILcWbGHtHGDMSqz99LFJBtpkvM=; b=OJxlvj
	5ob0f5Izi2nStb06/JW5xeAIoyVPXm2KcM+0JjYKGL+YkXb+l9U1cQ887dWS4P8N
	pAEfwpb1pI+ATmYobA5mV/M4ISsXp196/qCvcF/BBYagKw5njok+oxCoDzNxiQ4W
	OkWOnbewatKax1fwCJSs4geNB8BehoHCugqjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s8IAvosb2jf46yZdeZ6lrkH3E9aQuDcf
	0Z0rnvY4Ok1VsNIzwZvxhs5/Kb6/H00gtBmGG0nskeRBD6kp6HbWT18Y81r+5y9P
	q79MiQfGLtLjf5d2gnrvR5eKXzuWH0sGoQkUVa6vDniKYIDbKea36n3lPLW2aZmv
	ST8dJeG96Yg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 45625D634B;
	Mon, 13 Sep 2010 19:15:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08E85D6347; Mon, 13 Sep
 2010 19:14:55 -0400 (EDT)
In-Reply-To: <150763691.8130046.1284401891268.JavaMail.fmail@mwmweb048> (Jens
 Lehmann's message of "Mon\, 13 Sep 2010 20\:18\:11 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC75A6CC-BF8C-11DF-8CE9-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156150>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>>>Perhaps the default setting of submodule.<name>.ignore should be 'untracked'?
>>
>>I still vote for none. I think the default should be to not have untracked files in
>>your projects (like you should not have warnings when compiling your project).
>>If that is not wanted, just use the configuration options git provides to change it.
>
> I forgot to mention: I think untracked files should mark a submodule as modified
> because otherwise it is too easy to forget adding new files inside submodules,
> as they won't show up when the 'ignore' setting is 'untracked' .

What makes untracked paths in the superproject different from the ones in
a submodule?  "git diff" cannot be it as it does not show untracked paths
in the superproject, so you are talking about "the user cannot tell from
the 'git status' output", right?

How about giving a new section in the status output that lists submodules
with untracked paths, and do so only when ignore-submodules is set not to
ignore them?
