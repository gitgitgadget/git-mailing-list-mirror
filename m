From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Teach ignore machinery about pattern "/"
Date: Sun, 3 Jun 2012 19:36:23 +0700
Message-ID: <CACsJy8BSHFzGfsm6qY1LEX9wubKjKXXbJ_WMAiOAUhVGa631Ag@mail.gmail.com>
References: <1337950056-26491-1-git-send-email-pclouds@gmail.com>
 <7vlikgtbcx.fsf@alter.siamese.dyndns.org> <CACsJy8BjUQsCVVdzZtJxA9Qu2G0izZa8dvP1EKsQQAHWXZbHdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 14:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbA3L-00051U-Sg
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 14:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab2FCMg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 08:36:56 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45101 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab2FCMgz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 08:36:55 -0400
Received: by weyu7 with SMTP id u7so2298417wey.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gFqz0tG41pmbXr+DRc57TXf6Dj9BYB0wHaPZPYUbYV4=;
        b=e07ZiJkkfw6kUqjh9gxDChUfuxvdGwZt+MqzxCzqNnxKFN3NPRIxTwt4fKuH7IBxa1
         LwB//WGA5WUlfwcgD5in20h/RCgRJ5vqBuwlFzc96/owqoOoIVlmM5+m+eZEaKSwu+X7
         cJ4DcZvaGc20ybSlzPuDfBepZA+n8xqQE9FR+i/vuEaOSW+/Gc/3oZrVTmM/6osWLVjm
         u9Cp7j1DQ+wyBlQg0loPdOalf0infUbbg+bzWgLqN8NQHFb1UkLmb8J1fFZ5WgYTAe2u
         s6g+s1bKQbCpBcVuCe/lHwUG286LeIXasUKlFL4fgoHvUtY+RsbDZ82mWBgcUBG/47ps
         jakQ==
Received: by 10.216.194.196 with SMTP id m46mr8279397wen.197.1338727013970;
 Sun, 03 Jun 2012 05:36:53 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sun, 3 Jun 2012 05:36:23 -0700 (PDT)
In-Reply-To: <CACsJy8BjUQsCVVdzZtJxA9Qu2G0izZa8dvP1EKsQQAHWXZbHdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199084>

On Sat, May 26, 2012 at 11:30 AM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On Sat, May 26, 2012 at 12:32 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>>> Pattern "/" is ambiguous because the slash can mean "anchor the
>>> pattern to this location" (e.g. /path), but it can also mean
>>> "match directories only" (e.g. path/). Currently git interprets it =
as
>>> the latter except that 'path' is an empty string, which makes this
>>> pattern totally useless.
>>
>> Did the old version interprete it as the former?
>
> That calls for bit of testing, which I'll do soon.

"/" is no-op since 1.4.0 (tested with refs/tags/v*), tested with "git
add ." with $GIT_DIR/info/exclude containing only "/". "git add" in
pre-1.4 is shell script and needs to be installed to work properly so
I only tested v1.3.0 and v1.0.0, and it worked too (i.e. "/" is still
no-op). I think it's safe to make it a meaningful pattern (or warn
about its uselessness).
--=20
Duy
