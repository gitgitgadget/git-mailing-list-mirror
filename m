From: Brian Collins <bricollins@gmail.com>
Subject: Re: [PATCH v2] Run global hooks from the directory at hooks.dir
Date: Mon, 8 Nov 2010 19:22:43 -0800
Message-ID: <AANLkTimx5V7P4yFY0HYP6TNOKa+9fZ1vQUkhoMVL7OeR@mail.gmail.com>
References: <1289219520-37435-1-git-send-email-bricollins@gmail.com>
	<7v39rbpn1c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, s-beyer@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 04:22:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFenK-0006ZY-8b
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 04:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab0KIDWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 22:22:45 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51612 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0KIDWo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 22:22:44 -0500
Received: by wyb36 with SMTP id 36so4360791wyb.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 19:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T/S4loPCYjQ4H4HGIZDyZzjs/OpGO9JSx2c7NQ7sOg8=;
        b=rkvBx58nYOxQdCoEjD/QHjJMWpRsNiGnLuYGSG8TtjXkr2hG+dlIC+3t47ScUF2KV8
         vhlDuJM5ou0WxYYtzL6DjIw9kwVaz+XO9FXLW7a5PkXXS4geJs0+7iYMUJD4wKduHmNw
         dj9ihzrK1TXEPOH18qltqxAIMqyrNTKtKuiT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rt46XkKy8ZPq6HnohcLNgT3Gl7jcS5qvoOpEspxP1oRQVM7vLt1K4vUAH7JTHQGQI7
         eF+as44PLxUD5w7k4tJQ5p3V8U0+PYgX4IO4KJvWb/7MlohGjEvIx+uc4mt6r2cRyT9A
         Bl+mHOKG+SnB3DqhxxhKxWNr7HTGnfRwMGeUA=
Received: by 10.227.133.134 with SMTP id f6mr6004724wbt.202.1289272963077;
 Mon, 08 Nov 2010 19:22:43 -0800 (PST)
Received: by 10.216.233.41 with HTTP; Mon, 8 Nov 2010 19:22:43 -0800 (PST)
In-Reply-To: <7v39rbpn1c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161014>

> It is left unspecified what happens when the global hook exists and i=
t
> succeeds. =A0Watch out for hooks that read from their standard input.

The local hook will execute. They are chained.

> In any case, the above is totally backwards from the usual practice a=
nd
> expectation of local things overriding the global default. =A0If you =
want a
> site-wide policy suggestion, default templates would be a more accept=
able
> way (and the implementation of hooks you install to developer reposit=
ories
> can choose to look at $GIT_DIR/hooks/local-foo-hook).

The global hook doesn't override the local hook, it supplements it. In =
any
case, a developer can set hooks.dir to be something else in a specific
repository, and it will override the global default.

> By the way, with a distributed scm, anything-wide policy enforcement =
at
> the level of developer's individual working repositories is a lost ca=
use.
> You are giving freedom to do anything on their own copy of the histor=
y to
> the developers; the project-wide policy is to be enforced at the peri=
meter
> of your authoritative repository of the project.

The developer is in total control, it is a user configuration option.
It is the same
as setting colours for diffs. Just a preference that makes the develope=
r's life
easier by adding some way of automating certain tasks. Say you want to
post to IRC every time you commit, this could do that. Or if you want t=
o set up
a shell script to jump to your most recently used repository. There are=
 lots of
possible applications. I admit "site-wide coding style enforcement" was=
 a bad
example, and I certainly don't plan to use it for that.
