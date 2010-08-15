From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Status of conflicted files resolved with rerere
Date: Sat, 14 Aug 2010 23:59:36 -0700
Message-ID: <7veie0gy3r.fsf@alter.siamese.dyndns.org>
References: <20100812212828.GA17825@jpl.local>
 <AANLkTi=tVV5gL2b2LfXALXahzabJXzVjB5z9-OSztOMJ@mail.gmail.com>
 <D06701C5-E581-46AA-BC7D-3DA7C4127D44@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Magnus =?utf-8?Q?B=C3=A4ck?= <magnus.back@sonyericsson.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 09:00:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkXCQ-0000Fk-Id
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 09:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250Ab0HOG7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 02:59:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab0HOG7s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 02:59:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69D40CD45A;
	Sun, 15 Aug 2010 02:59:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rVt3we2hYj5RXLLW3H83iaN81Gw=; b=S0lxcz
	L03k/daVhcC8ZeJcaRtEr+0k5/Bu8y5b6k2WlN9upbNX78PDj0dvzqofmL8C4iSq
	EblpcwXMvEuSBhsoKJRcbcma2NWc9z9x0gWJO6tXtptRBUd+VxF+ub4KvGaoHf7f
	I7V2/ReqFVWJSJsQvNj3e21tXrOhjxqq8etzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Es953rfLFnIGehbTNygymrFkaqEVV7tn
	e+E+6VFoDu/SHjLREkEKie3u5Nz7Y8Jzg9t/atfSNT5t5Mwiza1GQ8SjZeDJ4fTF
	Aa8sGguAssa4f/u60jI/KGDG1hFzfENuerMX3IuJN5wvvzc/b5Td3OfApXGQMb5M
	7uyfs/3n6iY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 281E7CD458;
	Sun, 15 Aug 2010 02:59:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63CC2CD457; Sun, 15 Aug
 2010 02:59:38 -0400 (EDT)
In-Reply-To: <D06701C5-E581-46AA-BC7D-3DA7C4127D44@gmail.com> (David
 Aguilar's message of "Sat\, 14 Aug 2010 19\:24\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE5DE464-A83A-11DF-B1CB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153597>

David Aguilar <davvid@gmail.com> writes:

> Here's what we'd need in order to improve rerere and mergetool  
> interaction:  the ability to answer the question, "has this file been  
> rerere merged?"

I do not quite understand why the user _runs_ mergetool on a file that has
been already merged; isn't it an option not to do so in the first place?

Having said that.

I think you can use the fact that:

 - "ls-files -u" will list paths with conflicts; and

 - "rerere status" won't mention the ones that have been autoresolved

if rerere is in effect (check for presense of .git/MERGE_RR).
