From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: zsh: improve bash script loading
Date: Wed, 29 May 2013 10:49:35 -0700
Message-ID: <7vr4gpu15c.fsf@alter.siamese.dyndns.org>
References: <1369797840-3103-1-git-send-email-felipe.contreras@gmail.com>
	<51A59D8E.1040502@viscovery.net>
	<CAMP44s1UwYxS_sZSKTyEj5rhmrJ4gFkPc9z+eCL6WAaHXkY8eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhkVK-0007ko-PX
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934815Ab3E2Rtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:49:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58279 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933171Ab3E2Rth (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:49:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8549922CB9;
	Wed, 29 May 2013 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LMIB5VmCBc4ckF2s79e09MMoZeQ=; b=s1+qvf
	lCi9FNEsBwDg7n+q/G6USylEO2Qdmi6VkWMLoCT9A2C+bCa2S2hHqalmZm54hWkd
	aYD43TrQxEJndML5i+zF8BFVh3tnqUuo/GeiJ8Y8Rpl4B8wmRjNb5lPG9KmC/RVf
	01v/MIbckEw7YZX22HK4WPOqT/JNUM+m7PLFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m8dGV2abxwFys93owySseoI0SoJoBizx
	r/kP9qOkXRB7TlvVj+LmLRPVfhGeaBWlg/S9OuZmW3h0RxQ+uaQL+6scu6Cf8MFN
	Hjiyb2hf1NI/H0bqUBbsXoqwBTsyGIuCHxgihILmrTSft9Oc9cyGnXIu5lFmXQxB
	b4rFwwS9x9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78E6722CB8;
	Wed, 29 May 2013 17:49:37 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC43C22CB4;
	Wed, 29 May 2013 17:49:36 +0000 (UTC)
In-Reply-To: <CAMP44s1UwYxS_sZSKTyEj5rhmrJ4gFkPc9z+eCL6WAaHXkY8eQ@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 29 May 2013 01:30:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20E967D6-C888-11E2-A957-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225852>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 29, 2013 at 1:17 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 5/29/2013 5:24, schrieb Felipe Contreras:
>>> +if [ -z "$script" ]; then
>>> +     local -a locations
>>> +     locations=(
>>> +             '/etc/bash_completion.d/git' # fedora, old debian
>>> +             '/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
>>> +             '/usr/share/bash-completion/git' # gentoo
>>> +             $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>>> +             )
>>
>> Won't you need
>>
>>         local e
>>
>> here, or does it not matter?
>
> You are right, otherwise it would be in the user's shell.

Has this changed since 0a04e187e669 (completion: zsh: improve bash
script loading, 2013-05-24) which I have on 'pu'?

If not, I can do this locally to save a roundtrip, if you want.

 contrib/completion/git-completion.zsh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 9555cf8..fac5e71 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -28,6 +28,7 @@ zstyle -T ':completion:*:*:git:*' tag-order && \
 zstyle -s ":completion:*:*:git:*" script script
 if [ -z "$script" ]; then
 	local -a locations
+	local e
 	locations=(
 		'/etc/bash_completion.d/git' # fedora, old debian
 		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
