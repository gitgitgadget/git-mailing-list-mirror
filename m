From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 03/16] quote.c: remove path_relative, use relative_path instead
Date: Tue, 25 Jun 2013 12:23:44 -0700
Message-ID: <7v1u7q3sfz.fsf@alter.siamese.dyndns.org>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<654b2387c27470c3dc81169e8f43c231aa9504ce.1372087065.git.worldhello.net@gmail.com>
	<7vhagn8gtz.fsf@alter.siamese.dyndns.org>
	<CANYiYbGvqHpQpp2UD0nBS5pqeimGE7yDMVYr7q9bGA0hSNNNDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 21:23:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrYqK-0006fD-UD
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 21:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab3FYTXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 15:23:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774Ab3FYTXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 15:23:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAAEE29C3E;
	Tue, 25 Jun 2013 19:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3XxIFGTeWxzlIMB4RND5kYCzkWs=; b=gq05Rb
	4PwqZhqa/xhg++yeQw/ByjvOcqYZcvVBF51ZGvraUHOSf6OtR3OjuRZYsTKpAwqw
	GBl3J6BQAeez76WGQBgf7wojd5QdSdP9baqHP3VsmXINisOX25/KwtXjBlD94W8J
	yQSWPane5vJn94CAySGXtk7xsbgLxcKmxIKvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tc1s9RobEPBtUiTTjnCigD9telfWoX26
	F/4toI6VqqoEuNwzl8cdtDZ5JP43k7QEhNWRISFtSJkuPylZxo55YB6oB8sAjwXm
	L7nUpO4N7KgUYbjQ+hvfj1aq2nqP42OhY0DVSU7Ooev5KWbj306XAj2JuzTdcJF2
	5wFC2WVAWlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1D0929C3C;
	Tue, 25 Jun 2013 19:23:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2694029C39;
	Tue, 25 Jun 2013 19:23:46 +0000 (UTC)
In-Reply-To: <CANYiYbGvqHpQpp2UD0nBS5pqeimGE7yDMVYr7q9bGA0hSNNNDw@mail.gmail.com>
	(Jiang Xin's message of "Tue, 25 Jun 2013 19:09:58 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C15CE644-DDCC-11E2-8FD5-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228984>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/6/25 Junio C Hamano <gitster@pobox.com>:
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>>> Since there is an enhanced version of relative_path() in path.c,
>>> remove duplicate counterpart path_relative() in quote.c.
>>
>> There is no nice comparison chart before and after like you had in
>> patch 02/16?
>>
>
> You mean drawing a table to compare output of path_relative and
> relative_path?

I was interested in comparison between the behaviour the current
callers of path_relative() gets, and the behaviour the same callers
get from the consolidated helper function after your patch.
