From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase autosquash doesn't recognise a chain of fixups
Date: Tue, 05 Apr 2011 11:27:09 -0700
Message-ID: <7vk4f8mu4i.fsf@alter.siamese.dyndns.org>
References: <20110405154100.GC16031@bee.lab.cmartin.tk>
 <7v4o6cob4t.fsf@alter.siamese.dyndns.org>
 <B584DA91-1811-4976-A915-458672455DAD@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Notz <patnotz@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 20:27:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7AyN-00077e-GP
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 20:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab1DES1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 14:27:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1DES1V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 14:27:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B6AB42CE;
	Tue,  5 Apr 2011 14:29:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v2x3w9jsrbVng2HcGSC3EEwZuVU=; b=VJYPCW
	H3Kgq8VO9/RtA2e+po+S/QPsyV/lKx4FLAEOocPCIq4gMwT9buxOMq1y2yMzZekl
	G822CJNf/pPdfIZxPunKknlLnvCtjKqstJM88s0Ylu/fc9DzEXpPopyNsdVmpl2z
	ZuXR1AcAZDh0xZXL1yp+IsIa7yuc9IKeXD35c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EfBQKkf0OzjRSyd0nkXwXjzkuIydAvi5
	m5oQMWYUD7D+WfJPbuL7HA9e1Pr4zWrjAQqwPizih7MoIt9OqxApHWjBGkIW9T+u
	D1E99zeldBDCkV4h/C0j/pq2/d3Phulc39xZgMgO7Tw0HJuLHLHw8qzvyADCuIy4
	/KjeJcwGGDs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38F3742CD;
	Tue,  5 Apr 2011 14:29:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DBCA842CC; Tue,  5 Apr 2011
 14:29:03 -0400 (EDT)
In-Reply-To: <B584DA91-1811-4976-A915-458672455DAD@sb.org> (Kevin Ballard's
 message of "Tue, 05 Apr 2011 11:02:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98AE5D3A-5FB2-11E0-A1DB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170900>

Kevin Ballard <kevin@sb.org> writes:

> This seems unnecessary. `git commit --fixup HEAD` doesn't really make any sense at all to run when you can say `git commit --amend` instead,

What about this sequence?

	git commit -m 'foo'
        git commit -m 'bar'
        git commit --fixup HEAD~1
        git commit -m 'baz'
        git commit --fixup HEAD~1
