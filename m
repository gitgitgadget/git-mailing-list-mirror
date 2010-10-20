From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] t/gitweb-lib: Don't pass constant to decode_utf8
Date: Wed, 20 Oct 2010 21:05:58 +0200
Message-ID: <201010202105.59370.jnareb@gmail.com>
References: <1287554231-84196-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Sven Verdoolaege <skimo@kotnet.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 21:06:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8dzR-0001Oo-Jn
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 21:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab0JTTGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 15:06:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56576 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab0JTTGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 15:06:09 -0400
Received: by bwz10 with SMTP id 10so1613990bwz.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m8EnztSjc3rjT9e4/fPtXVvJ3kkbM/t/jA93ty0FDQ4=;
        b=uZBUb1AQ795WD8ZjZawvfSj7eaLHpTJLUoeVKMXDrW89b1hFb8L9z9kxdb3drlNhJK
         jcYdMW83EpgtxlVJHjMYSKDVOvHTQep9ntbYS1blknQ0w10lRzg+0vJVez0h2WsQwpsc
         86r/YDevf7kP3JTwyHKdnfOXMMnb6ad4bjRsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=H08uA9V+dbnIUaWibqF1o56hpYfIEBpdMYN9HNgoYo3nAUwOTFOBc38Z+01+4gVuLE
         6D8nEGtAFDiJOT//TMKHVm1ZzS/7YP7ykL78LBhZMSvth1dolCfvBuSkAx1A9JlTly/w
         X8mVL1r0LrUCEKyseQ2rdhHiVMlEhrDhzb1CY=
Received: by 10.204.121.84 with SMTP id g20mr7129544bkr.37.1287601568180;
        Wed, 20 Oct 2010 12:06:08 -0700 (PDT)
Received: from [192.168.1.13] (abvx10.neoplus.adsl.tpnet.pl [83.8.221.10])
        by mx.google.com with ESMTPS id d12sm470636bkw.7.2010.10.20.12.06.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 12:06:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287554231-84196-1-git-send-email-brian@gernhardtsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159422>

On Wed, 20 Oct 2010, Brian Gernhardt wrote:

> Encode.pm started updating the string to decode in-place when a second
> argument is passed in version 2.40.  This causes 'decode_utf8("",
> Encode::FB_CROAK)' to die with a message like:

Very minor complaint: line break here makes it less readable.

Perhaps this?

  Encode.pm started updating the string to decode in-place when a second argument
  is passed in version 2.40.  This causes 'decode_utf8("", Encode::FB_CROAK)' to
  die with a message like:


> 
> Modification of a read-only value attempted at
> /Library/Perl/Updates/5.10.0/darwin-thread-multi-2level/Encode.pm line
> 216.

Very minor complaint: It might be better to not include path to installed
Encode.pm, which is different on different filesystems.

  Modification of a read-only value attempted at .../Encode.pm line
  216.

> 
> Work around this by passing an empty variable instead of a constant
> string.
> 
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
> 
>  Changes since v1:
>  - Use an explicitly empty variable instead of $_

...which was undefined, not empty, I think.

>  - Clearer commit message

It is very clear (though I don't remember previous one).

>  - CC people who worked on t/gitweb-lib.sh

Thanks a lot.

>  - based against maint

Was there any difference versus being based against 'master'?

> 
>  t/gitweb-lib.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> index 81ef2a0..1b9523d 100644
> --- a/t/gitweb-lib.sh
> +++ b/t/gitweb-lib.sh
> @@ -80,7 +80,7 @@ if ! test_have_prereq PERL; then
>  	test_done
>  fi
>  
> -perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
> +perl -MEncode -e '$e="";decode_utf8($e, Encode::FB_CROAK)' >/dev/null 2>&1 || {
>      skip_all='skipping gitweb tests, perl version is too old'
>      test_done
>  }

Nicely done! Thanks!

-- 
Jakub Narebski
Poland
