From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] merge-recursive: Workaround unused variable warning
Date: Tue, 17 Aug 2010 19:10:32 -0500
Message-ID: <20100818001032.GA7694@burratino>
References: <1281665352-10533-1-git-send-email-newren@gmail.com>
 <1281665352-10533-2-git-send-email-newren@gmail.com>
 <AANLkTikLXy4gPttmX=wzcDaFAfZO=OEk4PEDKh3sCSOF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Sixt <j.sixt@viscovery.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 02:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlWGP-0004kp-G0
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 02:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab0HRAMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 20:12:12 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36847 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab0HRAML convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 20:12:11 -0400
Received: by qyk33 with SMTP id 33so4200qyk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 17:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=J1axMKQ1TF9BKP+Tw6bEDCjFUOoGbZelEVtadyRZMNA=;
        b=FxTrFWvoQN0kTYbdGKEd0W4XNk4qkRPF2RISx6pW7bH4kELFiuAN2QHSdGpaMyaQQo
         E6uJoTgnafO1v6Wy9PW8KCb7BEgQpLyNOpnvnC1S7UxV2w7ru8suCV7SdissHsMdhvFk
         TEVQ8oZjQ2Ef7D5fXAQNVpx6oaQu1vQ0nwmj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Y7IaHnzkNNpOcevGEFmXAhvMp37XKpjYefmHLh5R82w7C0wI72C9X0xrLxhq1YGLvf
         NvZJpxa42HERy8wn5S7jFxfSis27YFBtzIC7PhCc4FUUGChR3ZOYtCaTQMSWmsvrwvPt
         oTh5QdktAuNvjAVgGJA393iGkaKdmqFm0i2Hc=
Received: by 10.224.67.81 with SMTP id q17mr4864615qai.276.1282090330156;
        Tue, 17 Aug 2010 17:12:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm9450188qcq.10.2010.08.17.17.12.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 17:12:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikLXy4gPttmX=wzcDaFAfZO=OEk4PEDKh3sCSOF@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153800>

Elijah Newren wrote:
> On Thu, Aug 12, 2010 at 8:09 PM, Elijah Newren <newren@gmail.com> wro=
te:

>> +++ b/merge-recursive.c
>> @@ -1214,6 +1214,7 @@ static int process_df_entry(struct merge_optio=
ns *o,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We currently only handle D->F cases */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0assert((!o_sha && a_sha && !b_sha) ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!o_sha && !a_sha &=
& b_sha));
>> + =C2=A0 =C2=A0 =C2=A0 (void)o_sha;
[...]
>                        would a different method of fixing warnings
> when NDEBUG is defined be preferred?  (Maybe changing the
> "assert(foo)" into "if (!foo) die..." instead?)

Yes, that sounds like a good idea.  The user would probably benefit
from knowing what happened.
