From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about "git pull --rebase"
Date: Sun, 15 Nov 2009 12:18:29 -0800
Message-ID: <7vlji7k0dm.fsf@alter.siamese.dyndns.org>
References: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
 <4AFF3D4D.7000308@gmail.com> <m2my2noo0g.fsf@gmail.com>
 <4B005AEC.1000002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: "Johan 't Hart" <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 21:18:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9lYb-00049N-Sr
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 21:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbZKOUSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 15:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbZKOUSd
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 15:18:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbZKOUSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 15:18:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD2929EDB1;
	Sun, 15 Nov 2009 15:18:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mhJgIlCtJkqrPklE5ZuUxoTCmjQ=; b=sULlFT
	8tkNUhPoGoWOoOPCQnXxbb/rwhqm+bl81xDWRuiXJPiljGsYLO5iokFpzrGJfxy+
	/EK6N6PXHecl/7RpOFOapMYnUfFz4o8ywt8f1Y7uW5wIOF6qCC+R8nNWkCHgvn9C
	BxUn8Hit9pHsYYngo6f3JtvepPIkwvTdeGQA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J9Rva2qYmWraMpYKIx7UTwj35TB5zVgs
	0COqAfwUcZhDT6BXLiulEZrZtZCfW+GgLrLSrEH7r8tVzmx8HBsaeTyFGpH51kFU
	r964x3U4TQMlE6ss7dBHKLSyRnQRZYTkR+zVfXmYaUUDRtkaET0RWZbj0+YMjizS
	mVOgP3XQCvg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CA479EDAE;
	Sun, 15 Nov 2009 15:18:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 54B0F9EDAD; Sun, 15 Nov 2009
 15:18:31 -0500 (EST)
In-Reply-To: <4B005AEC.1000002@gmail.com> (Johan t. Hart's message of "Sun\,
 15 Nov 2009 20\:47\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D916B88-D224-11DE-94F1-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132957>

Johan 't Hart <johanthart@gmail.com> writes:

> Francis Moreau schreef:
>> Looks like you did :)
>>
>> I've been somehow confused by the git-pull man page, which says:
>>
>>   A parameter <ref> without a colon is equivalent to <ref>: when
>>   pulling/fetching, so it merges <ref> into the current branch without
>>   storing the remote branch anywhere locally
>>
>> So I thought that both of the commands were equivalent for 'git pull
>> --rebase'.
>>
>> Thanks for the explanation.
>
> Ah that part.
>
> It means that
> $ git pull --rebase origin master
>
> means the same as:
> $ git pull --rebase origin master:
> (note extra colon at the end)
>
> But not as:
> $ git pull --rebase origin master:foo
>
> It means that, when you give a refspec without a colon, it is the same
> as the refspec with the colon and without the right side.

Thanks for clearing it up.

I was puzzled by the above pointing-finger because I wanted to see where a
misinformation originated from to fix it at the source.  But still don't
see anything wrong with it.

Perhaps there was some other part of the manual that confused Francis to
think master: and master:foo are equivalent in that context?  I somehow
doubt it, but if there is one, we would need to fix that

In a separate thread, Thomas reported a gross misinformation in github
wiki he recently fixed:

    From: Thomas Rast <trast@student.ethz.ch>
    Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
    Date: Sun, 15 Nov 2009 13:24:03 +0100
    Message-ID: <200911151324.05109.trast@student.ethz.ch>

Perhaps that page had some impact on this misunderstanding? 
