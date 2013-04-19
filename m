From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 20:27:45 -0400
Message-ID: <CAPig+cRp7J+HYBA=2OL-CdA3NiQFjuUMZEjE+i+SnNrrPBAZ6Q@mail.gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 02:27:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USzBA-0005o3-FA
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 02:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967668Ab3DSA1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 20:27:47 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:61237 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967537Ab3DSA1r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 20:27:47 -0400
Received: by mail-la0-f47.google.com with SMTP id fk20so2849616lab.34
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 17:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=bvTHFfDbesMcyxRC2jVxiEpQL4WGkfqZ/tTd4fO0Ia0=;
        b=yvO3LyVLUKf0lKan3YMpCcT1ZLIRsaNA/EIeOzF5WYH5j3WeDjrvbhUX/gE7HkYmz5
         +x9cmvx2brWI3AhW7/Ucpu2TbeTJcZDaD/qqwfb6AFeQ9USJtDo8gIjToQQa4J76cQLV
         ueJ8IlmMwm5M9QIqKc+5d4cfxU4nbU8zVKhj8yglcUMbCGw3Y4uwaQReG/QDryjyyUTy
         TRFLKJNOg8eUTE1ehNx685duU1GtPs6w5e05IVCVt/XuBlnpJRtWM721TeGW5jl2NSKD
         2GN6HWEQuhVu2l7ekHcufQW59SqF7COTDo/Ld9UHMbzoAK6xpxWpzxedAc7XbDFSvJ4o
         wlNg==
X-Received: by 10.112.209.38 with SMTP id mj6mr6385529lbc.52.1366331265840;
 Thu, 18 Apr 2013 17:27:45 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Thu, 18 Apr 2013 17:27:45 -0700 (PDT)
In-Reply-To: <1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: o4Otrw4sV0AZLb9zSKyS5eY9CVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221721>

On Thu, Apr 18, 2013 at 12:14 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index cd1873c..3eeb309 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -111,13 +111,13 @@ test_expect_success 'pulling without refspecs' '
>         compare_refs local2 HEAD server HEAD
>  '
>
> -test_expect_failure 'pushing without refspecs' '
> +test_expect_success 'pushing without refspecs' '
>         test_when_finished "(cd local2 && git reset --hard origin)" &&
>         (cd local2 &&
>         echo content >>file &&
>         git commit -a -m ten &&
> -       GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
> -       compare_refs local2 HEAD server HEAD
> +       GIT_REMOTE_TESTGIT_REFSPEC="" test_must_fail git push 2> ../error) &&
> +       grep "remote-helper doesn.t support push; refspec needed" error

Is "doesn.t" intentional? It certainly works by accident in grep, but
did you mean s/doesn.t/doesn't/ ?

>  '
>
>  test_expect_success 'pulling without marks' '
