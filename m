From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] builtin/interpret-trailers.c: allow -t
Date: Thu, 07 Apr 2016 10:30:02 -0700
Message-ID: <xmqq60vt1g4l.fsf@gitster.mtv.corp.google.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-2-git-send-email-mst@redhat.com>
	<xmqqr3eh1hq6.fsf@gitster.mtv.corp.google.com>
	<20160407202631-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:30:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDl9-0005qI-LB
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869AbcDGRaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:30:16 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751440AbcDGRaP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:30:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2B7152BA4;
	Thu,  7 Apr 2016 13:30:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ltOum4+zbAICmiM1yen6YU5yhGs=; b=i4YlKu
	FQipS6bxLKZScUdwld2FFfDzjsL/54a7u3JMz3AKtd8TxOORmoWrK8Nox2Zuch6U
	bgDtiyBt2FFHvvN6G1SdVM55KoUgIk7Rp8Ay6Y5YT1m6bjNx2gw5zfiQEcN9sI4z
	kO/t4lJHsKZTwHz7jaonGlTc8lu8K5wUQJfKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mk0Kd8t9P91dc7pICIA5eCMGcp4NY0f6
	XhLxLoh6hIlHfEbzjWG7wrrXBnqkMFIFnAMZMoktDHYkmmaaeFwpLiS3MKPqrnOE
	S29/bIFRrCJj1oD4s3rGFeofGiL4KTiLYPyue6TPUkhUcgVYY5hRQ1czCRm8O8pR
	UNrlwEIQFIc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A42A852BA2;
	Thu,  7 Apr 2016 13:30:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4EA5052B9F;
	Thu,  7 Apr 2016 13:30:06 -0400 (EDT)
In-Reply-To: <20160407202631-mutt-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 7 Apr 2016 20:28:32 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E891934-FCE6-11E5-9189-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290935>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Apr 07, 2016 at 09:55:29AM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > Allow -t as a short-cut for --trailer.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> 
>> As I do not think interpret-trailers is meant to be end-user facing,
>> I am not sure I should be interested in this step.
>> 
>> I am in principle OK with the later step that teaches a single
>> letter option to end-user facing "git am" that would be turned into
>> "--trailer" when it calls out to "interpret-trailers" (I haven't
>> checked if 't' is a sensible choice for that single letter option,
>> though).
>
> Does OPT_PASSTHRU_ARGV handle this transformation for me?

As I wrote in my response to Matthieu, PASSTHRU_ARGV is one thing I
specifically do not want to see used in this codepath.
