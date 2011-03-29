From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-notes.txt: clarify -C vs. copy and -F
Date: Tue, 29 Mar 2011 11:25:51 -0700
Message-ID: <7v7hbhss0g.fsf@alter.siamese.dyndns.org>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net> <7vbp0tss6t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:26:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dcI-0006Qf-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab1C2S0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:26:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1C2S0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:26:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D6C6411E;
	Tue, 29 Mar 2011 14:27:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JIUgpXObTyzaQoGdvKYe8b+fbAE=; b=lDm1ZE
	60yctPEg3SVDO9sGjBQ/rH5WzB26dz7AxW8marKabzmGWXeqfZAOynC6W2SAvECs
	4xB75OY+NfemMkchAeNl46Ry7JnDRzLHVq3XA6MYTcJvfgw9kK2k1YDIVMM9hohM
	KFedRYaIbot5A2Kb8B3vfWFRp0u91lMp/vLDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VHhE6PovZMVPGoNN4m3Snbzs7jUJlqrL
	Xzn37IfaoVbGK3vmFsheHV+rRXj45d6ZjG/eMWsxjuqxGfLWQFJwl2KPZ3hmA3lx
	MqLkJPNjs7JpGD0+Gdu1wbxkCi+cDw1COaskdQeQauOj8+hTyB2Wq68HX1Eq9NsU
	HfHNwuj0nec=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E22A04118;
	Tue, 29 Mar 2011 14:27:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 80F2F4115; Tue, 29 Mar 2011
 14:27:41 -0400 (EDT)
In-Reply-To: <7vbp0tss6t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 Mar 2011 11:22:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EBB7752-5A32-11E0-969A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170299>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> The current description of '-C' together with the analogy to 'git commit
>> -C' can lead to the wrong conclusion that '-C' copies notes between
>> objects. Make this clearer by rewording and pointing to 'copy'.
>>
>> The example for attaching binary notes with 'git hash-object' followed
>> by 'git notes add -C' immediately raises the question: "Why not use 'git
>> notes add -F'?". Answer it (the latter is not binary-safe).
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> In fact, the long name '--reuse-message' is really misleading, but I've been
>> around long enough to refrain from trying to change it ;)
>
> Yeah, it utterly is broken.  Why not fix it before people start making
> serious use of notes?

Actually I take it back and throw it again after doubling it.  Not just
the long name, but using -C/-c is already utterly broken.  These are meant
to reuse (meta)data associated with an existing object, not using some
data that happens to be stored in a random loose blob.  I don't think of
any similar option anywhere in git.

Instead of mucking with the documentation, why not fix the behaviour to
match what -C/-c/--reuse usually means, which is what the documentation
describes?
