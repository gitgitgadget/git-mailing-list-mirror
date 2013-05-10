From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Fri, 10 May 2013 09:22:15 -0700
Message-ID: <7vfvxu3ivc.fsf@alter.siamese.dyndns.org>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
	<518C8EAC.6000106@viscovery.net>
	<7vzjw349y0.fsf@alter.siamese.dyndns.org>
	<CACsJy8CopioiTrEDfuZK=n1DfJ8_chxV9dEObqpVfHHmJvzyqQ@mail.gmail.com>
	<7vvc6r4855.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 18:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaq5O-0005su-O5
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 18:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab3EJQWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 12:22:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755240Ab3EJQWS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 12:22:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DC2A1D1BB;
	Fri, 10 May 2013 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1yLB1FQQsL7eojrlzacuAddTic4=; b=SM24md
	Yabqc11DJhDw8kQRJu6Ty/eHe4yiVMLWbk3tFJgKNWQdyZk2NJS4lZF7+9jYEBSy
	LEnpKmKaZnAxYMFfjEqnWDG2oZFB2mFdDSG7HkXv422BNxmFkzh1LivUTSUMIWdw
	uNzlluw/IkFKriITN3+cfQBrYkxBG/aFYaLBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rmSLM9TCmLJarHnsXsAgN82Lmv5oBQqZ
	grSkWCnepZWG7fNANw8tNMv9rU5O13QzrtFdE1zJLGIcmHZWngwvloEDxv2KvVOU
	wCaacMn+7r6iTdhIzs8FXeN83gLmValMvPr1aTd4oP0yGypiV6TfEg3StiqqpfwJ
	Rpa1zbIsvrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 919631D1BA;
	Fri, 10 May 2013 16:22:17 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 002631D1B9;
	Fri, 10 May 2013 16:22:16 +0000 (UTC)
In-Reply-To: <7vvc6r4855.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 10 May 2013 00:16:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7EA72A0-B98D-11E2-91AB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223877>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, May 10, 2013 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> Imagine that a user runs "git rebase" on a history leading to commit
>>> X to create an alternate, improved history that leads to commit Y.
>>> What if we teach "git rebase" to record, perhaps by default, an
>>> "ours" merge on top of Y that takes the tree state of Y but has X as
>>> its second parent, and "git log" and its family to ignore such an
>>> artificial "ours" merge that records a tree that is identical to one
>>> of its parents, again perhaps by default?  "git log" works more or
>>> less in such a way already, but we might want to teach other modes
>>> like --full-history and --simplify-merges to ignore "ours" to hide
>>> such an artificial merge by default, with an audit option to
>>> unignore them.
>>
>> What about git-merge? Will it be fooled by these merges while looking
>> for merge bases?
>
> I thought it was obvious that we should ignore the side branches
> that were superseded this way, as by definition they did not
> contribute to the end result at all.
>
> But there must be something huge that I missed...

I think what I missed is that the same logic to ignore side branches
whose history gets cauterised with such an "ours" merge may apply to
an "ours" merge that people already make, but the latter may want to
take both histories into account.

So I guess it is not such a great idea.
