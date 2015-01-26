From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Mon, 26 Jan 2015 11:32:17 -0500
Message-ID: <CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 26 17:32:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFmaN-0007sf-ES
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 17:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541AbbAZQcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 11:32:19 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36015 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbbAZQcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 11:32:18 -0500
Received: by mail-oi0-f49.google.com with SMTP id a3so7931120oib.8;
        Mon, 26 Jan 2015 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PYj/Wuj0JeqK+PJuBmFz+5Scf3vOEc0+GWoUWzpLGaQ=;
        b=nb0g9E6xMY900SlymcLfBCZzycUp9HOGQcIoZl5yyn1s75ESHjIrcb8vYGFo+07iyA
         ELWSFpdReCRA0ubi0QcVPnRZ4XB0KEOrrMsGes346JZzEM+RoDP8De4/Ie2L6RfqD4Dh
         Gs56Bb5rvt+VT65CGA3IWRa08CFJ12lviU5n5X3bv/a0j7v5sIa/Nh66BlvDXh4wdb/H
         apwYLi9CTvmfj6IlHF0KS/AMS8C2hxYfABR+Is//3/LIhpE3u0Ut/iiO1GzPI6fSNhXc
         TvU7zzJKv7xSjfGm3sxRUcX3NUDLGj3hHROBlky/suEOq6YmT+xNJfSKT7KKob/YMTMN
         +/9Q==
X-Received: by 10.202.186.8 with SMTP id k8mr12782712oif.39.1422289937460;
 Mon, 26 Jan 2015 08:32:17 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Mon, 26 Jan 2015 08:32:17 -0800 (PST)
In-Reply-To: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
X-Google-Sender-Auth: ZyQNTOCXjgc1iATDxPyJTI9kn9M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263035>

[Adding Junio's correct email address.  Sigh.]

On Mon, Jan 26, 2015 at 11:29 AM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> Hi,
>
> I went to do the Fedora 3.19-rc6 build this morning and it failed in
> our buildsystem with:
>
> + '[' '!' -f /builddir/build/SOURCES/patch-3.19-rc6.xz ']'
> + case "$patch" in
> + unxz
> + patch -p1 -F1 -s
> symbolic link target '../../../../../include/dt-bindings' is invalid
> error: Bad exit status from /var/tmp/rpm-tmp.mWE3ZL (%prep)
>
> That is coming from the hunk in patch-3.19-rc6.xz that creates the
> symbolic link from arch/arm64/boot/dts/include/dt-bindings to
> include/dt-bindings.  Oddly enough, patch-3.19-rc5.xz contains the
> same hunk and it built fine last week.
>
> Digging in, it seems that upstream patch has decided that relative
> symlinks are forbidden now as part of a fix for CVE-2015-1196.  You
> can find the relevant bugs here:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1185928
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=775901#13
>
> Aside from locally modifying patch-3.19-rc6.xz, I'm not sure what else
> to do.  I thought I would send a heads up since anyone that is using
> patch-2.7.3 is probably going to run into this issue.
>
> josh
