From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Thu, 29 Jan 2015 14:15:13 -0800
Message-ID: <CAGZ79kYqGoLGMkXChH+-63JtGbAAb8gnAbUHYuJYv=NUUNt4XQ@mail.gmail.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Thu Jan 29 23:15:40 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YGxNB-00028a-4K
	for glk-linux-kernel-3@plane.gmane.org; Thu, 29 Jan 2015 23:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758923AbbA2WPc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Jan 2015 17:15:32 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:37558 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758720AbbA2WPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2015 17:15:16 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so79927iec.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jan 2015 14:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nfk7pESKXpOrsdAxt3K0C8+z8ZMlwYXqpFQ/12E8Bqs=;
        b=ejsvE5hnTF2Uz1xEop4zmII7EwouI3MMe8tfqhmqYxwMwCM11C4JyvmGP3aKvPhXIh
         O9xrVaRrx8LD0bAXKKWjP6SnYVo44MKIK4FJFHi8phiMZzTPiuQu5llW6HHjwwVipUon
         zBb+awWzxm4x39JOkuSfkiPJYLcYgt5Qgm6EjOK8TX5QsvLww9vZ3vAXazmoB5qiTFZ1
         MgEh5QUIb4lrbQUbn67xCkagGxeDKtL1yZg7sNwhTIu03L5gkibgQmdnN+SZVdWWptyM
         lGMf1UsmPtSwmIU7sSWfuA7Pfde2o3ylhDCvN/DLaCcru+PoTva0B/+lVNLsEjEbAVge
         OKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nfk7pESKXpOrsdAxt3K0C8+z8ZMlwYXqpFQ/12E8Bqs=;
        b=fgRnhn93rPoVqCL+IJ8qnp8m7u9ZvGLRx/6TYOo9TaleBOiKGmfrdJpUxHRRpXBJK/
         Lm9CcpHFuDYztgSGw6VAAyrs5jX7UCkYZcvBHCqVCL9ZsroYGMWCxXoDI7VlWw24zYJJ
         SwCxjRit1/C458XfWRsXkKWXLNRD3I77hfIfdjNAdjRXJkVHtWb7AqbutzjgiKoklJpy
         hkTj3lSGwwxoCObO3fYM0pKW89AmH/Nb6mFoWOJNRkGJFdGLu/mptm2Zk58r6guV3Eio
         +RT/s1fAepFxJp2HHF/EITWGVdFi8IlzGUjLinGOeLZu05lItdLs7tuFSkFGc7wQi03j
         2Mtg==
X-Gm-Message-State: ALoCoQm9cDoPjJHsHL2aDPdJK/QmtSM/adNqhMkZKrvSW1TYT7NI1xIP9pVo9Ew0jjkZVUYs8O47
X-Received: by 10.50.79.161 with SMTP id k1mr3772029igx.14.1422569713068; Thu,
 29 Jan 2015 14:15:13 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 29 Jan 2015 14:15:13 -0800 (PST)
In-Reply-To: <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263164>

On Thu, Jan 29, 2015 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:

> +
> +test_expect_success SYMLINKS 'do not follow symbolic link (same input)' '
> +
> +       # same input creates a confusihng symbolic link

s/confusihng/confusing/
