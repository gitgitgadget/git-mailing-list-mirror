From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git daemon on Windows environment
Date: Fri, 30 Apr 2010 17:44:03 -0400
Message-ID: <j2q32541b131004301444iea34b138v4c34260aa82f8ec8@mail.gmail.com>
References: <1272532026043-4979038.post@n2.nabble.com> <t2jc115fd3c1004301434ofe8970fo2ea933dd450847d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: santos2010 <santos.claudia2009@googlemail.com>, git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 23:44:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7y0f-0004YQ-Pd
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 23:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759705Ab0D3Vo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 17:44:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38606 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759674Ab0D3VoY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Apr 2010 17:44:24 -0400
Received: by gwj19 with SMTP id 19so342187gwj.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IfbH/GQHj+8uKMdNzCSlcRqgCaDHpBzROv4x9LxY5DE=;
        b=QTxo8KpKR0eQEp8OEY3nC5jwx5UhaUhG8TjjO284sD1oTRsj3URgKImUK1qmmqBtk4
         F43fuzOIArcZJrMG1ySrxYylwKhGm2qDuumMGwnXpQat4u1oma1iVb8s5Oiwh/GOATEj
         xARnG/VcUL/1MgXwKSRQHyhaON8OMZCsJ8D8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QVe9OI8DSuHuB9BnOQ4odYItYtaRS+zHmuHfmm2uj4QpaLR7qz4diQUump+/uWniHQ
         66D/WqAUcTdlY7uJVVT/8qmDEGUKws4fSmbq0C5G0Na75aIgjU1kKcsPalx9dapfwEyK
         bL8JloQZNAduKnXKpL9c/hWrCnY7DAtAzIkbQ=
Received: by 10.150.180.1 with SMTP id c1mr134805ybf.57.1272663863177; Fri, 30 
	Apr 2010 14:44:23 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Fri, 30 Apr 2010 14:44:03 -0700 (PDT)
In-Reply-To: <t2jc115fd3c1004301434ofe8970fo2ea933dd450847d7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146066>

On Fri, Apr 30, 2010 at 5:34 PM, Tim Visher <tim.visher@gmail.com> wrot=
e:
> As far as I know, git --daemon is explicitly not supported in Windows
> environments. =A0At least that was the case not too long ago.

git daemon works perfectly fine in cygwin.  I've heard that the
msysgit one doesn't necessarily work, but that may have been fixed.

I haven't tried using the git daemon as a service, though; I mostly
use it as an ad-hoc thing to easily let me exchange branches with my
co-workers before they're ready to be pushed into the "real" server,
thus it doesn't matter much if git-daemon doesn't restart on boot.  So
I can't help with the original poster's problem.

> If you're running git --daemon because of its efficiency, have you
> considered the fact that [smart-http][] is almost as efficient? =A0Th=
at
> should work in any http server, a plethora of which exist for Windoze=
=2E

That's about 10000 times harder than running 'git daemon' from the
command line, though, if all you want is ad-hoc sharing.

Your suggestion is probably a good one for setting up a "real" Windows
git server; setting up a Windows ssh server should also work.  We just
use a Linux server at work, even for our Windows users, and life is
fine.

> Also, file system cloning is very efficient so if you're trying to
> share a repository you could in theory share over the file system
> using filesystem permissions to allow for cloning.

Hmm, in my experience, git cloning over NFS/SMB is kind of crappy;
using a real git server is much faster.  This is because of latency:
the client doesn't know which bytes to read until it reads some of the
other bytes, so there's a lot of back-and-forth communication.  The
"real" git protocols (like git daemon, smart http, ssh server, etc)
let the server make these decisions and can thus go much faster.

Have fun,

Avery
