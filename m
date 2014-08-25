From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Mon, 25 Aug 2014 14:08:48 -0700
Message-ID: <xmqqlhqcl1jz.fsf@gitster.dls.corp.google.com>
References: <53ED2E46.5020403@raz.or.at>
	<xmqq1tscwepa.fsf@gitster.dls.corp.google.com>
	<53FB985F.8080608@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:09:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM1Vi-0005fd-9x
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 23:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbaHYVJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 17:09:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65320 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbaHYVJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 17:09:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA92335D46;
	Mon, 25 Aug 2014 17:08:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Flpw2GhbfoyAbduryz7M7fxiWGM=; b=sGsHOn
	/lR6dMs29ZqZ6zWoLOh7oxtfxzMkYvS8PBjZ+edQdrR4M/y+LBrayYn4zey0g++S
	kKFK518+N9NsVQ+lyLrYKu7O0laz5UVErOxYQCkeMe1iVfvaK85aP38aPa+O+cTe
	7mUYyXwsgKJAKeyml5MBhzXRPOJEiYbbFlupI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UpmR72CfF8md8BINHzgLuYHcJqDHrJkW
	2Auv0MdoFz/r/lh9/vFfLr/hIf172APHewP++TzmwjUsECZdQ+HrKlZJeHaq33PD
	SXjf7e8JOdXNyujllZczarWBjn1I6q1uKHPTtMuotKWmRQRCtdTVExreAKIYiWcC
	swl4llIw4pI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A0BCF35D45;
	Mon, 25 Aug 2014 17:08:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 56F3335D3A;
	Mon, 25 Aug 2014 17:08:50 -0400 (EDT)
In-Reply-To: <53FB985F.8080608@raz.or.at> (Bernhard Reiter's message of "Mon,
	25 Aug 2014 22:11:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 02EEB762-2C9C-11E4-8905-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255868>

Bernhard Reiter <ockham@raz.or.at> writes:

> Yeah, but I still need to wrap the non-tunneled operation in #ifdefs in
> case we don't USE_CURL_FOR_IMAP_SEND in which case we fall back to the
> handwritten IMAP code, don't I?

We do not mind multiple implementations of the same helper function
that are guarded with #ifdef/#endif, and we do use that style quite
a lot.  Would it help?
