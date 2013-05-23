From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push not resolving commit-ish?
Date: Thu, 23 May 2013 11:10:32 -0700
Message-ID: <7v4ndtftyf.fsf@alter.siamese.dyndns.org>
References: <20130523105310.GA17361@redhat.com>
	<CAMP44s18KCYEZaMTn_S2znocyr-WDCT5ciuzLoYaSHPQFc4XCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 20:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfZyJ-0008FG-8m
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 20:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099Ab3EWSKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 14:10:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33279 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758017Ab3EWSKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 14:10:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 541FF21607;
	Thu, 23 May 2013 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=20dMObh92VRW5G4ZTMULKEkbj9w=; b=Z0Za76
	9XU4d7w3JiZTeF+Qx3/pEXdWo44yTg+J1J5DaUeFydpq+PDGeOWMcv/RLyEKegC1
	PTP6pWhjSooBv1UsNwcyp1Jx0PKLUThB8UnEnh35zV1p6c0KHznwgzfcXhhD9do+
	E9UkrrBddIf54wm0PcHvax1hCaIGMRgvKg5v8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VO2oX9A1d9+/OV82DYaNhSPcCDpwaQtk
	RbJKXp0GjckBW5lt4S0Y4nwFkBoSgCs2NTiBuf/S2hi8BwBjSP0A+RBqOf03KJRE
	WQcllgUjgE5h/8yGQoEQP9c2agryKjwZa5Tq3D9Dvh1HTploZdekqmASGL1t9FxS
	iC4veYuSnM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AB8A21606;
	Thu, 23 May 2013 18:10:34 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5ED121605;
	Thu, 23 May 2013 18:10:33 +0000 (UTC)
In-Reply-To: <CAMP44s18KCYEZaMTn_S2znocyr-WDCT5ciuzLoYaSHPQFc4XCw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 23 May 2013 05:56:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FAFB118-C3D4-11E2-BE93-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225278>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 23, 2013 at 5:53 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> Looks like push can't resolve tags to commits.
>> Why is that?
>>
>> linux$ git push -f $PWD v3.10-rc2:refs/heads/vhost-next
>
> Perhaps v3.10-rc2^{}. Yeah, totally and completely not-user-friendly,

More commonly "v3.10-rc2^0:vhost-next", if you are truly pushing it
out to a remote repository, but then it invites a puzzlement "What
do you plan to do next after pushing?  The only reason v3.10-rc2 is
used is because there is not yet a local branch that will host the
vhost-next changes that is built on top of that tag (otherwise you
would be pushing that branch to vhost-next)".

But in this particular case, you are force-pushing into the current
repository, and it is spelled much more commonly

    git branch -f vhost-next v3.10-rc2

I would think.
