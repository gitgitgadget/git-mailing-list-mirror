From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: RFC: "git config -l" should not expose sensitive information
Date: Fri, 21 Dec 2012 09:31:06 +1100
Message-ID: <CAH5451kjsfvye8PEBN7DGzA+auLDJEmJb2qAqcD9MX9MVAu4NQ@mail.gmail.com>
References: <50CF039A.7010800@gmx.de> <20121220150408.GD27211@sigill.intra.peff.net>
 <50D33409.1050309@alum.mit.edu> <7vbodo5zjj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 23:31:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TloeX-0007RG-BO
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 23:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab2LTWb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 17:31:28 -0500
Received: from mail-qa0-f44.google.com ([209.85.216.44]:40672 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab2LTWb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 17:31:26 -0500
Received: by mail-qa0-f44.google.com with SMTP id z4so5762557qan.10
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YuDeFsl5SHXEIroca9a9FIzbIeedogGj6/ddU+svYz8=;
        b=y51aQmvmQpjJ/0R1fFA8l8acmdFNtubRuNHgBaxhBg5t+4xChMKv9Eg5E9wdZ8u5wT
         sQxyCATcFpKp5fB9BScFCOQg1H+Lqo641a5IhLW6euUaXdn3epoDNeQYTpcz7mpkYQGf
         J1j75v8Zr1Mrpn95CzFyy0w+eMKeX8l74aDNzKB3n3D9K0Hoo7qD4cdF3hI7RuklFFcC
         mU0eaUFbYGi+t+VLP8smOG3H4CELGJQWoe/ccQuqk3EbPRBVKsC1qK9YnLWhjWJ2rPnH
         x+WswYW41jf1Nd01jydIp5dCJCLPpbj/giGGG+b00zbd6BPmMVJ/5YfaLKzocPAeHdsR
         DImg==
Received: by 10.229.69.85 with SMTP id y21mr1320500qci.75.1356042686204; Thu,
 20 Dec 2012 14:31:26 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Thu, 20 Dec 2012 14:31:06 -0800 (PST)
In-Reply-To: <7vbodo5zjj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211934>

On 21 December 2012 02:49, Aaron Schrab <aaron@schrab.com> wrote:
> Tools outside of the core git tree may add support for new config keys which
> are meant to contain sensitive information, and there would be no way for
> `git config` to know about those.

I understand that we've come down mostly on the 'users must check
before sending' side of things, but this point isn't necessarily true.

It wouldn't be too hard to create a config setting with a list of
'sensitive' keys filled with sensible defaults. It would be the job of
the 3rd party to add the relevant keys to this config file. This
wouldn't help with old 3rd party tools but would provide a way to
'hide' things automatically. A user could of course configure this
themselves (though one would think most who knew how wouldn't need
to).

On 21 December 2012 02:52, Jeff King <peff@peff.net> wrote:
>> I think that attempting to do this would only result in a false sense
>> of security.
>
> Yeah. Thanks for a dose of sanity. I was really trying not to say "the
> given advice is bad, and we cannot help those people". But I think you
> are right; the only sensible path is for the user to inspect the output
> before posting it.

One thing that a new option could provide (or maybe even the existing
option if it detects an interactive session) is to prompt the user to
review the content before outputting it. This is a nice way of helping
users who don't know that there might be sensitive information in the
output. Are there any use cases where prompting the user would be
annoying when using this command?

Regards,

Andrew Ardill
