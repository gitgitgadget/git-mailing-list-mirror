From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git symbolic-ref vs. reflog (vs. rebase)
Date: Fri, 29 Apr 2011 09:19:44 -0700
Message-ID: <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
References: <ipek0o$l0v$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Csaba Henk <csaba@lowlife.hu>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:20:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqQG-0008K4-IH
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759958Ab1D2QTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:19:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759948Ab1D2QTx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:19:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D66D50DE;
	Fri, 29 Apr 2011 12:21:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uItT0mYdwu1EB6e2Xb2sZCdjVkY=; b=CU8EHO
	ue33N7VVqCC7NyiN3r05nVXztruFPcsJfROL+MPfLciYLeQt53+/QthtkqCi6aW6
	3FPSnFjpl0pK06lrrBse8AnZI2EtogrGBDp+tiO7szUptUJ4Wp6C1F1vPJLrqm8k
	Zjz8XCc1+Zno1xuCLBd8QeXDhgzM9RxG1fjFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PBz1H2xp8QejKNphMNdUtE9yItlDuzRG
	1hC2Jnhh4fKgGfS/2CgxXdJrFF9gFlSpCSLEd7Ck2NbsSMLnMdh7sPPHVv+fQzDA
	xMdSrV2pl4AoMnMmxu2cbBq8gQXqQfZWmIOBwOPX6qIxD8218ywjD1vzFxtNNxid
	Zhw1o27LYQU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C44950DD;
	Fri, 29 Apr 2011 12:21:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2435950DB; Fri, 29 Apr 2011
 12:21:48 -0400 (EDT)
In-Reply-To: <ipek0o$l0v$1@dough.gmane.org> (Csaba Henk's message of "Fri, 29
 Apr 2011 15:03:52 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA7A8366-727C-11E0-842F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172461>

Csaba Henk <csaba@lowlife.hu> writes:

> "git symbolic-ref" is a dangerous command in the sense that it can
> change your HEAD position without updating the reflog. Is it
> intended behaviour?

Yes, it is.  But you can choose to do:

	$ git branch side
	$ git symoblic-ref -m "move to side" HEAD refs/heads/side
        $ git log --oneline -g HEAD@{0}
        05ddb9b HEAD@{0}: move to side
	e69de29 HEAD@{1}: commit (initial): first commit

if you wanted to.
