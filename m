From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 14:08:03 -0700
Message-ID: <7v8viswdho.fsf@alter.siamese.dyndns.org>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <7vmx79zeui.fsf@alter.siamese.dyndns.org>
 <CAJsNXT=YEida53nV7kj6a3cw2GibYJab4n2PucNO6inUR3HPRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 22:08:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SApF1-0000sF-T1
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 22:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873Ab2CVVIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 17:08:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab2CVVIG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 17:08:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6047D654E;
	Thu, 22 Mar 2012 17:08:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JilXGJCFU3JNOnndNf8RPCdJYY8=; b=lrKtfF
	8g59318Lrps8g9BXId0WJOsi4ImV+ugwXXNa9DQM7xiorqNZ3ftA7JwozSsdtcJ4
	dL3NQ11XkCrmRX+hRlV8hB8CzLCvD9vFR+ZzehayvWHJ2a6OkccN1xdASAYuqalf
	8Ls0Bnh3kEXMbf5BWBQp9to/dddoQD3Ix/bvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q3EqK/DznFDLnx6pzqzE18qtWXnh2lzr
	4PPp1odc1LA80DOOzayvoL4Y1VoY+lL7Z44ULB2p3MOnxjAlyFKR8UbRg5qstfAO
	kMgNi+VgNDU5djDqRvWfU17TrW0VKZTgrdJNKtP5hj8PQC/xAc597FmgOIrtP2pf
	EtjehcGTRqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57FCE654D;
	Thu, 22 Mar 2012 17:08:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2E68654C; Thu, 22 Mar 2012
 17:08:04 -0400 (EDT)
In-Reply-To: <CAJsNXT=YEida53nV7kj6a3cw2GibYJab4n2PucNO6inUR3HPRQ@mail.gmail.com> (PJ
 Weisberg's message of "Thu, 22 Mar 2012 13:40:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DDC8570-7463-11E1-A961-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193718>

PJ Weisberg <pj@irregularexpressions.net> writes:

> On Wed, Mar 21, 2012 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> underlying system calls like open("foo") will *not* magically start
>> returning a file descriptor opened for "FOO" if your filesystem is not
>> case insensitive.
>
> No, but magic_open("foo") might, if someone had put forth the effort
> to write a function called magic_open.

Exactly.

That is why we avoid describing what happens when you set it on a case
sensitive filesystem, to leave the door open for such a cleverness.

It may still be a mistake in the manual that we did not explicitly say
that setting core.ignorecase on a case sensitive system will give you an
undefined behaviour.
