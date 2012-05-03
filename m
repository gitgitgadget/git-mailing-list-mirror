From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: reflog for deleted branches
Date: Thu, 03 May 2012 14:37:31 -0700
Message-ID: <7vaa1pdjz8.fsf@alter.siamese.dyndns.org>
References: <4FA2F7DA.6020108@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Thu May 03 23:37:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ3iX-0002HG-KD
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 23:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab2ECVhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 17:37:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382Ab2ECVhe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 17:37:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D90957FB6;
	Thu,  3 May 2012 17:37:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s1pzqc1HNarjBXx9PI2ybdNaWyE=; b=t+bx/a
	ll9b7lg4VDC38mGPJa9L6Rw+hACEUF9jupis7zzxpHGiCo7ZLMbOPqPxiofr8cew
	L9fJx9B7FyMD2k+xJkqkQn5UUbrOsGwCeAKDfdmlI6IOJPyLFref0feJx65UQkPj
	VT1oGvVuw6By/SbI8RUC81JlRI4CXxjrI4Yco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JUo1kFloNmXdV2mmaDRTXcdqcqiX+khC
	MFq6z3pZz6ZnWdTN7rUdD6+C8V5Z3Y3d5gGUnI65oTfiIvV/oTGH/pzzYAvUqTtS
	uwhRHg3agRkg1VfQvzWfo0dF0RHDAmxw9TzDjtuJRkaHeEW8NAHuB45kaioJur8A
	gvH+4Adec8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0CB57FB5;
	Thu,  3 May 2012 17:37:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66DBF7FB4; Thu,  3 May 2012
 17:37:33 -0400 (EDT)
In-Reply-To: <4FA2F7DA.6020108@tu-clausthal.de> (Sven Strickroth's message of
 "Thu, 03 May 2012 23:25:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3150528C-9568-11E1-9D1F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196963>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> an often heart question is how to restore deleted branches. Sometimes
> those can be restored by using the reflog of the HEAD.
>
> But why not create a special (ref)log for deleted branches (with SHA1,
> date, name of the branch and maybe commit message of the last commit on
> the deleted branch)? This way people could just look up the SHA1 of the
> deleted branch and can recreate it (even if they moved the HEAD around a
> lot).

The itch is legit, but I doubt a "special log for deleted branches" is a
good design.  Why do you limit yourself only to a single "last" commit?
Wouldn't it be a better design to save away the entire reflog for the
branch when a branch is deleted, possibly with expedited expire rule for
such a reflog?
