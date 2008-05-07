From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 7 May 2008 16:15:58 +0100
Message-ID: <e2b179460805070815u6cc627feo6137084fe7c5a635@mail.gmail.com>
References: <1210149355875-git-send-email-mike@abacus.co.uk>
	 <4821992F.4060201@viscovery.net>
	 <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>
	 <4821AB32.8090700@viscovery.net> <4821BECA.8020509@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed May 07 17:17:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtlOC-0007MI-1C
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 17:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbYEGPQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 11:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbYEGPQD
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 11:16:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:62195 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758557AbYEGPP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 11:15:59 -0400
Received: by rv-out-0506.google.com with SMTP id l9so412487rvb.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vWr/fS0J7YK7xJIRQ0kQhFCMhtMDhUDAgG1f23BNa8g=;
        b=sr8fsbICyauyV2wV2MZyQdVEzcJZb9BZS5LajodAT6d/wM3TVWMcBMePCBVoDhpMQMkOJQcBMJhH2CZA4Y8iy4mwh+L0Z4xlJtDhT3XftQcsLVJVlUUVwDtv7I8wC6xRMi9k11aTth+vKwWv69LwN3/98WpD4XUSjt4QpF6wjoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bFz5cMbmI+iI5fontyASnXOn70PGUTjlbr1AyoLMPBVfYwdnpKlNSkSEE3pKcbNDVcpmc0D2hkC61TnX2t1ogW7fE5q/+HWc/3arWETY4xjoF41OhTB4vyKQKA29BIT1UYpUFGF6Q61Y4B9V6HgOWY7l/iXFHKFiTIpxgtMdJyQ=
Received: by 10.140.171.4 with SMTP id t4mr1005625rve.230.1210173358875;
        Wed, 07 May 2008 08:15:58 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Wed, 7 May 2008 08:15:58 -0700 (PDT)
In-Reply-To: <4821BECA.8020509@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81446>

2008/5/7 Brandon Casey <casey@nrlssc.navy.mil>:
> Johannes Sixt wrote:
>  > The #define fopen in git-compat-util.h essentially defeats the effect of
>  > _LARGE_FILES as far as fopen() calls are concerned: If
>  > FREAD_READS_DIRECTORIES is not defined, fopen() would be redirected to
>  > fopen64(), but when it is defined, it is redirected to git_fopen(), which
>  > in turn uses fopen() instead of fopen64() (due to the #undef in
>  > compat/fopen.c).
>  >
>
>  How about something like this?
>
>  diff --git a/compat/fopen.c b/compat/fopen.c
>  index ccb9e89..70b0d4d 100644
>  --- a/compat/fopen.c
>  +++ b/compat/fopen.c
>  @@ -1,5 +1,5 @@
>  +#undef FREAD_READS_DIRECTORIES
>   #include "../git-compat-util.h"
>  -#undef fopen
>   FILE *git_fopen(const char *path, const char *mode)
>   {
>         FILE *fp;
>
>
>  -brandon
>

Ta. I still get all the warnings with that, was that what you were
trying to solve? The 64 bit specific tests in t5302 do still pass.

Mike
