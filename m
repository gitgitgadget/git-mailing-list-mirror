From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/3] pretty: add conditional %C?colorname
 placeholders
Date: Sun, 25 Apr 2010 21:13:47 -0500
Message-ID: <20100426021347.GA29669@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 04:13:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Dos-0001yS-1F
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 04:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab0DZCNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 22:13:01 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64235 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab0DZCNA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 22:13:00 -0400
Received: by qyk9 with SMTP id 9so16516037qyk.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 19:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LhXEj1PwVt98Ofo/VBns9eX6ODLB6ml9ehm3HlLxqY4=;
        b=KAcvZgS/UcnGtNJZ3SPUwMQA6GV466HF2+zVqq3X3P1bG85yjne+UmLPdWFvJ4xOQS
         qygvbPcPbBpu8NklkvM6qythv4ZWbCRIase+hBFV99bbNszNnL47Sk7p9/k+FvNr9uGw
         ymR2y6jaNf/3/5IrsRlPL2B+kLA2jwxB7arFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=J6xGyw2epDr4VBQ+OwOYUue8AD/UUaTMxRBKjrq7ULo1xavXUNfFRc/qHxu0XSQ95T
         VT1Cl8AKi01ATszrFU082h2/+7tpNiegWl51gSP5UJ+Ux/E5mBJFqKrSUoaqf7KAsv5K
         gVk9z2pnukkp9ihmZiZj1pFj/mGj+guzLMCGg=
Received: by 10.229.228.3 with SMTP id jc3mr3955240qcb.83.1272247979917;
        Sun, 25 Apr 2010 19:12:59 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2677135iwn.14.2010.04.25.19.12.59
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 19:12:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145779>

Hi Will,

Will Palmer wrote:

> Here we add the %C?colorname placeholders which act just as the
> %Ccolorname placeholders, with the exception that the pretty_context =
is
> checked to see if color should be used according to configuration

Thanks for tackling this.

I have thought a little about a related problem: some commands have
configuration for the colors they use, like:

    color.grep.<slot>
        Use customized color for grep colorization.  <slot> specifies w=
hich
        part of the line to use the specified color, and is one of

        context
            non-matching text in context lines (when using -A, -B, or -=
C)

        filename
            filename prefix (when not using -h)

This is nice because in certain situations (e.g. different background
colors), the default colors might not be suitable.  As an example of
this, the =E2=80=98commit =E2=80=99 line of =E2=80=98git log=E2=80=99 o=
utput uses color.diff.commit.

So it would be nice to be able to use %C(diff.commit) and
automatically use the right color, if color is enabled.

Why not make %C always check?  I can understand that it would be
annoying when first trying to use %C.  On the other hand, it would be
more convenient for writing format.pretty configuration that should be
shared with old git, and I assume anyone using %C for the first time
would be looking at the manual, which could warn her.

Cheers,
Jonathan
