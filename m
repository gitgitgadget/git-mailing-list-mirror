From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Disambiguate PREFIX define in sideband.c
Date: Tue, 06 Mar 2012 11:04:40 -0800
Message-ID: <7v1up5tut3.fsf@alter.siamese.dyndns.org>
References: <1331024077-5736-1-git-send-email-user@vincent-VirtualBox>
 <1331024077-5736-2-git-send-email-user@vincent-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 20:04:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4zgn-0004wt-84
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 20:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168Ab2CFTEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 14:04:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755940Ab2CFTEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 14:04:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DBD65939;
	Tue,  6 Mar 2012 14:04:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lgcWjF+u4v9Jp2wn/msJI36Y4pI=; b=rxiONE
	mmuqReqW9a2PPVfdd7OStWvwzUROS/NeCa3NOSzSdUgvEzJfp9gnpFkEh9Sq5+Zs
	dxRqZX7+rh5tkB7Pv/T+cJWmkTgpBoQhMEHcxcOUT0JBvUy/9LuxLTYAsaty6iBw
	tohx0IENi7R6WJQ7c7kEAxEFwrcO/IvWN0qo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NPX+/wKt3IbBAet1T0HtORtIwmQZnM/p
	krBr+/EnGOazNCc9QjTYlaw8B8vtmYtHTSHU11R+pgKBsih4SsKGwGAG1T/AONpO
	HbEBt+TuBMK3niW7Z4MRLqw1lTzWoudPVIDQdzeihaP/KUOb0WKpzIZ5jQjzI1Ee
	5b0hVOVyEsw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9577D5938;
	Tue,  6 Mar 2012 14:04:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E6775937; Tue,  6 Mar 2012
 14:04:42 -0500 (EST)
In-Reply-To: <1331024077-5736-2-git-send-email-user@vincent-VirtualBox>
 (Vincent van Ravesteijn's message of "Tue, 6 Mar 2012 09:54:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AE02F7E-67BF-11E1-AB0D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192376>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> From: Vincent van Ravesteijn <vfr@lyx.org>
>
> PREFIX is already used as the prefix for the system path in system_path(..)
> in exec_cmd.c. If PREFIX has been set, this patch prevents a warning that
> PREFIX is being redefined.

If I recall correctly -DPREFIX= is given only when compiling that
single file in order to limit the knowledge of the actual value, and
is not given when compiling sideband.c, so it is unclear what
problem you are trying to solve here.

In any case, it probably makes sense to rename _both_ symbols to
make them more descriptive.  In the context of Makefile, PREFIX is
perfectly fine symbol to define the common prefix for installation
path (I would rather see it all in lowercase, but this dates back to
the very original Makefile by Linus), but in the context of the
whole source file, PREFIX doesn't not tell us what kind of prefix it
is about.
