From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Fri, 13 Jan 2012 00:59:53 +0530
Message-ID: <CALkWK0=NVUd629FgkPfgi8ZgTuO+a10t+iwbSrAvONCSmeq2rQ@mail.gmail.com>
References: <20120111173101.GQ30469@goldbirke> <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke> <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com> <4F0F32CC.8040404@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:30:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlQM3-00089R-Bv
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 20:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab2ALTaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 14:30:19 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:45248 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127Ab2ALTaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 14:30:15 -0500
Received: by werm1 with SMTP id m1so1630617wer.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 11:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SP5Zi8h0OpK9JkRNDFdj3ZaTXtOE5Srw+bhE8ciE4sE=;
        b=XKZI02t9BIRWbMt2PhgpAfuRiOAAuBVjSyBBoA0o0E3iDOYnuJ9hqtJSJr3kkoMTSZ
         J/bsoWkvfSqYsFh8Pm+WjCJYqdyoAGIynezXIfAZFo1XwiDfBjk9XePP0GoMrkRLAIys
         +eCU7X1hPC+uaoBeo3tj4c75LIk6RpQ3ZYTqU=
Received: by 10.216.139.153 with SMTP id c25mr709270wej.25.1326396614221; Thu,
 12 Jan 2012 11:30:14 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Thu, 12 Jan 2012 11:29:53 -0800 (PST)
In-Reply-To: <4F0F32CC.8040404@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188475>

Hi Johannes,

Johannes Sixt wrote:
> Why do we need a new flag?
>
> =C2=A0git show origin/master origin/maint
> =C2=A0git show origin/maint origin/master
>
> show the revisions in different order, in particular, in the order
> requested on the command line. Shoudn't cherry-pick be able to do the
> same without new hacks?

That was my first reaction too -- then I saw builtin/push.c (the
builtin show is quite similar), and found out that it doesn't use the
revision walker at all.  It operates on refs, which has different
semantics altogether (called "refspec" in some places I think).

-- Ram
