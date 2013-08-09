From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: reject if another gc is running, unless --force is given
Date: Fri, 09 Aug 2013 09:00:24 -0700
Message-ID: <7vhaey7t2f.fsf@alter.siamese.dyndns.org>
References: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
	<1375959938-6395-1-git-send-email-pclouds@gmail.com>
	<7vk3jw9hlm.fsf@alter.siamese.dyndns.org>
	<CACsJy8DRRLkyZid_OPSvRkvKfnd62TnLBnaueim9GrXUikPGuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 18:00:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7p7D-0005al-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 18:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164Ab3HIQA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 12:00:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934068Ab3HIQA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 12:00:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22ABA36625;
	Fri,  9 Aug 2013 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RzOORac+uvTtaOl2EtDWaycXLJ0=; b=b/9j96
	LB1Pejbo0c0nw41iDFo+ItKemEi0tq5s4cmaQ4nm0MD2tpHF8pCFNQbE1SSoc2qS
	gWCOhUoD69H26egCBzj1c1y3WwjRqXroF3+cLdrVDyzyefXxZn0qhzQ4zJlgxmAX
	xfy3qadleOKW06ZF3zb6OCchDjw4Osd4FlBv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LMo1mx/QThRPjRRdA+hw67ytEHna9gQQ
	w1aZOABQLI+Tm3VGykdf76EX3JygrYbaCvzGZFdhWRURiGdG03P/uxI29AjVeu/n
	HT9elJIyrpJlD6GaoNFjuzokEqiBmnyxrhtT/WLbFTCP37Ya88ugxVke5VLqdq63
	Fk4pk6vvdew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1120436623;
	Fri,  9 Aug 2013 16:00:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5455436622;
	Fri,  9 Aug 2013 16:00:26 +0000 (UTC)
In-Reply-To: <CACsJy8DRRLkyZid_OPSvRkvKfnd62TnLBnaueim9GrXUikPGuw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 9 Aug 2013 19:52:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE4BDBF4-010C-11E3-8C01-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231991>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Aug 9, 2013 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> When we see a recent lockfile created by a "gc" running elsewhere,
>> we do not set "should_exit".  Is that a good thing?  I am wondering
>> if the last two lines should be:
>>
>> -       !strcmp(locking_host, my_host) &&
>> -       !kill(pid, 0);
>> +       (strcmp(locking_host, my_host) || !kill(pid, 0));
>>
>> instead.
>
> Yes I think it should (we still have the 12-hour check to override
> stale locks anyway). Should I send another patch or you do it yourself
> (seeing that you have this chunk pasted here, you might have it saved
> somewhere already)

The above was typed in my MUA ;-), but it is an easy update I can do
so will do so anyway.

Thanks for double-checking.
