From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] build: do not automatically reconfigure unless
 configure.ac changed
Date: Wed, 2 Jan 2013 00:42:48 -0800
Message-ID: <20130102084248.GA22919@elie.Belkin>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
 <20130102072141.GB18974@elie.Belkin>
 <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com>
 <20130102082544.GD18974@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 09:43:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqJuw-0007Ib-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 09:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab3ABIm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 03:42:59 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54431 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab3ABIm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 03:42:58 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so7818010pad.38
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 00:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=i2qfMl8UH1isskOEdUkjVGINtCR0/eRgnAeSZ8o9Ysg=;
        b=vWRlcIgJBZVmN1ao9hpfS71KgaBW3Nk/cuAOeC6LS27gysJAktrqH3bCymbmmcF5ag
         s2yeoJ3Y/B7WiQ5/PMMaPZSw04pb65hL6J+eRyeZoeRNXxtoILWyoU9w4AKnq1Ddm9qe
         M/cCuTxufdx1LgLFz+UNFQsbzz/sbOitiVWS8fzKCWhvGzEcg37EuRPFLgXUie0FyD1h
         HHaS1wfUh7vPyjjmw4U5n79IC6/fgNoq9w3bTWcTfkoVGoGYmss5rLQLjauB4mGTUHsw
         pbwJRiW7miNeo5w5wXAbUCof9m68HwGcz0eBXvoe9AiH608tCrJowWPEGcz/pGVLJ2A1
         qleg==
X-Received: by 10.68.83.68 with SMTP id o4mr143947163pby.25.1357116177589;
        Wed, 02 Jan 2013 00:42:57 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id kp4sm28076361pbc.52.2013.01.02.00.42.55
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 00:42:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130102082544.GD18974@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212505>

Jonathan Nieder wrote:

> Starting with v1.7.12-rc0~4^2 (build: reconfigure automatically if
> configure.ac changes, 2012-07-19), configure is automatically run
> every time the "configure" script changes.  In particular, that
> means configure is automatically rerun whenever the version number
> changes (which changes the configure script to support "./configure
> --helpe")

Gah, I sent the log commit message --- the patch description from v1
is the right one.  Sorry for the trouble.  Here is the fixed
description again.

Subject: build: do not automatically reconfigure unless configure.ac changed

Starting with v1.7.12-rc0~4^2 (build: reconfigure automatically if
configure.ac changes, 2012-07-19), "config.status --recheck" is
automatically run every time the "configure" script changes.  In
particular, that means the configuration procedure repeats whenever
the version number changes (since the configure script changes to
support "./configure --version" and "./configure --help"), making
bisecting painfully slow.

The intent was to make the reconfiguration process only trigger for
changes to configure.ac's logic.  Tweak the Makefile rule to match
that intent by depending on configure.ac instead of configure.

Reported-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
