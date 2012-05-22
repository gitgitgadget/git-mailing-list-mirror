From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Tue, 22 May 2012 18:29:45 -0400
Message-ID: <CAOnadRGBi0+Zno_eqzzkJjoUfXh=vEpEV5Cf_6zjOV42XPjXdg@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com> <4FBC0019.6030702@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?ISO-8859-1?Q?Ville_Skytt=E4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: =?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed May 23 00:30:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWxal-0006rj-2i
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 00:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab2EVWaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 18:30:04 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:59392 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab2EVWaD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 18:30:03 -0400
Received: by wibhj8 with SMTP id hj8so3929550wib.1
        for <git@vger.kernel.org>; Tue, 22 May 2012 15:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=dkim-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=gBxXh1eidJG3zKs6+s+Vq2zyfcJFySIiWObHjV1rSns=;
        b=m20uTEE4ThRo6BfMsE8KYubPsDo6a5lGMpzVtmrRpISa7wh20HdHefNHjVQVWI6fkF
         CEGIOMmqUnoap8M6Ch4zSyOfaUcXzH0Z3L73vRzR++JXkXRzgZl+by81KdKXNwOlaNhv
         Y39AE68YsCroEWvLbcGOikzYKQdrIcMkGmYPPP/eJFI9ngim2s7UrNBvcTCObjThm0mO
         yfWEyYqkeEHGbxIjfr1KX8IrtgeUEllmwR6tWtH0hbRR7gbKh1zs0zQOdL9e07MQ3+2S
         PIrhi8O7p3QELgoN6B7wUtVR+YWprCDLu5ufVMVx/v38f06/OHrDRs/0buOByfzTgYn0
         W77Q==
Received: by 10.180.105.69 with SMTP id gk5mr39031160wib.3.1337725802275;
        Tue, 22 May 2012 15:30:02 -0700 (PDT)
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com [74.125.82.174])
        by mx.google.com with ESMTPS id k8sm56332404wia.6.2012.05.22.15.30.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 15:30:01 -0700 (PDT)
Received: by weyu7 with SMTP id u7so4202728wey.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tedpavlic.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gBxXh1eidJG3zKs6+s+Vq2zyfcJFySIiWObHjV1rSns=;
        b=JxxJBpz57/Tszwmv87+xePMEW/XVHDEHD9KXYDmgPbW8OyMagc+1inre02mPk34yqZ
         RKOlGN9CEo7I4HmBaNBLkdJlfcS4E0TlHxklzG+bnnaPhaFD71mWRhRTNN36e/RiCyFI
         LftJbUPxs+KnouwKBI1KrV7PgdMlcvNQ+E3nc=
Received: by 10.180.85.129 with SMTP id h1mr39026229wiz.2.1337725800546; Tue,
 22 May 2012 15:30:00 -0700 (PDT)
Received: by 10.216.131.211 with HTTP; Tue, 22 May 2012 15:29:45 -0700 (PDT)
In-Reply-To: <4FBC0019.6030702@in.waw.pl>
X-Gm-Message-State: ALoCoQlJnfqtuZfrAe4KTZom1uAe3nD7lN3S8liYO2nSH4UcZn1kOZLqj67zvyvycPm5LOFwHBYy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198262>

>> =A0create mode 100644 contrib/completion/git-prompt.sh
> Hi,
> since git-prompt is not completion related anymore, should a differen=
t
> directory be used?

Making it even more likely that the __gitdir in one will someday not
match the __gitdir in another...

Maybe __gitdir should live inside git-prompt and git-completion would
include git-prompt. That would make everything backward compatible
too. And that way there's a good answer to why git-prompt lives inside
the completion directory.

--=20
Ted Pavlic <ted@tedpavlic.com>
