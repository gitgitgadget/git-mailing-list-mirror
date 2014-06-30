From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v12 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 30 Jun 2014 13:57:40 +0200
Message-ID: <53B150B4.1030303@gmail.com>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org> <20140525053223.5329.28002.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 13:57:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1aDc-0005K0-AC
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 13:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbaF3L5w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 07:57:52 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:57043 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaF3L5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 07:57:51 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so8105006wes.4
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 04:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NMDubG/KXpxOH+hYMZ/Qj3Zw9I5Hb5Yu7Q/2o9pPcc0=;
        b=Hp5Ke3XyV9NkqNs/88FOmLp9zs2CJM4lbPOk9repHnMIIaPa2BkiCyojAuo1maDwai
         vXCFcKM9ufw/xhvCjZW4cbjUUIgi7otLdYmIs9M3EsCYFEuMad4CqLGNlU0CaAMENMR+
         l/BmjCRL4k03X/J2pJ9ZpBu22KPCMtoq1vyl7Y1Vt+s77pJCYoaKFf16C10i7buEMY8v
         nNFxOFEzIbne8S3VYejYfOtpArJxzCGDJ5owH4djlMMAD6hqoIO9t2+nl3aGdcL165wv
         6m9K43QcIf4NLrv9w3yZobtrq00wHM2a4NTyTxth6GVRXxcjbLDHrqMwnxDRDMz+5CpY
         lR6Q==
X-Received: by 10.180.208.13 with SMTP id ma13mr29183423wic.45.1404129469830;
        Mon, 30 Jun 2014 04:57:49 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id m3sm30685593wik.7.2014.06.30.04.57.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 30 Jun 2014 04:57:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140525053223.5329.28002.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252663>

Christian Couder wrote:

> +------------
> +
> +* Configure a 'sign' trailer with a command to automatically add a
> +  'Signed-off-by: ' with the author information only if there is no
> +  'Signed-off-by: ' already, and show how it works:
> ++
> +------------
> +$ git config trailer.sign.key "Signed-off-by: "
> +$ git config trailer.sign.ifmissing add
> +$ git config trailer.sign.ifexists doNothing
> +$ git config trailer.sign.command 'echo "$(git config user.name) <$(=
git config user.email)>"'
> +$ git interpret-trailers <<EOF
> +> EOF

How to configure git-interpret-trailers command so that it follow
current rules for DCO:
* Signed-off-by: is always at bottom; we can have
   signoff+signoff+ack+signoff
* Signed-off-by: can repeat itself with the same author;
   this denotes steps in coming up with current version of the patch.
* but we shouldn't repeat the same signoff one after another

So we want to allow this:

   Signed-off-by: A U Thor <author@example.com>
   Signed-off-by: Joe R. Hacker <joe@hacker.com>
   Acked-by: D E Veloper <developer@example.com>
   Signed-off-by: C O Mitter <committer@example.com>

but prevent this

   Signed-off-by: C O Mitter <committer@example.com>
   Signed-off-by: C O Mitter <committer@example.com>


IIRC
--=20
Jakub Nar=C4=99bski
