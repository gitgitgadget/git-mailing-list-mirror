From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 5/8] gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
Date: Fri, 6 Apr 2012 01:26:37 +0200
Message-ID: <201204060126.38337.jnareb@gmail.com>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com> <1333569433-3245-6-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 01:26:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFw4h-0004DW-Ff
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 01:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab2DEX0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 19:26:39 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59402 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab2DEX0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 19:26:38 -0400
Received: by wgbdr13 with SMTP id dr13so1733131wgb.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 16:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=bTzOKLZ1ljXjwJJYrku7xfrrztcj0k11zhPM7yOsZcw=;
        b=JhHFmhpCdXCz1ZYUtxCwnLG6yJU2idg2hDKficTA5rFEfDGaUkdbx4XPdpsuvXTt8P
         X5+Owqgfu2/oTv4bSgEX/YLHHjDqY94W0W15nvLhQAuR3tBFrROtKRDPEftHgCZs+jYj
         YJW/s0afi0JpRMYWMHYZY0Olw+9piQgLPgD4Da8e4Q/r3z3AgFCobqM8y3jJWnqLSdjp
         eo/5UcQy+wkdjAgKZeqPLAho5kOJ8ttXSw3t2qcS7BVaPOC37/K/txvga98eC3w3a4JF
         5sgryKXByJgvoNxtlmP5b2vujzxbGDncvJpBSVNeEmlc6siyM+Y1VrRPnnSyGVRa4/NP
         Sneg==
Received: by 10.180.107.132 with SMTP id hc4mr7047862wib.21.1333668397378;
        Thu, 05 Apr 2012 16:26:37 -0700 (PDT)
Received: from [192.168.1.13] (acxc205.neoplus.adsl.tpnet.pl. [83.11.160.205])
        by mx.google.com with ESMTPS id ff9sm1341507wib.2.2012.04.05.16.26.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 16:26:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1333569433-3245-6-git-send-email-michal.kiedrowicz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194821>

Micha=C5=82 Kiedrowicz wrote:

> This renames print_sidebyside_diff_chunk() to print_diff_chunk() and
> makes use of it for both side-by-side and inline diffs.  Now diff lin=
es
> are always accumulated before they are printed.  This opens the
> possibility to preprocess diff output before it's printed, which is
> needed for diff refinement highlightning (implemented in incoming
> patches).
>=20
> If print_diff_chunk() was left as is, the new function
> print_inline_diff_lines() could reorder diff lines.  It first prints =
all
> context lines, then all removed lines and finally all added lines.  I=
f
> the diff output consisted of mixed added and removed lines, gitweb wo=
uld
> reorder these lines.  This is true for combined diff output, for
> example:
>=20
> 	 - removed line for first parent
> 	 + added line for first parent
> 	  -removed line for second parent
> 	 ++added line for both parents
>=20
> would be rendered as:
>=20
> 	- removed line for first parent
> 	 -removed line for second parent
> 	+ added line for first parent
> 	++added line for both parents
>=20
> To prevent gitweb from reordering lines, print_diff_chunk() calls
> print_diff_lines() as soon as it detects that both added and removed
> lines are present and there was a class change.
                                                 , and at the end of hu=
nk.


I think it is worth adding the above to the commit message.

--=20
Jakub Narebski
Poland
