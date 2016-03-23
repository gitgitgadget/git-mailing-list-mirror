From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fix regression for deinit without submodules
Date: Tue, 22 Mar 2016 19:47:37 -0700
Message-ID: <xmqqlh59ewqe.fsf@gitster.mtv.corp.google.com>
References: <1458690134-538-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, cederp@opera.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 03:47:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiYpm-0001Tj-GP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 03:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbcCWCrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 22:47:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753525AbcCWCrl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 22:47:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE7AF4F3C9;
	Tue, 22 Mar 2016 22:47:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IkEE1U5ZZokatUj3/zpFRb8KC0o=; b=heDZk9
	V3PrAcfDROjnmwzp8z3xf/UeKZixG2wnq65XDIcFBoLFb3u1JQC/l2Mmws56b5Ex
	RKdhDXYotE+iUdwI3WgzvbV42qiNhBfvvOKvUlr7tQgvs9K8kwnRFqeW2lZvfOVs
	Wrarb89JtJkEOlYEfGbU6GtYO3P532yKcU/nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t/eLZoFj3jt9FPJRJVL+XnB0HM8dPEt+
	mHy2Prc4VMD30JuvQoS4qRXp3iyRUWSAhWO5+G0BUPKlDbu/sI26RHEMSokPBFcz
	FYDKjiHe+5K9Ifi5N/h4HDqBnNjl6L3PUurK5voAe0lO+g7RIkpLV8284p2VLn31
	02Xx9fG1hx8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C596B4F3C8;
	Tue, 22 Mar 2016 22:47:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A4414F3C7;
	Tue, 22 Mar 2016 22:47:39 -0400 (EDT)
In-Reply-To: <1458690134-538-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 22 Mar 2016 16:42:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B747F88-F0A1-11E5-815C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289594>

Stefan Beller <sbeller@google.com> writes:

> Per Cederqvist wrote:
>> It used to be possible to run
>>
>>    git submodule deinit -f .
>>
>> to remove any submodules, no matter how many submodules you had.  That
>> is no longer possible in projects that don't have any submodules at
>> all.  The command will fail with:
>>
>>     error: pathspec '.' did not match any file(s) known to git.
>
> This regression was introduced in 74703a1e4dfc (submodule: rewrite
> `module_list` shell function in C, 2015-09-02), as we optimized
> ...
>
> Reported-by: Per Cederqvist <cederp@opera.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Ok, let's try again. This is what I understand is the best bugfix for
>  2.8 and below. (This patch was developed on top of 2.7.4)

Thanks, let's aim to merge this for 2.8 final.
