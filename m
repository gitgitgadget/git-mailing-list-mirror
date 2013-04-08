From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Mon, 08 Apr 2013 11:00:32 -0700
Message-ID: <7vehekykan.fsf@alter.siamese.dyndns.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <1365376629-16054-2-git-send-email-aaron@schrab.com>
 <20130407235112.GH19857@elie.Belkin> <20130408000845.GH27178@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:00:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGMy-00006c-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934863Ab3DHSAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:00:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934624Ab3DHSAe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:00:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3022914325;
	Mon,  8 Apr 2013 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pr0FFqNeogU/LnRLredUbsjf7x4=; b=N+mLvw
	Bab9rMTjOhHYzLvbDlTEqp4C/SjDV5GBR6kBonqEEl3chFiTXdCCNOhg8Q4Ddkq6
	X94wlIk7JC0k9LMMufujjHoVtZtRoMOHoXyKviH8ebmpYTqjXXNRW5yl5AhKHzd5
	4iRJ1qRy9jxOi3Dmzx6NZcHfNPwkYLAh7KfJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bFki40qJc06fSW/GdhMA4N/W/lLZsa7g
	IydZ5SBxH9QkZRGjOtCpi3IvkoS0Q5avauDGI8aB7dbXnZ2VC8FiMw+VTMHw50Da
	cNuwoxWi+cW9dKrE79b3JL+bxBZ/0TdwG0RQYsjD4zS/tZjRlC9VkxUpxHLEyStD
	VSskPIn85no=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27BC014324;
	Mon,  8 Apr 2013 18:00:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 848F414323; Mon,  8 Apr
 2013 18:00:33 +0000 (UTC)
In-Reply-To: <20130408000845.GH27178@pug.qqx.org> (Aaron Schrab's message of
 "Sun, 7 Apr 2013 20:08:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 354F6BF6-A076-11E2-A64A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220476>

[ADMINISTRIVIA: please do not redirect a direct reply to you to
other people using Mail-Followup-To.]

Aaron Schrab <aaron@schrab.com> writes:

> At 16:51 -0700 07 Apr 2013, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> -	char *ref_git;
>>> +	char *ref_git, *repo;
>>[...]
>>> +	repo = (char *)read_gitfile(mkpath("%s/.git", ref_git));
>>
>>Why not make repo a "const char *" and avoid the cast?  The above
>>would seem to make it too tempting to treat the return value from
>>read_gitfile() as a mutable buffer instead of a real_path string that
>>should be copied asap.
>
> Good catch.  I'll fix that in the next version.

Thanks.  The patch otherwise looks good to me.
