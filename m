From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Speedup prefixcmp() common case
Date: Sat, 29 Dec 2007 21:14:55 +0100
Message-ID: <e5bfff550712291214p7554ea52o875667906ce1a22d@mail.gmail.com>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	 <7v63yhb8kf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 21:15:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8i5d-0005oZ-VV
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 21:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbXL2UO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbXL2UO5
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 15:14:57 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:23926 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXL2UO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 15:14:56 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3961725rvb.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 12:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zSMf0aMDy8wMjEEuisLNGkoON1pLxRTGQMqtnvFunCM=;
        b=Z+xt4rtzwhXLPkkPZWMEO7hmlnRDo0j2aSci0lrUQpBw67HU21olLPM88WuqEa9+H//24+3Tb35PBFyv6Qh3K7RJrA11AUgBkm7tFzEjCibKc3Lif+nBxAvxa37n0b0yhAMxRHOeOyH8RPL/0llodrEhfMSujB/o7DYbcFaV2sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NJYyPLnLfJ/V2u7Or0XXV5oBwyvxaoIy8/5NjXJ7ZhwdBvtzJWfe4lGXTxuAg4/j8hUTeV2Yv9sdkUPUiBAxRxHzGkL4ScF7AvJUHf7IUwKP0EmxCTtqpxGpv8LN3TMPrsIaanYROvMIOuh0r/2tJOjh2d+lQVAc2kf7qkjsdL8=
Received: by 10.141.22.1 with SMTP id z1mr5521787rvi.277.1198959295665;
        Sat, 29 Dec 2007 12:14:55 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 29 Dec 2007 12:14:55 -0800 (PST)
In-Reply-To: <7v63yhb8kf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69329>

On Dec 29, 2007 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Why isn't it like this?
>
>         if (!prefix[1])
>

well, what about if prefix == NULL ?

Actually I didn't checked if strncmp() checks for NULL pointers before
to proceed, if this is the case I managed to keep the same semantic.

You could say "Why, lazy you, didn't you checked if strncmp() checks
for NULL pointers? "...but I hope you are foregiving ;-)

Thanks
Marco
