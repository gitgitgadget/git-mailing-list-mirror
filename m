From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH 0/2] Test the Git version string
Date: Tue, 16 Apr 2013 11:24:28 -0700
Message-ID: <CAJDDKr7WKwt10sCRTbm8gdhwEUKSYuQxtPDVm7usTm2ZHryk9g@mail.gmail.com>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
	<7v8v4k6hp2.fsf@alter.siamese.dyndns.org>
	<79879228B71A45A48A961F5B1880B61F@PhilipOakley>
	<7vli8k4lnj.fsf@alter.siamese.dyndns.org>
	<99AE5E981E2547B6A71A4D77B17167B9@PhilipOakley>
	<7v8v4imjji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:24:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAYU-0001q4-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934491Ab3DPSYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:24:30 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:40796 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab3DPSY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:24:29 -0400
Received: by mail-we0-f180.google.com with SMTP id r5so577706wey.25
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qp+leJCf/+IN90Pj/gN8aLZ9wXex/J+MNS3nhvqDugY=;
        b=j3JxWGkQeIqExwaBAix6dZlqdPgb94OxbzQvduoBQj6bMhlE7KgCQoDclcJZhw6nRz
         e2bmiDfwfzTkaCqJ4+xANHKNv7LxKp//N3h9T/pFLnIHsN/K7pFkQlyTbKYuzLm6mAk1
         gSXuehfZF29q4GfJfmmV/mbjYQvEPlGBMuBLlyFIpnB/2YnKWioqQkxDMN9difSeYviM
         8TsqF/uAG3O2Fz5JpOJshECixpcJb2yJ6C3JavnyUC8HGgsuP9HDwe+OIH4wShVaIihQ
         Z//ileG1KHUbwmQwfrnCo/sTo1S1Whqo8nXps+Z74QK/FmDBDEp5Ay3O8FZaNEEw/6Sj
         V8cQ==
X-Received: by 10.194.122.131 with SMTP id ls3mr5939911wjb.55.1366136668625;
 Tue, 16 Apr 2013 11:24:28 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Tue, 16 Apr 2013 11:24:28 -0700 (PDT)
In-Reply-To: <7v8v4imjji.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221447>

On Tue, Apr 16, 2013 at 11:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
> >> What kind of benefit are you envisioning out of this?
> >
> > The purpose of tests is to detect mistakes and spot regressions.
> >
> > A change to the 'git version X.Y.z' string would be a regression, as I
> > spotted earlier, as it conflicts with expectations of standard
> > programmes such as git-gui.
>
> Sorry, but I do not follow.
>
> A released version says "git version 1.8.2.1".  In a month or so,
> I'll have another one that says "git version 1.8.3".  Or I may
> decide to bump in preparation for 2.0 and it may identify itself as
> "git version 1.9".
>
> Neither of which no existing "program such as git-gui" has ever
> seen.
>
> In what way is that a regression?

Sorry.  I was the one that first suggested that this was an issue.

The "regression" is that there are scripts and tools in the wild that
need to know the git version when deciding whether or not to use some
new feature.

e.g. "git status --ignore-submodules=dirty" did not appear until git 1.7.2.
A script may want to use this flag, but it will only want to use it
when available.

If this string started saying "The Git Version Control System v2.0" then these
scripts would be "broken" since they would no longer recognize this as a
"post-1.7.2 Git".

The unstated suggestion here is that it may be helpful to others if we
were to declare that the "git version" output is plumbing.

Folks are already using it that way so making it official would provide
a guarantee that we won't break them in the future.
--
David
