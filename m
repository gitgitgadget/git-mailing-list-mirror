From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 10:56:04 -0800
Message-ID: <xmqq4msm2o1n.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Ucv-0005KX-LU
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbaLWS4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:56:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751403AbaLWS4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:56:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 891D5293DC;
	Tue, 23 Dec 2014 13:56:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gehigKt5aaaeOamPDESrpjRyLcI=; b=Th8Z9l
	JU/PpJ7pTou7+uQVY5DoxwvXBEmQiq+Fgb8QuzecWorNYMgHWIl/TyJtj4wmLSy2
	TcXR62ZwREKX3vrTdKBa/NXxiPPxva2MVJ3GkeQbA6z6or9xI5T2iuPlA6I3LDYC
	3FoecpGKwyYA+y5VFZ7mduhGbqlltv6o4CyDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NmT7JbWKOfryDygyPVOONOefsLOnTkWx
	6lV0DynFtKIe4aMEX/BXsfydBpH6PePOH5FMnUkFqMKkFQGYkfyc8XAG5rjqvNU/
	R0INfCifqzxd14meAId5p4gt7dMo/Ie8+xDJY5F8rMr0MjVy02N51ZEAEHSWEg0M
	6fn+gRzwWOI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EAC6293DB;
	Tue, 23 Dec 2014 13:56:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0890E293DA;
	Tue, 23 Dec 2014 13:56:05 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412231911470.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 23 Dec 2014 19:14:56 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 59656388-8AD5-11E4-8BED-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261765>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 23 Dec 2014, Junio C Hamano wrote:
>
>> Having said that, I think "missingTags" etc. should not be configuration
>> variable names (instead, they should be values).
>> 
>> Because of that, I do not think we need consistency between the way
>> these "tokens that denote kinds of errors fsck denotes" are spelled and
>> the way "configuration variable names" are spelled.
>
> Okay. That makes more sense.

I am sorry that I didn't step back and think about it earlier to
notice that we shouldn't be talking about configuration variable
name syntax.  I could have saved us time going back and forth if
I did so earlier.
