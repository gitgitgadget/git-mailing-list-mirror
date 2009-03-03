From: Dave <kilroyd@googlemail.com>
Subject: Re: [Orinoco-users] linux-firmware binary corruption with gitweb
Date: Tue, 03 Mar 2009 18:59:55 +0000
Message-ID: <49AD7E2B.3010101@gmail.com>
References: <49A98F6A.50702@gmail.com> <1235886467.3195.15.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, orinoco-users@lists.sourceforge.net,
	dwmw2@infradead.org
To: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756677AbZCCTA2@vger.kernel.org Tue Mar 03 20:01:54 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756677AbZCCTA2@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZsF-0002bZ-QI
	for glk-linux-kernel-3@gmane.org; Tue, 03 Mar 2009 20:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbZCCTA2 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 3 Mar 2009 14:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbZCCTAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Mar 2009 14:00:10 -0500
Received: from mail-ew0-f177.google.com ([209.85.219.177]:47077 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZCCTAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Mar 2009 14:00:09 -0500
Received: by ewy25 with SMTP id 25so2462485ewy.37
        for <multiple recipients>; Tue, 03 Mar 2009 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=FvbB6nCexQ+ZtI5QRH08Hv6mYvno2i2bpjNm8DqN/nY=;
        b=hi2Yj1nzKhhhkD2wp9o5DyvEDfv+abDV8WPe3zF5eaIQq/mwFQfuTfaieA5FxEZLx4
         3bofnKxDbmbCC5PrFBOKch+NPT488C0y2oPoymojP1loarCtZeBjadmGEeYZfFGX/KXm
         dToC29z1VgoFLFrTGHl5sbbieQMU96XwQea74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tZxnMAMB/wcFO/Am0RepwPvg0ReyBrnVPkaZYzGpWN4y+nSE9ApeSVYtqhsEuE9qZV
         e+w09T5Rf2qGn6CKn7xXWdqLYq98pBRDQsHsEjs2sFUqRuZUUDbyZO80UMWVHyvHSPLT
         OPLVDWGqyA88ytd6LapHJrGuVV81pzfzFxBpU=
Received: by 10.216.26.70 with SMTP id b48mr380888wea.141.1236106804765;
        Tue, 03 Mar 2009 11:00:04 -0800 (PST)
Received: from ?192.168.0.4? (5ac998a0.bb.sky.com [90.201.152.160])
        by mx.google.com with ESMTPS id q9sm2812373gve.27.2009.03.03.11.00.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Mar 2009 11:00:03 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090104)
In-Reply-To: <1235886467.3195.15.camel@mj>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112148>

Adding the git mailing list.

Pavel Roskin wrote:
> On Sat, 2009-02-28 at 19:24 +0000, Dave wrote:
>> I'm aware of at least a couple users of orinoco who have picked up
>> corrupt firmware# from the linux-firmware tree*.
>>
>> I've verified that the firmware in the repository itself is correct.
>>
>> It appears that downloading the file using the blob/raw links from
>> gitweb causes the corruption (0xc3 everywhere). At least it does with
>> firefox.
> 
> I can confirm the problem with Firefox 3.0.6.  But it's not "0xc3
> everywhere".  The corrupted file is a result of recoding from iso-8859-1
> to utf-8.  The correct agere_sta_fw.bin is 65046 bytes long.  The
> corrupted agere_sta_fw.bin is 89729 bytes long.
> 
> There is a way to recode the original binary with GNU recode:
> recode utf8..iso8859-1 agere_sta_fw.bin
> 
> wget 1.11.4 also gets a corrupted file 89729 bytes long.
> 
> curl 7.18.2 also get the corrupted file:
> 
> My strong impression is that the recoding takes place on the server.  I
> think the bug should be reported to the gitweb maintainers unless it a
> local breakage on the kernel.org site.

Thanks Pavel.

I just did a quick scan of the gitweb README - is this an issue with the
$mimetypes_file or $fallback_encoding configurations variables?


Regards,

Dave.

#<http://marc.info/?l=orinoco-users&m=123411762524637>
*<http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=shortlog>
