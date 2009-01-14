From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Wed, 14 Jan 2009 16:55:45 +0100
Message-ID: <bd6139dc0901140755n7e8cbf6eu7cf91279be463501@mail.gmail.com>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at>
	 <1231944876-29930-2-git-send-email-drizzd@aon.at>
	 <1231944876-29930-3-git-send-email-drizzd@aon.at>
	 <1231944876-29930-4-git-send-email-drizzd@aon.at>
	 <alpine.DEB.1.00.0901141641500.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Clemens Buchacher" <drizzd@aon.at>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>,
	johannes@familieschneider.info
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 16:57:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN87D-00085Z-E6
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763590AbZANPzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763577AbZANPzs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:55:48 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:43033 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbZANPzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 10:55:47 -0500
Received: by yx-out-2324.google.com with SMTP id 8so247379yxm.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=XHY1bzItnlhQnq8O70gNiWQZbxCMsbHyPFXTq1OHf0E=;
        b=WOBf95IbuIdW0uYIiP/StLWjtyCVlpKc5OXbLraBI25M/y+xa9jlUixSqzY/BJgRnK
         23xTXeXT25Coh1xk/CeFPXS3SCmgkBGOIuuPrYA/Kja1qgpaM9+xVP0qbHxNOQYCZQ8P
         FVF7CsqeHiAXwcQWCeNGBKdcfiey+epbuIyGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=H7eGJ2L/Z7KNOzHATpXHpL+wOAbps7vDPmMz5pxVWgRE91fsL74YzThayIHIPpK2Gk
         rli+kjMLWx0Qn38MYgXZ8Z2qtXpgCDLouCGxgzxr2Sx+21oo8O0iVb8dOeTVQUvo+xzb
         FLxHgziXALTjYQ64W+TFleEYuTSLXd1Jf49VI=
Received: by 10.150.146.14 with SMTP id t14mr2096938ybd.137.1231948545491;
        Wed, 14 Jan 2009 07:55:45 -0800 (PST)
Received: by 10.150.198.12 with HTTP; Wed, 14 Jan 2009 07:55:45 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901141641500.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 17d01719bb0a05a5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105648>

On Wed, Jan 14, 2009 at 16:44, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> +static int has_special(const char *p)
>> +{
>> +     int x;
>> +
>> +     while ((x = *p++) != '\0')
>> +             if (isspecial(x))
>> +                     return 1;
>> +
>> +     return 0;
>> +}
>
> I would prefer something like this:
>
>        static int has_special(const char *p)
>        {
>                while (*p)
>                        if (isspecial(*(p++)))
>                                return 1;
>                return 0;
>        }
>
> but that is probably a matter of taste.

FWIW, I think the above is a lot less readable due to the assignment
in the while loop's conditional. Whereas in Dscho's version it is
intuitively obvious what the termination condition of the while loop
is.

-- 
Cheers,

Sverre Rabbelier
