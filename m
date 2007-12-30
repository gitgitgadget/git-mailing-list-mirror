From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sun, 30 Dec 2007 16:17:52 +0100
Message-ID: <e5bfff550712300717r4512954rbf2516491fc13adc@mail.gmail.com>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	 <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	 <e5bfff550712291239y5648b923y8d332d9c40a8c97b@mail.gmail.com>
	 <Pine.LNX.4.64.0712292307210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	 <e5bfff550712300502p543680b9jbeb9469a5a970f0@mail.gmail.com>
	 <20071230135557.GA25917@artemis.madism.org>
	 <20071230135820.GB25917@artemis.madism.org>
	 <e5bfff550712300650j2ea70032jaca893b734592184@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 30 16:18:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8zve-0007Iu-LH
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 16:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826AbXL3PRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 10:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755553AbXL3PRy
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 10:17:54 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:43552 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392AbXL3PRx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 10:17:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4214666rvb.1
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 07:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=su/uxv2qkcD5v8tA2Gj/Bn9LqCv/T5nX2eyMtmsiI4k=;
        b=ZKeAZ9LEU+Prc22Rqv4XkNitqOSdSyx2BcO3VO/PD5GtF9XlcOEItlvrzeVo3lHyftwP45VEcWgzE0x9b9aJXGu9yphppgoH5ulQ6B65ivUkyLfe9xamVOxJyv+GT1cnQehiDLgsN7mh9C7a1OQSmGpujGSXLnXVSRGjiybt5Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=El/m4MHvZ1VTUR2Vig/UTddD4fJwB9TiiXGcvWydK265I6+FH8mzI3broMh0QKhejjwsxEUkNKNZRXcxaKrohic/ZKwVYE7XFw6OrDaIhvJ9jrN033N2zVgtX0wLc1fdQWXY0tV8d4WwsSixIFLxgb0lla3xHRAt834o1YJRR6A=
Received: by 10.141.211.13 with SMTP id n13mr5848043rvq.184.1199027872841;
        Sun, 30 Dec 2007 07:17:52 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 30 Dec 2007 07:17:52 -0800 (PST)
In-Reply-To: <e5bfff550712300650j2ea70032jaca893b734592184@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69366>

On Dec 30, 2007 3:50 PM, Marco Costalba <mcostalba@gmail.com> wrote:
>
> If *prefix == "" case is to be considered I vote for your/Johannes
> version because it's "better code" (tm).
>
Ok this is fast and correct

static inline int prefixcmp(const char *str, const char *prefix)
{
	while (*str == *prefix && *prefix)
    		str++, prefix++;

	return (*prefix ? *(unsigned const char *)prefix - *(unsigned const
char *)str : 0);
}


This is the last one, I promise ;-)

Marco
