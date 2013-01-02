From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2] build: do not automatically reconfigure unless configure.ac
 changed
Date: Wed, 02 Jan 2013 15:13:47 +0100
Message-ID: <50E4409B.4070203@gmail.com>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com> <20130102072141.GB18974@elie.Belkin> <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com> <20130102082544.GD18974@elie.Belkin> <20130102083837.GA9328@sigill.intra.peff.net> <20130102084807.GB22919@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 15:14:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqP5B-0000mL-3F
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 15:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab3ABONz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 09:13:55 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:58702 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3ABONx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 09:13:53 -0500
Received: by mail-bk0-f44.google.com with SMTP id w11so6046734bku.3
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 06:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pF+/QAA2EBrGve+0O3thTYNca8YoJkWWAP0rhg7WA6s=;
        b=HIiIn4NkA0661B4EjkwucIEE9gb428L8YH1h8kpWG0Z/ortzyLX1jDvZu2gI5Zpnmz
         Xqt79hHNiWXlquPmtuK6Fl8+jYE0MllGOcRHJV2QTfJb1R5mQcnidIm/gIkBmHvVDIKF
         f4RErvI3Vi9fTxscvxCQUC0GSdzHbMnpBQJgt+vLOk5+8UF5LmkNEF6/NGPzj9bBm144
         DPlrvIjBrglAk8dh17ZOnLk/sFERB8zqbfzkQKclWR7ReVaLNV7hK3mQBp8EotN4Uxqq
         vt5zMM8JV4llLktnuPf8CtauRQzgQ8zDE+YJYuUaifRGhxyglitKBmS7/mOVSNuOUbmQ
         u4/w==
X-Received: by 10.204.5.211 with SMTP id 19mr21922300bkw.42.1357136032055;
        Wed, 02 Jan 2013 06:13:52 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id d16sm31299303bkw.2.2013.01.02.06.13.49
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 06:13:51 -0800 (PST)
In-Reply-To: <20130102084807.GB22919@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212514>

On 01/02/2013 09:48 AM, Jonathan Nieder wrote:
> Jeff King wrote:
> 
>> It seems I am late to the party. But FWIW, this looks the most sane to
>> me of the patches posted in this thread.
> 
> Thanks.  config.status runs ./configure itself, though, so the rule
> should actually be
> 
> 	config.status: configure.ac
> 		$(QUIET_GEN)$(MAKE) configure && \
> 		if test -f config.status; then \
> 		  ./config.status --recheck; \
> 		else \
> 		  ./configure;
> 		fi
> 
> Rather than screw it up yet again, I'm going to sleep. :)  If someone
> else corrects the patch before tomorrow, I won't mind.
>
FYI, this seems a sane approach to me.  At least until Autoconf is
improved to offer better (read: some :-) support to "dynamic" package
version numbers specified at configure runtime.  I hope that day
isn't too far, since the current Autoconf limitation has been causing
its share of annoyances small woes in Automake and Gnulib as well.

The only nit I have to offer is that I'd like to see more comments in
the git Makefile about why this "semi-hack" is needed.

Thanks,
  Stefano
