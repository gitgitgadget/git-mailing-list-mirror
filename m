From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitweb: Don't pass --full-history to git-log(1)
Date: Thu, 06 Aug 2015 00:41:05 -0700
Message-ID: <xmqqy4hozwxa.fsf@gitster.dls.corp.google.com>
References: <1438784487-9176-1-git-send-email-avarab@gmail.com>
	<xmqqr3nh4qx5.fsf@gitster.dls.corp.google.com>
	<CACBZZX5GvCqx3LkWBDb4kDFpyaEwK-Fnhtof6nhKsctmx22m1g@mail.gmail.com>
	<xmqqvbct1kb3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 09:41:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNFnd-0004kM-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 09:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbbHFHlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 03:41:08 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33209 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbHFHlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 03:41:07 -0400
Received: by pdrh1 with SMTP id h1so11194905pdr.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 00:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7K6X6bcz94U9ERGEbqybjWLwiesESCA8zFdYeI+AOio=;
        b=HLfVcQzezexZzNhBYX6oIqsgfB2QYIR1i53Ao3h/8jVlrywIn/N06Fv5St6NdGv7GG
         yY0kr/oYlANC85Y8AehOEagErYL8HMNoLwHeQi+GNSp4g2jqinlWLr0CsO7YDhOvwibe
         ourR1e1uj5dHAZGYuxFMvrgbGwFpY65zrGM8B/tDNgDrdqnOn43e6eWLeWUp+ZSRn1mU
         vexp8k3oauMX7eVMdKCeI2GUo2GyClVf+YtYvGo/idctEb4ryWDEwhraR97CiwkEi7oe
         G3FQNUNXl0L0d4vPQXHpu3N3hT7abTshvpnW6eYa1AoFRRUJhFlF7o7NZL7wz0Gq+FDm
         asUw==
X-Received: by 10.70.88.80 with SMTP id be16mr579971pdb.37.1438846866932;
        Thu, 06 Aug 2015 00:41:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id f4sm5390288pdc.95.2015.08.06.00.41.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 00:41:06 -0700 (PDT)
In-Reply-To: <xmqqvbct1kb3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 05 Aug 2015 14:45:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275416>

Junio C Hamano <gitster@pobox.com> writes:

> Heh, in 2008 we already had more than a few dozen.
>
> I think
>
>  (1) It is perfectly OK to add an UI option to let the web visitor
>      choose between simplified and full history at runtime,
>      optionally with a new gitweb.conf option to let the project
>      owner choose which one is the default;
>
>  (2) It is also OK to add gitweb.conf option to let the project/site
>      choose between the two, optionally allowing the web visitor to
>      override it with something like (1).
>
> Anything else would not give the same out-of-the-box experience and
> would probably not fly well.

Just to make sure, "would not fly well" is not an outright rejection
(given enough thrust, even a pig could fly).

An alternative with a bit more friction may be to do a variant of
(2), without UI but only with gitweb.conf tweakability, _and_
flipped default.  That will break the out-of-the-box experience but
I suspect that many people would not notice (because their history
is linear), some people who do notice would like the change, and the
remainder can tweak their installation back to the full-history
version, as long the change of the default is prominently
advertised.
