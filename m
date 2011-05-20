From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] receive-pack: eliminate duplicate .have refs
Date: Thu, 19 May 2011 20:06:20 -0700
Message-ID: <7vaaei5avn.fsf@alter.siamese.dyndns.org>
References: <20110519213231.GA29702@sigill.intra.peff.net>
 <20110519213446.GC29793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 20 05:06:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNG2t-0004kF-5E
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 05:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab1ETDGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 23:06:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321Ab1ETDG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 23:06:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E63745311;
	Thu, 19 May 2011 23:08:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y0yW7/odebuxfAABSpaQ9Zu2QQE=; b=XhJDRL
	68hVKDtIovangRzU4w0l/IPConVZPFNP212EFgnbmbTds1Ky5SB6aqCiMNfXT4Gd
	TlPxIbwApMfg9vl+5CLUD3Wujoj2aX08cAtgJQYiFi87BKvuDz9dJ9zp1ChuPgCz
	YNlA96Dr6af0iJb2N+sNpE8eolDexFrIGqGgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZA+8giVr2ahXD3V6qjxfPljP8RoexzBS
	ACFF11kBHxReKUKPXqWfuLkgp5PEiQNiuvomvxxygQwLtkizYhBG7Wqo/VgczEix
	MTF9lDaTKaDRSYYg3TWwTG/ryta5x4WqVhSVk/SSqgifyoL5by+4OhTFD3424ONH
	9f86hBl/b+0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF35E5310;
	Thu, 19 May 2011 23:08:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BEBFB530F; Thu, 19 May 2011
 23:08:29 -0400 (EDT)
In-Reply-To: <20110519213446.GC29793@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 19 May 2011 17:34:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71BE4038-828E-11E0-A62F-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174034>

At first I thought you are going to insert the object names into a sorted
list and handle dups while doing so, but it makes a lot more sense to
append first and then sort at the end, and skip the dups while scanning,
which is what you did.

Looked sane; thanks.
