From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 9/9] refs: use warning() instead of fprintf(stderr, 
	"warning: ")
Date: Tue, 24 Mar 2009 02:17:24 +0100
Message-ID: <40aa078e0903231817g41fd1bc1s296121d85923f7ea@mail.gmail.com>
References: <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
	 <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
	 <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org>
	 <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org>
	 <6ca31ce7256d8945f520b7d57e2a14b890731abd.1237856682.git.vmiklos@frugalware.org>
	 <83e5caf5764a146779d8cefbf874f540a6160eb4.1237856682.git.vmiklos@frugalware.org>
	 <5e3412be5d72bce2bf36fdcc2734b89386fdfc21.1237856682.git.vmiklos@frugalware.org>
	 <cover.1237856682.git.vmiklos@frugalware.org>
	 <607f1ab07464931305b62599805f898e2bf2ca98.1237856682.git.vmiklos@frugalware.org>
	 <f6b2ede9af2bd40ce89f0251b32861098af46aad.1237856682.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:19:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlvID-00007j-Cw
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbZCXBR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbZCXBR1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:17:27 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:30922 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbZCXBR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:17:26 -0400
Received: by ey-out-2122.google.com with SMTP id 4so601484eyf.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 18:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jMKvpOKVtHu9wndISGw0wnbXyF6Ob1piHgm1oEuoI8Y=;
        b=Yj8nDjhlwJC9/Ixi6d1cPiP2AzzebtzjuZfpPnXWCruwjc8OeASocvWmIinoNkdCFI
         nQyS+Gmy1HriiE3fCVLWWKe/icB8PSMmlB3VoE9XR0I5QmiF9Lw3AOTCYr8gRPBSQKNJ
         f0CfJghF2G2gMyn/3RbL+jFLnaG+V/xa+Rohk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pqSdI0r2H+a7mmmjgKdY2iWwQfLIquxDB472UXYvubux67KAHffcfz87H/hddPgyyO
         jC7QDWPSclKZ0Z4M+Fo/Bv9kd3Rc6kS+F0hA4oTIGArVp7zFUTH9BHYG3DNr8XHr6gYr
         6sOwzVBgKGpmoq22c8CEvjgT0uikSsGc+YHrg=
Received: by 10.210.126.18 with SMTP id y18mr5901792ebc.5.1237857444092; Mon, 
	23 Mar 2009 18:17:24 -0700 (PDT)
In-Reply-To: <f6b2ede9af2bd40ce89f0251b32861098af46aad.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114383>

> @@ -996,7 +996,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>
>        err = unlink(git_path("logs/%s", lock->ref_name));
>        if (err && errno != ENOENT)
> -               fprintf(stderr, "warning: unlink(%s) failed: %s",
> +               warning("unlink(%s) failed: %s",

Doesn't this add a newline? The original string doesn't have a '\n' at
the end of the format-field, but AFAIK warning() terminates with one.
I'm not saying it's a problem, I'm just pointing it out.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
