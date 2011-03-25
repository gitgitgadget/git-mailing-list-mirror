From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Fri, 25 Mar 2011 15:39:05 -0700
Message-ID: <7vvcz64ygm.fsf@alter.siamese.dyndns.org>
References: <20110325200528.GA7302@blimp.localdomain>
 <7vsjub53j2.fsf@alter.siamese.dyndns.org>
 <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com>
 <7voc4y6g6v.fsf@alter.siamese.dyndns.org>
 <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 23:39:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Ff5-0004rr-Ny
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 23:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab1CYWjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 18:39:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab1CYWjO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 18:39:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29D664A47;
	Fri, 25 Mar 2011 18:40:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4fNihdZ9+eEL
	IyHXwJamSOM3gPc=; b=WLZi+lK56yEt9lub7uoCgiXFvA/Q8l40L4LdQrg76ufk
	wC75hM4voW8p0dOKOu57wqkdsxrROv0AyVtINdyf7+Dt5CXxWlXZBOL1ypAF1BM+
	69+WCYhi7K5dVCTk0H/UGTLbcpAd7yClHKfJK+cOORtN6DxpmJkvf5h47LGEMv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w8bTXo
	YU0ImDxlnnuxLl1IuYHMHnuJ1L5x8IiY/VPaZBwTFAzQ9V83gXhIamQJ9K1Yfmq3
	pVcKO/i8EInGf1a31F+IZqnplFDkPMqTJSuPIGVhgVHY+gYoZD94yObcul0HFvZ+
	82WrpD8iQbzF4ZWz63ka24hy7ClIRwb7x/esQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07C544A46;
	Fri, 25 Mar 2011 18:40:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EBE154A45; Fri, 25 Mar 2011
 18:40:50 -0400 (EDT)
In-Reply-To: <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com>
 (Alex Riesen's message of "Fri, 25 Mar 2011 22:51:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F14CD6A4-5730-11E0-B8C8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170029>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Fri, Mar 25, 2011 at 22:30, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>>> On Fri, Mar 25, 2011 at 21:49, Junio C Hamano <gitster@pobox.com> w=
rote:
>>>
>>>> Doesn't this change the location of HOME used during the test as w=
ell?
>>>
>>> As long as the test only includes test-lib.sh only once - it doesn'=
t.
>>> Why? Or rather, how?
>>
>> I thought you moved HOME=3D$(pwd) across "cd somewhere-else". =C2=A0=
Doesn't it
>> change what is returned from pwd?
>>
>
> Oh, it does. That's why the second patch (prefixed "[PATCH, fixed]").
> It makes HOME to be "$(pwd)/somewhere-else", or precisely:
>
>   HOME=3D"$(pwd)"/"$test"
>   export HOME

What happens to people who has non-empty "$root", iow, their $test begi=
ns
with '/'?

I am not saying that having HOME at t/ directory instead of t/trash-*/
directory would necessarily break things (I don't know).  I am just
pointing out that the patch changes behaviour.
