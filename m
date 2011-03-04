From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 04 Mar 2011 10:41:59 -0800
Message-ID: <7vaaha7mo8.fsf@alter.siamese.dyndns.org>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
 <4D700469.7090807@gmail.com> <7vhbbj93yb.fsf@alter.siamese.dyndns.org>
 <AANLkTin8Gnbyji4sz6cnWLcAzC2RAS_wnd_o3avDvsvG@mail.gmail.com>
 <AANLkTiksQg1U=uAEVJG8fyjd7HpsTqgBOdyh6wrEMSED@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:42:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvZx9-0001LC-P3
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 19:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454Ab1CDSmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 13:42:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428Ab1CDSmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 13:42:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CDAC4C02;
	Fri,  4 Mar 2011 13:43:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HAF+WOiLfKSKpUJPb4i2qEspzlo=; b=LbS0/S
	T0XjcBVldZ8jLpuRsJyxbN/MxRLb9I4a/VwV/VRG0QT9+lljTE2+5j3nThHFm2F7
	t4MLoTyU+6NGoEfI3ltsTrpj7jQYlpoTGYp0ce8A0fzfBoSlF+2gQMH4wcEYe3VQ
	cuMrvHHg756bkur9a4ibre8BtkooJHNYteLmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tu6S0IcDMKfhQ0kYiDJcr99YUCx+eIdg
	Bv2CDk7RXj8q/AWJfXcZ3nZCfEdvDeZZYPWQazb8xEekrFdnGpa9wzgspeqOLYhT
	QBpOd0xewulKpiTN0Ar4UGESrBS0E8UuT/TIN+K10bY7deOGn/oLPJmAGWjsTkvW
	k9tz+nVNqs4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 489A64C00;
	Fri,  4 Mar 2011 13:43:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36E4B4BFB; Fri,  4 Mar 2011
 13:43:23 -0500 (EST)
In-Reply-To: <AANLkTiksQg1U=uAEVJG8fyjd7HpsTqgBOdyh6wrEMSED@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 4 Mar 2011 19\:26\:16 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B880556-468F-11E0-A43C-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168458>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> It's actually good that path is prefixed by gitdir. I imagine once
> superproject is supported, .git file in subprojects will have another
> line
>
> supergitdir: /path/to/superproject

No.  On a platform with usable symbolic links, you should also be able to
solve "this version of the superproject has the submodule, but that
version does not, and we checkout the other version" with symlinking .git
without using a gitdir file at all, just like we can use .git/HEAD symlink
to denote the current branch.

Also, gitdir file is not for sole consumption of the submodule feature.
Keep separate things separate, and don't try to tie unrelated concepts
together.
