From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Tue, 07 Jan 2014 11:07:48 -0800
Message-ID: <xmqqy52rd30b.fsf@gitster.dls.corp.google.com>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
	<1388890249-3577-2-git-send-email-ceztko@gmail.com>
	<20140105203349.GB3737@book.hvoigt.net>
	<CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
	<20140106140627.GA27265@t2784.greatnet.de>
	<CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	"W. Trevor King" <wking@tremily.us>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:08:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0c0P-0005UJ-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbaAGTH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:07:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbaAGTH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:07:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A75D661824;
	Tue,  7 Jan 2014 14:07:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8AHGOoc8Ch7M0oOCZWIAmef45fc=; b=Llzq7x
	6LHssI/Mzt8k1sEfHUC5fxuS+02QXedMPqeTAtb7h8UOdAaT+YXooXUJOPZKrRKW
	/1u00AH//luUQstMqduYUpUMCVXX9zppBAQf83litCux4CIUTYr7sQBtVSc7OneU
	E6sEquOvvIPh4q5Pz9fz9rpHzmX2gKBM0z6os=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wujIAKwKF42UWcrnPD4AM6NK6qa1i5zt
	F0tN8emlCU/YAB2sf61AQxfIMFeZ3Jo9MDAo+E1bIaoZy4MTjh06YCnyHvh9ZwbQ
	IxhrlTdZSbqm6YiRA1u93wd4eZ7zCk5sB1E18j6+Ewn4D7XW9Qb0MlvaNqNjFkTo
	Eo7NuhVlLvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A377C61820;
	Tue,  7 Jan 2014 14:07:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E24796181F;
	Tue,  7 Jan 2014 14:07:50 -0500 (EST)
In-Reply-To: <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
	(Francesco Pretto's message of "Mon, 6 Jan 2014 18:47:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 00F70338-77CF-11E3-AF5A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240129>

Francesco Pretto <ceztko@gmail.com> writes:

> My bottom line:
> - For what I understand, detached HEAD it's a way to say "hey, you
> have to stay on this commit. Also don't even think you can push to the
> upstream branch". This sometimes can't be spurious, as in the use case
> I wrote above: access control on the remote repositories should be
> enough. I think maintainers should have the option to make developers
> to clone a repository starting with an attached HEAD on the branch
> suggested in submodule.$name.branch;
> - "git submodule update" is missing a property to do automatically
> "--remote". I think in the use case I wrote it's really handy to have
> a "git submodule update" to act like this.

The short version I read in the message is that your workflow, in
which partipants want to work on a branch, gets frustrating with the
current system only because the default update/initial cloning
detaches HEAD and will stay in that state until the user gets out of
the detached state manually. Once that initial detachment is fixed,
there is no more major issue, as update will stay on that branch.

Am I reading you correctly?
