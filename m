From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Expose the submodule parallelism to the user
Date: Tue, 27 Oct 2015 12:12:58 -0700
Message-ID: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:13:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr9gE-0005eM-KY
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 20:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbbJ0TNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 15:13:06 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964950AbbJ0TNE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 15:13:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AF8925D7C;
	Tue, 27 Oct 2015 15:13:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=274uGoT6+DLMbyF7vIqoL/sFjDU=; b=RLrhbc
	iyYvT/sgIPOc1IzxSYByx6NlGQV5MW4md1ktGp9NlcOFbuHnrf3fRy2xBorbBVgM
	j+kyJxo0CxtcSJlyfS0o2PSwHumKFmSX8+YxM/uHkyRXdjU9tTsuvl0Ss/Z9mI8j
	bBo1/nK7xKu1B14sTZjWe76AHkqjWh+0sqIPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UiDyf2UWySX3/5Vbdq+SHVH6e9b/IGeb
	vPiMOWJgG86oSqTAEee5I6lOCDatKxWnwFssbrg0tVBc2yzEKaKIAywzKQ0V/9/w
	lIhFxB9BUqENb11rbQkEkdof2SOlzg+g5fcVVlsvWORGt1vco907mWMdo43kt+aI
	IbztCsX6FsM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3163925D7A;
	Tue, 27 Oct 2015 15:13:03 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A001C25D78;
	Tue, 27 Oct 2015 15:13:02 -0400 (EDT)
In-Reply-To: <1445969753-418-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 27 Oct 2015 11:15:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE9ED670-7CDE-11E5-9EC9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280291>

Stefan Beller <sbeller@google.com> writes:

> Where does it apply?
> ---
> This applies on 376d400f4c (run-command: fix missing output from late callbacks,
> which is the latest commit in origin/sb/submodule-parallel-fetch which was
> merged to origin/next)

Thanks for a detailed description.  I'd do this:

    $ git checkout -b sb/submodule-parallel-update 8b70042
    $ git merge sb/submodule-parallel-fetch~4 ;# 376d400f4c

apply 2-9 there (the fork point is the merge of config-parse topic
to 'master'), and drop the four patches near the top of the other
branch.

> I realize sending refactorings in the area you'd be likely to touch as 
> a separate patch (series) is not necessarily a good idea as it leads to
> situations like this.

Don't worry too much about it.  When you tackle a large area with a
lot of existing code, these things are bound to happen.

> What does it do?
> ---
> This series should finish the on going efforts of parallelizing
> submodule network traffic. The patches contain tests for clone,
> fetch and submodule update to use the actual parallelism both via
> command line as well as a configured option.

;-)
