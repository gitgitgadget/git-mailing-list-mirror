From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/i18n.txt: clarify character encoding support
Date: Sun, 14 Jun 2015 17:12:10 -0700
Message-ID: <xmqqmw01ltid.fsf@gitster.dls.corp.google.com>
References: <557C9161.6020703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 02:12:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4I0f-0000Sq-QF
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 02:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbbFOAMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 20:12:14 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36348 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbbFOAMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 20:12:12 -0400
Received: by igbiq7 with SMTP id iq7so7252918igb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 17:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=46IhKO0gAbTO72S6lq0lzdrETUadbSzoEqqBWTaYGAs=;
        b=V12BhLTa6eqeJxmrmaER0k7ebuzVuQscSMEwz9XtZw42bt8zNywHtRXSQf0fgeJf1A
         HKGcXtLirmzD448KWJNXgCUBp3WyhTBN6w3lDSjtybvREDrPTCN3JeIvGUREW7vliHYO
         ZZnoZh4cLtxEyZdk0TBWsUeYN6JAQ9Jdfa6gL0Vn3/4wCBjQX3JUOVF56KiWS4zfuy+4
         4EYq2aZomAVMmmut/y1pyhC7DwOQEwX8nmcEkTS5ujrAOuZ+gCHTfMbWwua/L3pvzHsC
         5pulcAnSprFx7E1Cq9DB4cfpJM8fwJYl6jLvRFOjcIFwwfX7k4uQduvg4/7vRPDAGwo9
         jOpA==
X-Received: by 10.50.8.3 with SMTP id n3mr146590iga.37.1434327131942;
        Sun, 14 Jun 2015 17:12:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8cf8:478e:8162:753f])
        by mx.google.com with ESMTPSA id p193sm6779789ioe.34.2015.06.14.17.12.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jun 2015 17:12:11 -0700 (PDT)
In-Reply-To: <557C9161.6020703@gmail.com> (Karsten Blees's message of "Sat, 13
	Jun 2015 22:24:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271657>

Karsten Blees <karsten.blees@gmail.com> writes:

> diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
> index e9a1d5d..e5f6233 100644
> --- a/Documentation/i18n.txt
> +++ b/Documentation/i18n.txt
> @@ -1,18 +1,28 @@
> -At the core level, Git is character encoding agnostic.
> -
> - - The pathnames recorded in the index and in the tree objects
> -   are treated as uninterpreted sequences of non-NUL bytes.
> -   What readdir(2) returns are what are recorded and compared
> -   with the data Git keeps track of, which in turn are expected
> -   to be what lstat(2) and creat(2) accepts.  There is no such
> -   thing as pathname encoding translation.
> +Git is to some extent character encoding agnostic.

I do not think the removal of the text makes much sense here unless
you add the equivalent to the new text below.

>   - The contents of the blob objects are uninterpreted sequences
>     of bytes.  There is no encoding translation at the core
>     level.
>  
> - - The commit log messages are uninterpreted sequences of non-NUL
> -   bytes.
> + - Pathnames are encoded in UTF-8 normalization form C. This

That is true only on some systems like OSX (with HFS+) and Windows,
no?  BSDs in general and Linux do not do any such mangling IIRC.  I
am OK with mangling described as a notable oddball to warn users,
though; i.e. not as a norm as your new text suggests but as an
exception.

> +   platforms. If file system APIs don't use UTF-8 (which may be
> +   file system specific), it is recommended to stick to pure
> +   ASCII file names.

Hmph, who endorsed such a recommendation?  It is recommended to
stick to whatever naming scheme that would not cause troubles to
project participants.  If your participants all want to (and can)
use ISO-8859-1, we do not discourage them from doing so.
