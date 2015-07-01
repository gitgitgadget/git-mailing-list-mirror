From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] pack-protocol.txt: Mark pushee field as optional
Date: Wed, 01 Jul 2015 12:07:04 -0700
Message-ID: <xmqqy4iz8zon.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-7-git-send-email-dborowitz@google.com>
	<xmqqbnfvaeqk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:07:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANLk-0006xN-5y
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbbGATHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:07:08 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36747 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbbGATHH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:07:07 -0400
Received: by pdcu2 with SMTP id u2so30920052pdc.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4OeMYC04FOSS4TiG1moaemMQy/LN03ZtsE5vy6QPrpA=;
        b=vSeasTxN4zApPtdUw7YOZ6H8z5o86zFImzwjRKm72E3DN/X21/GmzS7rhZhci6TEaP
         g5lH/EgViu0eA56DwAEoi7JsjXfkVAu69j/DzLI0hnaTPOK6f6c+LOBjv+i4CLR1Ps9u
         4lpgFO/POCCfaat9BbENiwj6OeiygGwlw/wCP8dAUBGuB3eOndD4oCCxNyZ9Zfp9x/yW
         +aytHT0E6v6bA8Bj4w1iApW2+UNA1Y1Sf4TiIulMjlseALXeQnjeS1nRtXWWd7SzSRna
         vU14lQKDayyPOKW2IDHWd2ymvBR60SOaGyB/P+N19roUyVPJqRVTuUAYpV62rimSamte
         UN3Q==
X-Received: by 10.70.0.71 with SMTP id 7mr45530839pdc.118.1435777626447;
        Wed, 01 Jul 2015 12:07:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id tr2sm3095680pab.33.2015.07.01.12.07.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 12:07:05 -0700 (PDT)
In-Reply-To: <xmqqbnfvaeqk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jul 2015 11:56:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273186>

Junio C Hamano <gitster@pobox.com> writes:

> Dave Borowitz <dborowitz@google.com> writes:
>
>> send-pack.c omits this field when args->url is null or empty. Fix the
>> protocol specification to match reality.
>
> Do some clients omit this in the real world?
>
> As you say, send_pack() does omit it if args->url is null or empty,
> but args is prepared in transport.c as a copy of transport->url when
> the function is called, and that transport->url is how
> builtin/push.c reports where it is pushing with:
>
>    if (verbosity > 0)
>        fprintf(stderr, _("Pushing to %s\n"), transport->url);
>
> So I am somewhat puzzled...

Answering myself, the most trivial example is "git send-pack" ;-)
It passes args that has a NULL in the .url field.
