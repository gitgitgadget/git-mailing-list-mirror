From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git rebase" loses the additional changes in "evil" merges
Date: Mon, 04 Mar 2013 13:18:22 -0800
Message-ID: <7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Mon Mar 04 22:18:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCcmY-0008Tf-UE
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 22:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404Ab3CDVSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 16:18:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52388 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758173Ab3CDVSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 16:18:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62999A804;
	Mon,  4 Mar 2013 16:18:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a/mXDb3KxE3hG0ZXfucjk+WQVNA=; b=CnKfLi
	XtPhSWPEFpyjAAIFkla5nKAfSak2ZTIN+l5U70D31ejHQt9VrdhMoSjt/CUPjlIj
	34+3D8i5pitrca+Of5jSvmV9h6DQ7lh+2ZNY+qJiit3VY4OeKkxPuF39XL4YKSpS
	Atl1E6VugxCGkLQ/IF9cL1VAT+fZ6GHt79maA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g/jQ0E0yVr+nK7hQ963Hnrv4P6uMnRWX
	FB9lb3Pmqa1iNh9dpol4tZGQJMC1ns+mwbNF2bu9ToWoLXeAk7eKLbVdXKVAYhN2
	ANtNXfah7xRv693MlYADvWk0DQX9RAbnbPFWC4cdcEjNEbv/h9icAXmQ7NE0tKe/
	fy3/ZVvif/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55B1DA803;
	Mon,  4 Mar 2013 16:18:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAFB6A801; Mon,  4 Mar 2013
 16:18:23 -0500 (EST)
In-Reply-To: <201303042058.r24KwwEx012408@freeze.ariadne.com> (Dale R.
 Worley's message of "Mon, 4 Mar 2013 15:58:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C1835CC-8511-11E2-865D-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217410>

worley@alum.mit.edu (Dale R. Worley) writes:

> (git version 1.7.7.6)
>
> I've been learning how to use Git.  While exploring "git rebase", I've
> discovered that if the branch being rebased contains an "evil" merge,
> that is, a merge which contains changes that are in addition to the
> changes in any of the parent commits, the rebase operation will
> silenty lose those additional changes.

I think this is to be expected for "git rebase", as it does not even
look at merges.  It is a way to find non-merge commits that haven't
been applied yet, and apply them to the upstream to create a new
linear history.
