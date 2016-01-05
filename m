From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] Add a test for subtree rebase that loses commits
Date: Tue, 05 Jan 2016 10:57:37 +0100
Message-ID: <1451987857.2668.5.camel@kaarsemaker.net>
References: <1451968805-6948-1-git-send-email-greened@obbligato.org>
	 <1451968805-6948-2-git-send-email-greened@obbligato.org>
	 <568B833B.4060001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Jan 05 10:57:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGON8-0004Ws-RW
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 10:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbcAEJ5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2016 04:57:42 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37636 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbcAEJ5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 04:57:40 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so20725036wmf.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 01:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=OozexJAVvpypQsBjKB/BqYxqTBg57mYIiwITuCemG18=;
        b=SFpH139FvoVQeUGoSRGlaiWwOkuSV5Id8Jfpk3lTr3uhd9RCNgiQzIYhwDjDKKGZMZ
         lVJwS5G5JaIbCyKNktYCCt1fXQhWhNb6A/aQiSXZ4iTQoFl+vviv5EpBh3ZIyqfVytVp
         J8fOb48x7gwYDLa/wnfFkDTGuGktsGOh/jM17I1Uzq/Rufk/Tx3IiLuYbeOIFIlZNtDt
         xInKtFAMy3YnkWsFKGqS+XfSxkqg/XYnjAHXHUBHm4Iudm8LdiInlM0Xn4DJfK0Urc9g
         IYLTmJ55NZJ4Wb5InQXd/rlJtqmxaZ3MwuSDIzsK5tjiKMASjfRLGCHqFheMui1JN/8Z
         pNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=OozexJAVvpypQsBjKB/BqYxqTBg57mYIiwITuCemG18=;
        b=i7Qqo0jdAVzi46YnOCNUnPsepvQ1KyEaIHPFb9mmjNZqKKs2UGewS1ldoP03HQcoJF
         SXwafATOb5g8+HYqsG4GJJXbHbT55Dl1Md+krCoAqKVXlNtEPg6mJMr7rpR+hhY/ylyz
         lvHH+hFk8rHd17tx4BUrVLmwAQ5GZi/2aJSjDHen4LQTAe2giRUA7rYayOGlT0rVKw+H
         f3+Uv/n/ma+mb2vHe+q4lq/RRoe9EH1gO8M4tcC1349erB+IQc05kCY8vrRidUQIalFB
         tB9THMPUxfhakSaUYOpmCxNudUWy2Z7TDWgZ4maoiO0uemvXcjdsHBZ0HQ8rUd7VWeaU
         JDhQ==
X-Gm-Message-State: ALoCoQk40XpHZAQ1TVxGQ/IIbDz63WWNKdIS6Wq8Ndv8CWZLyS/v/mNEb0exCmgJRJ+4OVZB6vq33GwS8An5ysumHlvHFu1u3Q==
X-Received: by 10.28.148.140 with SMTP id w134mr3274904wmd.66.1451987859670;
        Tue, 05 Jan 2016 01:57:39 -0800 (PST)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id x125sm2976395wmg.1.2016.01.05.01.57.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 01:57:38 -0800 (PST)
In-Reply-To: <568B833B.4060001@web.de>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283368>

On di, 2016-01-05 at 09:47 +0100, Torsten B=C3=B6gershausen wrote:
> Need to drop
> David Greene <greened@obbligato.org>
> from List, no MX record

seahawk:~$ dig MX obbligato.org
obbligato.org.		1800	IN	MX	10
mail.obbligato.org.
seahawk:~$ dig mail.obbligato.org
mail.obbligato.org.	1800	IN	CNAME	obbligato
=2Eorg.
obbligato.org.		1800	IN	A	173.255.19
9.253

So it has an MX record, it's just incorrect: MX records must not point
to things that are CNAMEs.

--=20
Dennis Kaarsemaker
http://www.kaarsemaker.net
