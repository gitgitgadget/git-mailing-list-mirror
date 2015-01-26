From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Mon, 26 Jan 2015 13:30:47 -0800
Message-ID: <CA+55aFwa1-pudNus+r=5EghpGkm33h--GZNND5UHt=ZKvP15Xw@mail.gmail.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<CA+5PVA5RdtLyRiYerG=u--bRZQ87qU0EGf7kGPMiQs9_KB3hRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Josh Boyer <jwboyer@fedoraproject.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 26 22:30:58 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YFrFH-000883-Gr
	for glk-linux-kernel-3@plane.gmane.org; Mon, 26 Jan 2015 22:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020AbbAZVau (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 26 Jan 2015 16:30:50 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:40384 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890AbbAZVas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2015 16:30:48 -0500
Received: by mail-ie0-f179.google.com with SMTP id x19so11418921ier.10;
        Mon, 26 Jan 2015 13:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PkfCj1+7Ka60hbtzKB98V38C2PkWQolkAtt19BplF9c=;
        b=XRXmanrmgoU6JWmHg9Q6OBA69ky3f35Xc8vLdl2RhsuEGHY1/8yToxil/X36NiQIEF
         kYWpld9eb9nSsI+N0PyVmkITjAyVCZwhfYcTU40hH4BwNcJw3SFzxjshW9tL0FxKBGGT
         bcx8Cg9KHUW/X45fUbQC3FXYvrlQfsSUkxqxCz91IMaXHM1bs4myO2G2ZI77lua+k1Cr
         kR5G/fg9FOBTE7o4bmcbo3v+d12A/t57miwYqCGg0ZtvaTi5q10H9Rb0nf04vboQqCEQ
         9lVZKMChkwGBbSkk/3VfrrZTibzrMSlBuRAtGuu+N9tXXs4AFAt8BMtTsEuldRC2/Yqv
         7w8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PkfCj1+7Ka60hbtzKB98V38C2PkWQolkAtt19BplF9c=;
        b=MnC7kfMkYh00Av4Wo6Udt1oE8I4J8r1NYVtaGSdKzn2+LAmyimQqnsLvGgHKr3h7ph
         utyz9/CD3Uzz0ch2hzTa2WBjBRjGI/4O5ohaMarZsdRMzFxA0+R4vMjdQ70cRoQXT/r8
         UEhyO9oyGVHFxolinXeow+Kxep6BfWgDYTARY=
X-Received: by 10.50.49.43 with SMTP id r11mr19017164ign.18.1422307847728;
 Mon, 26 Jan 2015 13:30:47 -0800 (PST)
Received: by 10.36.81.82 with HTTP; Mon, 26 Jan 2015 13:30:47 -0800 (PST)
In-Reply-To: <CA+5PVA5RdtLyRiYerG=u--bRZQ87qU0EGf7kGPMiQs9_KB3hRw@mail.gmail.com>
X-Google-Sender-Auth: JC113fG5nyz5xGiwbq1ur7eS1Ss
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263047>

On Mon, Jan 26, 2015 at 1:07 PM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
>
> Or did I miss a way that git-apply can take a git patch and apply it
> to a tree that isn't a git repo?

Exactly. "git apply" works as a straight "patch" replacement outside
of a git repository. It doesn't actually need a git tree to work.

(Of course, "git apply" is _not_ a "patch" replacement in the general
sense. It only applies context diffs - preferentially git style ones -
 so no old-style patches etc need apply. And it's not
replacement-compatible in a syntax sense either, in that while many of
the options are the same, not all are etc etc).

                               Linus
