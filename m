From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Mon, 30 Aug 2010 09:09:58 -0500
Message-ID: <20100830140958.GE2315@burratino>
References: <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
 <20100828214641.GA5515@burratino>
 <20100828215956.GB5515@burratino>
 <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
 <20100828221655.GB5777@burratino>
 <AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com>
 <20100829204519.GB1890@burratino>
 <AANLkTin4A6B9zqSYHsWQ+GLWRqLvzJWAQ0F2WC85zDqC@mail.gmail.com>
 <20100830134136.GA2315@burratino>
 <alpine.BSF.2.00.1008301353260.95618@x.fncre.vasb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcin Cieslak <saper@saper.info>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:12:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq55f-0005j7-N9
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab0H3OLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 10:11:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40422 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab0H3OLt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 10:11:49 -0400
Received: by wwb28 with SMTP id 28so7339934wwb.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/A9jK5PzLh0zelgObDbDmjikg359+qQwj2lvdwuR24I=;
        b=EVqoJqF1bzTyvnQ/h9SLUhZP+7bOSM1GCZlz/nOlgzZ4mBaqVQYrhUBntTb4Tyoj/Z
         hgQfhRI4IUKxJpP8xbv+O6vxeoNbaqiAdqg0x+TayUfKtWI/4HR1ZbOCWAGmu/LQAwz+
         51dFHIuqB9jLoPe2QWAC2+sufYCwUEHAM8LeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k511zwpXDO9rmhs2szTt02JFwWdZrX18heLz37YV06Yu0FVn6ylhHxTzVCDFMD1DEk
         KsrFLvrEq00iNPihI0HImRaeCWAkh93gSKAfIrf8PtIcKoplYZIBz+VF0jhdKroCDjLu
         jjnQas3PCbyGfIBZW5ALVQHQruU45YfRpfado=
Received: by 10.227.94.138 with SMTP id z10mr4439871wbm.166.1283177508339;
        Mon, 30 Aug 2010 07:11:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id k46sm4469498weq.10.2010.08.30.07.11.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 07:11:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.00.1008301353260.95618@x.fncre.vasb>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154807>

Marcin Cieslak wrote:

> Well, in this case everybody will be force to have UTF-8 in output
> on-screen, not useful for people using ISO8859-*, KOI8-R and similar
> things...

Can't we do:

	setlocale(LC_CTYPE, "");
	charset = nl_langinfo(CODESET);
	setlocale(LC_CTYPE, "C");

to allow an arbitrary character set?
