From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without
 pathspec
Date: Tue, 01 Mar 2011 10:40:18 -0800
Message-ID: <7vd3maelbh.fsf@alter.siamese.dyndns.org>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
 <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
 <7vy6512rnb.fsf@alter.siamese.dyndns.org>
 <AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
 <7vk4gkk5pd.fsf@alter.siamese.dyndns.org> <vpqipw2rixy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 19:40:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuUUz-0002WE-5Y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 19:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683Ab1CASkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 13:40:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574Ab1CASkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 13:40:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4FC544CB8;
	Tue,  1 Mar 2011 13:41:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H/lMp7gxbHQI2qPmyiGZAGQU7Dc=; b=Hyo7ly
	c4kcsfhZm7R1wACCnlH1hgU0lcCEzrUIONHziS4evh0TnqWs5aVNt79bYsh41Ozq
	KMTi9wiPl14hi9qa4m0PqAdf2ldknJxo0WcOcEvI9SPBLnJHP/szbHwKcHgRHLO5
	9N+pvNM0AfwhQBee9fu0YLrArBBp6TGvTTvbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cvuDd2luRQrp5vVDxj7C2JRjN5P02gGx
	2zUoyU3VtOn006Rp9E3+SHajUvqcBZ2mHyy0BxooRkp+lkyZ9syNa4eiT087dGET
	N0k0aybTkzUgn/NvpJjtjQDUnUFRlzTX5s7DwNCNICtSWVO1Ua47qqQaUsQDH8MF
	pYp0P9rNzRw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E19974CB5;
	Tue,  1 Mar 2011 13:41:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C8AA4CB3; Tue,  1 Mar 2011
 13:41:40 -0500 (EST)
In-Reply-To: <vpqipw2rixy.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue\, 01 Mar 2011 15\:53\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 910F7568-4433-11E0-9C78-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168237>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I think promoting "git add -u ." more than a configuration option would
> reduce the pain.

Yeah, I tend to agree.

> As a user, if I get used to typing "git add -u ." instead of "git add -u", 
> I get the current behavior regardless of the version of Git, without a
> warning. Later, when all the machines I word on support the tree-wide
> "git add -u" (either 1.7.x + some configuration or 1.8.y), I'll use it
> as a new feature.

Once your users (you as a script writer) have an option to set the
configuration to participate in the tree-wide party early, you would need
to update your scripts immediately so that they don't break on them; so
the introduction of the configuration becomes a flag-day event.  Hmph...

> So, a warning like
>
>   warning: the behavior of "git add -u" without pathspec will change in
>   Git 1.8.0. To keep the current behavior, use this instead:
>   
>       git add -u .
>   
>   + explanations about the config options as already discussed here
>
> would be fine.

Yeah, I think you convinced me that an elaborate configuration wouldn't
help us at all.  We just keep warning in 1.7.x series when "add -u" didn't
see any pathspec, and flip the default at 1.8.0

Simpler and cleaner ;-)
