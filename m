From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use __VA_ARGS__ for all of error's arguments
Date: Thu, 07 Feb 2013 13:05:19 -0800
Message-ID: <7vwquj6dio.fsf@alter.siamese.dyndns.org>
References: <1360267238-21896-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Max Horn <max@quendi.de>,
	Jeff King <peff@peff.net>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 22:05:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3YfD-0003BA-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 22:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454Ab3BGVFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 16:05:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759374Ab3BGVFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 16:05:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EEC2B39E;
	Thu,  7 Feb 2013 16:05:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6tWQnrU1+JYSFAlZ1UpL7tPHXgs=; b=s293j+
	KOCTBorfFqxYNIsrd4VECatQ12xqzUSidA8llwM2KeOE6p4ZfCcddHKbcDGqVI3b
	IDq7WWPLWQ69qGucbJu0IRVaIKRygbFa5IxfIpgKxpwxR1vL840INw5OcY5z1/ly
	M0L1RMVoNxMvWCUVMcl2eEcQnGziCjOFTJuLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cjPIeFcDtmTsoX2UZ1PDrgCNVr5FH5/9
	pIoxPuy2b0BxR2mcr7i+qTxx0m7GObxKlU7W5/O98KbAkeqE5ThfSHgN7TKuBMA7
	DCaai2DBqyuVVVaCfMYSDJIdUf/iRTm7GSPX8oD/6p4183max2njt766b3HzquWI
	jY4mx5GwVVI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 033FFB39D;
	Thu,  7 Feb 2013 16:05:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80110B39C; Thu,  7 Feb 2013
 16:05:21 -0500 (EST)
In-Reply-To: <1360267238-21896-1-git-send-email-kraai@ftbfs.org> (Matt
 Kraai's message of "Thu, 7 Feb 2013 12:00:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 157A295A-716A-11E2-A750-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215730>

Matt Kraai <kraai@ftbfs.org> writes:

> -#if defined(__GNUC__) && ! defined(__clang__)
> -#define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
> -#endif
> +#define error(...) (error(__VA_ARGS__), -1)

Before your change, we only define error() macro for GCC variants,
but with your patch that no longer is the case.  Does every compiler
that compiles Git correctly today support this style of varargs
macros?
