From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/21] Convert ce_path_match() to use struct pathspec
Date: Fri, 17 Dec 2010 07:09:52 -0800
Message-ID: <7vfwtwjv0f.fsf@alter.siamese.dyndns.org>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-15-git-send-email-pclouds@gmail.com>
 <7v39pxl10y.fsf@alter.siamese.dyndns.org>
 <AANLkTikKCU==mS5_TdqHstETj=CQ_deHMCJ4xW0r+Sck@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 16:10:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTbwm-0001cR-HK
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 16:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab0LQPKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 10:10:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab0LQPKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 10:10:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E07E2A87;
	Fri, 17 Dec 2010 10:10:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W83KQx+zJHI++wVd+Ejna9XIVLc=; b=r2Jh22
	9VEGcVWfw+uUdpTnXkZzEn5BBX+GJjAnPuSb2o7jXhWzFFOaZgSDnarBb9zuhDsp
	dRLc59pqxcWY2z5qPvTdLJvknegQo/23pXNxIGrhYqi2Sq2EncPhz29+R5K9i4rq
	RcGQadesnF29SATQx23I4/akNMXGZ/9gSBAWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nJfPz68Dm03pHDNWtlOf8szemVnYuKC9
	HySlTS/stKqLIRhnwp9QPW8dArm/sfjtwCMKJI0mCUDRBeQ/WCft9e5mGgfu3U9y
	99YncwUo7K0KRi9TWKIt0JLR1sKyVZqLl+6RivN87RnWxg+/umQNMXmYNbpaA+yb
	e/Mykw2sm08=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7893A2A83;
	Fri, 17 Dec 2010 10:10:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 99F3C2A82; Fri, 17 Dec 2010
 10:10:20 -0500 (EST)
In-Reply-To: <AANLkTikKCU==mS5_TdqHstETj=CQ_deHMCJ4xW0r+Sck@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 17 Dec 2010 16\:59\:52 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C563001A-09EF-11E0-AC2F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163882>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> I wonder if it makes more sense to change the type of revs->prune_data
>> from an array of pointers to strings to a pointer to struct pathspec.
>> Is there a downside?
>
> Converting a pointer to another pointer means mis typecasting can
> happen and the compiler won't help catching them.

You can rename the field at the same time, and the compiler will catch
anything you forgot to touch, no?
