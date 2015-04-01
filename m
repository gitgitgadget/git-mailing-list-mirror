From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trying to push into empty repo, get fatal: bad revision 'HEAD'
Date: Tue, 31 Mar 2015 17:00:59 -0700
Message-ID: <xmqqego4ogxw.fsf@gitster.dls.corp.google.com>
References: <CAHkN8V8cpZUmCi6=MUcsCOCBe6H_G6btr6WaV2vVrO1Nm_r4tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Samuel Williams <space.ship.traveller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 02:01:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd65k-0001JV-N2
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 02:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbbDAABE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 20:01:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751668AbbDAABC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 20:01:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94EA24584A;
	Tue, 31 Mar 2015 20:01:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L0WLJV+sfbuhH+TIZvBtfd6eEO8=; b=U8dB4V
	2omY41PoCf+CROVTlH5uRzc6ILb8K6NSOccYH/ClHyJAnIJdSyqogifgRArNYQUD
	L/bhUmxCM6FbP5IuZAeNtkXLHiRFySP5bgMXhg6vUDFjbFW+O1Ci4Cw7jetRFr9E
	dP4WkEfSCjtTw+V/2KpEwCLe1sFQOEvgEkraQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cwtnXhZqW6na7pV8gscpu7BKbiNLj6e5
	vVGBJFcwf79O841cb4IxEg8XsX4LZIgK/pjSOZSNFM3+/h6w6WzfiZJZus7/gi11
	JN2VcATqJLesVA/mqeSQRitol1ErE3pxXWYvUmWFak/n6Yi51b/DYHlQgdN8kXpf
	ErPt1Y5YpvA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E8C345849;
	Tue, 31 Mar 2015 20:01:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0735645846;
	Tue, 31 Mar 2015 20:01:00 -0400 (EDT)
In-Reply-To: <CAHkN8V8cpZUmCi6=MUcsCOCBe6H_G6btr6WaV2vVrO1Nm_r4tg@mail.gmail.com>
	(Samuel Williams's message of "Wed, 1 Apr 2015 12:29:20 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E8E8FF2-D802-11E4-B710-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266585>

Samuel Williams <space.ship.traveller@gmail.com> writes:

> I would expect if you push to an empty repo, it would update it
> (because denyCurrentBranch = updateInstead).

Good finding.

I think the current implementation of updateInstead is set up to
bootstrap from an empty repository but only supports incremental
updates once the receiving repository and its working tree gets set
up.  But I do not think it was a conscious design decison to forbid
bootstrapping an empty repository, but was a mere gap in the
implementation.  At least, I do not think of a reason why we should
forbid it (and I am Cc'ing Dscho to confirm).

Fixing it should not be too hard, but I am on a bus right now so...
