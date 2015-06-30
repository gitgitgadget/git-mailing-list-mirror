From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/11] ref-filter: implement '--merged' and '--no-merged' options
Date: Tue, 30 Jun 2015 08:58:15 -0700
Message-ID: <xmqqfv5989yg.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
	<1435222633-32007-1-git-send-email-karthik.188@gmail.com>
	<1435222633-32007-6-git-send-email-karthik.188@gmail.com>
	<xmqqegkubddy.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZSqvtXioRzeekjCAL3HoFsQmaLKQF=9YmftjQasiHvpqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 17:58:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9xvT-0007bZ-N5
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 17:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbbF3P6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 11:58:20 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34469 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbbF3P6S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 11:58:18 -0400
Received: by igcsj18 with SMTP id sj18so110683457igc.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ixr0g+0nExN+pPa+GioS+QeAPr4hu61n1+xn1f3uQnc=;
        b=zwVFsLnmy7km3rAMzTDu4yeE7ZDzeHAjtWYP7cdFo5EAwAPr9uolvi5WEaXkYRVgsa
         RArIG0al8vlB1s1vUSBc1Y07bBho5hu2RUjiyxj/kZ2cAZBnyHecVh4O/u0yG5fxNMO5
         vBMBCkJByZ41lgHtf9BydwkOSra2+Iiq6g5BLnnJSQfboKYFXr8ITR+MERM782rl0SqD
         SQk4mzQ1MK2UhHmO1UMq3LYERsLSugVsiejnl95BNcUdfeRwk+sMZSTYjA3A/mVy15Sf
         U+pdXQXfFT+mc1/xjSYaieUmCZv0FrF08TPJZeXs9XhVkv+CXd0H3sM3SksWtGZsv/aR
         n7yA==
X-Received: by 10.50.143.38 with SMTP id sb6mr10993623igb.44.1435679897853;
        Tue, 30 Jun 2015 08:58:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id m193sm30298164iom.19.2015.06.30.08.58.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 08:58:16 -0700 (PDT)
In-Reply-To: <CAOLa=ZSqvtXioRzeekjCAL3HoFsQmaLKQF=9YmftjQasiHvpqg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 30 Jun 2015 19:08:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273073>

Karthik Nayak <karthik.188@gmail.com> writes:

>> I also have a feeling that compared to an implementation based on
>> paint_down_to_common(), including is_descendant_of(), this may be
>> less precise (e.g. it would be confused with clock skew that lasts
>> more than SLOP commits).  If we are inventing a new helper (as
>> opposed to moving an existing one), we'd probably be better off
>> doing a thin wrapper around paint_down_to_common() than calling
>> revision-walk machinery.
>
> I'll have a look and get back to you.

Not as part of this series, now I know it is a straight-forward port
of what we already have for "branch --merged".  This series is not
yet about improving counting logic but first unifying the three.

Thanks.
