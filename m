From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH nd/threaded-index-pack] index-pack: disable threading if NO_PREAD is defined
Date: Fri, 20 Apr 2012 12:49:42 -0700
Message-ID: <xmqqr4vimbe1.fsf@junio.mtv.corp.google.com>
References: <1334844329-24557-1-git-send-email-pclouds@gmail.com>
	<4F910145.5030102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, kusmabite@gmail.com,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 21:49:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLJq3-00073Z-KJ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 21:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757628Ab2DTTtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Apr 2012 15:49:46 -0400
Received: from mail-we0-f202.google.com ([74.125.82.202]:61534 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab2DTTtp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2012 15:49:45 -0400
X-Greylist: delayed 82028 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Apr 2012 15:49:45 EDT
Received: by wejx9 with SMTP id x9so476596wej.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 12:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=VcLFPutcMx4bspP9xbAMRTSRcKqswmMHKl5MwTbXdzA=;
        b=CsPYNObY1Xdwnx5JSuMlQ5xsN9UrrnpDEKiFTkuPq9RVRMkilzGIh/XX7gIjHHU2iP
         Fv+kSCNV+U00sucp541E9aVmhUHjQuE1Oc0uKB1dcP6daD8uJvIHIrBErGnQsZXjlEso
         TcFREsGKlzOGYssSZvGLKfxndRum4WUW9dI+MEBpx44mRhoydjdvi3u0mZNHEqpBqvUE
         5lJHwFglqMiGAiDG1XWh7F1W8uEuzB7xCSiDlzjGLGfQZbKizYsE9DDRC2HBbD5EhDsH
         ZtPdeEflz+cVNHHDeo7Ut0FhBUp8Sf7JS305shijfGiNNgDTWk+VbSfcvlh8W6zVTGSK
         83/Q==
Received: by 10.14.96.134 with SMTP id r6mr2132421eef.1.1334951384117;
        Fri, 20 Apr 2012 12:49:44 -0700 (PDT)
Received: by 10.14.96.134 with SMTP id r6mr2132394eef.1.1334951383975;
        Fri, 20 Apr 2012 12:49:43 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si6174649eei.3.2012.04.20.12.49.43
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 12:49:43 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id C2E51200497;
	Fri, 20 Apr 2012 12:49:43 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 20A69E120A; Fri, 20 Apr 2012 12:49:43 -0700 (PDT)
In-Reply-To: <4F910145.5030102@viscovery.net> (Johannes Sixt's message of
	"Fri, 20 Apr 2012 08:25:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnc5mCYwUojnO+HOOEuKyJ6fXThU06dx2VmAKv0w+lBIIWPk/aFnjCOgoxdT7n45X+4+22zIPJwTnjrDeFKfUw522Etn/Lv+H77hlK9gemqaqDNPkkFgFhLMyN2q9UCbOUYCox9OaXp5g6o8Qo/rDMoVTkl2eLo14yG41gYLC/mwUoWOEo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196014>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 4/19/2012 16:05, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
:
>> NO_PREAD simulates pread() as a sequence of seek, read, seek in
>> compat/pread.c. The simulation is not thread-safe because another
>> thread could move the file offset away in the middle of pread
>> operation. Do not allow threading in that case.
>
> Unsurprisingly, this fixes the breakage for me.
>
> I used the attached patch to keep t9300 running when the breakage
> was detected.
>
> --- 8< ---
> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] t9300-fast-import: avoid 'exit' in test_expect_succe=
ss snippets
>
> Exiting from a for-loop early using '|| break' does not propagate the
> failure code, and for this reason, the tests used just 'exit'. But th=
is
> ends the test script with 'FATAL: Unexpected exit code 1' in the case=
 of
> a failed test.
>
> Fix this by moving the loop into a shell function, from which we can
> simply return early.

Makes sense.  If the original were written more readably, I may have
suggested to run the entire for loop in a subshell, but a helper
function is equally readable and with many identical checks, it is the
right way to do this.

Thanks.
