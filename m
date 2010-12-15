From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] get_sha1: support ref^{/regex} syntax
Date: Tue, 14 Dec 2010 18:56:31 -0800
Message-ID: <7v62uvrbfk.fsf@alter.siamese.dyndns.org>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 <1292209275-17451-3-git-send-email-pclouds@gmail.com>
 <7vaak7rh9k.fsf@alter.siamese.dyndns.org>
 <AANLkTikgXAg9+0TXzpFH7LT1yD2sV5Dp=025GbudnY5S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 03:57:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PShY5-0001oV-QZ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 03:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758709Ab0LOC44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 21:56:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697Ab0LOC44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 21:56:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 46E603967;
	Tue, 14 Dec 2010 21:57:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=51UMClv0D4xdfDnA7sDTadGejOA=; b=ZpI1tn
	NoIargN9llp0Zd/sbyRv4R770reaJGrhknejqfXqyJBvxHNsJPSWHAivQ4Ic5Rp6
	u1Obdh5WB5zILjQVLf5DWLwGevJMnEbZpuXqFv2FxKEg8I9EMzxqXE7yZcrFNBN2
	qQlGtHmQmo2gJKJWwfpitTM19/LlHy21Fx5o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xEPjzM7nhZ5h1JAU7FrlY7iF43ddm6xd
	15Ntp+m/bYBL6u6KhwJSm12RCj8hyr2TnBT5eDSFumuOkBx2bLo5dXIVmlRQWRAS
	XAfpc8SIlEMDbhkPNhpOp//TdrKVwLcywPbmxIPaVztcJ5LDsFIwIRxhbcws2Jbo
	L9qnNcquAxM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9728D3966;
	Tue, 14 Dec 2010 21:57:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A3133959; Tue, 14 Dec 2010
 21:57:01 -0500 (EST)
In-Reply-To: <AANLkTikgXAg9+0TXzpFH7LT1yD2sV5Dp=025GbudnY5S@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed\, 15 Dec 2010 08\:58\:11 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 035BBC0E-07F7-11E0-807C-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163729>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Perhaps we should just reject this case. No sane body would ever use it.

I'd have to say that dismissing before even trying is not a very
disciplined attitude.

Shouldn't an empty regexp simply match everything?  Even on FBSD8,

    $ grep '' /etc/passwd

seems to show everything.  How hard would it be to do this in the codepath
we are discussing?
