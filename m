From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/14] revert: Introduce struct to keep command-line
 options
Date: Wed, 06 Jul 2011 14:20:45 -0700
Message-ID: <7vzkkrjec2.fsf@alter.siamese.dyndns.org>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 23:20:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeZWg-0001bY-3W
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 23:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab1GFVUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 17:20:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756503Ab1GFVUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 17:20:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1C2E69E3;
	Wed,  6 Jul 2011 17:20:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Z54hm9NibqBZhNwO8qcLL1OcE0A=; b=XS0DfPG80nyWlf8Hjk56
	foHVycvkG03GrWd9LnjvwNHD9L+/GJbVaON3C7p4UtGIp83HA5iMt9U4zr9EiNp6
	q5ZoxbHqYf7U7lA73N5fCs/aU79GMf6BieUFu9jkAZUOjuvSS+GlbcH7wlF4f4OH
	xwDgs1TE0ssbLwUBEmlVFow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=OdfOKVr0Jb31Su1horyQDkDy2HRq1H83SAFO9CWZ8rHRcu
	XxI9Z/dQdWkYyCbO0q2lkao+0vnRAdYqRR03Vac+Gj/YNzySEgtJmhZU2cMdGfV9
	n+UPjj8O45c2ijsAr/4zxhp2TISkvIQUuHZ39uR20GgCUtcKdvt7KY1CQx8t0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A514369E2;
	Wed,  6 Jul 2011 17:20:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0505E69E1; Wed,  6 Jul 2011
 17:20:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0B3587E-A815-11E0-BB55-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176730>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The variable "me" is left as a file-scope static variable because it
> is not an independent option.  "me" is simply a string that needs to
> be inferred from the "action" option, and is kept global to save each
> function the trouble of determining it independently.

Would it make more sense to remove the variable, pass "action" around
where only "me" is passed around right now, and introduce a function
"static const char *action_name()" to help places that wants textual
command name for display purposes?
