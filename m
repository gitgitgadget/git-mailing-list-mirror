From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 01/12] commit-tree: allow indirect tree references
Date: Sat, 13 Mar 2010 13:58:25 -0800
Message-ID: <7v634z7uke.fsf@alter.siamese.dyndns.org>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
 <1268455984-19061-2-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 22:58:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZLx-0002qa-Le
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 22:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378Ab0CMV6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 16:58:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab0CMV6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 16:58:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFC86A125B;
	Sat, 13 Mar 2010 16:58:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BNY+snQihU89+gdqGgE68j3R9W0=; b=lShhkz
	L6UH8v+ql+ORW8hc2p7ZhKcvThuMrvYdOBOXtADmEdUkKdP7vcqjXCvjrHlK4Rxb
	7Iz+TQa+QuB2/YrbphgKV4ywQfC3b5HKMGomHWOhnMHQ7s+zEpKDa+yor1vpGgrJ
	Kujc6oveimkr5uBjT5spEH4v6kgQ98YggkkUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KQu0eaDEE0DYoeXdpVzFocm9qPGNoO6A
	9uxpjl7eUZ8CpQxjw73CJp0djSf2IRn9iM+UYrHrcNe1Q4ngngiBq17svUWhpybv
	M9qVIDPsBUvsKSly4TuScHHcFKHni0Z8iCVu3QwOW8IYbN85HPWJPhO3dLXnwblQ
	eE05p3oKHrk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE309A125A;
	Sat, 13 Mar 2010 16:58:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BA14A1258; Sat, 13 Mar
 2010 16:58:27 -0500 (EST)
In-Reply-To: <1268455984-19061-2-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Fri\, 12 Mar 2010 23\:52\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F1ADCBA-2EEB-11DF-A9C9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142111>

Mark Lodato <lodatom@gmail.com> writes:

> 'git commit-tree' was the last remaining built-in to accept a <tree> but
> not a <tree-ish> (an indirect tree reference through a commit or tag
> object.)

Historically we deliberately chose not to DWIM things down to tree for
this plumbing command to catch mistakes by Porcelain scripts
(e.g. arguments given in wrong order---the order of commit-tree's
arguments are, eh, unintuitive).

I do not think that matters much anymore---I do not think this patch
is unsafe.
