From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Faster git grep.
Date: Thu, 25 Jul 2013 18:28:50 -0700
Message-ID: <7vhafi3y99.fsf@alter.siamese.dyndns.org>
References: <20130725182905.GA7664@domone.kolej.mff.cuni.cz>
	<7vli4u4bkm.fsf@alter.siamese.dyndns.org>
	<20130725213100.GA28551@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Jul 26 03:29:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2WqE-0001jI-9s
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 03:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab3GZB3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 21:29:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757016Ab3GZB3E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jul 2013 21:29:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7554427BF9;
	Fri, 26 Jul 2013 01:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Yj08Z4y65o9X
	KP1yNmWrjmubVv8=; b=O8EpKdtWJ4RMUayTre92y4YKvWuCAz6nTFBp3+c1v5Dv
	tE3+MucLu/gyLqWeLJt9oWlY73OvUf1iREoYhWKJOGf0L6Aus7LYg5UH+moPtqpb
	lAt3RBlKXZto+nj/Ain5Zc8+DSZvjnqwd39cVT359r+x+Rv/04C3s6dywGEX7RU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iWgCaO
	ZxNm+DzV6UP6ee9FKU2vhmx42KnJfM+AuwBmfr+IuvD47ltH+5dU+6l3kieuCZRs
	T3FhrTUhW/UiRvZaq8N/J/WFeyXTO+oeJbuOs3SXiucY97hYeAnlDn8xyh8WpC9t
	TiaqbmR2tu/Q7KhqwLQap2uYZ4g4H+ttpGLIQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67CB427BF8;
	Fri, 26 Jul 2013 01:28:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB18927BF2;
	Fri, 26 Jul 2013 01:28:51 +0000 (UTC)
In-Reply-To: <20130725213100.GA28551@domone.kolej.mff.cuni.cz>
 (=?utf-8?Q?=22Ond=C5=99ej=09B=C3=ADlka=22's?= message of "Thu, 25 Jul 2013
 23:31:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA796298-F592-11E2-A2F0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231156>

Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> writes:

> If grepping random commit in history is important use case then keepi=
ng
> db information in history makes sense. Otherwise just having database
> for current version and updating it on the fly as version changes is
> enough.

Will you reindex every time I do "git checkout next; git checkout
master"?
