From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using git-replace in place of grafts -- and publishing
 .git/refs/replace between repos?
Date: Sat, 15 Sep 2012 23:04:18 -0700
Message-ID: <7vk3vuzeot.fsf@alter.siamese.dyndns.org>
References: <CACffvTp4qnHc3RHKDotEfvshVDqGtTX6eh6Fr-bmJSMUvTFN6g@mail.gmail.com>
 <7vvcffyzfh.fsf@alter.siamese.dyndns.org>
 <CACffvTroMt-s7X_DV9AHerzKdgz+xABXTd91aTUc2BtYO7QxCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 08:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD7yu-0008OO-Cv
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 08:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab2IPGEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 02:04:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab2IPGEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 02:04:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB0B75DF5;
	Sun, 16 Sep 2012 02:04:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iBW4wKcHBjUNGlppPvqP7yPoC1o=; b=bMRGAp
	rsFEcfztuKg7t/RliJrMWKASFHFsL5suonMQquI/oNcgL0dmjg1ptUqxMUlSZo8+
	BgSAGUYIwTpIMucG1T+XvYTWQdXVzsrSYe1fkY/p/b6Dk1tD08TP8l5vZFEdgJqm
	UBrkb5d+ZrgoKw4OS64xXu4HR28weFLhiWuZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gjum6FI02TURlfHN4ktlHxhuoRkpGRJu
	IGIxdGN52ltzrbel6EVoWWx0fZMJOzIS+dkPq8nFGmT+uJvjECCMQBHEOpgQgpPz
	GXDV2sBvIC2PFKVUWQN7KNzYUM8uD5yalQl6M+TyVJ9lcScULqdDocLOMPxxaNFx
	ONAzyI0VtdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D84BB5DF4;
	Sun, 16 Sep 2012 02:04:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F0C15DF3; Sun, 16 Sep 2012
 02:04:20 -0400 (EDT)
In-Reply-To: <CACffvTroMt-s7X_DV9AHerzKdgz+xABXTd91aTUc2BtYO7QxCA@mail.gmail.com> (David
 Chanters's message of "Sat, 15 Sep 2012 22:49:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B01584E-FFC4-11E1-AB7F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205593>

David Chanters <david.chanters@googlemail.com> writes:

> I've tried:
>
> [remote "origin"]
>         fetch =
> +refs/replace/*:+refs/heads/*:refs/remotes/origin/*:refs/replace/*

Read the documentation and learn about <refspec> instead of blindly
guessing.

	[remote "origin"]
		fetch = +refs/heads/*:refs/remotes/origin/*
	        fetch = +refs/replace/*:refs/replace/*

would be syntactically more correct.  That would blindly fetch each
and every replace refs from the other side and apply the replacement.

It is questionable if it is a sensible thing to do, though.

"Git cabal" has been discussing a plan to make this easier but it is
not quite ready to outline here yet.  Perhaps after I return from my
vacation post 1.8.0 release ;-)
