From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5 v4] diff: parse detached options like -S foo
Date: Mon, 2 Aug 2010 14:47:24 -0500
Message-ID: <20100802194724.GC2180@burratino>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
 <1280478669-22973-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v62ztnesc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 21:48:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og10F-00089m-Kk
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 21:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab0HBTsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 15:48:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59394 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab0HBTsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 15:48:46 -0400
Received: by wyb39 with SMTP id 39so3637294wyb.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WJNyDdoac7x8lcFPRYJKc2GXQ+0mo3e1k0OmF/etBgA=;
        b=XbtXyZlq/bKTFlT6UA0IBo5QSWwklo2uZgq8GZq6Yzu5OeKJF/or0P8uU8jbWJFHv3
         lQz4yi30p5v0RvgX3/Dhk4S5wiVpXH5DRMWXfJM7ohDJSW8Mo2BqrOOxKnbz7Mi8taca
         bzJ63BABAT/snchAdvzJTwtrAP4t6p7/2b8go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tZ2xiJ4WtNk/OtyeJuIFF89X+ZSE0vRFZiC44UmsugzKh/MilJ+EGpdZ1WZ+QTqnA2
         VcqV2cmTiZPov4TzhQrDszJPYMBfg+y8FtTwJ7/iOYIlELdn3tUKFwFg2RpmU2E2gnx0
         fCQr9z4JhYNdo0M2Dmf8h706btYCfwOph8hiU=
Received: by 10.227.156.202 with SMTP id y10mr5253587wbw.48.1280778524376;
        Mon, 02 Aug 2010 12:48:44 -0700 (PDT)
Received: from burratino ([64.107.3.126])
        by mx.google.com with ESMTPS id i25sm5292037wbi.4.2010.08.02.12.48.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 12:48:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v62ztnesc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152444>

Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>> +	if (arg[2] != '\0') {
>> +		*optarg = arg + strlen("-c");
>
> Just a style thing, but I think "arg + 2" is much easier to read in this
> particular case, as it won't risk tempting readers to go "Huh?  What does
> that 'c' mean"?

Yeah, especially after the "if (arg[2] != ...)".  Thanks for a sanity
check.

> Do we have an option that can take a zero-length string as its value and
> do something meaningful?  I don't think of any offhand ("log -S'' -p" is
> not it---it may be meaningful but it is not useful), but this code would
> start giving "-p" instead of "" to the option in such a case.

 -l<num>:	"" is not a number.

 -S<artifact>:
		Could "" come up if a user tries to find a commit
		"Adding/removing string:" without typing a string to look
		for in gitk?  No, gitk protects against that.
		How about creating a view with an empty "Search string:"?
		No, that is protected against, too.

		Currently "git log -S" does not seem to do anything
		meaningful, anyway.

 -O<file>:	"" is not a file name.
