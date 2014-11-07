From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Fri, 07 Nov 2014 09:14:42 -0800
Message-ID: <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
References: <20141107081324.GA19845@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 07 18:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmn7a-000843-DQ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 18:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbaKGROq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 12:14:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751714AbaKGROp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 12:14:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A2001A709;
	Fri,  7 Nov 2014 12:14:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rhhOzJ95gXVTIfM3ykPTauOPRIQ=; b=j//hli
	A9zguH9BbLbu294WFAU3Pm2/RIX/BsrE9hsXQR7W42689qJtgbq1FBdPTMf5Y2Pz
	Cm3c4+4KPToW+S2yAU0L3yh/lhUmlGJ3BuojaODxvK9Dan8CeZ/SgG85Z2tlZNk2
	gHVdmoP/Y/ayRXwUNOJ0k6LAeWlx8NM4wLJh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r875dQpML00a4yTZ54cDx6y/Y2KDQHdp
	3kyn2BUiRXkIROcvxewVhY8IUFsKbH6KaurO63yDnFPjb5GPmA7okJ5GUX3a6F1h
	5NsQlTwppL34/G68IhGxRZFlBWG0MIpu8isyEs+L80N2lfd711Zb7zjddCXvBTKn
	ZadMoPn0j5w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2F261A708;
	Fri,  7 Nov 2014 12:14:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8269B1A707;
	Fri,  7 Nov 2014 12:14:44 -0500 (EST)
In-Reply-To: <20141107081324.GA19845@peff.net> (Jeff King's message of "Fri, 7
	Nov 2014 03:13:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91896B2C-66A1-11E4-8BC0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Is there a reason that we don't use this diff technique for checkout?

I suspect that the reasons are probably mixture of these:

 (1) the code path may descend from checkout-index and predates the
     in-core diff machinery;

 (2) in the context of checkout-index, it was more desirable to be
     able to say "I want the contents on the filesystem, even if you
     think I already have it there, as you as a new software are
     likely to be wrong and I know better"; or

 (3) it was easier to code that way ;-)

I do not see there is any reason not to do what you suggest.
