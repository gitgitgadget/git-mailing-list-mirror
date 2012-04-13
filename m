From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 14:56:08 +0300
Message-ID: <CAMP44s0C=MV_gxsH9Mk9V6Q27E2E=o1nr3HShBFSTyTYC0Tg4w@mail.gmail.com>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120413091236.GC2164@goldbirke>
	<20120413094500.GD2164@goldbirke>
	<CAMP44s3g8acV4fjaSvnUo_jnhj40-TWR0az6zOwRNfv9_Qa23g@mail.gmail.com>
	<20120413111437.GF2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 13 13:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIf6v-0007zF-17
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 13:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab2DML4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 07:56:12 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51254 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab2DML4K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 07:56:10 -0400
Received: by eekc41 with SMTP id c41so752836eek.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Py3Ag1FqrmoddUeS1L0SV8QoeS24IMDJ1wMvGGbMFFc=;
        b=Cl1EGT+jJ9kv64F6YaoGe4LRnu3f4sV8NXT/1XgAx85oEpuBpxeQrLxw+/5I/UGP1h
         +2cC4hQc4qYlXjLpGHheUelA5fQX0xS2SEmAPr9xcZPs3tiXCJ3Op/aACbgOHAXwXuFa
         62KcI95o6rGT9nBXEIQQLvhWvtQGKAUglqY/SaVgHKHdYaNSObuq1n8frA+bNqjvGtTo
         i3e1RG8diw0apiYw4X9WKOJ8YANDucJzczSaMWtzKj2qKeqDnZxxD1G2XtT++NQiV4bg
         XaNZtkgBlGMTl3AQ/LNznRUIm7eNBTHN73UHLw6yzHKsf4WaYeOzx2o6u2QT+QqTNgo6
         Xjcw==
Received: by 10.14.39.197 with SMTP id d45mr170102eeb.89.1334318168228; Fri,
 13 Apr 2012 04:56:08 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Fri, 13 Apr 2012 04:56:08 -0700 (PDT)
In-Reply-To: <20120413111437.GF2164@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195422>

2012/4/13 SZEDER G=C3=A1bor <szeder@ira.uka.de>:

> i.e. to set COMP_WORDS and COMP_CWORD in run_completion() and it
> worked. =C2=A0However, I agree that it feels iffy to mess with a
> shell-specific variable, and I'm afraid that this just happened to
> work on my system, but it might be broken in previous or future bash
> versions.

Yeah, we could explore that possibility later, as
_get_comp_words_by_ref is part of the completion, and should be tested
as well, otherwise we might be missing some bugs.

However, I wonder if _get_comp_words_by_ref is needed at all. From
what I can see it has to do with '--foo=3Dbar' and 'foo:bar'
completions, which in fact don't work correctly in zsh (I have patches
for zsh to fix this though), but by modifying the code that checks for
'--*=3D*' stuff we might be able to get rid of it, or at least the call
to __git_reassemble_comp_words_by_ref. Right?

Cheers.

--=20
=46elipe Contreras
