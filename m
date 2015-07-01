From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] pack-protocol.txt: Mark pushee field as optional
Date: Wed, 01 Jul 2015 12:08:47 -0700
Message-ID: <xmqqtwtn8zls.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-7-git-send-email-dborowitz@google.com>
	<xmqqbnfvaeqk.fsf@gitster.dls.corp.google.com>
	<xmqqy4iz8zon.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:09:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANNb-0007mV-OW
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbbGATJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:09:04 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35167 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbbGATJB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:09:01 -0400
Received: by pactm7 with SMTP id tm7so27256907pac.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HIF/287rE/gLDcAR/Oo1KADJQA2kVCDLuFgDz6FccHs=;
        b=kKpc21RF6npAfvJ2r9yRHfIZukt4kW8OzRB4ajR2MTKqqNbHxvN6y2ssLc0dnBr/vw
         U1Al3uXY8UedXnJf1H7Xf6Mh/zY40BDs2PmLZpFbLcnYP8lgXyCyyI24j83DxjuVH+OC
         zXzhaXrQ+NtxRQguOmlby+jM3R1uexRkY1Nqpo5VQnT7d+VvSfkpvQC6nK7nSDmfQTwM
         /Y2UTRmDQM8TFxi37oqAbQoQ+B/zK0+sjan7yPnocLx4Brk8W5hZd6viGzEcA/ViVZS7
         YCnTtgoQbkWLfTH1d67tOxrSbidLE2FIXt3zziVhbgjwFciWyYPfW05scT1Oa9+E4Ac1
         /voQ==
X-Received: by 10.70.96.139 with SMTP id ds11mr57692209pdb.98.1435777741128;
        Wed, 01 Jul 2015 12:09:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id pj4sm3093143pbb.29.2015.07.01.12.08.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 12:09:00 -0700 (PDT)
In-Reply-To: <xmqqy4iz8zon.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jul 2015 12:07:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273187>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Dave Borowitz <dborowitz@google.com> writes:
>>
>>> send-pack.c omits this field when args->url is null or empty. Fix the
>>> protocol specification to match reality.
>>
>> Do some clients omit this in the real world?
>>
>> As you say, send_pack() does omit it if args->url is null or empty,
>> but args is prepared in transport.c as a copy of transport->url when
>> the function is called, and that transport->url is how
>> builtin/push.c reports where it is pushing with:
>>
>>    if (verbosity > 0)
>>        fprintf(stderr, _("Pushing to %s\n"), transport->url);
>>
>> So I am somewhat puzzled...
>
> Answering myself, the most trivial example is "git send-pack" ;-)
> It passes args that has a NULL in the .url field.

... which may be something we want to fix, but that does not mean
the field is mandatory, as we have implementations in the field that
do not send it ;-)

The patch looks good.

Thanks.
