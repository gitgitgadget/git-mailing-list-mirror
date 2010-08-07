From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] Allow HTTP user agent string to be modified.
Date: Sat, 7 Aug 2010 08:34:53 +0000
Message-ID: <AANLkTinyohKaACbheGR2Q=-K5sWwv+y1u1-3b2WPzxVh@mail.gmail.com>
References: <1281152060-16736-1-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Sat Aug 07 14:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhiGk-0004JG-8g
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 14:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab0HGIe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 04:34:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49791 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab0HGIey convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Aug 2010 04:34:54 -0400
Received: by iwn33 with SMTP id 33so2032088iwn.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YFwwGvR2xszerhmmUc+sqIF4Tbb3bI/vDEOAS2mEWKY=;
        b=WrSYvVBD5xO+ljBblT5FQG9lojBGenBrzQlWk/QI3woObfXpKrhb3VZpyK8C9dg6rz
         JKMHu5sGMNB+6kvukKdvV57RuO9ySLzuAZmcpSX6xSvLQNRNd09aEz8sKTUwLFC39PRl
         /qt7hv3dy2Yxqb1qAoAXjwut4L8AeRsR1y6vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QUyj2Mik4SR/cQfufz6ixJXQ3OZPporvVS8X5ppKmWMHmX2crF8oT2pFcXPv2j+e4x
         FqUk4blbUuMzaXQdSI/CojzpH+l8FBawyZtz8VvDWExkCV/+4GlJWGZhVZi77rOFIC2w
         nxzL0SVrR3CS+KbjzX4uUoOJzZsVvufOv31xs=
Received: by 10.231.32.132 with SMTP id c4mr15051629ibd.84.1281170093067; Sat, 
	07 Aug 2010 01:34:53 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 7 Aug 2010 01:34:53 -0700 (PDT)
In-Reply-To: <1281152060-16736-1-git-send-email-olsonse@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152848>

On Sat, Aug 7, 2010 at 03:34, Spencer E. Olson <olsonse@umich.edu> wrot=
e:

> - =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(result, CURLOPT_USERAGENT, GI=
T_USER_AGENT);
> + =C2=A0 =C2=A0 =C2=A0 if (user_agent !=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(r=
esult, CURLOPT_USERAGENT, user_agent);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(r=
esult, CURLOPT_USERAGENT, GIT_USER_AGENT);

Can't you just skip the !=3D NULL?:

 =C2=A0 =C2=A0 =C2=A0 if (user_agent)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(resu=
lt, CURLOPT_USERAGENT, user_agent);
 =C2=A0 =C2=A0 =C2=A0 else
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(resu=
lt, CURLOPT_USERAGENT, GIT_USER_AGENT);
