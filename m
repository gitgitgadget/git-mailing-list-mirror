From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without
 pathspec
Date: Sun, 06 Feb 2011 21:58:10 -0800
Message-ID: <7vsjw0v11p.fsf@alter.siamese.dyndns.org>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu@a-pb-sasl-sd.pobox.com, "Moy <Matthieu.Moy"@gr.pobox.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 06:58:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmK7M-0003Y7-0Y
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 06:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab1BGF60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 00:58:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab1BGF60 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 00:58:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 959462259;
	Mon,  7 Feb 2011 00:59:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ehYtvY+h5Dao
	p0GKhNkvQUplYNM=; b=h5WAeJ9aTKjae8s1F+N2xI70ljZquGNppQTjDMsZxcAE
	Q5Ld3qpQGJbVqVr/Sdc92Jh+VuKwD5VB4mxAoVW/rTxyUxHh09PqttzsJPhc8bDm
	wBUqpTvaEAlnHqqjAuHusVBDebuBHwb8bsHmgc2Q4904z88YsDwqHMF+qwOyyYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TU7oJE
	3jRsdo81gaVJqne8Q/9vWInPmwPBQHJ00UQ9R7uVckM8/iWTOOnhsiucI3iO2CY/
	A9hHwdFvlv+fGTqpMPuZk0JHFA8rJI7qTlgdj1S2QgguUp38XhpEX0Sljh+FMyy1
	aar5sNSBqphIe9ae1+eU/XLD3PRwIWObYXlYo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CDF52258;
	Mon,  7 Feb 2011 00:59:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 738A62256; Mon,  7 Feb 2011
 00:59:09 -0500 (EST)
In-Reply-To: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\,  7 Feb
 2011 09\:27\:23 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 65D90BD6-327F-11E0-BC28-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166233>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When -u was introduced in dfdac5d (git-add -u: match the index with
> working tree., 2007-04-20), "add -u" (without pathspec) added
> everything. Shortly after, 2ed2c22 (git-add -u paths... now works fro=
m
> subdirectory, 2007-08-16) broke it while fixing something related.

As long as the command takes pathspecs, it should never be tree-wide.
Making it tree-wide when there is no pathspec is even worse.

If "add -p" does not limit operation to the current directory, probably
that is the inconsistency bug to be fixed.
