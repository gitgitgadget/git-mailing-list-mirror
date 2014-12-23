From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 13:17:03 -0800
Message-ID: <xmqqmw6e12y8.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
	<xmqq38878gao.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
	<xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
	<xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
	<xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
	<xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231829020.21312@s15462909.onlinehome-server.info>
	<xmqqwq5i2qtl.fsf@gitster.dls.corp.google.com>
	<xmqqsig62q78.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231911470.21312@s15462909.onlinehome-server.info>
	<xmqq4msm2o1n.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412232109120.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 22:31:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3X30-00026d-Te
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 22:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560AbaLWVbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 16:31:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754691AbaLWVbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 16:31:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D79E42AB52;
	Tue, 23 Dec 2014 16:31:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5aqP/76cbPhXXG+tr8IYYZxz7sU=; b=DVDla7
	reZxGAuiIIJ/+7QP4dqA/ljJxIDA0JeMdp5ypqrlnncTqUQ3XM8PiwMfAO1VrlVt
	RZ33c2fApRWzFIgerdJ0eS34by/GfKEUMh1B9J6M8f6gbsIjAP7GsHgb5YlqOKLs
	xBDLgvyN5402nJk2t+vaLvR4cZLCuUmAGnzo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QywncDyVmL4FcifpPH/yCTIgX+CTpKIX
	3yjh2GYURBjqaVFy2M6EMC6Wqobh5is1HxrVhupSqKGTMCZwE9dqBUsNxKI3Ijbk
	MAFgcroyMTHBYKPTN8letJDFEi8Kv5RAFPzc1iaudlc4R0yeeRYIJxeXW3Zv2zVt
	F8CTIuyBuro=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB9832AB51;
	Tue, 23 Dec 2014 16:31:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF3212A87A;
	Tue, 23 Dec 2014 16:17:05 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412232109120.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 23 Dec 2014 21:12:06 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0BCC8B4C-8AE9-11E4-9060-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261777>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Unfortunately, I will not be able to submit v2 of this patch series this
> year, but I will do so in the second week of January (including the change
> to the global array with the default severity levels because I do want to
> see this feature integrated).

Heh, we are not in a hurry.  Enjoy your holidays.

A happy new year to you in advance ;-)
