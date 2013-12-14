From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unexpected cherry-pick behaviour
Date: Sat, 14 Dec 2013 11:39:06 -0800
Message-ID: <7vmwk3gr39.fsf@alter.siamese.dyndns.org>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
	<xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
	<7050e7272bb83d083a56a2c391228ed8@matos-sorge.com>
	<CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com>
	<beee32a53ece8b839578703deb851eaa@matos-sorge.com>
	<CALWbr2y1YDX0dzjpZoF8WL4+ND+8drurH+Wrf1wBs_-=0datOA@mail.gmail.com>
	<3FFF08967D2E480FA6B0E0EE3A72A8D9@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Antoine Pelisse" <apelisse@gmail.com>,
	"Paulo Matos" <paulo@matos-sorge.com>, "git" <git@vger.kernel.org>,
	<git-owner@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Dec 14 20:39:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrv3a-0003uQ-4c
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 20:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab3LNTjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 14:39:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab3LNTjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 14:39:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B973D58ECF;
	Sat, 14 Dec 2013 14:39:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lu9L0ZecjbkdkosyOmM8yXMFqwg=; b=ncxlyd
	LJNkKLDrs891/gFquJj/5HNxwtOMlGU6Llq8FY7fZR7o7Cvx01qyxRlhKywcxoyx
	strI9Gx6LWsv/LVZE4NoBEyGurbUcDXgKMwCazNNVINoxmAfU7NlTaSCoB1AhIuO
	EMUbNDIuyoXQZdxN6HphGdcly+QMEP0tzVD28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O+EiqfRMrclpH8Q+78yJIfmJoKcWhDdI
	JLHskpa0BuYe4a/IyxKeSqRjmh/RQpTHgWmB5Ta+AsHNaQ0UsUi04LtgngeS6Qf4
	UWaTMhgi8btZQ8pH08WGm7qEHZDUuFPX53L6ZdUoHAoSBQGH2PXF68sHeoXBoYDh
	JmJOgbw1wqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DD4558ECD;
	Sat, 14 Dec 2013 14:39:09 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A63BF58ECA;
	Sat, 14 Dec 2013 14:39:07 -0500 (EST)
In-Reply-To: <3FFF08967D2E480FA6B0E0EE3A72A8D9@PhilipOakley> (Philip Oakley's
	message of "Sat, 14 Dec 2013 14:53:30 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 65B13D38-64F7-11E3-BBB7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239313>

"Philip Oakley" <philipoakley@iee.org> writes:

> Would this be a good use of the
>    * Magic pathspecs like ":(icase)
> that was recently released (v1.8.5  2Dec13)  so that the merge stages
> can be named.

Because the pathspec mechahism is for you to tell an operation that
works on a collection of paths (e.g. "all the paths in the HEAD",
"all the paths at stage #1 in the index") to narrow the set it
operates on down to only those that match, I do not think it is a
good match at all to what you are trying to do.
