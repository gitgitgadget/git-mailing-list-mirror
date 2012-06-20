From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Wed, 20 Jun 2012 10:32:40 -0700
Message-ID: <7vr4t9x51j.fsf@alter.siamese.dyndns.org>
References: <4FE091FB.7020202@desrt.ca> <87a9zztdxt.fsf@thomas.inf.ethz.ch>
 <7v8vfj17de.fsf@alter.siamese.dyndns.org> <4FE0E493.1010308@desrt.ca>
 <CABURp0p6Hv8=Yg1MNb_DMRM3D2JWZtGNwn_GiOfP_x3MctrJ9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Lortie <desrt@desrt.ca>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 19:32:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShOls-0002zW-M8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 19:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab2FTRco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 13:32:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab2FTRcn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 13:32:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1030499D6;
	Wed, 20 Jun 2012 13:32:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BaGYJYBEx6HZvLcUwjQqDcVE0J8=; b=cE3u08
	pXwmcWKbnqZQ/bFVfM8w6r+NuSD3ud01koc5uOrAXbp7IfZZXfgaK4aaWsyHWDvW
	t1AgrW3gaAFG7o+3pbtL8E51xTD/Rsj1eUPTBgNZb5YW7D/MS90Xk1YarlzPhU95
	NBYbtGKC2JkfjtDlf1hNsxxBvHtGvurD+SSpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8PWBxAwkLNjq366n5sbGFpH2Cit6qWE
	BHkvPwkFxL8mXCj3JpgxaGaJ6+7MSi/DRiBSM4+0S4TDifageOKJjmVoVlgr1F/5
	xePw7ZVyHD0YpYwxkWW3KE7nm/TV9/sUfjs95hTv4xGwzv4Z5M+JqhTjGMnx343H
	w8S/N8Mh6ec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0541299D4;
	Wed, 20 Jun 2012 13:32:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C8D799D3; Wed, 20 Jun 2012
 13:32:42 -0400 (EDT)
In-Reply-To: <CABURp0p6Hv8=Yg1MNb_DMRM3D2JWZtGNwn_GiOfP_x3MctrJ9A@mail.gmail.com> (Phil
 Hord's message of "Tue, 19 Jun 2012 19:21:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0AD962A-BAFD-11E1-AEBE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200303>

Phil Hord <phil.hord@gmail.com> writes:

> Maybe you can suggest the advice verbiage which you think would have
> helped this user.

Requiring starting point and failing without --force will never
happen, but it could be a possible approach to issue an additional
advice message under reasonably narrow conditions, namely:

 - The starting point was not given explicitly;

 - It would have DWIMed to "git checkout -t -b it origin/it" when
   creating the branch (I think you need to check configurations
   like branch.autosetupmerge and existence of the tracking branch
   remotes/origin/it); and

 - advice.branchNotTrackingCorrespondingRemote is not set to false.
