From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why is --graph --max-count=n so much slower than --graph HEAD~n..?
Date: Tue, 20 May 2014 15:50:43 -0700
Message-ID: <xmqq61l0rrng.fsf@gitster.dls.corp.google.com>
References: <vnkwd2f8ayea.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jonas@bernoul.li
To: Mitchel Humpherys <mitch.special@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 00:50:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmss1-0006tl-MI
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 00:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbaETWuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 18:50:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52258 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbaETWut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 18:50:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D66019EB2;
	Tue, 20 May 2014 18:50:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HQL0OcM7Pe8IWYWp6FFiHBum3Vc=; b=qxgbpe
	bxIbM5v2MFM1wz6ugmrl5qr/FMFmHpvmJehm4M3KUY7SKg/deCGsEf0jkpL+082f
	04L+F+iF6d7J+XKcxCJqcg2DV0BoZyAhYLFFgiaBn5gIjen+WuIatyILGkgYIo4D
	RwXynE+16iy6glhC5vzsD7EQXnzLkcFOOnabI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qNK6OpvEWGq5noMeOGKi4dnF6acETMX9
	U35rMtgM5peXnIierf/aK4JUsESj26G5l9+Eza/FIlzO30j34FkWGP9FQR2PGNry
	mleLwUWUKndYPOd0MeMjOT4DiNrc5DynPsw8tTJHcax1fWu9yZjmrLaIcntmPZ39
	ZzffWKQakO4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2352D19EB1;
	Tue, 20 May 2014 18:50:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C703019EAC;
	Tue, 20 May 2014 18:50:45 -0400 (EDT)
In-Reply-To: <vnkwd2f8ayea.fsf@mitchelh-linux.qualcomm.com> (Mitchel
	Humpherys's message of "Tue, 20 May 2014 15:17:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2DF5A226-E071-11E3-8503-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249758>

Mitchel Humpherys <mitch.special@gmail.com> writes:

> I've noticed that --max-count doesn't seem to speed up `git log --graph'
> computation time.

AFAIK, --graph wants to compute the whole history and the max-count
only affects the output phase after --graph does its computation.

Besides, "log --max-count=n" and "log HEAD~n.." compute completely
different things, so the comparison is apples and oranges.
