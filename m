From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 13:04:11 -0800
Message-ID: <CA+55aFxdxzeHmckgn5ZSvXKr9VOztNApif+=5xmZ+4v=RhUryQ@mail.gmail.com>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
	<xmqqiof163kk.fsf@gitster.dls.corp.google.com>
	<54E31405.5040502@gnu.org>
	<xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>
	<54E3A5E2.6060806@gnu.org>
	<CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com>
	<54E3AA41.5070209@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 22:04:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNpJY-0007Fo-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 22:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbbBQVEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 16:04:13 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:43690 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbBQVEM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 16:04:12 -0500
Received: by iebtr6 with SMTP id tr6so33448322ieb.10
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rIE9k5fgx3Hg/dLy2pSwhw4mcSYgxvhxKnqfdxxTlSA=;
        b=PhNSjiKoavO3UD4GbKthOQ2U3bH0cXcNOhj381okOHw+XR8KAhMlchn8vyTiZOWnVp
         Ajm90NXyHclGAbyjbkposDch+JIMQX30npM71QVANVNvaxoNjQPjm+yd3LBsmyhUTJaQ
         41Y/f8SVz5vc6X+ObGNhjMKjuwfEijBcjviMdaVGD6ohk5dkub7pw+1p0kJ1FO8Hqv1o
         oQK0mUvCzLqkiSoSVt3qeAgNyZEO03fwWBnBjsAvveh5FztrjSoB9+tSK62aAHcTVhVL
         nDKbwBJTEESj8+GgLJChG9Tn5SF8k6IrpUAgwMA9uTgH53qK57F2DJKdY2YCqmCEn5JD
         f6hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rIE9k5fgx3Hg/dLy2pSwhw4mcSYgxvhxKnqfdxxTlSA=;
        b=fbKEV9PICFw0K4MJZtGH+QP0EV8EXXOIkqfBzpfX+Po5kRltdb0tQDY9xFypBE209/
         GR8XVyb9+DRBn0cL0hzzwTAdJmGlBWB2D1GLgf0UYUqnxlYnuaJFZ2N7HmbxlU4v1YDP
         iPqAT8G7SvlfAeolyCW0H8OCryQ2F2/+b/9/U=
X-Received: by 10.50.79.163 with SMTP id k3mr30380784igx.30.1424207051098;
 Tue, 17 Feb 2015 13:04:11 -0800 (PST)
Received: by 10.36.60.10 with HTTP; Tue, 17 Feb 2015 13:04:11 -0800 (PST)
In-Reply-To: <54E3AA41.5070209@gnu.org>
X-Google-Sender-Auth: QeYg3W8YFxNLUMMHFAWg346BV8A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263985>

On Tue, Feb 17, 2015 at 12:53 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
>
> Without $3, git tries to do things that make no sense like "git show-ref
> --heads --tags HEAD"; or that make little sense when requesting a pull,
> like looking for HEAD in the output of "git ls-remote".  But from the
> release notes of 2.0 it looks like it's intended and the script is just
> taking shortcuts.

It is *you* who make no sense.

Looking for HEAD in "git ls-remote"? Perfectly sensible:

    [torvalds@i7 linux]$ git ls-remote origin | grep HEAD
    cc4f9c2a91b7be7b3590bb1cbe8148873556aa3f HEAD

that's the default thing when you don't specify any particular branch or tag.

> Ok, in 1.9.x I used to not say anything; if the new workflow is to
> always specify a tag, that's okay.

Indeed. You have to specify what you want me to pull. Exactly because
in 1.9.x people didn't, and I got *really* tired of getting bogus pull
requests that didn't work, or pointed at the wrong branch when people
had multiple branches with the same contents etc.

> I wanted git to find the matching tag on the remote side when I use "git
> request-pull origin/master URL" with no third parameter, since I never
> request pulls except with a single signed tag.

The thing is, HEAD works. Not for you, because you don't use HEAD. But
because you don't use HEAD, you shouldn't use the default.

I *would* agree to making $3 be mandatory, but there are still people
out there who just use a single branch per repository and no signed
branches. Which is the only reason that "default HEAD' thing exists.

                       :Linus
