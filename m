From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Fri, 15 Jan 2010 20:18:40 -0800
Message-ID: <7vljfyiswv.fsf@alter.siamese.dyndns.org>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vzl4frl7i.fsf@alter.siamese.dyndns.org>
 <7vfx66sz5p.fsf@alter.siamese.dyndns.org>
 <20100116090321.6117@nanako3.lavabit.com>
 <7vk4virjzh.fsf@alter.siamese.dyndns.org>
 <be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com>
 <7vhbqmn9c4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 05:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW091-0008Ob-Hk
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 05:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab0APESy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 23:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266Ab0APESx
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 23:18:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab0APESw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 23:18:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 142A19161C;
	Fri, 15 Jan 2010 23:18:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pt3Y9ilNzU+dwKBr7KmMLiZz8Wo=; b=VwGVPB
	JnQxkrZf58H2iZympCmcuYqgYZQbtsr3WGRlUXBATjo1NtdoO3SM9gUegtWPfPC4
	YrOW/wYOhegKFzA1GuwVizxqpNbR3WYZ7U2JPHwQUuzzO6Oz4L573yzfSzhhoY29
	n585fwIRkjQxj0lDuts4Y42JdMuOTySYsyuQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kjg2n07fiz9QwKQTgCaTnNZY7D7kO7Ns
	zZDlZ+0QIiR++zPGRLNEmHvn9l3/Xx/Mds+5AhcmfNvWZK4leR3i1jLZwu/L8thH
	jHYm/9aGTira7CN05wGXMkx7u1+yD1CAP1/sOAj/1Pxn8t++Xh9eWeDnam1E37fe
	ntjMe9jCR6E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C414E91615;
	Fri, 15 Jan 2010 23:18:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0E4791614; Fri, 15 Jan
 2010 23:18:41 -0500 (EST)
In-Reply-To: <7vhbqmn9c4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 15 Jan 2010 17\:10\:19 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E27B95C-0256-11DF-BE73-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137198>

Junio C Hamano <gitster@pobox.com> writes:

> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> After all, there's already the config called branch.autosetupmerge and
>> branch.autosetuprebase.
>
> Do you mean Ilari's patch already sets up branch.name.rebase for people
> with branch.autosetuprebase true?

I checked; the patch uses install_branch_config() so it should get this
right automatically.

I'll queue the v2 patch on 'pu'; we might want an update to move the code
inside "unless --dry-run" condition, but other than that I think what we
reviewed in this thread was pretty good.
