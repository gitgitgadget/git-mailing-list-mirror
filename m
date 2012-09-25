From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem completing remotes when .git/remotes exits
Date: Tue, 25 Sep 2012 16:43:59 -0700
Message-ID: <7vbogtvfb4.fsf@alter.siamese.dyndns.org>
References: <505A2330.9040800@kdbg.org> <20120925230045.GA13266@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:44:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGenX-0006YJ-Sw
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 01:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab2IYXoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 19:44:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab2IYXoD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2012 19:44:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 567838769;
	Tue, 25 Sep 2012 19:44:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5uYESg4H15Ze
	LvL9VDaC9C3lzD8=; b=DFe1vQrDcvxQP9z12cUL1Emt8bJDy8E9XWWjnWsthUJq
	o3tttdAn92KMzSsSa4dLmbpKFJG7W0mu+lEA7hZQXIKxefSWVb6XUDA6CdrBXhB1
	bz9bQwQ5pseJIbk6qmIGh7Z593sMRYWCPRGwN7L6ObBn61LOsRZYEgdtCbxukeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=p/LtTc
	FtwZCvNOGPpT74MUsFlvS05vsJDosJwrgBSimngdwo51+GUFPD7a47v6C75jGzWj
	WpkGvJ2suOFxWzQjZaxqusjqPTGgKhnJJy/OkHB8H+Fm/XTJ+2rOtY93jIOWPeDN
	KGkr4suVz7vXrxY/LX0rhOn9amlfA2atD10eU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 110718766;
	Tue, 25 Sep 2012 19:44:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 845998764; Tue, 25 Sep 2012
 19:44:01 -0400 (EDT)
In-Reply-To: <20120925230045.GA13266@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Wed, 26 Sep 2012 01:00:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E21531F4-076A-11E2-97A6-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206386>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> -	test -d "$d/remotes" && ls -1 "$d/remotes"
> +	test -d "$d/remotes" && command ls -1 "$d/remotes"

Yuck.  For normal scripts, nobody sane would define "alias" for
non-interactive environments, but because these things work in an
interactive environment, we have to protect ourselves from user
aliases.  Not just "ls", but "test" we see above may misbehave X-<.
