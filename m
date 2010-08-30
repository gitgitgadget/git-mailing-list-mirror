From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Mon, 30 Aug 2010 10:05:13 -0500
Message-ID: <20100830150513.GJ2315@burratino>
References: <cover.1281985411.git.j6t@kdbg.org>
 <4C6C01A9.4080306@workspacewhiz.com>
 <AANLkTinwQqwjmeNfiUE6LiZtbBhEEFyisZXUgF9_b+2Q@mail.gmail.com>
 <201008182032.40375.j6t@kdbg.org>
 <AANLkTimtmudtWccRS==LrO_JrPmAJ7HzA6CU0ALbDZcV@mail.gmail.com>
 <4C7BC344.9020500@workspacewhiz.com>
 <AANLkTikbLtfx6xL6K32o_AXqY+qeqKANN5n2g0oYPoi6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 17:07:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5xA-0002aJ-5I
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 17:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab0H3PHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 11:07:06 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51462 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0H3PHF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 11:07:05 -0400
Received: by ewy23 with SMTP id 23so3236587ewy.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9Hh8GHadaAsmTXkEhIFLOnOh9WDdgFgXtk1+heCd5FU=;
        b=HwGZJKoT84Q4QleoOem3GhFMf7/i38MZ3RgvUyakJHCiqKJMmnRqh6IsZ+vNc722Bo
         vL4SNF24GDkh66dwrx2jgYZ/710E8AsoInQzfrhzX5NVPeqieO1fkV4OFKufQ/fXrp28
         kDfvKcendYf/hZ0Bzl9ausBFMWG8VtItSex8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EW5jtGrn8AMrDKrT8Xw3DBgcKaVkRl1sDzggI43J4l4yS4qNNSRAx84JgOkPkWVIhk
         R+4ZnZveDIdCXce9jYbWmseW6FQuTG7REvGnbB+7AbL2i2OeG4itS/vsh+lt0OSmI/i0
         /PJDC3XJ1kl0rF2lsLbDJW2ks8eTzBxxo+Bt8=
Received: by 10.239.130.208 with SMTP id 16mr272213hbk.73.1283180823859;
        Mon, 30 Aug 2010 08:07:03 -0700 (PDT)
Received: from burratino ([128.135.11.176])
        by mx.google.com with ESMTPS id w14sm2423761vce.26.2010.08.30.08.07.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 08:07:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikbLtfx6xL6K32o_AXqY+qeqKANN5n2g0oYPoi6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154821>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I don't think duplicating the GNU (or *BSD) version into a
> compat/fnmatch.c would be a bad thing. See e.g. compat/snprintf.c.

Maybe meanwhile someone (I guess that means "I") can ask around about
=46NM_CASEFOLD going into posix.  I like to imagine the compat/
directory shrinking over time.

>> You added COMPAT_OBJS above, but I think there is no linker
>> guarantee it will pick up compat/fnmatch/fnmatch.o over the C
>> runtime version? =C2=A0Perhaps the makefile is architected to do so.
>
> It's probably just an artifact of how the Solaris linker works

Isn't the portable way to do something like

 #define fnmatch gitfnmatch

in fnmatch.h?

Meanwhile I guess that no other system header includes fnmatch.h, but
if that were to happen, there would be preprocessor symbol conflicts.
So on systems with fnmatch, ideally one would want to do something
like this:

 #include <fnmatch.h>
 #ifdef FNMATCH_LACKS_CASEFOLD
 # undef FNM_PATHNAME
 # define FNM_PATHNAME	(1 << 0)
 # define FNM_CASEFOLD	(1 << 4)
 # define fnmatch gitfnmatch
 extern int fnmatch(const char *pattern, const char *name, int flags);
 #endif
