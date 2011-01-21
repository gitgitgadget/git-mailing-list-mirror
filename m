From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Move git-stash from one machine (or working copy) to another
Date: Fri, 21 Jan 2011 09:49:26 -0800
Message-ID: <7vfwsmp2op.fsf@alter.siamese.dyndns.org>
References: <AANLkTin2M+dLUOFnAKqNvYn04NumCmmQ331Yfb9ieW-D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 18:49:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgL7D-0005Wy-SL
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 18:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab1AURte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 12:49:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38602 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab1AURte (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 12:49:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4E182CA4;
	Fri, 21 Jan 2011 12:50:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DXvMzT3Likqqi0gAltMYGE+EU00=; b=jumdLo
	dUAeTx3l9OkgRjRcOi9DRiS0IXXjabJrC+eQagb2au3hKolKovT7B5o7NbyrvByz
	ilRRM4PfsoN8PzLTpM6yiVW044XKUYL+ZwWpDj+T4T+/+vUrU3IHB1Qw4dw8VsZy
	YQUAvovlVjN+2ogDAM575OrtGoEEhkylSuO40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BupsOguoXjUtEreX0lJo18VV24ZnWDaS
	vNsD0YlCkn0ewplcHwUIylF55PbXanN5Yi6TwVG5DnQad7N5Pi82/0HtMyYDPNmV
	s0zbLyAgerDADFlkDxuxCmdEdDJHuWnR7ZJzv+op7rFSJ9XYnZ5YYNxurT5wimKJ
	YebKjTFj5o4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8066F2C9F;
	Fri, 21 Jan 2011 12:50:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98A072C96; Fri, 21 Jan 2011
 12:50:15 -0500 (EST)
In-Reply-To: <AANLkTin2M+dLUOFnAKqNvYn04NumCmmQ331Yfb9ieW-D@mail.gmail.com>
 (Patrick Doyle's message of "Fri\, 21 Jan 2011 09\:54\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8EDC3B4-2586-11E0-AE79-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165386>

Patrick Doyle <wpdster@gmail.com> writes:

> Is there an easy way to move work in progress from one machine to another?
>
> One way to do it might be something like this:
>
> machine1$ git checkout -b movewip
> machine1$ git add .
> machine1$ git commit -m "Moving work in progress"
> machine1$ git push origin movewip:movewip
>
> machine2$ git fetch origin movewip:movewip:
> machine2$ git checkout movewip
> machine2$ git reset HEAD^
> machine2$ git stash
> machine2$ git checkout master
> machine2$ git stash pop
>
> # go through and delete movewip branches on machine1, machine2, and
> the origin server
>
> Except for some possible typos, this seems like it would work, but
> seems to be awfully clumsy.  Is there a more elegant way to accomplish
> this?

If your two machines can talk directly with each other (which seems to be
the case from your "take that with me (somehow) to machine2"), you don't
have to push and fetch through the origin.
