From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 5/5] Speed up log -L... -M
Date: Thu, 21 Mar 2013 17:11:28 -0400
Message-ID: <CAPig+cSG1gYohpZQZxnCpKgkUPs=Dwfokx+3OhiqdGKX8fajBw@mail.gmail.com>
References: <cover.1363865444.git.trast@student.ethz.ch>
	<72a500432c0e6fde830f505204a1d02180710656.1363865444.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>, Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 21 22:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UImmE-0000Qs-L7
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 22:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab3CUVLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 17:11:31 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:61312 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3CUVLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 17:11:30 -0400
Received: by mail-la0-f47.google.com with SMTP id fj20so6097708lab.34
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=7Uy6DC/SZL0s5c6QwnhS3efj1rLND20CWaWCATpNqBM=;
        b=vlaP1Ny3NGbwHAGUmPmwWWd+XB/jPjmYueXQ50qDHopv7n70UM5Ii9cyT2AITI4a00
         dZYhmUAelVHsFX6o68Z3VMmUAzoayslsOI1a8vHImlNFwUPxDKKGVWTJF6eqv3BShfi5
         bLS7oT4ed/HUz/TpKnwnqaIX+lPWaFEly9/hyz6AYyvyLYlfj31wh6YYZ+v2wE71D+7m
         l4lXvP39KeDZaKNHGhNn7OoOcmR4VYIXD6LBJZOP7JYW1hGFdzsuxKlVOHxWIilF0sqT
         hFeSOunB9hW729DKNf/mMXb2e6JVY3LwRfVM9xwxTsRTzT5N98eupIRQfes+JfiI9kde
         +sMA==
X-Received: by 10.112.162.65 with SMTP id xy1mr12092596lbb.105.1363900288592;
 Thu, 21 Mar 2013 14:11:28 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Thu, 21 Mar 2013 14:11:28 -0700 (PDT)
In-Reply-To: <72a500432c0e6fde830f505204a1d02180710656.1363865444.git.trast@student.ethz.ch>
X-Google-Sender-Auth: IDTx6dYs8FUqQ2dke9j09L09-94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218762>

On Thu, Mar 21, 2013 at 8:52 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> This is a bit hacky and should really be replaced by equivalent
> support in --follow, and just using that.  However, in the meantime it

s/using/use/

> speeds up 'log -M -L' by an order of magnitude.
