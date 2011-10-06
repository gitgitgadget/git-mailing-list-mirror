From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 05 Oct 2011 17:43:32 -0700
Message-ID: <7vsjn73q6j.fsf@alter.siamese.dyndns.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
 <CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
 <7vaa9f59p5.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com>
 <7vwrcj3sow.fsf@alter.siamese.dyndns.org>
 <CAG+J_DzZrFx2v09zNxKm2xyA82MyKRTq3AEus3QthtpZYhQn0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 02:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBc3r-0004oH-AZ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 02:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935580Ab1JFAnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 20:43:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935275Ab1JFAng (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 20:43:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D1DF6C31;
	Wed,  5 Oct 2011 20:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bUbfnIOpk8XxI3UgauJr9lg4/V8=; b=O3kpXM
	zg75lgVLRfbFAagVx51bXmxhDEZBf2tLuevvob2EC/0uZxwKvztXzUBOeD1mANbZ
	1lamowXr7g0RhjH+4GO2RTnWJtn/zFrFjNL5omF21nzE7eV9D1bDhZgiILqRztxI
	9eLl2iDqgjszV1Lfze+REQt/n1R7CJBHclUac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ikL344ux8ou5McVrxPEg/x1OmYKlie7K
	s7K/Q8gyXvWyAp+LM63VNSENnubIsJPFnzm5M3NwTGtNo+IyHr7m18b+rQOTpnHB
	WvhDauGX0ELQBpBvUhSGL2ITppXDhN/WYzp0iHi6iFyy6I+zbKf/Jme0a4SWnSDU
	kraYLKbq3uw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CCFC6C30;
	Wed,  5 Oct 2011 20:43:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE52D6C2E; Wed,  5 Oct 2011
 20:43:34 -0400 (EDT)
In-Reply-To: <CAG+J_DzZrFx2v09zNxKm2xyA82MyKRTq3AEus3QthtpZYhQn0A@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 20:33:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38CD66E4-EFB4-11E0-B9DA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182908>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Oct 5, 2011 at 7:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> This reminds me of how we ended up handling the "scary warning" around
>> detached HEAD. It is not wrong nor even dangerous to detach. It is not
>> wrong nor even dangerous to make commits on detached HEAD. It is however
>> dangerous to switch away from that state without saving it to a ref, and
>> that is where we give warnings.
>
> If you have the same branch in two workdirs, then if you commit to
> that branch in one workdir, you have to reset --hard in the other. In
> that case, wouldn't it make more sense to just use a detached head in
> the second workdir?

Not at all. My build infrastructure determines where to install the built
binary based on what branch is checked out. Having a head detached at a
commit that is at the tip of one branch is not necessarily the same as
having the branch actually checked out.

> Also, if we wait till commit time to tell the user "sorry, topic's
> been updated elsewhere", now the user is in a perilous state.

Wouldn't the "elsewhere" user would be warned before being able to update
the branch? I thought the whole point of your adding "this branch is
checked out over there" is exactly so that the "elsewhere" user can come
talk to you before that happens. These two people might be yourself, of
course.
