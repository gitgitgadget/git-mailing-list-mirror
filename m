From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/22] argv-array.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 13:49:40 -0800
Message-ID: <xmqqwpqavrwr.fsf@gitster.mtv.corp.google.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
	<1455194339-859-4-git-send-email-gitter.spiros@gmail.com>
	<xmqqd1s3vuhy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:49:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTz7T-00022J-9h
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 22:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbcBKVtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 16:49:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751548AbcBKVtm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 16:49:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4ED2440229;
	Thu, 11 Feb 2016 16:49:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=egdCjVbPr5yGW1HJQYR/BuObvnQ=; b=vnPOTq
	EkaagGkOVVvlt2njpP2mS798vHTWHpmQW3sWMJV6ur6MjrSVRIg4MLPTv86AbJqR
	Hvw0yIXfHHnB+h4WOxA7SB6E/zBm5Lt4eNvXetTKuo+C71K8xoo363TDo2XEz8gU
	Mq2pqcOASJ5+zomtBq9PS8aXVdMdUyX+FRBbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W86ff10Rh61n1aKZgq03EqxJYz+dH69f
	Y6Q/7A5VgF27oh4xmAJcQFgPtaMbzSysSIr06a52dZOA+I9BRUWlb7JAFZho9Q6Z
	TnEb3iWOrEYX5HVScqQduPgWoTyZ7fw50WpJZgYKDURAuUFsB9ozVimLuNWGhxWV
	6q3qiF3RvhI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4381340228;
	Thu, 11 Feb 2016 16:49:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B446B40227;
	Thu, 11 Feb 2016 16:49:41 -0500 (EST)
In-Reply-To: <xmqqd1s3vuhy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 11 Feb 2016 12:53:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B129E82-D109-11E5-90F7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286006>

Junio C Hamano <gitster@pobox.com> writes:

> OK, this may answer my previous question.
>
> It might be pleasing to the eyes when these two macros appearing
> together in all CAPS, making them look similar and consistent,
> perhaps with two more tweaks:
>
>  - Imitate LAST_ARG_MUST_BE_NULL and spell it FORMAT_PRINTF;
>
>  - Consistently have SP after comma, i.e. FORMAT_PRINTF(2, 3),
>    or to make it obvious that this thing is a special magic, drop SP
>    (i.e. this patch would stay the same but some other patches left
>    a space after comma, which made them look more inconsistent).
>
> Thanks.  I am not 100% sold on this yet, though.

Regarding the second one, I misread the patch series.  You
consistently drop space and make the result FORMATPRINTF(X,Y).

I was fooled by the inconsistent original text, some of them using
__attribute__((format (printf, X, Y))) while others saying
__attribute__((format(printf,X,Y)) and some other variants.
