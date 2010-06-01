From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-instaweb: Add option to reuse previous config file
Date: Tue, 1 Jun 2010 23:31:37 +0200
Message-ID: <201006012331.37871.jnareb@gmail.com>
References: <1275399845-13311-1-git-send-email-pavan.sss1991@gmail.com> <201006012240.18755.jnareb@gmail.com> <AANLkTinmDi-4nZm9x81FlDbp9mJMLoWmom2qUKnSLIrZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 23:29:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJZ1p-0003JA-82
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 23:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422Ab0FAV3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 17:29:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37385 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757151Ab0FAV3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 17:29:24 -0400
Received: by fxm8 with SMTP id 8so1395959fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6ow7xsRl2iNT4JA9LgFDWyBVopWfC0kn7Z2Irkws0Ro=;
        b=D8bXBFrduWamA80w2k0tpjxAJInvq35P4z/9EUuHf6+EnyaweRcr7V2tX7PZyyEDKF
         FzD36kijHSrV+KTurMWtDWVfGoPWw9RwmaTOzyFORip/jo5v+DRVnnbwYU10ZFxJQLWe
         xvLFg8AxxdTKWCNmHvqBoaTuj13B09o6OdOMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AIlH0dBCM5yxgJJfjUYlWbZ+gnfroclO3zUdn9TvgTmc7YAXF48Mcs6P7XYvYuAuur
         8IjNStmfpBuzVblHS7UPWH0ENLo5UBTqKqiQ/JS87tnRzFn/0iTrIurnngqFHYFrrTTg
         e6VTsmcrGiuroJNoMlHV6oGaAqcmwEhrN8aW8=
Received: by 10.223.17.136 with SMTP id s8mr7719795faa.41.1275427762410;
        Tue, 01 Jun 2010 14:29:22 -0700 (PDT)
Received: from [192.168.1.15] (abvg224.neoplus.adsl.tpnet.pl [83.8.204.224])
        by mx.google.com with ESMTPS id r12sm48905395fah.20.2010.06.01.14.29.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 14:29:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinmDi-4nZm9x81FlDbp9mJMLoWmom2qUKnSLIrZ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148160>

Pavan Kumar Sunkara wrote:
> 2010/6/2 Jakub Narebski <jnareb@gmail.com>
> 
> > On Tue, 1 June 2010, Pavan Kumar Sunkara wrote:
> >
> > > Add an option to git-instaweb which allows the usage of the old
> > > gitweb_config.perl situated in '.git/gitweb' dir. When the option
> > > is in use, gitweb_conf() won't be used and thus the gitweb_config.perl
> > > won't be overwritten.
> >
> > I think that the correct solution would be to avoid overwriting
> > (customized) git-instaweb's gitweb_config.perl, but to generate it if
> > it does not exist.
> 
> So, you say that there is no use of this option ?
> Well, what happens if someone want's to overwrite their 
> gitweb_config.perl?

No, I am not saying that.

If git-instaweb is invoked *without* --reuse-config, the gitweb_config.perl
would be regenerated whether it exists or not, overwriting your changes.

If git-instaweb is invoked *with* --reuse-config, the gitweb_config.perl
would be generated if it does not exist (so if you delete gitweb_config.perl
and then run 'git instaweb --reuse-config' it would not fail), and reused
if it does exist.

  test "$no_reuse" = true || test ! -e "$GITWEB_CONFIG" && gitweb_conf

or something like that (the test if $GITWEB_CONFIG file exists might be
moved to the fragment of code that sets no_reuse to true instead).

-- 
Jakub Narebski
Poland
