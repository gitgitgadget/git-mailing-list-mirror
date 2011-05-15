From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit -a reports untracked files after a clone
Date: Sat, 14 May 2011 20:43:32 -0700
Message-ID: <7v39kgr5ln.fsf@alter.siamese.dyndns.org>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Philipp Metzler <phil@goli.at>
X-From: git-owner@vger.kernel.org Sun May 15 05:43:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLSF7-0007JB-Cj
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 05:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759880Ab1EODnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 23:43:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759861Ab1EODnk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 23:43:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 30AE45B78;
	Sat, 14 May 2011 23:45:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xVg9+NF0Bnn/5sstMbCR7kylb3w=; b=HBaDL6
	v6/Cgw5u0VJS1cU7WHF3KWymBQ9j+SYmCCct3OzsPx3Hd84fFt5dz2uARZavz928
	5L3BeGFK+q3vTQHcd3miap1P1dn6xRtS+SzdiC6jCo6ALRt85lxvN8s/e0qt6yaA
	DXPvcJlBkFHIlobmw6rtL9fCa0FJHoB6v3/5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bN8TxrNEDR7I640by3Jw2zF4EnD4RHCP
	Z8RK7yZ8hnceCkrCOgHhvt4QoY6rGDg0unXoe++kRbRQQlrj2aG6jxrqltrSCHVo
	GMRYoNLLKRHwhbSDedLWvj59SUj13VI4PJ0ztB+QXbDFOEbOso/QBorE4+KQ7j4S
	YqxhAVR9Mus=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D2DF5B77;
	Sat, 14 May 2011 23:45:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3E0CC5B75; Sat, 14 May 2011
 23:45:38 -0400 (EDT)
In-Reply-To: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at> (Philipp
 Metzler's message of "Sun, 15 May 2011 02:46:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE775004-7EA5-11E0-A8DF-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173617>

Philipp Metzler <phil@goli.at> writes:

> This is how you can reproduce the problem:
> 1. clone a repo
> 2. run the command "git commit -a"

Does it reproduce with _any_ repository, or just a particular one?  If it
is the latter, then the above description is useless for anybody to start
formulating any theory on what goes wrong. Sorry.

You being on OS X, I would guess that you may have a pathname in the
project that HFS+ does not like.

On HFS+, when a program creates a file with "open(filename, O_CREAT)",
reading the directory the created path is in with readdir() does not
return the string given when it was created but something else for certain
pathnames; you may be seeing that git is confused by that behaviour.

But that is just a wild guess.
