From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] test-lib: add a function to compare an expection
 with stdout from a command
Date: Sun, 17 Apr 2016 12:22:23 -0400
Message-ID: <CAPig+cT8SSeYPJe8A2DJcxeVW5KJrnDWEJ1VMWDNy5vRkYj0AA@mail.gmail.com>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
	<1460823230-45692-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cSOuFygsScGn_Nu0_d8mvRik1hQJuanrb-Nvw3ozyt7JQ@mail.gmail.com>
	<5713A979.6030404@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 18:22:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arpSw-0004Or-Av
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 18:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbcDQQWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 12:22:25 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34898 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbcDQQWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 12:22:25 -0400
Received: by mail-ig0-f194.google.com with SMTP id fn8so8316503igb.2
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=TDKCx3xLvktG7zDrGOxV/iA1fgI8i+5lh1giEEWpfXI=;
        b=Uen1xwySz7Yxj7xudKjVeGkzvcQsm56qQgfOPfIq3V/ROzyU7uO+urz2v5Rmry1CMD
         QOW/Q0VtvVpBu49fAG7f9EmIYS7c4AUW27/2chpm6JDYFymCxWT+/ar+aLgNmcmWT3pX
         S6/04NGWnCD8r6dSWe6scxP1KH8TcnWau/HhTBCMvvI3OIBP7F2wZy6W/5v9HJpDNnq4
         B7gyUP0bCj/R+dgxSvfOgjWFQXRLm72aSvlWd+roUAr1Phbo15P+i/t0ShpdEELJ1sRA
         3VJwUzHWPKsdJmBza1N+ofCE3f0uRKE9lMZ3n1oNekLYzsFhPgBXM+x5yxzOQcsoPss8
         +CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TDKCx3xLvktG7zDrGOxV/iA1fgI8i+5lh1giEEWpfXI=;
        b=OFO1GG8Ym1WHo2O6ttFQYZVhGgFJh3yow5zn5tiRenJPwJQD3wArQHXGlAd04Ru8Mp
         I/FNPsCeJE1P3oAZiGif8jlzoipraWDu8jd9+ItlT9V1BiFcVagKDMzT77D7WhbwKcDc
         lcHJWfNGPK3Vv7gb6bZXWK/JZyzJZOQbkrb+43KkrnJZcqbgYWyGzP97THQDZjQ2fJ0K
         G8uwYr0KzsPx8DXZPtNKtsJXJs8UrmG9zgZ5swTQlWyuJ7hlW1GEcmAdViTDL1qq26+D
         I/ptMofiyPEFcNwa+iCjV60CPECZDuuckX5PtqpHky8Mup6Nu0jmFB4I5Lk7TrT3bPDs
         FDDQ==
X-Gm-Message-State: AOPr4FUEDoT2yL7QIxr1tNRlUfGMK9S8R7WSamL2pJXfU3U22ez57zYEFJ0onfT2i5NqGVUG8EoHyTNiJsIAdg==
X-Received: by 10.50.189.233 with SMTP id gl9mr13930580igc.73.1460910144180;
 Sun, 17 Apr 2016 09:22:24 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Sun, 17 Apr 2016 09:22:23 -0700 (PDT)
In-Reply-To: <5713A979.6030404@kdbg.org>
X-Google-Sender-Auth: 0_keKmRND-rxJuzdlR1jL2nqIHY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291765>

On Sun, Apr 17, 2016 at 11:19 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 17.04.2016 um 05:07 schrieb Eric Sunshine:
>> Hmm, considering that $(...) collapses each whitespace run (including
>> newlines) down to a single space, I don't see how you could get a
>> multi-line result.
>
> No, it doesn't. It only removes trailing newlines:
>
> ~:1004> frotz=$(echo 1; echo; echo 2; echo; echo; echo); echo "$frotz"
> 1
>
> 2
> ~:1005>

Thanks for the correction.
