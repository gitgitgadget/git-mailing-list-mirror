From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: parse_commit_text encoding fix
Date: Sat, 01 Aug 2009 02:21:55 -0700 (PDT)
Message-ID: <m3r5vvris1.fsf@localhost.localdomain>
References: <1249115323-17974-1-git-send-email-zfuzesi@eaglet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: =?iso-8859-1?q?Zolt=E1n_F=FCzesi?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Sat Aug 01 11:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXAn2-0005gl-9J
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 11:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbZHAJV6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 05:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZHAJV6
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 05:21:58 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:54483 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbZHAJV5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 05:21:57 -0400
Received: by ewy10 with SMTP id 10so2003531ewy.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=AFQ3PJ7dvRnhpFxCAoEs7svjmqeDgILOabbxgZw8Q0o=;
        b=r/yXwyZfvm67mbFWW69IflaOvZYxijuzFnvngnN0ZaOpen0nrg6cVRwOMXg9Cx+8Rb
         b3suN8J6/nLxA6sB7Uu7+MW5QStpkiro4FmoSlOTVTwHTobkek6/Y0PUWj9fTZa998gd
         tpzvbwrzv026zgzt4yIRIHY/qa50nf6nMS/dM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=SeAWr5jVQN2uIJ3EZDlw77aZR3IlM+4CjaqTVlsHKju+91LI/nfF/Y2J36YTlZOhiv
         pJd77F+ffZVL63PqXZYERn6k22B4WbFqWrlC5owHxFLqrKmLEnqgkLAyRhm1XdIRWoc5
         0uW4fjvi/Xq4KHAQUrwWQznRnRMrVgzIvQRqQ=
Received: by 10.210.29.17 with SMTP id c17mr2081171ebc.69.1249118516307;
        Sat, 01 Aug 2009 02:21:56 -0700 (PDT)
Received: from localhost.localdomain (abvt157.neoplus.adsl.tpnet.pl [83.8.217.157])
        by mx.google.com with ESMTPS id 24sm4494986eyx.53.2009.08.01.02.21.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 02:21:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n719LrBT006763;
	Sat, 1 Aug 2009 11:21:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n719LoRt006760;
	Sat, 1 Aug 2009 11:21:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1249115323-17974-1-git-send-email-zfuzesi@eaglet.hu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124614>

Zolt=E1n F=FCzesi <zfuzesi@eaglet.hu> writes:

> Call to_utf8 when parsing author and committer names, otherwise they
> will appear with bad encoding if they written by using
> chop_and_escape_str.

[re-wrapped]

>=20
> Signed-off-by: Zolt=E1n F=FCzesi <zfuzesi@eaglet.hu>

Thanks.


Still, I do wonder if it would be possible to simply do the following:

  -binmode STDOUT, ':utf8';
  +use open qw(:std :utf8);

=2E..but it unfortunately doesn't work.  It was tried in
  http://thread.gmane.org/gmane.comp.version-control.git/87129/focus=3D=
87135

to_utf8() has at least (possible) fallback if it encounters characters
outside of UTF-8 coding.

> -			$co{'author'} =3D $1;
> +			$co{'author'} =3D to_utf8($1);

--=20
Jakub Narebski

Git User's Survey 2009:=20
http://tinyurl.com/GitSurvey2009
