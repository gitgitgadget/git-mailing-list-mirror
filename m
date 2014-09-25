From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Branching workflow
Date: Wed, 24 Sep 2014 22:15:57 -0700
Message-ID: <xmqqsijgb7qq.fsf@gitster.dls.corp.google.com>
References: <CALZVapnjN_69y0+PLFA2t8b72WDK+D4BhjDRnRPxU_9iX+_NuA@mail.gmail.com>
	<xmqq8uw1oij6.fsf@gitster.dls.corp.google.com>
	<CALZVapkvVNxb-jJssZqjT-Y8sApK8O1pe3xTB8guNtx9Md2W6Q@mail.gmail.com>
	<CALZVapmm3=zgx4xZegieSxiUOcYcz9DMHVFknA8SeeYwO5fVJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo Cansino <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 07:16:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XX1Pb-00036P-C2
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 07:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbaIYFQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 01:16:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65291 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbaIYFQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 01:16:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D2453DF00;
	Thu, 25 Sep 2014 01:15:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7fyi32OWg3Ldy56DcjO6d/ABElk=; b=Dpox+V
	9lA3SSVzVGqYkOrf98eOg1NuhSUWWnt5alYvnll1hrXF9n+eI4r56GmVEuHgWO7h
	yWHUa6WYeUaB8trf50OHyRk9LunyxZgGC3X+jvu50HxDAFN5cDqciAQXOh3Hessx
	6u6GQfWd9c5vIMZJhMDTLVW89r5ImyqBR6p/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IX7MfbKvq70l5VaBPT3vluJfaLt8iFpY
	k6z3qvzw2jJqgbgh6tQBVpxFXz6SuuNRTDmjsN5icwWMGg4daFEEHznmcr+wX5ME
	AxKGkCJAle/WRdRx/H7l/kz6z43cZn0F3S9frtdqFEH98YFS9BphGkZITTzzaPWv
	edYSff/0gPs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62C853DEFF;
	Thu, 25 Sep 2014 01:15:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D58FC3DEFE;
	Thu, 25 Sep 2014 01:15:58 -0400 (EDT)
In-Reply-To: <CALZVapmm3=zgx4xZegieSxiUOcYcz9DMHVFknA8SeeYwO5fVJQ@mail.gmail.com>
	(Javier Domingo Cansino's message of "Mon, 22 Sep 2014 17:59:02
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08E0BE10-4473-11E4-A28A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257472>

Javier Domingo Cansino <javierdo1@gmail.com> writes:

> I would like to seek for a little more advice. I keep rebasing all my
> work each time master branch is updated, and I would like to know if
> this is usually done or not.
>
> The workflow is not using emails, but each developer has his clone
> where he works, and occasionally sends work to the gerrit tool we use,
> upgrading the patch with each master update.
>
> I know this is a crazy workflow, and I would like to know when you
> usually consider to update the sent patch with a rebase.

When a rerolled set of patches come, I try to apply them to the same
commit as the previous fork point.  When there is no reroll, there
is no reason to ever do any rebase myself.

The trial integration branch 'pu' is rebuilt from scratch every day,
starting from the tip of 'master' and merging all the topics that
have not been merged to 'master'.

By not doing unnecessary rebase, we won't risk breaking each topic.
By merging topics together to updated 'master', we make sure changes
done in other topics do not negatively affect each topic.
