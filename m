From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Improved infrastructure for refname normalization
Date: Mon, 12 Sep 2011 09:44:12 -0700
Message-ID: <7vwrdd90df.fsf@alter.siamese.dyndns.org>
References: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
 <7vehzmbd0o.fsf@alter.siamese.dyndns.org> <4E6E2122.8000201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 18:44:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R39cM-0006FE-NC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 18:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab1ILQoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 12:44:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab1ILQoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 12:44:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291CB5E02;
	Mon, 12 Sep 2011 12:44:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLAiQUf0a0vuJL08jzRoDEshGzA=; b=g2rRy6
	mLNW6xvZ/Cy5678r68AvzKXJREOrrnNC2JgB6Le02aJnG4FeJpTjL+WcWiDS//jw
	QfhXLpXn4r90ZtepvpuWlCvncf9rTIEwyI+Tx6G/Dht3kOQr6yN8wGRjXVSgEt1+
	vanjOUcahMHgr3vAGbaFqlAZlskJ9846a5uHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MvnaiVKX0AlGiujb79DJwVTS/5DszquP
	pXcrBMQV/QzeOaqhLGCembiyKM97RY4/j3i8396y5oJO4iu0oz1ogXuIjH/WU2Wn
	6vus91G3tAoTFUKsbsC6VZdZBqwHxxZ+neUgFKGfdcvWVgW5tqPtqcKYQ/GEy3i2
	ml43JII4M/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FEF15DF9;
	Mon, 12 Sep 2011 12:44:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A65325DF8; Mon, 12 Sep 2011
 12:44:13 -0400 (EDT)
In-Reply-To: <4E6E2122.8000201@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 12 Sep 2011 17:11:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7263D64E-DD5E-11E0-B252-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181221>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> OTOH I am again having serious doubts that trying to support
> unnormalized refnames is a good idea.

Sorry, I am confused. I thought the way you are planning forward is to
leave unnormalized ones unchecked as the current code does (and mark the
places that do so with _unsafe()), with the eventual goal of fixing the
caller to pass only normalized ones to make call to the "safe" version?
