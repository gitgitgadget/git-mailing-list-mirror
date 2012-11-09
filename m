From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Thu, 08 Nov 2012 23:34:54 -0800
Message-ID: <7v390jqlep.fsf@alter.siamese.dyndns.org>
References: <cover.1352431674.git.wking@tremily.us>
 <fb2d915cf60160c200b84df88c6112c1c2d4eefd.1352431674.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Nov 09 08:35:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWj7S-0004J1-MF
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 08:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab2KIHfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 02:35:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793Ab2KIHe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 02:34:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E650F6F18;
	Fri,  9 Nov 2012 02:34:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ML9mysEGA3LEGp/W2lndAYKPxnM=; b=ZGB5ET
	e55ndpmDCuuaq576x2qOekFzJGNeglSCOf7SiV+kXkN896sAdzxAWbOXwUeechgq
	0VXj5KCe0Cu85VjjHUSzpBftwnWGmyvocjXvlQf9vPIMxqr/hma+86Ozyk81VNii
	T/B3mEjkLmrCoS3CsIyTiOZFpFXI6gTuI1rZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OxQwbr24v3l3pYbfkcnY+inryfb2tESd
	DDPer4lVxnAjgOB+JbUiCNmD2ng1FWFgpG7NKlLOQlKcdV2XM1z0bG0L0pUv1aVv
	/3p4LX9lUKknKK/hw2iaOUS+WEVbycLzZC5MAfmpawXOcH/B5vBNGyp/LLER1gY0
	59pE5o6zG+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2B456F17;
	Fri,  9 Nov 2012 02:34:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F30D6F16; Fri,  9 Nov 2012
 02:34:56 -0500 (EST)
In-Reply-To: <fb2d915cf60160c200b84df88c6112c1c2d4eefd.1352431674.git.wking@tremily.us>
 (W. Trevor King's message of "Thu, 08 Nov 2012 22:35:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F56BFA7E-2A3F-11E2-88FF-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209207>

"W. Trevor King" <wking@tremily.us> writes:

> By remaining agnostic on the variable usage, this patch makes
> submodule setup more convenient for all parties.

I personally do not think "remaining agnostic on the usage" is a
good thing, at least for any option to commands at the higher level
on the stack, such as "git submodule".  I am afraid that giving an
easier way to set up a variable with undefined semantics may make
setup more confusing for all parties.  One party gives one specific
meaning to the field, while another party uses it for something
slightly different.

I would not object to "git config submodule.$name.branch $value", on
the other hand.  "git config" can be used to set a piece of data
that has specific meaning, but as a low-level tool, it is not
_limited_ to variables that have defined meaning.
