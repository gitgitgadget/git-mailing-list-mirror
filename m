From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule add: improve message when resolving a relative
 url fails
Date: Tue, 31 May 2011 16:23:34 -0700
Message-ID: <7vaae2ihe1.fsf@alter.siamese.dyndns.org>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com>
 <4DE541EC.7010202@web.de> <4DE548C4.2010600@web.de>
 <4DE5561C.3010200@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:23:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRYI0-0007ey-5h
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 01:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935Ab1EaXXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 19:23:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919Ab1EaXXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 19:23:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FC6652E7;
	Tue, 31 May 2011 19:25:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=30lT6EjHo4eBIQ2Q+wtbLv/Gbmk=; b=I/ECNx
	GsstzZ8gdJVCTeJvzvgpDx8/g/8HAi9NDgrZiBCkbvATRikw7q7U4USP9BtETuQ2
	q5xmlhcsOD7D8eFjLeSxvxNH3oUvVvzLUz/oPBd9cJZwgu5eYfr3DjYAkH5d5POP
	kKTEb3lGWur34TvyP/iB086+Xcxs8Z2vziarM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DsuYFGcqKH5j+iGoEv09XIxCBHIDiTZv
	O3aW3NiU2IE6HcjO2KfLRTnaf8FDZf4U5xS27K2qXB+0zPQG4qnRDYNoOSMO3WZF
	TA2sedaJ/Xxj5ApEgUXJylUW+bDlWNVDRoWpvGPMI2tS8SX1/Z8LHHswwUsi2DgZ
	CKyeKkO9k+A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7014D52E6;
	Tue, 31 May 2011 19:25:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4FA9052E5; Tue, 31 May 2011
 19:25:44 -0400 (EDT)
In-Reply-To: <4DE5561C.3010200@xiplink.com> (Marc Branchaud's message of
 "Tue, 31 May 2011 16:57:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50F59902-8BDD-11E0-87CA-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174838>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Back when Junio accepted the original patch, he said "If you maintain and
> serve a set related projects you need to give the users a single URL (per
> where the user is and how to reach the server)."

I think it was phrased badly. At least it should have s/need/only need/;

Imagine ta project has many components, all of which are kept as
submodules of a single top-level superproject. You wrote and manage
everything; there is no borrowed code. In that context, imagine that I am
talking to the maintainer of that set of projects and calling the person
"you".

By giving the URL for the top-level superproject, without having to give
any other URL for the subprojects, you can let your users fetch from you,
as everything underneath is relative. Another convenience this may give
you and your users is when the user needs to talk to you over different
transport. You may give "git://your.site/project.git" to the users, but
they may come to "http://your.site/project.git".

By recording submodule.<path>.url as relative to where your users happen
to have fetched your project in the superproject's .gitmodules file, your
users do not have to run around fixing URLs for 47 different component
submodules.

At least I think that is what I meant back then.
