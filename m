From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 21:10:35 +0200
Message-ID: <201004142110.36453.jnareb@gmail.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <l2jfabb9a1e1004111635v16e4dc86g405883ca12d316b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 21:10:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O27ya-0004O0-NF
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 21:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab0DNTKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 15:10:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:18138 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab0DNTKH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 15:10:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2348835fgg.1
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xM/2jKzSBU5koiNuVzv25Yq7y6+/THJJ+KZ6sUDpp1w=;
        b=C5kWgPv+S7QX2bsk/dsxGEaf4ILQCz+USx+zDAru8Ufl3xHbsQytAIx6NOaNkrimtf
         50e/PX69OPTu0Kv6ajU0IMfe+S/qQSUx1DIZNP9yhlIWGqnzLPkni9AVQxtoyG13JkeG
         x4Q6SWo/6Jf9Mx6pjG2923q9HDezHqyJ7Eleo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=P9zlsvdk5HSDA/GLyDjN46xccoSjZgpCXtHGjznGIJJXm8arJvHSZK06TN72zLFh28
         oTMDbFhitJZXnD7uSv/YZAWmeRtZy9HcPbQUzRNAnMcwnK81o8YlIfZ/DnrI/N/flIMQ
         SX3X/vfaAZFVg404OICwWZet2ZoY0psVauzpg=
Received: by 10.87.71.7 with SMTP id y7mr6170883fgk.63.1271272205923;
        Wed, 14 Apr 2010 12:10:05 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id 18sm1313832fkq.34.2010.04.14.12.10.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 12:10:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <l2jfabb9a1e1004111635v16e4dc86g405883ca12d316b9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144892>

On Mon, 12 April 2010, Sverre Rabbelier wrote:
>=20
> On Mon, Apr 12, 2010 at 01:21, Julian Phillips <julian@quantumfyre.co=
=2Euk> wrote:
> > Probably the biggest change from v1 is an expanded aim. =C2=A0Now t=
he output library
> > is aimed at controlling _all_ plubming output. =C2=A0This series in=
cludes a patch for
> > ls-tree that has all it's output going through the library, and a p=
atch for
> > status that has all the --porcelain output going through the librar=
y.
>=20
> I like where this is going, a lot, especially since we don't have to
> convert everything in one go, but we can do it as desired, similar to
> optparsification. I still think more commands than just these two
> should be converted to validate the design though, perhaps something
> like 'git blame', or 'git for-each-ref'?

I don't think it is needed for either command.

'git blame' has --porcelain and --incremental output, which is line-bas=
ed
and pretty much self-describing (with "header-name value" syntax for mo=
st
of it), and well documented.  JSON output would only add unnecessary
chatter and different quoting rules.

'git for-each-ref' has both --format=3D<format> to allow to get data wh=
at
one needs, and in the format one wants (with e.g. %00 to reresent NUL),
and [--shell|--perl|--python|--tcl] for placeholders in <format> to be
quoted as string literals suitable for specified host language.  Althou=
gh
I am not sure if this option, meant to produce scriptlets, is used that
much/ note that there is not support for --json quoting, nor --xml=20
escaping.

--=20
Jakub Narebski
Poland
