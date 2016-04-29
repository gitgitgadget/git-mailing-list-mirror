From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/15] submodule--helper list: respect submodule groups
Date: Fri, 29 Apr 2016 11:31:58 -0700
Message-ID: <xmqqpot8xo4h.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-9-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:32:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awDCz-00055H-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 20:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbcD2ScE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 14:32:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750714AbcD2ScD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 14:32:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB0E515F27;
	Fri, 29 Apr 2016 14:32:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BHnkAex6IS8eJ8AsML71A+Fqy+U=; b=MylCjX
	ATQHd0G9X7Q0kuj7SnD7XjXvA1MEFGpTTPpJcGJHNZqNnfsuYbaWlR55MIuKqb3Z
	9KmeRlnMidcKedc3pGV+sA/XJ6Ts0LiyZNsrR82y5PpbHXV5miRi6sBm28W9pOR1
	Mn6DMQtsoXGquOCdBzVgMKQlTbrtFFH9BkdW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WWVV1NqHNw1ARzLkyJC8OP5M7PP8X34o
	XX06stPVNKacNhYsjnjzCtgXhpBEbiF7x712pjWHZ/TH06auuGEyZQaTZyCBFucv
	mnmaPwupKCbKdtn4Tr2I967ujOgy8+LMMDte+YbXuIM/4CKVs4VZf57gsHngDaa8
	oDv/7PNslpI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AEF7115F25;
	Fri, 29 Apr 2016 14:32:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DB1315F23;
	Fri, 29 Apr 2016 14:32:00 -0400 (EDT)
In-Reply-To: <1461703833-10350-9-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A96AC534-0E38-11E6-8956-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293042>

Stefan Beller <sbeller@google.com> writes:

> As submodule--helper list is the building block for some submodule
> commands (foreach, deinit, status, sync), also add tests for those.

The title is slightly misleading, isn't it?

This step only teaches the commands to limit the operation to the
defaultGroup instead of operating on everybody.  There is no
mechanism (yet) to ask for arbitrary group(s) from the command line,
which was my expectation of "respecting submodule groups", i.e. "the
only way to limit the operation to subset of submodules used to be
by giving pathspecs to match, but now a more general submodule group
mechanism can be used" is yet to come at this point in the series.
