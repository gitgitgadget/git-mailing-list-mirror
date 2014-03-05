From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fnmatch vs regex
Date: Wed, 05 Mar 2014 13:27:16 -0800
Message-ID: <xmqqk3c8fia3.fsf@gitster.dls.corp.google.com>
References: <CAKOJyXc2dezciw=x=-Gw3qjt3Sd=V=2Dy_ARZ25kmjYHULT5_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincenzo di Cicco <enzodicicco@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:27:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLJLm-0004Ty-T0
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 22:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301AbaCEV1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 16:27:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757265AbaCEV11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 16:27:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E52A6FA42;
	Wed,  5 Mar 2014 16:27:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oXyL7i9qguHZQp2dSyIc5ZaP4cQ=; b=Rd6gWi
	uvT6oVaTcbCYvKVP825zq/FhYhD5zexZmTnMWOJRi/8ETlp0drTzfBnNn9p7EBTX
	+mrqLbhk8waYGSRdIoSzqM8NSrI66+fCo1PhhkO+v8rOBc/kIaQZbXZaogHgdg5X
	C7aXI7/0XFoL0b4XnL9XRI72DGEww4cYbi884=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZT6Y+r8Kd/Pg5NbQgKihm37Q1cI40EOt
	MZ1/pQrTGeibRgNp9Ve94XtEdpuAc/Zn7uN5VLetk31u0KgKkweTM9VptD36OcgP
	9kQqzJgO4CZHHUFgTrSX0ryEhvLJ5OfYUM8fxuUmNJnzoxwJeUB9rNu2pjB1i3vo
	FjOlP+pe4vA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26EA46FA3E;
	Wed,  5 Mar 2014 16:27:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29D666FA3B;
	Wed,  5 Mar 2014 16:27:26 -0500 (EST)
In-Reply-To: <CAKOJyXc2dezciw=x=-Gw3qjt3Sd=V=2Dy_ARZ25kmjYHULT5_w@mail.gmail.com>
	(Vincenzo di Cicco's message of "Wed, 5 Mar 2014 20:55:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F28B6F0E-A4AC-11E3-A810-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243482>

Vincenzo di Cicco <enzodicicco@gmail.com> writes:

> But: why the decision to support the Blob Pattern instead of the
> Regular Expressions?

s/Blob/glob/;

Matching pathnames using fnmatch/glob is a fine UNIX tradition;
because we generally consider refnames also as "pathname-like"
things, we use fnmatch for them, too (what we actually use is
wildmatch, which can be thought of as a natural evolution of it).
