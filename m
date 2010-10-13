From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t5523-push-upstream: add function to ensure fresh
 upstream repo
Date: Wed, 13 Oct 2010 14:30:39 -0500
Message-ID: <20101013193039.GA8941@burratino>
References: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
 <1286998311-5112-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:42:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P67D4-0002Eu-Cw
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab0JMTlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:41:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58884 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab0JMTlu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:41:50 -0400
Received: by wyb28 with SMTP id 28so1418447wyb.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KejFWwDIRXDT59VDg0BAuch3StvPWFDfNcCObRioGMc=;
        b=MTgdOR2EZMirs6tTP9R7J5aauPtgdFcnGUqYKTyrSMNcyV1V5rL34lpPTfUZbvc4w4
         6mWpkQ1FMSjDZmv3jxa1EXFwhW3yJTjWzlmuJKLDKnaBWHtrXJqXVUiyWgArnAPO1yjZ
         z0RAuHKOP1UeaUQHZYPXoJydXGFrPCuD//22c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UDlmWS6qFWkwUjesI9WobiAcd76vhXQyR+rIlAPWFq06rCyr3mHyJplp2xfnUm0+6a
         BHwzpyMYpY2WxG4YC8LQgnzgRAKPZQvfsY97FvpEMKnAjh7FvSBE23lO8jaExg6tTcNs
         3yXbag4o5NXP3g7QP8M4acX/ghbLga4brXe4o=
Received: by 10.227.68.207 with SMTP id w15mr9277533wbi.75.1286998445881;
        Wed, 13 Oct 2010 12:34:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a17sm6432534wbe.18.2010.10.13.12.34.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 12:34:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286998311-5112-2-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158973>

Tay Ray Chuan wrote:

> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
> @@ -3,8 +3,14 @@
>  test_description='push with --set-upstream'
>  . ./test-lib.sh
>  
> +ensure_fresh_upstream() {
> +	test -d parent &&
> +	rm -rf parent
> +	git init --bare parent
> +}

Wouldn't

	rm -rf parent &&
	git init --bare parent

do it?
