From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] editor: use canonicalized absolute path
Date: Mon, 29 Jul 2013 21:37:15 +0530
Message-ID: <CALkWK0=dGmMkgvaNV27E3Pb3+SWSZ2pNMOr-wsEcUR_wgLjMFA@mail.gmail.com>
References: <1375030782-13339-1-git-send-email-artagnon@gmail.com> <7v8v0p2z45.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 18:08:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3pzM-00089X-Gx
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 18:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756636Ab3G2QH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 12:07:56 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61197 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab3G2QH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 12:07:56 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so13542793oag.33
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v5qYECM2gbs5ApeKw/ZfgtnSeXPvWPCZZbDT4YNVEcg=;
        b=qGCyumpLyH4jCEnG1s7B8BJBUkK+F0PkhL1kqChAWSJjJ0Y8DdmcNl3OvRCdlMfG2a
         BsGU8tcFKN0Cmw6hhMMLR6x508nQCLXaZ56SccE3TCwPObcOoGG1r0sG4YcSsWuMU58p
         bqae9NXlHjUlNPhJjPOUXKBWb0adjlhx7HLUhi6P2qdviiG13tq1C10gcU6RwxD2rqHw
         Oh+0CpnjjrV6u+0nJanXIEjmj+4WkyKPq7sQfWd7aAbtLPP/kh0bz+nZg20bG6FGKjhT
         XEEi80rr1alSdnT3noENjvyHOgtF2xS5k4/x2gAGu1AxajAtgGKGMHk7jcdCxXE3Dtol
         1mLw==
X-Received: by 10.43.15.68 with SMTP id pt4mr21747316icb.35.1375114075520;
 Mon, 29 Jul 2013 09:07:55 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 29 Jul 2013 09:07:15 -0700 (PDT)
In-Reply-To: <7v8v0p2z45.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231297>

Junio C Hamano wrote:
> That's a bit strange---the patch text looks like the "how about
> this" patch Duy posted earlier.  Shouldn't it be From: Duy with
> S-o-b: by two of you instead?

Feel free to amend as you see fit, as always.

> For editors that are not broken, this could be an annoying
> regression, isn't it?  When the user asks "What is the path of the
> file I am editing?" to the editor (i.e. an equivalent of \C-x\C-b),
> the updated code will start spewing a long full-path from the root
> directory, while we used to give a relative path that is short,
> sweet and more in line with the context of user's work.

Does it matter for COMMIT_EDITMSG or other files in $GITDIR?  If
you're concerned about it, we can change the logic to: real_path() if
path-is-relative to avoid mangling the path in the non-submodules
case; in the submodules case, it will use an absolute-path, as before.
