From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix
 regression)
Date: Tue, 17 Jan 2012 12:11:46 -0800
Message-ID: <7vzkdmqebh.fsf@alter.siamese.dyndns.org>
References: <20120114152030.GX30469@goldbirke>
 <1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
 <CAMP44s2nYMmfC36+pGaYfOZUQy3fLMYDuaSriPYjHBeApmsRVg@mail.gmail.com>
 <CAMP44s0T15idhwb6Eae5vdMxf25KK9MhY57mBf+BFN=OSC6Lhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 21:11:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnFNp-00028z-Rq
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 21:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372Ab2AQULt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 15:11:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab2AQULs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 15:11:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05C3F76B0;
	Tue, 17 Jan 2012 15:11:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F1D10loBuxvu4nec5iaazCG4ZgM=; b=eGNNzW
	WRuLRLEG1fSkYfllMH2ZDmitFzdZfrmb2m6oIwiEnaZ049gXjIIu6oLDd5NzSYJy
	UKyDsTXnFKgbrjPWs7KzybjFAD32G6UWR8BixokeI0vI7ZWwgweK26oTtfde+Kwq
	Xs+rVTIRvo/Mj0Q2EzsajiCzIhAQLG8EViKy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hDstxOLGFoJ3kvVCEzjhKkXoPBTMf/TE
	KC3HERYIPm3FZVyWeskogPSTZ5sIBjAeLh0AFkxry9mqoa4rP3OrD6/9bKN1Ph8P
	nSoWr9QzWYdY0GXT121oRKbST/8dYW+l2u45dWUyaSP8A3K0fQPsYTqo4LYPhSzD
	poFT39Xm9bU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F13CD76AF;
	Tue, 17 Jan 2012 15:11:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85CB076AE; Tue, 17 Jan 2012
 15:11:47 -0500 (EST)
In-Reply-To: <CAMP44s0T15idhwb6Eae5vdMxf25KK9MhY57mBf+BFN=OSC6Lhg@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 17 Jan 2012 22:03:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BEF77E8-4147-11E1-B5A7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188718>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Jan 17, 2012 at 9:18 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sat, Jan 14, 2012 at 8:55 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>>> Commit a31e626 (completion: optimize refs completion) introduced a
>>> regression for ZSH users: ref names were completed with a quoted trailing
>>> space (i.e. "git checkout ma" completes to "git checkout master\ "). The
>>> space is convenient for bash users since we use "-o nospace", but a
>>> quoted space is worse than nothing. The absence of trailing space for ZSH
>>> is a long-standing issue, that this patch is not fixing. We just fix the
>>> regression by not appending a space when the shell is ZSH.
>>
>> I have this issue with the script from v1.7.8.3, and I think it
>> started with a zsh update.
>
> Yeah, works fine with zsh 4.3.11, not 4.3.14 or 15.

As I was planning to queue Matthieu's patch as-is as a regression fix
before v1.7.9-rc2, I would appreciate if you can clarify this report a
bit. Do you mean with the patch more recent versions of zsh still does not
like the workaround and adds quoted space at the end?
