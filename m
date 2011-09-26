From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Mon, 26 Sep 2011 15:30:33 -0700
Message-ID: <7vehz30wdy.fsf@alter.siamese.dyndns.org>
References: <20110926184739.GA11745@erythro.kitwarein.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mathstuf@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 27 00:30:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8JhC-0002yZ-AK
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 00:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab1IZWah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 18:30:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288Ab1IZWag (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 18:30:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A91F851B6;
	Mon, 26 Sep 2011 18:30:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HOv7s5jz+KsITQbLyxbP0cnjR2A=; b=l6N3Th
	2ab6X/BLuzVkE413GetpR+ziEqtSdc+jYNwSlqh20EG/gbMVX4qtExnxnJGKFkW4
	/om8l/6c6IZsRFOaCOEsH6R+DBb9W/52ZvTdbz6Pls3CW7S/eiUnC2SEUWORnywd
	ii+q5FhtMS6in7y/sMZisP4rHwnEU0CcHuu10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MelFrzVThWe/pRccJDowRVDqW3bTuoKN
	AnK7ET0aeuwG26e8iJ4ELrK0/2UneuoBrxkKT3tOxT41b2Nm0aZF1wdbVmIlg8FH
	7Jo5GXuMRUyq71l/GwaxXxcvoFOFOWJHmhMvXPX5KBLroV3VIA0owEr6uILGpu7P
	NLMZcvqm0bA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A07D251B5;
	Mon, 26 Sep 2011 18:30:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3870751B2; Mon, 26 Sep 2011
 18:30:35 -0400 (EDT)
In-Reply-To: <20110926184739.GA11745@erythro.kitwarein.com> (Ben Boeckel's
 message of "Mon, 26 Sep 2011 14:47:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26F12A9A-E88F-11E0-9562-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182177>

Ben Boeckel <mathstuf@gmail.com> writes:

> When the --prune and --tags options are given to git fetch together, all
> non-tag refs are pruned because only tags are looked at and when pruning
> it appears as if the branches have disappeared and are therefore deleted
> locally.

I would call that a bug, and it is not limited to the use of "--tags". For
example, I suspect that

    $ git fetch --prune origin refs/heads/master:refs/remotes/origin/master

would prune remote tracking branches for "origin" other than "master".
