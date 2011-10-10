From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Teach merge the '[-e|--edit]' option
Date: Mon, 10 Oct 2011 08:23:18 -0700
Message-ID: <7vmxd8oopl.fsf@alter.siamese.dyndns.org>
References: <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
 <1318023997-54810-1-git-send-email-jaysoffian@gmail.com>
 <7vfwj4tplw.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dzrk5x0+JRC8EbrAxjZE+hD+-5mp+H=F=M8Su2WosPfmg@mail.gmail.com>
 <7v8votpx4n.fsf@alter.siamese.dyndns.org>
 <7vr52lo1m3.fsf@alter.siamese.dyndns.org>
 <m3ehyl1g5v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 17:23:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDHhZ-00041E-Lz
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 17:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755Ab1JJPXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 11:23:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab1JJPXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 11:23:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 829B05D52;
	Mon, 10 Oct 2011 11:23:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Z92jM+w4DZ/KaH4AmYmubHIwYQ=; b=DbIdyR
	svM03kKwOhtvNRPJqfuX10pdBho1GwPesyNITELvtHKVzSNhzfyf35ESsvtCV3Ys
	dzXsknCrRnN/yfcyff7wMrFzzh+22ZS4Mo9x2spyW6t2ZkGgHMElOEaokdad0nuk
	PO7PopLVPqkm4eG+FagdmQHETePLUjgdp9DIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=logPyqZPm0mkrKIrPDTy26pYC+GxIQyh
	cxxQad1Q+h7MPJ2smNvoFWqaGZXZ3ty5k+5Y55qg+rSq5DS9zS8NKZRovw6ob2Ha
	YSubTCawGCjRzjorI3OugJPo6OBScVhskUgYGT9wYkmTQEpgWxIfTH3AMZZEiA0V
	4Pe1Emp4dBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 734A45D51;
	Mon, 10 Oct 2011 11:23:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D84CB5D50; Mon, 10 Oct 2011
 11:23:20 -0400 (EDT)
In-Reply-To: <m3ehyl1g5v.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon, 10 Oct 2011 00:05:02 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9772A5C-F353-11E0-84EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183243>

Jakub Narebski <jnareb@gmail.com> writes:

> Yet another issue is if we should blindly trust automatic merge resolution.
> It is considered a good practice by some to always check (e.g. by compiling
> and possibly also running tests) the result of merge, whether it required
> merge conflict resolution or not.
>
> IIRC Linus lately said that making "git merge" automatically commit
> was one of bad design decisions of git, for the above reason...

I think your recalling this discussion

    http://thread.gmane.org/gmane.linux.kernel/1191100/focus=181362

While I agree with what Linus said in the message, I think you are not
remembering the discussion correctly. It was about bad commit _message_,
and an improvement is not to let users tweak a cleanly automerged result,
but is to allow users or force them to always write their own message,
perhaps with "merge --[no-]edit", which is exactly the point of Jay's
patch in this thread.
