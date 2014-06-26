From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v20 13/48] refs.c: make resolve_ref_unsafe set errno to
 something meaningful on error
Date: Thu, 26 Jun 2014 11:54:40 +0200
Message-ID: <53ABEDE0.9070501@gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-14-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 11:54:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X06OK-0000Nc-DJ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 11:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965AbaFZJyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 05:54:45 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:42453 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbaFZJym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 05:54:42 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so692354wib.13
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ivqhidebatM+PcTN9x25vvD6VZE7PTnwAOGAsr3Jkcg=;
        b=0wO1m7YyRgcVELYbVWWmqzoEBpwta8n+lKF99dAR5CYjES/E4OYRtddeSTgrWpLfIQ
         Ns0RZiBK360zDtVtioOgjx2D5jNi8TrkozTKxmTDZLZIZPnqIy/LNzBAIYQVjKjWUm2s
         R1utTrEuS9Eujub2zxPUYzQRUS5X5T++UgqNwuD50lUNvXTn8pITrY0jPsG2DNAKKjHH
         nwmZ2iXoMVEmPDfohtR9nwv+4Q1SuJ7Mgoc9KF0Bij/dCypset0qJpn8KDwyovAVCNxN
         hBYi8mo1HyaaESjlWsV6VM5VepmDmnukecgZMH6U4F6EqBIQ9IhkIRFQExOsnnhOWkqk
         +oQg==
X-Received: by 10.180.107.99 with SMTP id hb3mr3077415wib.8.1403776480056;
        Thu, 26 Jun 2014 02:54:40 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id jb16sm22606903wic.10.2014.06.26.02.54.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 02:54:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1403275409-28173-14-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252496>

Am 20.06.2014 16:42, schrieb Ronnie Sahlberg:
> +			errno = ELOOP;

This fails on MinGW and MSVC < 2010. Perhaps add this to compat/mingw.h?

 #ifndef ELOOP
 #define ELOOP EMLINK
 #endif
