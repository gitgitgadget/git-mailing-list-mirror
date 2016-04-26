From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] submodule doc: write down what we want to achieve in this series
Date: Tue, 26 Apr 2016 15:42:07 -0700
Message-ID: <xmqqd1pcc7r4.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:42:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avBgN-00062k-Of
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 00:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbcDZWmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 18:42:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752207AbcDZWmK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 18:42:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EBA01693E;
	Tue, 26 Apr 2016 18:42:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tjojX0f1bys2pdqp1g0qglCXDdg=; b=RXmNwH
	VgBzGf2v3rWLOHcaQIUMJYQ7auCiij9dvqZ001D9yUL3ao3ALBWkRbU3MYCwmAK7
	PDMl8o7+ncCm7jXnlp4N9xT5TNrK3iM4RHJC/RM9NtgYr7MbUuBMv+nv7DMROlF6
	V5jZx8q70px4oixPx4OzXznsdK8MIts9K1Ydg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WwRS3WA73ajTWshYfzAgpr4djU37sClg
	/PG/Rou6fztAVx7xsPlCHnOfmBLGMNVU4P/ijevLFWofnBh7Evdbcarx6hSfkSG3
	vFNkXrCaOmE6JjNFZVc8wRECrKypwp98LuoyP0R7NQS+BIyyBjtU04eqcmK0nsBS
	n8xXqfakVLY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7489D1693D;
	Tue, 26 Apr 2016 18:42:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E28681693C;
	Tue, 26 Apr 2016 18:42:08 -0400 (EDT)
In-Reply-To: <1461703833-10350-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1BED1304-0C00-11E6-AB88-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292692>

Stefan Beller <sbeller@google.com> writes:

> +When operating on submodules you can either give paths to specify the
> +desired submodules or give no paths at all to apply the command to the
> +default group of submodules.

So, "git submodule foo path1 path2" would act on path1 and path2 but
would omit path3.  If you have path1 and path3 but not path2 in the
default group, and do not give any path, i.e. "git submodule foo",
it would act on path1 and path3 but would omit path2.

OK so far.

> +By default all submodules are included in
> +the default group.

So if you do not do anything special, i.e. do not define any group,
"git submodule foo" would act on path1, path2 and path3.

I think that is in line with the way how module_list aka
"submodule--helper list" works.

> +You can change the default group by configuring
> +submodule.defaultGroup. Once the default group is configured any
> +submodule operation without a specified set of submodules will use
> +the default group as the set to operate on.
> +
>  Submodules are composed from a so-called `gitlink` tree entry
>  in the main repository that refers to a particular commit object
>  within the inner repository that is completely separate.
