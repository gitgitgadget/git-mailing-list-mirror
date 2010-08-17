From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 19/24] merge script: handle -m --log correctly
Date: Tue, 17 Aug 2010 16:54:04 -0500
Message-ID: <20100817215404.GC2221@burratino>
References: <20100817065147.GA18293@burratino>
 <20100817070656.GS22057@burratino>
 <AANLkTimrrfVsP=yduEmstuhm=Y-Km=HmoYgAvRkmQf91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 23:55:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlU8O-0007kB-Ll
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 23:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427Ab0HQVzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 17:55:47 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46297 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab0HQVzq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 17:55:46 -0400
Received: by qyk9 with SMTP id 9so308336qyk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 14:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AVfPjD9TQ3diXChL0lOBnpQsRK7y7NtD1QcphankI6U=;
        b=gMboozrQNsUaBpPrVy4e36aA/yX/kE4yJyvu1xOGYz5oGDEjsUg03MIOimodb+RlPP
         OeTIUmDOltbdSzdvKYXc8QAvTW7lsXys8/0KGpGKiqCvU2llGoEOh4r22LCFoSFUyYAM
         XegWZmOyRRQBNWY511ZmVLH/5q3FHIPhUM6hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=C+e3HkZlCXhft0mjYQcusgSEq1xDTwHKNA4rSy++2D/AvgWXZXJGF7md5f57CaBNEw
         O11CsqzJI8oHE5drwd4Ax4lmu1rKHFB2xhyAW322nTHSPHCQzrmv7W3aH9EXSLz1bwrg
         bDA2UbV++FYJVjok3zYFmx9LhLC0ejiRlT8gA=
Received: by 10.229.175.167 with SMTP id ba39mr159384qcb.181.1282082145697;
        Tue, 17 Aug 2010 14:55:45 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r36sm9293440qcs.3.2010.08.17.14.55.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 14:55:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimrrfVsP=yduEmstuhm=Y-Km=HmoYgAvRkmQf91@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153783>

Tay Ray Chuan wrote:

> Thanks for the heads up.

Thanks for adding the feature in the first place. :)

> On Tue, Aug 17, 2010 at 3:06 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> +++ b/contrib/examples/git-merge.sh
[...]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done | git fmt-me=
rge-msg $log_arg
>> - =C2=A0 =C2=A0 =C2=A0 )
>> - =C2=A0 =C2=A0 =C2=A0 merge_msg=3D"${merge_msg:+$merge_msg$LF$LF}$m=
erge_name"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test "$have_me=
ssage" =3D t
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 git fmt-merge-msg -m "$merge_msg" $log_arg
>
> hmm, when did git-fmt-merge-msg learn -m? Mine (1.7.2.1.219.gf2a27) d=
oesn't.

Patch 11 from this series ("fmt-merge-msg -m to override subject line")
should do it, assuming it works correctly.
