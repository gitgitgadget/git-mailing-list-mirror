From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sat, 04 Dec 2010 21:24:03 -0800
Message-ID: <7vsjycx05o.fsf@alter.siamese.dyndns.org>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 06:24:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PP75B-00070y-4H
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 06:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab0LEFYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 00:24:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab0LEFYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 00:24:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 394533945;
	Sun,  5 Dec 2010 00:24:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bii+ZZzRkrE6dr/gqgrzdDElnGI=; b=sPFlLO
	ycwjO8214QIsbz1UEsqQ+TLOIuy42CTpTPwxzmVkT4CaZ0kKjRian4nw181MISk6
	nJHqT7NWdheGxrJ6nZn70dp5R7CgAYVX5Ke+s2Sw2Lm92winSrg+t1iBo31mvE02
	/DTrUUcFB0WJ9yFfyHPzjue+tFiB23jg4eJXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FLXpxbo+HQp/26521dPdM5vbMskmso9X
	s1I0Xg5kMrskAkZM4XCkqQdKSAcjKh8UErtP1xrtJOubvx/hJBoMVlATBHqRNBhf
	BjLCOl+HyNkqnQKWIzJX1jyxYuXwvL0JISXSGLP13EP+ECayDX11ZlhZ2f1W/kN2
	bDgNpL8NpD0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1833D3943;
	Sun,  5 Dec 2010 00:24:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3842B3942; Sun,  5 Dec 2010
 00:24:25 -0500 (EST)
In-Reply-To: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
 (Thiago Farina's message of "Sat\,  4 Dec 2010 23\:59\:08 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EEC6C960-002F-11E0-9F41-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162928>

Thiago Farina <tfransosi@gmail.com> writes:

> Signed-off-by: Thiago Farina <tfransosi@gmail.com>

I really do not like this.

The use of type "struct commit_list" to hold the set of parent commits is
incidental; if we had "struct commit_set", we would have written a
function with the same purpose, and named it the same "reduce_HEADS".

Adding commit_list to the name makes the code harder to read (and type)
with little added benefit.  "LIST"-ness is not the important part.

If a function takes a commit_list, named "reduce_HEADS", and returns a
commit_list, what it does should be obvious to you; otherwise you
shouldn't be touching the internal of git.

Having said that, I do not claim "reduce_heads" is the world most
wonderful short-sweet-descriptive name for what this function does and
there cannot be any better name.  But commit_list_reduce_head is not it.

If the patch were to rename the function, especially the HEADs part, to
clarify what it does, instead of how (iow, what type it uses to hold the
data) it does it, my reaction would have been very different.
