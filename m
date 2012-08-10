From: Junio C Hamano <gitster@pobox.com>
Subject: Porting to a new platform
Date: Fri, 10 Aug 2012 09:20:45 -0700
Message-ID: <7v1ujelnvm.fsf_-_@alter.siamese.dyndns.org>
References: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1344526791-13539-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20120810132608.GA29609@hmsreliant.think-freely.org>
 <003901cd7708$fa482c10$eed88430$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:20:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzrxG-0008OH-Dx
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 18:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab2HJQUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 12:20:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842Ab2HJQUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 12:20:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA33D9403;
	Fri, 10 Aug 2012 12:20:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aXIXQxSktuIra8AgzovE+2D+7bs=; b=c85Cdp
	XSrrribix15wZR1rb9wzxR4FIwxRE7l+ZKZGlLRkiBKHvBemNtHnbqbXeeE7UUzZ
	ivF2oWO085WwlPAYwwpLbEFh4mQ2kljQZbXk+kEPYclwNr5SxqgHLA9pB912Gti6
	E9nBuKxhFXPMFRvYm88pmvkjWCNsspPvSLsgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZlJPTFJireaWmYO/NK/pkiBN+8l7By1R
	rLvUSWyMsSbi5GVM9Sc6MzR/MQLc2K70Mz/SL3/X+bl1M+94q+zHXwP6udEhX+Fb
	MsC84Z0gVlAruM67fzyi8Go5384yKZDCn8EZK3I5hMcPKouk4xLjsXwcc81RAKWx
	iGxmd+YSjtI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6C459402;
	Fri, 10 Aug 2012 12:20:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 331339401; Fri, 10 Aug 2012
 12:20:47 -0400 (EDT)
In-Reply-To: <003901cd7708$fa482c10$eed88430$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 10 Aug 2012 17:01:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 579F81AA-E307-11E1-A625-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203230>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> - HP NonStop is lacking poll(),...
> - HP NonStop is lacking getrlimit(), fsync(), setitimer()...

I would check compat/win32 and friends and see what other platforms
that lack this and that do, if I were you.

> so telling configure to search for c99  should help here.

In general, the top-level Makefile is designed to be usable without
ever worrying about "configure" mess.  Just define CC for the
platform section there, and optionally add a support to flip the
same in configure.ac.  This applies equally to other conditional
compilation options you may have to add to support your platform.
