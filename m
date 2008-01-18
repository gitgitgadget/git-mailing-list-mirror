From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Fri, 18 Jan 2008 00:22:10 -0800
Message-ID: <7v63xrilvx.fsf@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
	<7vhched3kw.fsf@gitster.siamese.dyndns.org>
	<7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
	<7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
	<alpine.LNX.1.00.0801152256480.13593@iabervon.org>
	<alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org>
	<7v1w8hploy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 09:23:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFmVJ-00053v-SM
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 09:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbYARIWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 03:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbYARIWW
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 03:22:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYARIWU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 03:22:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1819043E7;
	Fri, 18 Jan 2008 03:22:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4570B43E6;
	Fri, 18 Jan 2008 03:22:13 -0500 (EST)
In-Reply-To: <7v1w8hploy.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 16 Jan 2008 12:19:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70975>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> That's why tying "--git" together with any prefix handling is wrong: 
>> because it's a totally different issue. It's true that "git-apply" right 
>> now doesn't understand these things, but assuming we want to teach 
>> git-apply to apply to subprojects eventually (we do, don't we?) we'll 
>> eventually have to teach it.
>
> That's all correct but
>
>  * currently diff does not recurse, nor apply does not apply
>    recursively;
>
>  * "git diff" that comes with 1.5.4, if we do not do anything,
>    can produce a diff that will be rejected by the stricter
>    check "git apply" has when used with --no-prefix and friends;
>
>  * submodule aware versions of "git diff" can be told to add
>    "--mark-as-git-diff" when it passes "--src-prefix=a/git-gui"
>    and "--dst-prefix=b/git-gui" when it recurses internally, to
>    defeat what my proposed patch does.
>
> So I think it makes more sense to mark output as a non-git diff
> when custom prefix is used in the version we are going to ship
> as part of 1.5.4.

Do you still have objections to the patch?

I do not think it matters _too much_, but I think starting
stricter and then making things more relaxed later is easier
than the other way around.
