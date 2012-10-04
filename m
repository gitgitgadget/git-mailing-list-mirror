From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Thu, 4 Oct 2012 18:46:07 +0700
Message-ID: <CACsJy8DUmjwrkDTePr_8zAU_gcm1kh11J4NVWANMXKsqA6Pb1A@mail.gmail.com>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org> <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
 <7vbogj5sji.fsf@alter.siamese.dyndns.org> <506D5837.6020708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:08:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtWq-0001w8-Kf
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab2JDLqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 07:46:38 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:60394 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab2JDLqh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 07:46:37 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so138466iag.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tJ/8pvQJBA4msq6Kt+EjIdm9ac0eXYBCaNumjxctVic=;
        b=tBaG1qmEUHCmCc6wwkfUBfOpBbZMbtv53ctdNbvQEw7VP/aeHdvoJa+pDG9N4HhwGM
         uFhUkc6cuP69YTMgJMJAOlvH9dUDnF40OgUSrkYd07ZvFObz0/nEocxdpUXkBBT3fBRp
         q3Y72XLJmCFtkknVSBOUp5b4emSNEwggj2/qj1fT7ECVE/3JhFpQTstDohbWFwq9t5Wf
         tYy7R/dRODQ5j4dwonIcWiiUwT1/Px3ZfS6AOxrs3Rn4M7bpxgpQ/QR36DrujOOS5FGz
         K51j5XMWrt1SXPvSQxnG804E9oBN6CPDQE9cwR3we8h8wE81ZKissh8D3wk8tzChHy+a
         Ky5w==
Received: by 10.50.220.129 with SMTP id pw1mr15214664igc.47.1349351197252;
 Thu, 04 Oct 2012 04:46:37 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Thu, 4 Oct 2012 04:46:07 -0700 (PDT)
In-Reply-To: <506D5837.6020708@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206968>

On Thu, Oct 4, 2012 at 4:34 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
On Thu, Oct 4, 2012 at 4:34 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Given that there is no obvious interpretation for what a construct like
> "x**y" would mean, and many plausible guesses (most of which sound
> rather useless), I suggest that we forbid it.  This will make the
> feature easier to explain and make .gitignore files that use it easier
> to understand.

Yep, sounds like a good short term plan.

> As for the implementation, it is quite easy to textually convert a glob
> pattern, including "**" parts, into a regexp.

Or we could introduce regexp syntax as an alternative and let users
choose (and pay associated price). Patterns starting with // are never
matched (we don't normalize paths in .gitignore). Any patterns started
with "//regex:" is followed by regex. Reject all other // patterns for
future use.

> _filename_char_pattern = r'[^/]'
> _glob_patterns = [
>     ('?', _filename_char_pattern),
>     ('/**', r'(/.+)?'),
>     ('**/', r'(.+/)?'),
>     ('*', _filename_char_pattern + r'*'),
>     ]

I don't fully understand the rest (never been a big fan of python) but
what about bracket expressions like [!abc] and [:alnum:]?
-- 
Duy
