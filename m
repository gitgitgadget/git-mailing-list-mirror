From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC_PATCHv4 1/7] git submodule: teach `add` to label submodules
Date: Tue, 22 Mar 2016 15:34:13 -0700
Message-ID: <xmqq7fguf8gq.fsf@gitster.mtv.corp.google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens.Lehmann@web.de, sschuberth@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:34:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUsZ-000307-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbcCVWeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:34:18 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752981AbcCVWeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:34:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B35A4EA3F;
	Tue, 22 Mar 2016 18:34:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cIlgjnSpV9OsAMavLjiE77mixa4=; b=QHXmPM
	cvi39zSgtGFj2Euy0mj577vskUUOS1WR1SdU+aV9a0wVLAuQe7Wzra4m8ceLT0B1
	g8Dfrt0DXLhVbv1u0HgaLtSoE36Etjt7dI/x0WE3MgGYyBAFg1MufaVHf2a7Zs5N
	LJFGhi7EgAHVtAZl/pyp39EPE1FPazHauhDaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p0O3oWOG2ZLxk0GUH4A9gK58s0PXGrK4
	UPGjjDpjxQ3Hu/UCy57CGGq2kB/rB9+XfIubt8YtaXRV6TcBcfPmA68Q62Ynz/Lr
	xF3XSasoyCUwq3/PZExu3xyD/Ufsh9MNeGsePegSMamgb3qSeiI4nwfPTn+SoHWR
	zwrgOsJBRw4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 332814EA3E;
	Tue, 22 Mar 2016 18:34:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 987084EA3C;
	Tue, 22 Mar 2016 18:34:14 -0400 (EDT)
In-Reply-To: <1458612372-10966-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Mar 2016 19:06:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34C302DC-F07E-11E5-BF07-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289581>

Stefan Beller <sbeller@google.com> writes:

> When adding new submodules, you can specify the
> label(s) the submodule belongs to by giving one or more
> --label arguments. This will record each label in the
> .gitmodules file as a value of the key
> "submodule.$NAME.label".

Having an ability to add a label when adding a brand new submodule
would be a "nice-to-have" convenience feature, but I think it is
better to start a series to add a new concept by "need-to-have"
infrastructure that is lower-level.  E.g. "git submodule label"
command that allows you to things like:

 - query the labels on a given submodule
 - add a label to a given submodule (or to a set of submodules)
 - remove a label to a given submodule (or to a set of submodules)

And with that, the user can start using the feature without having
"git submodule add --label".
