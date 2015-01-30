From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 10:04:57 +0100
Message-ID: <CAP8UFD0zourNU6oqxcORP=3x2oXmTa3xz+jicdWRLXBgN7QQtA@mail.gmail.com>
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
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 10:05:16 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YH7Vr-0000FD-37
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 10:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760059AbbA3JFE (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 04:05:04 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:41234 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbbA3JE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 04:04:58 -0500
Received: by mail-ie0-f176.google.com with SMTP id at20so2084546iec.7;
        Fri, 30 Jan 2015 01:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mqGR6djyCf2clOR0uc9FQ8x2scT0gMvT017Ff4YoyUc=;
        b=OIw4eOWFM6LyeMsDpeY0rmRAaWG/TxP7NFW5+cWMzlrdBUzl9PdfnZZVLJ4p5qhJbo
         mQcKATg0qXNCoZv697Q3b/TZHon5anX4CSXkyPeigrlkhMtF7dwdLEZ6qFcGIXYVvzi3
         2uZUlW8LNpypN5u3uyR5/Oh9amfbP7gX7hmi8QPMdd5b/xQFavynckb+h62VdL+hrDdn
         VYAvVbLJ/L3e5v4Tu3bfV0C5e67h2FZPm9BfxvFQHjn4oJSdb4ynNeleFaWsRbP6T9pj
         A3uHXr35linW9rv+vk2qwlpoYr4FAfISJC1Os+FmgkPVqyzxiRFYm4r9PPLeZ0isxWCu
         SnJA==
X-Received: by 10.50.138.226 with SMTP id qt2mr1577503igb.1.1422608697652;
 Fri, 30 Jan 2015 01:04:57 -0800 (PST)
Received: by 10.50.245.144 with HTTP; Fri, 30 Jan 2015 01:04:57 -0800 (PST)
In-Reply-To: <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263172>

On Thu, Jan 29, 2015 at 9:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Instead, for any patch in the input that leaves a path (i.e. a non
> deletion) in the result, we check all leading paths against interim
> result and then either the index or the working tree.  The interim
> results of applying patches are kept track of by fn_table logic for
> us already, so use it to fiture out if existing a symbolic link will

s/fiture/figure/
s/existing a symbolic link/an existing symbolic link/

> cause problems, if a new symbolic link that will cause problems will
> appear, etc.
