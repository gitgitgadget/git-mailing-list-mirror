From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] http: try http_proxy env var when http.proxy
 config option is not set
Date: Thu, 01 Mar 2012 13:38:28 -0800
Message-ID: <7vty28knmz.fsf@alter.siamese.dyndns.org>
References: <4F4FBE0F.6020004@seap.minhap.es>
 <7vy5rkm91t.fsf@alter.siamese.dyndns.org>
 <20120301210129.GD17631@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:38:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Dhs-0005mt-DI
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058Ab2CAVic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:38:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964939Ab2CAVib (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:38:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C085720B;
	Thu,  1 Mar 2012 16:38:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=54VLvPDGXAj6DJ3/t0GJiS3hAF8=; b=gRKR59
	Xm6oq8RRQ/2F4VJ8Xsy/Dc1lHH+uVHN3Pynld9bKyJsyRJGtiwgER2H0ZkP+qNNa
	ndz9wlhLndhna5plF38cMFHGyz48aCAEXTnDoakSGD+ZmVhfTjRkAxY2a7ACtYgd
	i+gwo1xrqKetuM+V1rXwdsSlMsyoPNlKaKe6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KW7WEC8xVYg7p1tzyyOwuVeZbtLTn0hp
	aKB1qXpDRGexq/gAHUTx3p9LqEo/HvmJ+GTpraYU6tT6FttnKSL/rPX+q7mfdHAb
	y/EZnSAPcd5fKm1a0HxaSBIg4N7SjgQEDxMzsxUmQ8u8KZdxajukkQgeRkSi/LRT
	h5KqBrOO//4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41A047209;
	Thu,  1 Mar 2012 16:38:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C94217204; Thu,  1 Mar 2012
 16:38:29 -0500 (EST)
In-Reply-To: <20120301210129.GD17631@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 1 Mar 2012 16:01:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2E8B9CA-63E6-11E1-BC2E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191972>

Jeff King <peff@peff.net> writes:

> When we need to authenticate for the destination webserver, we detect an
> HTTP 401, _then_ ask for the credentials, and retry the request. I'm
> curious what the error condition is for the authentication failure, and
> if we can do the same here.

Yeah, that would be ideal.
