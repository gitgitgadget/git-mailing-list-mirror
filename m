From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Tue, 08 Jan 2013 18:54:09 +0100
Message-ID: <50EC5D41.6030209@gmail.com>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se> <7vobh4sffw.fsf@alter.siamese.dyndns.org>,<7vehi0qh4x.fsf@alter.siamese.dyndns.org> <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsdNr-0004HE-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848Ab3AHRyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 12:54:23 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:54719 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589Ab3AHRyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:54:22 -0500
Received: by mail-bk0-f47.google.com with SMTP id j4so420246bkw.6
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=obGGtCCA2g8VU7KX2hKH33LugPaeMAIQaPuVYv/pRh8=;
        b=kLasUW4bvKg5vS7YuOtIlhSXYi73LOms6iuVC2I83IolnDJINS/WJa8vasu/mLLPuh
         WFoWfmlmD4oHNJWGrEJIFjdkMKDsM3vUcR+2J5r9wFIFeRtJ0fc8EpK0yW1qTeObmJlW
         wRD4RN7aZx7eZGXpNZZFwmMPztpvL98Hhmwclf/+bxkBYSFeLL7qUxOlLkRasjj2LPRs
         pytY1lf6JYGZMnMJbLBwswZN4gZcVYxTNVF9Tsu87MqJN0d4InB9QgrbN25M9M+26ezi
         FrbDQoVpk658Xp2j0Rs9P/ooQ6Pb6FjMNyZ22S+1E321ZxIljFj7tZyVpRavHDslTp88
         g4ew==
X-Received: by 10.205.120.3 with SMTP id fw3mr32942110bkc.40.1357667661683;
        Tue, 08 Jan 2013 09:54:21 -0800 (PST)
Received: from [192.168.0.3] ([151.70.216.223])
        by mx.google.com with ESMTPS id m20sm46299759bkw.4.2013.01.08.09.54.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 09:54:20 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212986>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 05/01/2013 21:23, Marc Khouzam ha scritto:
> [...]
> 4- Completion choices include their entire path, which is not what bash does by default.  For example:
>> cd git/contrib
>> ls completion/git-<tab>
> git-completion.bash  git-completion.tcsh  git-completion.zsh   git-prompt.sh
> but
>> git rm completion/git-<tab>
> completion/git-completion.bash  completion/git-completion.tcsh  completion/git-completion.zsh   completion/git-prompt.sh
> notice the extra 'completion/' before each completion.  This can get pretty large when completing with 
> many directory prefixes.  The current tcsh completion has the same problem which I couldn't fix.  However, I am 
> not sure if it can be fixed for bash.
> 
> I personally don't think this is regression, just an slight annoyance.
> 

After some searching, I found how this is supposed to be done.
It is possible to use the -o filenames option to tell Bash completion
that "the compspec generates filenames, so it can perform any
filename-specific processing".

Unfortunately this option must be passed to the complete builtin
command, and we can not do this, since the comspec not always contains
filenames.

> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDsXUEACgkQscQJ24LbaURMlgCdEyeSRTRktKtGuDxq4HX1meWt
IV4AmwS6wasCip+1u4vS2FwG8AlXXB7r
=pN8F
-----END PGP SIGNATURE-----
