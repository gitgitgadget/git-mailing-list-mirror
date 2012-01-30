From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does git stash create two commits?
Date: Mon, 30 Jan 2012 11:11:24 -0800
Message-ID: <7vhazdatur.fsf@alter.siamese.dyndns.org>
References: <4F26DF7B.7050109@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 20:11:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwdY-0002We-2C
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab2A3TL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 14:11:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583Ab2A3TL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 14:11:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFCB572DD;
	Mon, 30 Jan 2012 14:11:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O1CxXvmfdXXQIdIfRjBEXlkYq+8=; b=sZHY2Y
	o1abXlvdbgZmKdD00XlthEQtssVbsfM7YQbzJJo14XooAdFvWtY0dcrS1gq6frkf
	GehkzXtcx35/sII2ktzcRkn6J0VF8TIpggSQ3RDvJtf24Q/Vuf24t7Jp/QGqfvAh
	JNZV0/ZPlltFrn50sNQYrUX4MSvyQQNHXIup0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vL5JX3FDRZwrB0yA7ccs+5I+DpUvPnMr
	t3HR6ykYiVIC22xOt57+ZINKYbUSgIZUg7B+AXEhrZjRnolVKquzqVbVUBRihoM/
	uxnRcoBBZQduMqw/0ANBLoyzytZNOse29oDXUn+DQ+rp60TmJTT2sIonQyf+pnHi
	v7+7YIzjXgo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7E6072DC;
	Mon, 30 Jan 2012 14:11:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F6A972D9; Mon, 30 Jan 2012
 14:11:25 -0500 (EST)
In-Reply-To: <4F26DF7B.7050109@ubuntu.com> (Phillip Susi's message of "Mon,
 30 Jan 2012 13:20:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 345E9B64-4B76-11E1-B80D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189402>

Phillip Susi <psusi@ubuntu.com> writes:

> git stash makes two commits, one that has no changes from the base,
> and one to stash your changes in.  Why?

The only reason the former is identical to the base is because you are not
incrementally building your next commit using "git add". It represents the
state of your index. The latter represents the state of the tracked files
in your working tree.
