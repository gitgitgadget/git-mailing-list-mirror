From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/6] run-command: add "use shell" option
Date: Wed, 30 Dec 2009 14:55:43 +0100
Message-ID: <40aa078e0912300555x5beb1f0ejc27fd544856f6da1@mail.gmail.com>
References: <20091230095634.GA16349@coredump.intra.peff.net>
	 <20091230105316.GA22959@coredump.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 14:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPz1j-0001yV-9r
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 14:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZL3Nzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 08:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbZL3Nzq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 08:55:46 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46612 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbZL3Nzp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 08:55:45 -0500
Received: by ewy19 with SMTP id 19so3679845ewy.21
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 05:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dFcOOqv4Lnw1rebQOoP8XbM3vE4xFTukJq7okLvfH3k=;
        b=l+b0VvdE9NPvtRKJZ0mh9cBsFwiumHVem4HGyHZ7LVxOxJ6RBQwaKJyvWxKafEwcYs
         plCNX2Z/xs8jeyOXWxUbCGrFUj7aKzQeWb9lQXSusawqnbaI4IC/Y1yV6CtnwHQMAVxi
         Rv/CMn23TGK/6/+WNYZkmS0h3QOkTPgfrpkGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=gpyMZN26c+mqy2Sg49/sgPLRbNgsqhrvM+YrBjogj6z7Gf8b6/4By0T1o/Q85efqFS
         l4sm6uZBdGm+IlVa9WsToPO4XgaDnqQGxSHl+t/JSZxr/s0YILF68opPttOCd+Q8Yvnb
         UuQyB3RKFQe5mH12YtsJnnJJwFx0N75EEAaw4=
Received: by 10.216.86.213 with SMTP id w63mr6530449wee.71.1262181344007; Wed, 
	30 Dec 2009 05:55:44 -0800 (PST)
In-Reply-To: <20091230105316.GA22959@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135898>

On Wed, Dec 30, 2009 at 11:53 AM, Jeff King <peff@peff.net> wrote:
> Many callsites run "sh -c $CMD" to run $CMD. We can make it
> a little simpler for them by factoring out the munging of
> argv.
>
> For simple cases with no arguments, this doesn't help much, but:
>
> =A01. For cases with arguments, we save the caller from
> =A0 =A0 having to build the appropriate shell snippet.
>
> =A02. We can later optimize to avoid the shell when
> =A0 =A0 there are no metacharacters in the program.
>

Nice. This could be helpful if we ever decide not to depend on a
sh-compatible shell on Windows (since one isn't included by default no
Windows, and installing msys/cygwin has some compatibility-issues with
previous installations).

--=20
Erik "kusma" Faye-Lund
