From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] bisect: replace hardcoded "bad|good" by variables
Date: Tue, 09 Jun 2015 12:18:16 -0700
Message-ID: <xmqqr3pk6687.fsf@gitster.dls.corp.google.com>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqtwuhl6s0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:18:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2P2d-0000DE-O2
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 21:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbbFITSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 15:18:24 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36662 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbbFITSS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 15:18:18 -0400
Received: by igdh15 with SMTP id h15so3144074igd.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=y3aPbxAqj5r0e/MQIFTyKwI4qwkGpoj+HfhuxpO1Y4U=;
        b=IMh9UwfeOT8bxnGveAG5kZUNNziFhgRkFGve2M2DIUML3jqnOpHhjJiuENiVsCSt4p
         dzQHVLZCzh2k9xCa6JnYAZ+xu7YK2k3fXA99fnYGlz58hJzrNEsjgAacXy0Atw9/H+aC
         trpvTf+vZGDn4oWmIWMBBVcYwcaSG9LYJRcEVBkoMVjd8G7zmsIVGvlLpPSlOUYBYIuf
         CJ6vSqSlcEC85I4+CcyV5fvD8P65aKaVDyhJ6xCPPE8sU67Y+r7s6Dd1b71syqhY0D/f
         r6nRICOLBV4zOWJMimXBimalJa9bilzaTdTXfCz5Am4HAn7bu/MIp50JDGzqgrmKPGPN
         kWIQ==
X-Received: by 10.50.78.199 with SMTP id d7mr522758igx.18.1433877497860;
        Tue, 09 Jun 2015 12:18:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id d77sm4493215ioj.6.2015.06.09.12.18.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 12:18:17 -0700 (PDT)
In-Reply-To: <vpqtwuhl6s0.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	09 Jun 2015 08:45:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271234>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:
>
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -32,6 +32,8 @@ OPTIONS_SPEC=
>>  
>>  _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>> +NAME_BAD="bad"
>> +NAME_GOOD="good"
>
> I would have written
>
> NAME_NEW=bad
> NAME_OLD=good
>
> "old/new" are the generic wording, so I think it would make more sense
> for the codebase to use it when we don't hardcode old/new.

Yeah, I would think so, especially if we envision that the new/old
will not be the only pair we will ever allow in place for the
traditional bad/good.  Being bad is just a special case of being new
only when you are hunting for a regression.
