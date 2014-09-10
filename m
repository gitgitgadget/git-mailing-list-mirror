From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] Add regression tests for stricter tag fsck'ing
Date: Wed, 10 Sep 2014 10:56:12 -0700
Message-ID: <xmqqbnqngy0z.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<cover.1410356761.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1409101553080.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 10 19:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRm7w-0001GU-9u
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 19:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbaIJR4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 13:56:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61384 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbaIJR4P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 13:56:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FB1237378;
	Wed, 10 Sep 2014 13:56:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q5UjwlHV5GaHVxADiPat9Ok0vjs=; b=PxqPeu
	9czdoVO1/TEq4OOE8mtW6pn+QtlkRogyAAwzEP4/g+RqzsNENBeOqC2Rpo1pOJrm
	cxU5mi6ozSoudAV+0pBEGEc4a2YuwJMUPm2f57kwCe22kLC4OyHHkAku0e6WTyMM
	0ASrZVZURADHNh9nX+xbxarsT66a5iT+UF3Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=brxEcQgc/ETucsnD1rYtiOeKTkUEwdyv
	8wLNx0xmmr99l1DqbIb3vJz/+Ly8PukqkfrXLzh52xQgaNZu+anxm7XCmlZAS0B5
	j3bJnx4ZvQ0OPWx4THT+uGf5Ap4GHK+Xjs8bmY1oKnfqdOYvAN0KiePCVUahwnMz
	8EcErR/T0C4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36AAC37377;
	Wed, 10 Sep 2014 13:56:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ABA6937376;
	Wed, 10 Sep 2014 13:56:13 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1409101553080.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Wed, 10 Sep 2014 15:53:10 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C13D1992-3913-11E4-8E81-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256759>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	test_when_finished "git update-ref -d refs/tags/wrong" &&
> +	git fsck --tags 2>out &&

I wonder what the command does with or without --tags option
(applies to both tests added by this patch)?

Does running "fsck" without the option not to report broken tags
detected by the new checks added in this series?  Should it?
