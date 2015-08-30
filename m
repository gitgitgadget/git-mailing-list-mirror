From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 16:40:24 -0400
Message-ID: <20150830204024.GA1249@flurp.local>
References: <20150826021517.GA20292@sigill.intra.peff.net>
 <CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
 <CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
 <CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
 <CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
 <CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com>
 <CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
 <CAPig+cTEd_Ceei82x=bxhVZfoggixBCf27U2zHxAwOm9dAtG-g@mail.gmail.com>
 <xmqqd1y4zpjx.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTf2YLWGi2swmMxdx_XpEU=GkAx11ng6VVACMX9NpA_SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Gabor Bernat <bernat@primeranks.net>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 22:40:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW9PG-0005Fb-Kv
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 22:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbbH3Ukb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 16:40:31 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32894 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbbH3Uka (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 16:40:30 -0400
Received: by iods203 with SMTP id s203so139561939iod.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8glnumysf+gIDAIoThF4Y1ll6QZUjPjkTpb15iM6QWc=;
        b=E7JyzhBNV37NxXPKTnQu88yWV2e9dl3oSUcMxhQbsql4viO5Zfusx25e7ZRlpnM0u6
         mtIPn9ObjtAvMube/wElCBu7enCYdNuZEfiMWKpnFmd24GM7qDmzXmWpsEXIK4LG164f
         jDB9KVVEoDxRnNKOLTGvVfBHPENX0mQdvn6R5y8ILzq1MMBDLPYAyASON5PhVjnEjm/K
         e1T+F+fYBDXdL2pNdsM3Ow7ciBfNy5Atp0HSUipj5RGL2cUEs2VRYJp+tsjxPKEWLi7E
         ygVtKrudbWOaZ2vJFwSFQPliWzKekLU/zzB2XCVwStOv7b3G42lepgDs1aXsfXMaMlub
         v7OA==
X-Received: by 10.107.25.20 with SMTP id 20mr25572802ioz.169.1440967230045;
        Sun, 30 Aug 2015 13:40:30 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id qc6sm9080838igc.1.2015.08.30.13.40.29
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 30 Aug 2015 13:40:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cTf2YLWGi2swmMxdx_XpEU=GkAx11ng6VVACMX9NpA_SQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276837>

On Sun, Aug 30, 2015 at 03:40:20PM -0400, Eric Sunshine wrote:
> I suppose a viable approach might be to test once outside the loop if
> "date +%s" is supported and print the "(%d elapsed / %d estimated
> remaining)" annotation within the loop if it is, else not. The test
> might look something like this:
> 
> echo $(date +%s) | grep -q '^[0-9][0-9]*$' 2>/dev/null && show_eta=t

Actually, you'd also want to suppress 'date' errors via /dev/null, so
perhaps:

  { echo $(date +%s) | grep -q '^[0-9][0-9]*$'; } 2>/dev/null && show_eta=t

or something.

> Platforms, such as Linux, Mac OS X, and FreeBSD, which support "date
> +%s" would get the annotated output, whereas it would fall back
> gracefully to the non-annotated output on platforms such as Solaris
> (and perhaps AIX) which lack it.
