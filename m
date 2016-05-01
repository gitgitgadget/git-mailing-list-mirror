From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 17/41] compat/win32/syslog.c: use warning_errno()
Date: Sun, 1 May 2016 14:40:50 -0400
Message-ID: <CAPig+cT9+xAXEM19LYVS_cpmjSaN-nyAXN8DH0GsbeZxxxdB6g@mail.gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462101297-8610-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 20:41:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awwIg-0001U6-6O
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 20:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbcEASkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 14:40:52 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35378 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcEASkv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2016 14:40:51 -0400
Received: by mail-ig0-f193.google.com with SMTP id fn8so8545954igb.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=EZbuyNJDZKewb7VYxJiklR8h7p+2r/kMEhU0Cg7qqVs=;
        b=g3ZVCAjpQEJEMoRLWrMjXX6n30CBH4dkEKN/30Z4LHUgi1/ILES+Pj444VfyWCK2QI
         TB1CQia1GKvosxG9vqc4evlDYfc3t/g9+WK9s51VJlTh4lr+rpw1XTsIVu+0ibvgosLy
         3zYU+HZ95wSJ2To03P5xxm9mxNGR7i50/lX0a3RkEhzJcwQM6JYzoJc92OWTomnT3SPB
         S/CvHszkaQ6ja0pcJ61g3ofkA+G2+0YF+/hm19NkbwT/9kzn/N3iVn53DXCmFh+YrlWX
         QMo8RlIlPOeIxpUb/1obx9zjdojjTtFhzraLi77njWFEFizrXQapLXT098gUaHbt7gsW
         RM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=EZbuyNJDZKewb7VYxJiklR8h7p+2r/kMEhU0Cg7qqVs=;
        b=a43gTo+TBs0372xRB4vIM+z8HoX+aK6QMqGoujoB4bwJnmvmQkbMrqei1NzzeDsm/X
         jsPn90pVttFL6AU86TrBeXBgPSBBpUeHS2H0ubr9SXJBnfn3ch4CKS0A0sbfr7xXG3Vh
         z5Ge73Z/ZNKg35e/G0P4J4sAUOYdqX95PtfubUzZon8vtmbZqqyhdimL8dtwme4qmjQ6
         qCjJvhF1J71XH1aH6OlQrTZplnQ9EQ99kdtvrSImYhONZpmW290pQAcoFA/mjI6nIxge
         R29BzBjig/ELfc2pna3YpdzoyRHoF147cD0aJmzlXzXej1VYNfarIEJVq60LTwT9MWg0
         9mfw==
X-Gm-Message-State: AOPr4FWqQRFz3yCoNpj6yNMA8bfwMdDv+pfg9VGdFM8MB6YKJSruW77McM1RISgszJ4AnHZpVPpUcoGKaJCrCA==
X-Received: by 10.50.224.148 with SMTP id rc20mr2862176igc.73.1462128050774;
 Sun, 01 May 2016 11:40:50 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 1 May 2016 11:40:50 -0700 (PDT)
In-Reply-To: <1462101297-8610-18-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: ID0mfW_KeMvGhyneoFXY3FKTK-c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293204>

On Sun, May 1, 2016 at 7:14 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> @@ -28,13 +28,13 @@ void syslog(int priority, const char *fmt, ...)
>         va_end(ap);
>
>         if (str_len < 0) {
> -               warning("vsnprintf failed: '%s'", strerror(errno));
> +               warning_errno("vsnprintf failed:");

s/failed:/failed/

>                 return;
>         }
