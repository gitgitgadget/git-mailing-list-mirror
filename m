From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Thu, 19 May 2016 10:03:28 -0700
Message-ID: <xmqq1t4ykmjj.fsf@gitster.mtv.corp.google.com>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
	<20160513103621.GA12329@dcvr.yhbt.net>
	<xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
	<4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
	<xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
	<5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
	<20160517121330.GA7346@sigill.intra.peff.net>
	<DD9F360B-78F0-4C83-B642-606688772E39@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
	Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, spearce@spearce.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 19:03:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3RMI-0002jo-Ah
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 19:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbcESRDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 13:03:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754640AbcESRDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 13:03:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 107771DAF8;
	Thu, 19 May 2016 13:03:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qK4OY00uC/7d+/Vb6BPUVlF2/CU=; b=EkXUV3
	3R7/YwyrPQ5C2CFYy4+s81gi1QtpENT5V8pJyx/w84OfgvXLqwvgxqn9jii6GeaH
	W2D9bjvpaK/2meOfKO4FJ97BkTWgLGXrmt/PU0Kr7KY8e39ArEnj6BD8zfSvTV4+
	YROUQIJkAqqT4RUdOdNkWI4blWK11cq7/wBJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KAVBfKRCrvoSw51YIW1BKOAW+dcqzkQF
	OT6lYPTwACWtJT0OiyCg4wk8YcYOwT4ssgkqdXUxfmekdRHOE+FxAYKk7TQz6Vrj
	VXPrpPXZpg2de9YffsY0ldt3xl6sSLjtBbQcEMMmK3eKRDlu+Er0zPURNPk5/nNN
	+Khgg6kRSDM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E904D1DAF7;
	Thu, 19 May 2016 13:03:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50F551DAF5;
	Thu, 19 May 2016 13:03:31 -0400 (EDT)
In-Reply-To: <DD9F360B-78F0-4C83-B642-606688772E39@gmail.com> (Lars
	Schneider's message of "Thu, 19 May 2016 10:19:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D3C9110-1DE3-11E6-922A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295075>

Lars Schneider <larsxschneider@gmail.com> writes:

> From my point of view little packs are no problem. I run fast-import on
> a dedicated migration machine. After fast-import completion I run repack [1] 
> before I upload the repo to its final location.

How do you determine that many little packs are not a problem to
you, though?  Until they get repacked, they are where the
fast-import will get existing objects from.  The more little packs
you accumulate as you go, the more slow fast-import's access to them
has to become.
