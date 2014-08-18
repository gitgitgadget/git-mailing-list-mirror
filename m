From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Mon, 18 Aug 2014 09:34:16 -0700
Message-ID: <xmqqppfxycxj.fsf@gitster.dls.corp.google.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	<1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
	<xmqq8umt5z8i.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFcJ5FFeJP=0-oG59fs=3ztenoPOGWOZKfZDdHpLGOYeA@mail.gmail.com>
	<xmqqiolw2dqc.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFJiUt1p_OfefswS8O8_BA6mQy=PStmYyNw=ABZCOQprQ@mail.gmail.com>
	<xmqqmwb5zatx.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NEE0d_5Vj3MSGEJCtFBFOe75Rb+q9fk7q1YC-WcvAMb4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 18:34:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJPtC-0001OS-K7
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 18:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbaHRQe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 12:34:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56332 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbaHRQe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 12:34:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2E2430C24;
	Mon, 18 Aug 2014 12:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u4JPr7gbsUKP2AV+vbUnpIIaQ8g=; b=vEJePw
	eaqGUYzqIU71GKQxEVuENuk9AT8VI2g+1NV4yvds4iCFVV6GChoeXkPlcisYJfnx
	IrY6hnIkIssQg7EpFgioNiWr5dzgZRTcEDTlJm+VbKLaEI/QqpT7COz3+FVbPHss
	a/GgnPS+arGlroZ5+CgFFWj7wEerHcaI2+/mU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V9pU9Jj7BfGdVDHLdXT1CatStLosqOAc
	Cc3AGo1EQe2TGtyLdBqxnDu2F4lN3xbzWWj4m9JIulAZg7CNjgOaq/bqNBrhm1Ox
	1uIH+ZSySbqZ+mH9sKIM3ef/tRWTfqiY0NKy9yCKls9n0wiX6csa3g4YjKvBpytW
	125Ni+D/XKQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 967F030C23;
	Mon, 18 Aug 2014 12:34:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2EECC30C18;
	Mon, 18 Aug 2014 12:34:18 -0400 (EDT)
In-Reply-To: <CAPuZ2NEE0d_5Vj3MSGEJCtFBFOe75Rb+q9fk7q1YC-WcvAMb4A@mail.gmail.com>
	(Jaime Soriano Pastor's message of "Sat, 16 Aug 2014 16:51:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7FDD4A56-26F5-11E4-B471-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255396>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> I'd like to add some tests too for this, but I don't know how to
> reproduce this state with git commands only, is there any way to add
> entries to the index without checkings?

Perhaps feeding "update-index --index-info" four input lines would work?
