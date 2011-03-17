From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitweb: introduce localtime feature
Date: Thu, 17 Mar 2011 11:26:04 -0700
Message-ID: <7vaagt4n9f.fsf@alter.siamese.dyndns.org>
References: <3ef1af6874437043a4451bfbcae59b2b@localhost>
 <e272fa98ecab9d30edb4457e2e215688@localhost>
 <m3d3lq57vw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:26:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Htt-0005g7-M2
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 19:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab1CQS0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 14:26:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab1CQS0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 14:26:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 94E414E9D;
	Thu, 17 Mar 2011 14:27:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PGmUiZXZT0Kho/1gcre9GnW9ryw=; b=DNmLyf
	zYq3jMK+J6/F/PVr1iRYA6EJEMmQu9E+ybWn6LbSlgyeDwZCm3QFBJc5XQlCK866
	AiTNsO32ORroFo6akPuHDuwq4MMvlq2n+hvKXmlTyy2gNseFygND6TE4ykCvud0+
	EmD3TDDO6K9VCEgY87W/mx9xGZzkyJfuU5yIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k4iehUPgm3dGnNdcZOwNr4if7SWfEM0W
	reFHKXq4Ry7bA/ShxegKcbvtj2wHuduVqe7tMyYUHnjR9wzOA+LvE9o3SePIf1qT
	8ilj80cQ5NPlvcerM/ewu9Jp5e4ofD51cq9GM3jjGWjxXJZt98wZF7F1uAtV5jos
	rz3+ALAEq5w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6328C4E9A;
	Thu, 17 Mar 2011 14:27:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 495754E95; Thu, 17 Mar 2011
 14:27:39 -0400 (EDT)
In-Reply-To: <m3d3lq57vw.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu, 17 Mar 2011 04:01:18 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FAD5F94-50C4-11E0-B471-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169253>

Jakub Narebski <jnareb@gmail.com> writes:

> Kevin Cernekee <cernekee@gmail.com> writes:
>
>> With this feature enabled, all timestamps are shown in the machine's
>> local timezone instead of GMT.
>
> This does not describe why would one want such way of displaying
> timestamps, and which views would be affected.
>
> BTW. should it be timezone of web server (machine where gitweb is
> run), or local time of author / committer / tagger as described in the
> timezone part of git timestamp?

Both are sensible choices; another plausible choice that normal people
would want to see is to use the zone of whoever is requesting the page
(note that this would affect the caching layer).

>> +	# Use localtime rather than GMT for all timestamps.  Disabled
>> +	# by default.  Project specific override is not supported.
>> +	'localtime' => {
>> +		'override' => 0,
>> +		'default' => [0]},
>
> Why project specific override is not supported?

Good question.
