From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git + mod_auth_kerb
Date: Tue, 22 Jul 2014 10:00:22 -0700
Message-ID: <xmqqfvhtgwgp.fsf@gitster.dls.corp.google.com>
References: <CAPYmS35cgcEOfKvT17tULYyxL5GgXBavkD6anhV6yJtdoXVE9Q@mail.gmail.com>
	<20140721231721.GB5616@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Francois Bouchard <jfbouchard@accedian.com>,
	git <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:00:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9dQa-0001F2-J8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 19:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbaGVRAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 13:00:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60247 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620AbaGVRAb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 13:00:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2822329E75;
	Tue, 22 Jul 2014 13:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9JMM67OTemmtIskdv8aUcqDKVRQ=; b=PWTkMS
	rAz+MP4UMwEJhMHHhNkAn/LxHYg6BsyggTLwcZcw7jgh8xUMphMEXXo5uoRGetFx
	AcxS6df/7tQjao4EsDz7b9olirDxLcUphf9HTtZl1ZLCzPMAtfj+FSRR7lNlF7C2
	ons9QRKitf7dyJBNkbczko0ujnspNLe1q2+ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DtzFFyzQzFulu4x9cKnCeIzkebiahd4b
	fHzAmBXvZYHJ2yDr/BdBrzhc60RLriO7Q+EMyVYEM8VMdqjQTAcNpYO6/1/Yzli/
	k90rLV8vrU6DYoxciLHUKi8e8j1hw+wUocnb5foLlhVc1iFU8Z9i6YF37fjH2Z2U
	6XThlrJi+C4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B66029E74;
	Tue, 22 Jul 2014 13:00:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6C2E229E64;
	Tue, 22 Jul 2014 13:00:24 -0400 (EDT)
In-Reply-To: <20140721231721.GB5616@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 21 Jul 2014 23:17:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC4699E2-11C1-11E4-A6E9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254022>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> So git uses libcurl with CURLAUTH_ANY.  In order for authentication to
> work with libcurl, you have to supply a username.  If you specify it in
> the URL, the libcurl realizes that it can use Kerberos, and goes on its
> merry way.
>
> If you don't specify the username in the URL, git notices that
> authentication has failed, and asks the credential store for a username
> and password.  git does not know that a password is not needed, so the
> credential subsystem prompts for one anyway.

Hmmm, does this hint that we might want to be able to tell the
credential subsystem that it is sufficient to have name without
password, or allow the credential subsystem to say "I am giving you
sufficient information" when it returns only username without
password?
