From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wrong handling of text git attribute leading to files incorrectly reported as modified
Date: Tue, 15 Apr 2014 14:23:35 -0700
Message-ID: <xmqqob02jnhk.fsf@gitster.dls.corp.google.com>
References: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch>
	<534852D4.5070608@web.de>
	<D552B854-59FB-406A-8CDE-3A1269CD0F6E@ammeter.ch>
	<CANUGeEYoS+t57jfpEoZE-2u_cD1uOD5pdp=yF--Rhpb9z91qxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Ammeter <git@ammeter.ch>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Brandon McCaig <bamccaig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 23:23:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaApV-0001No-Ca
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 23:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbaDOVXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 17:23:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbaDOVXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 17:23:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CDC57C40A;
	Tue, 15 Apr 2014 17:23:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tgtg7uK9CjRjclGUiGIo2HNXOvU=; b=t4qcaR
	Gs+pluEZFg21VRxLWErr+gJmL4Vw+JvVi7KQZg+JZx6psypPd7UklAXl2ghhh5GC
	vYDR6tU5rbkbSdVgSCgjDu+oEHlCnHUtF9U64VznnXFCUw3npCDzlw5thS5f0eM9
	Y/Dm1ziiMeVwXgzFjoHn2xrBQp/hesf7adn28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uTq6fICshcx3FxX2ojLnfYJWkxBHiZBT
	dOjp/q/FZRW7TzHN9ZSeaFUI/XhoQ1O3E3LFDSfYVDc5bxbuYBVgqmrbbxhgf5MX
	AEkIhxrS5XYciJXYmxnJzj4JRHF/JLwxHzc3JlfV4A5/fmqsg+f3nWAHb6mIzNVb
	SJQt3dvvLLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27D067C408;
	Tue, 15 Apr 2014 17:23:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11DE87C405;
	Tue, 15 Apr 2014 17:23:36 -0400 (EDT)
In-Reply-To: <CANUGeEYoS+t57jfpEoZE-2u_cD1uOD5pdp=yF--Rhpb9z91qxQ@mail.gmail.com>
	(Brandon McCaig's message of "Tue, 15 Apr 2014 16:12:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3513AFEC-C4E4-11E3-AE61-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246302>

Brandon McCaig <bamccaig@gmail.com> writes:

> That is for your benefit, and for easily sharing that configuration
> with collaborators. Git only cares that the file exists in your
> working tree at run-time.

It is a lot more than "for sharing".  If you made .gitignore only
effective after it gets committed, you cannot test your updated
version of .gitignore is correct before committing the change.
