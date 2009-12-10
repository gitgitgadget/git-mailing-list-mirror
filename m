From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REROLL PATCH v2 6/8] Support remote helpers implementing smart
 transports
Date: Thu, 10 Dec 2009 09:10:05 -0800
Message-ID: <7vvdgekb6a.fsf@alter.siamese.dyndns.org>
References: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260372394-16427-7-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091210155811.GC30665@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 10 18:10:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NImX0-00026O-Vi
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 18:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761111AbZLJRKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 12:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761099AbZLJRKK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 12:10:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761067AbZLJRKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 12:10:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17737A517B;
	Thu, 10 Dec 2009 12:10:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xDE15nX0GuwRlGVtBwLxIclQJDU=; b=WXW82b
	cRbPrnB0Wmiho05YTwEwhz0Ny7M0lPS4hhG+UkzlrzyisabnNeTYVDc02oAXCnlV
	QH+RIjLE+mmrYc+u+CHuX3KdjcXfp1XclxLHubc4azoCWFGGVxHKyJjP1OHVhZwK
	9YxEoXAizumuaqLndIQsbsmWrBqdVMnll8mvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fM2wV03emhvWWHa30xAuhGzrqm2PuH76
	EZgHPcFsPLqDQN8+qezwLjHvgr8i1gO4B6CwDfZrT6302RAUj5AonX20eGPpOcmF
	Q69zRdqz5PK3WHuWCutikR3pKK8SX68sHaKEYD6QRdnMH94hTOxOInh545i41kVs
	PZfF5R7r61g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4F62A517A;
	Thu, 10 Dec 2009 12:10:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 90DA7A5179; Thu, 10 Dec 2009
 12:10:07 -0500 (EST)
In-Reply-To: <20091210155811.GC30665@spearce.org> (Shawn O. Pearce's message
 of "Thu\, 10 Dec 2009 07\:58\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E04F5916-E5AE-11DE-9BD3-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135036>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
>> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
>
> This is better.

Is this sarcasm?

As far as I can tell, there is no "Junio received and added some that is
copyrightable, and Ilari later received it and worked on it" anywhere in
this series to require recording of patch ping-pong, except perhaps 3/8
where I gave remove_ext_force() with a shorter implementation.  The only
edit I did myself was to fix style.

I did suggest renaming a few functions but that (1) eventually was done by
Ilari, and (2) isn't large enough change to be copyrightable, I think.

>> +	if (strcmp(name, exec)) {
>> +		r = set_helper_option(transport, "servpath", exec);
>> +		if (r > 0)
>> +			fprintf(stderr, "Warning: Setting remote service path "
>> +				"not supported by protocol.\n");
>> +		else if (r < 0)
>> +			fprintf(stderr, "Warning: Invalid remote service "
>> +				"path.\n");
>
> Style-nit: We prefer "warning: " with lowercase.

Also this could be a semantic nit; we prefer to call warning(), which is
meant to be overridable by the main program (it probably does not matter,
though).
