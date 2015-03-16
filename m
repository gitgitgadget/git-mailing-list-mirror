From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git submodule purge
Date: Mon, 16 Mar 2015 08:55:03 -0700
Message-ID: <xmqqmw3drl7s.fsf@gitster.dls.corp.google.com>
References: <20150316134407.GA31794@pks-tp.elego.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Mon Mar 16 16:55:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXXMQ-0007Rm-0x
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 16:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935132AbbCPPzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 11:55:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933765AbbCPPzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 11:55:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 11BAD3F733;
	Mon, 16 Mar 2015 11:55:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eY5uMeH1hY9DC1ql012AtX26RKM=; b=bTzWU3
	R9jToKrcZPt0R8oKj0dSOdZ5y72iejeb+aQYzVaY3NHhsCZGutjczFNOAxlIn2LH
	ey5VxH6Xh1DF2tm1XVgb8iMgMyLa5FBOR1InXnI180oBeum/pBkNFJm0LuuCqecT
	AXWofJH1nydZLQNi49sjRttoHfpr/oyVj500g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BBBVTG1uO8jQ9vL2SEw9/JlZUTCfX1PJ
	ondyn/v4gx+CVmxrZeuMmBwBOonaZlBey7Js2jsKVRbbclTy/KGe90RwSutmPj76
	btOVdlEMP0JSw6edb2RXcH4tkzY0h7VAFIoCI2K5XjHkFcND0mTuU1yiuY8OEHL9
	uSxzDfG5wrA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AE503F732;
	Mon, 16 Mar 2015 11:55:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 787B93F72F;
	Mon, 16 Mar 2015 11:55:06 -0400 (EDT)
In-Reply-To: <20150316134407.GA31794@pks-tp.elego.de> (Patrick Steinhardt's
	message of "Mon, 16 Mar 2015 14:44:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0E4A328-CBF4-11E4-A8E3-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265567>

Patrick Steinhardt <ps@pks.im> writes:

> I think there should be a command that is able to remove those
> dangling repositories if the following conditions are met:
>
> - the submodule should not be initialized
>
> - the submodule should not have an entry in .gitmodules in the
>   currently checked out revision
>
> - the submodule should not contain any commits that are not
>   upstream
>
> - the submodule should not contain other submodules that do not
>   meet those conditions

I do not have a strong opinion on whether it is a good idea to make
it possible to remove the .git/modules/*, but should it be a
separate subcommand, or should it be an option to the 'deinit'
subcommand?

Also, how would you apply the safety to a repository without
"upstream", i.e. the authoritative copy?
