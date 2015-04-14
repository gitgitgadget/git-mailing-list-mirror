From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: provide cmdline args to git hooks
Date: Tue, 14 Apr 2015 08:08:51 -0700
Message-ID: <xmqqwq1e3fy4.fsf@gitster.dls.corp.google.com>
References: <CAM-hpQcgOgrAJBAZrH4icDtJMiHUYOz1tynYkoj7qzyVMZ0eVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Chris O'Kelly" <chris@mapcreative.com.au>
X-From: git-owner@vger.kernel.org Tue Apr 14 17:09:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi2SV-00031N-94
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 17:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbbDNPI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 11:08:58 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755517AbbDNPIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 11:08:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 050C6487BA;
	Tue, 14 Apr 2015 11:08:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D4Cjw3KmuwhWOMzHcGiSf9zSGd4=; b=fsrZWa
	8nlQgTt3I1A59WjQ/p6X0sEnnUHY/b2mCqfFj8Ejb2HTWrftKYvI6sTcWvKgmWHv
	UpEqWq6R8e/3ioH9z3/mp5lwju2SQQuRsjh9E3qAzyOLBNE2F0yR/ALJzAEDaTi3
	dQqLOubPKyEaR2QHhnOOTY4Tf3EIF0uDh6bzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O830swSBGqXUt/rg0oOFWx+VnntsaHjc
	KVoaQ99OQKA+vQkvLEWQ9TaW1jBnx4IMKAc81ncND+azSBTTbhlIRcno0Hl+KOGO
	usax8gOpRTMcYAs5E5pYZKlqlqpgKSE3TR52Oq8YHKEBKu70bkeqo2ZJjfs0v8hl
	onn5iAARvhY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2956487B3;
	Tue, 14 Apr 2015 11:08:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5582A487AF;
	Tue, 14 Apr 2015 11:08:53 -0400 (EDT)
In-Reply-To: <CAM-hpQcgOgrAJBAZrH4icDtJMiHUYOz1tynYkoj7qzyVMZ0eVQ@mail.gmail.com>
	(Chris O'Kelly's message of "Tue, 14 Apr 2015 13:42:45 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29F3D84C-E2B8-11E4-B35D-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267141>

"Chris O'Kelly" <chris@mapcreative.com.au> writes:

> A brief background of my use case:
> I am wanting to write a pre-push hook to prevent tags being pushed to
> our production servers. The production servers in our case are --bare
> endpoints, and when we push a tag at them, they always checkout the
> commit that tag is attached to via some post-receive magic (WPEngine,
> FWIW). This behavior is even present when the tag was already pushed
> to the repo previously, if for instance a normal push is made with the
> --tags argument.

Do you mean that you want to forbid some people from pushing tags
into that repository while allowing others (i.e. those who manage
production deployment)?  If that is the goal, it sounds like that
the right place to do this is at the receiving end via pre-receive,
not at the sending end via pre-push.
