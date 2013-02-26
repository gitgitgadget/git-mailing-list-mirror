From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better handling of erroneous git stash save "somemessage"
 --keep-index
Date: Tue, 26 Feb 2013 08:10:04 -0800
Message-ID: <7vwqtvm4yr.fsf@alter.siamese.dyndns.org>
References: <CAPs+M8JvcnTcZiySmpMBuOxek4THRnTx0jkZv7NHaSDNLhcOAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gunnlaugur Thor Briem <gunnlaugur@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 17:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAN6y-00026z-Dz
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 17:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757904Ab3BZQKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 11:10:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47308 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757517Ab3BZQKH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 11:10:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E74A4AEFE;
	Tue, 26 Feb 2013 11:10:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J1/ChIY+Jz2cHmdGIaUw/QCOLXg=; b=vJVxCp
	W+kgHh1O1wAS8cTjcrXczECNguHulwsgpGWCwpn/0BPqpMH063/xfCcblPbCbbux
	wjZHvS1Z0ElEyeTUrmSTCk39ALEG10pmAPjZUdnxrWORqZhSYc56gD7wLdQj/OOa
	YD7KVn/skbx2uBNaiPn/mZWMNZlPWyvNehtmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MFmU3zmhqp31uPaewlhu555JrGsTovPG
	bXGzgy6BUMBGDnyyYOtrfBS7ai2tU2dSTQ4mZNa0j6zP48JuYpuDGiW+SXch9Cdy
	Xe2VjOpkmWmnPDssP9zib/qI4Y3NMKoJaHelgTWpKv0HT2EoNK2FP+kggg/Pdlrt
	XmM61p76v7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC307AEFD;
	Tue, 26 Feb 2013 11:10:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CD9FAEFB; Tue, 26 Feb 2013
 11:10:06 -0500 (EST)
In-Reply-To: <CAPs+M8JvcnTcZiySmpMBuOxek4THRnTx0jkZv7NHaSDNLhcOAQ@mail.gmail.com>
 (Gunnlaugur Thor Briem's message of "Tue, 26 Feb 2013 15:59:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC46C578-802E-11E2-A6A9-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217141>

Gunnlaugur Thor Briem <gunnlaugur@gmail.com> writes:

> the command:
>
> git stash save "some message" --keep-index
>
> stashes everything, including the index, and adds the "--keep-index"
> to the message. The manual labor of separating index hunks from hunks
> to stash is lost. This is in version 1.8.1.3.
>
> This is a user error, of course (per the man page, parameters are not
> accepted after the message). But it would be better handled by
> erroring out, with a message like "git stash save does not permit
> parameters after the stash message".

Then the user cannot say

	git stash save some message that consists of multiple words

no?  You may have a WIP to enhance the behaviour of one option and
you might want to say

	git stash save wip: tweak behaviour of --keep-index

to save it away when switching to higher priority task.
