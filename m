From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 03 Jan 2010 23:14:31 -0800
Message-ID: <7v4on2pciw.fsf@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 <7v7hs09tpi.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <7vhbr2pcsh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 08:14:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRh9Q-0004Nv-GG
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 08:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab0ADHOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 02:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286Ab0ADHOs
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 02:14:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab0ADHOr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 02:14:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A92D8DA49;
	Mon,  4 Jan 2010 02:14:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oaBrU+yHlTIQjkb5rpj1kQBWbuY=; b=rnTgfG
	5Adl20COLz6MxjQ/fi2plu/oo8XVY9Xf4IIG4i2IuoYekcLMopJUIGeuYm/oLCL1
	OYOOVGf9LQ4PvuplH9CVOsJv3zxX86V3jdTBYmNG6KLTHlh5av4E7iVXEVVHjkZg
	dZsjZZZM6HFrBg2jX7t6jMhS2sHKbjPPlUmNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nKW7MPi49W49IFnGBeoxxmSYzmsKnyEt
	IUpAZz/kG4NhzaTtX4WuGzhDhhA2JzsqJlDBMs+7+qx/LCUD1onDgC3O7rnafp5M
	RhZCznJMEagSCqai/nVBWiiW/4KqAVupvEVtdq+JkZCIxvEMMu/fkJCprEklKGE0
	9OGQdxGzCkQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AB258DA48;
	Mon,  4 Jan 2010 02:14:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 992C78DA47; Mon,  4 Jan
 2010 02:14:32 -0500 (EST)
In-Reply-To: <7vhbr2pcsh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 03 Jan 2010 23\:08\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2958772-F900-11DE-ADF0-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136099>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I have to wonder, though...did anybody ever actually profile our
>> internal grep to find out _why_ it was so much slower than GNU grep?
>
> I vaguely recall that somebody fairly competent mentioned that modern grep
> implementations are based on DFA engines, but I offhand don't remember if
> the discussion had concrete numbers.

I found only this one.  The author was indeed somebody fairly competent.

    http://thread.gmane.org/gmane.comp.version-control.git/23798
