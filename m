From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 09 Dec 2014 11:37:23 -0800
Message-ID: <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
	<20141206020458.GR16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:37:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQbD-0000fR-Ei
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 20:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbaLITh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 14:37:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751099AbaLITh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 14:37:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB48224556;
	Tue,  9 Dec 2014 14:37:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JoiXTSH0jB8tmqFnYFwOT2TF0wo=; b=DyM+Py
	TBu6JjN4xCJ/PwCgzjikRMkL2PPcv8mn8CILHsck2AjtEegHZbt54ADiq2pzJrJU
	5pxZAtIGwi+zvnjvB46CcOtGW0I5daIoLxDzpqD6FmhlWqqiPRGFOQhI0kH8x2cv
	18okWmgsrqk/XXjELRK/51oOcKKPOBar0oaZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hfJ+lL26ltotr0JFqOhSAMisMUvylxiK
	GD7kCxDfoImHuKaOqbgm4hry6TIm71I3JcNMoAoIh4eLQrLvGAFwqBZkteVCJx6/
	ZKTd2eSfLICLyu3yKMzWsrCjLPPVoKJ5OQFhXe35X5k/0lLLu8bUBiNNldzPtw3L
	xNM/AClOefo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2D7124555;
	Tue,  9 Dec 2014 14:37:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67BF224554;
	Tue,  9 Dec 2014 14:37:25 -0500 (EST)
In-Reply-To: <20141206020458.GR16345@google.com> (Jonathan Nieder's message of
	"Fri, 5 Dec 2014 18:04:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CD71ECE8-7FDA-11E4-AF03-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261144>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +/*
>> + * Clears the string list, so it has zero items. All former items are freed.
>> + * If free_util is true, all util pointers are also freed.
>> + */
>>  void string_list_clear(struct string_list *list, int free_util);
>
> The api doc says
>
> 	Free a string_list. The `string` pointer of the items will be freed in
> 	case the `strdup_strings` member of the string_list is set. The second
> 	parameter controls if the `util` pointer of the items should be freed
> 	or not.
>
> One option here would be to say
>
> 	Free a string_list.  See Documentation/technical/api-string-list.txt
> 	for details.

If we later introduce string_list_free() that is in line with the
distinction between "free" and "clear" discussed on this thread, the
comment for this function needs to be fixed to "Clear the string
list.  See $doc". and that is not much different from "See $doc"
without the first sentence which is the function name.

Perhaps the API doc that currently says "Free" is the only thing
that needs fixing?  And perhaps add "See $doc" at the beginning of
the header and remove duplicated comments we already have in the
file?
