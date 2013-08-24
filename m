From: Antoine Pelisse <apelisse@gmail.com>
Subject: contrib/credential/netrc/git-credential-netrc: Use of uninitialized
 value in string
Date: Sat, 24 Aug 2013 16:55:32 +0200
Message-ID: <CALWbr2ynAvevTxFd3duAfFzgv0DCGTDxFUaniW-8hM+eoLiOEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>, Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 16:55:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDFFa-0007CF-3j
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 16:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab3HXOzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 10:55:33 -0400
Received: from mail-qe0-f46.google.com ([209.85.128.46]:55468 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab3HXOzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 10:55:33 -0400
Received: by mail-qe0-f46.google.com with SMTP id f6so925816qej.5
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=MnEFAW6D7iHCN/ZmLVDyvSYnA2eKPtBN3AZAQ1luGmo=;
        b=kUAWFs/QQPTlpt+J/l/GKNkzpUOMHcwz0AD4m3ITvtU7DEFxMumeBP965NBrl/R9Y/
         FSBH5p2nBAdDUM53xxREftX+TchPGcBSslMyH4qSmfPW2EiKGvaJH/bUMcgp/I5arkk4
         lMK91E5i0SpyaiJMKNqg6ZgVg5160wPXyUwlUygz/I52vFMS4UeAPGLU9KzPxKTP9Pfc
         AOasL09LZnLVojjbUjw/lx8ZnctKKCV/MYH/VovKirSodnn8aOamDDzsbnnYJwmEoMB7
         +DyaU4GTbydYd+TmvYwsaKqix8oSxlsQbE9+Ck6aQ4IR3AeYsAbfPULhQ0mfbFlnQBW3
         24Tw==
X-Received: by 10.224.160.194 with SMTP id o2mr5468255qax.3.1377356132426;
 Sat, 24 Aug 2013 07:55:32 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Sat, 24 Aug 2013 07:55:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232885>

Hello,
I've tried to use the netrc credential with git-send-email
(v1.8.4-rc2), and I've had the following log (running with -d -v):

We were given search token protocol and value smtp
We were given search token host and value smtp.gmail.com:587
We were given search token username and value apelisse@gmail.com
Searching for host = smtp.gmail.com:587
Searching for password = (any value)
Searching for path = (any value)
Searching for protocol = smtp
Searching for username = apelisse@gmail.com
Using GPG to open /home/antoine/.authinfo.gpg: [gpg --decrypt
/home/antoine/.authinfo.gpg]

You need a passphrase to unlock the secret key for
user: "Antoine Pelisse <apelisse@gmail.com>"
2048-bit RSA key, ID DE2A8792, created 2010-12-31 (main key ID A066A853)

gpg: encrypted with 2048-bit RSA key, ID DE2A8792, created 2010-12-31
      "Antoine Pelisse <apelisse@gmail.com>"
compare host [smtp.gmail.com:587] to [smtp.gmail.com:587] (entry:
password=secret, username=apelisse@gmail.com, host=smtp.gmail.com:587)
OK: any value satisfies check password
OK: any value satisfies check path
Use of uninitialized value $_[2] in printf at
/home/antoine/code/git/contrib/credential/netrc/git-credential-netrc
line 419.
compare protocol [] to [smtp] (entry: password=secret,
username=apelisse@gmail.com, host=smtp.gmail.com:587)
Use of uninitialized value in string eq at
/home/antoine/code/git/contrib/credential/netrc/git-credential-netrc
line 378.

I can fix the problem by adding a "protocol smtp" to the matching
line, but I wonder why this would be necessary ? After all, if host
smtp.gmail.com:587 matches, do we need to match the protocol ?

Cheers,
Antoine
