From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: [PATCH] format-patch: cover letter does not respect
 i18n.commitencoding
Date: Tue, 20 Sep 2011 23:55:05 +0400
Message-ID: <20110920235505.26fb6501@zappedws>
References: <1316507177-6403-1-git-send-email-zapped@mail.ru>
	<7v62kn6mqi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:55:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66Pc-0005BI-Bu
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab1ITTzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 15:55:17 -0400
Received: from smtp15.mail.ru ([94.100.176.133]:46392 "EHLO smtp15.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1ITTzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 15:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=ZrcRR0zkmQw0NdtcTFZ91Ty52STZnizjAKX4KlnKNKM=;
	b=iPqb1HFbHUXteTG042ag9CxcHR89KECrzD+WDgcYYd6pl8ZezdnFsDRQqG5s5fRGwJTMRvSx5hRVkbylU3SFtI1SKiAz2rFKh7dshfJo5my+t/PaKMUeb++D6CnAKbVX;
Received: from [91.77.15.134] (port=20490 helo=zappedws)
	by smtp15.mail.ru with psmtp 
	id 1R66PS-00022U-00; Tue, 20 Sep 2011 23:55:14 +0400
In-Reply-To: <7v62kn6mqi.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181787>

> Alexey Shumkin <zapped@mail.ru> writes:
> 
> > diff --git a/builtin/log.c b/builtin/log.c
> > index 5c2af59..6a4050c 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -769,7 +769,7 @@ static void make_cover_letter(struct rev_info
> > *rev, int use_stdout, struct shortlog log;
> >  	struct strbuf sb = STRBUF_INIT;
> >  	int i;
> > -	const char *encoding = "UTF-8";
> > +	const char *encoding =  get_commit_output_encoding();
> 
> Hmm, I have a feeling that this should use log output encoding. Am I
> mistaken?
Oooh! I made a mistake. I'm sorry

get_log_output_encoding must be used instead, yes

> The i18n.commitencoding variable is about the internal representation
> in the object [*1*] that is to be converted from the encoding of the
> original e-mail message which could be different.
> i18n.logoutputencoding is to externalize it [*2*].
> 
> [Footnotes]
> 
> *1* f1f909e (mailinfo: Use i18n.commitencoding, 2005-11-27)
> *2* a731ec5 (t3901: test "format-patch | am" pipe with i18n,
> 2007-01-13)
> 
