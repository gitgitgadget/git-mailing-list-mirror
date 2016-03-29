From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] MSVC: vsnprintf in Visual Studio 2015 doesn't need
 SNPRINTF_SIZE_CORR any more
Date: Tue, 29 Mar 2016 21:09:19 +0200
Message-ID: <CAHGBnuP1Y1F-CrQJx9zNKSv1KP7gH86WSKo7tbmcYT3Vf2cQ_g@mail.gmail.com>
References: <56FAAC78.2040304@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	blees@dcon.de
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:09:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akz13-0003Lf-KN
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbcC2TJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:09:21 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34470 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbcC2TJU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:09:20 -0400
Received: by mail-vk0-f67.google.com with SMTP id e6so3545276vkh.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Bj58BpZwHC3YoSq4u74ljQdERSJUMCSOB4UN44VtPeQ=;
        b=YDMwuLm9jKg0BBF4XKXPW7ULEIO2m3Shf28CoheJRA/aHN0/eWQZMRomn7v0jKkBlK
         tkOH7a0dEO8HZ1jum9NAO+I4GRdFyxsYHz1O/VljDT1DlFeBdX7sqq1srhyYNhvh5yRa
         1oNVlRVwuurf2A35+GO9Lg8nojo6NRhd0rRTOgTvVtLWMOgghJ6EHDKGwg8mDPW0r9pW
         pPM5/F9hWd9pVlGFaVzVvNvUQHHkEIrav9cLTM56qezElo7wponPmJon3a3uhUsXbEZF
         VmQrrbhSQKrs5iZrFxGFjJ00/5DOylBoIX6WMMIuDHTDspoh7SHXHj5nwRWZ0gcgrblH
         6T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Bj58BpZwHC3YoSq4u74ljQdERSJUMCSOB4UN44VtPeQ=;
        b=GcxqZkx66m1jvCs9u0hFcSypde17JOhcWZ0k6h/tCKyHrl7mRp+bIkzDxmLa1f6b5S
         QCJ2wELT9vY94RekFl0bZXlArM0CM5/J7PS5Nsx4kCtfTl2EuSEMBCqNsODd5lg6rtw3
         iYzOLB0DZgBF315afT7WlqR+snNRkGI35DIMqNKomwnmoO6sQysWJLY+3SPlAo/KGFXk
         ZoOZNeerMGlq0aeNMkmIT1Ac0y/NVc8kBeGhTGHwBv+B4czEw9NkqwE0Z1bylm9s5nnJ
         eoCTvNhJTWrLhtUIwLShwpUJVeMORGFk0jdy8dSe/SAMhn3Dt8V3AMXaRG3yc0dJUOUo
         Gd1A==
X-Gm-Message-State: AD7BkJKh8LDg9JpWKjkZHHX2do64jo9kjM45NNc+0unrOqRLDg43RZgT3nXkgoNaoqThwLusUfC2+t9sHCtmrw==
X-Received: by 10.159.36.39 with SMTP id 36mr2285059uaq.16.1459278559045; Tue,
 29 Mar 2016 12:09:19 -0700 (PDT)
Received: by 10.176.68.6 with HTTP; Tue, 29 Mar 2016 12:09:19 -0700 (PDT)
In-Reply-To: <56FAAC78.2040304@cs-ware.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290163>

On Tue, Mar 29, 2016 at 6:25 PM, Sven Strickroth <sven@cs-ware.de> wrote:

> In MSVC2015 the behavior of vsnprintf was changed.
> W/o this fix there is one character missing at the end.

How about adding a link to [1] in the commit message and quoting the
central "Beginning with the UCRT in Visual Studio 2015 and Windows 10,
vsnprintf is no longer identical to _vsnprintf. The vsnprintf function
complies with the C99 standard; _vnsprintf is retained for backward
compatibility" statement?

[1] https://msdn.microsoft.com/en-us/library/1kt27hek.aspx

-- 
Sebastian Schuberth
