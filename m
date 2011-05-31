From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.c: Remove unused git_config_global() function
Date: Tue, 31 May 2011 10:51:06 -0700
Message-ID: <7vy61miws5.fsf@alter.siamese.dyndns.org>
References: <4DE5241E.9030000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 31 19:51:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRT66-0007fZ-W4
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 19:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937Ab1EaRvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 13:51:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab1EaRvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 13:51:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1069C563C;
	Tue, 31 May 2011 13:53:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a9VXXfUowsdzGFHwubAL0Swoh4s=; b=K09AQl
	FM3E1OOWER9skN+44nTzr6+/evl1pEhibenKHJknckYOqyMiDTkYeG+cVkYTvOCH
	cUrbzSRVJ8fezlXxPAYv+sq5w9wg6b2zZqS3e9IxVTP3Uv+KjJ7xPL8ZdyJ5L8a2
	EOLBhdP/+mxNCuYcEH6WDkmt5ESLw3DRPiWrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P5w9a2/bB2nx/W5Ba6CnaZEsTyzeYc3J
	2vrHCAF+lv8jw+sDPj6rxIKC7BSmiYXyt2jBrZ4rRol29deylUkq5gh4kipGGXl6
	jV7j2irio1FG2cwj3rHRmgeoYd2eORoOmdF0ZHtET1TjoO3sXL+7P5I3rY+Cybul
	2BPOYbAZRnQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E1194563B;
	Tue, 31 May 2011 13:53:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 13FC1563A; Tue, 31 May 2011
 13:53:16 -0400 (EDT)
In-Reply-To: <4DE5241E.9030000@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 31 May 2011 18:23:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEBA1AC6-8BAE-11E0-AAFC-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174817>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Commit 8f323c00 (drop support for GIT_CONFIG_NOGLOBAL, 15-03-2011)
> removed the git_config_global() function, among other things, since
> it is no longer required. Unfortunately, this function has since
> been unintentionally restored; I suspect by merge commit 25b86e45
> (Merge branch 'jk/maint-config-alias-fix' into next, 25-05-2011).

Yeah, I think it was 1f9a980636 which was a merge between fb674d7 and
73546c0.  I just compared the output between these two:

   $ git diff fb674d7...73546c0 -- config.c ;# what the topic did
   $ git diff fb674d7 1f9a980 -- config.c   ;# what was merged

and indeed I can see these four lines snuck in by accidental faulty
conflict resolution. My bad.

Thanks for spotting.
