From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 14/27] update-ref.c: Extract a new function, parse_next_sha1()
Date: Wed, 26 Mar 2014 14:39:07 -0400
Message-ID: <53331ECB.5040901@kitware.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu> <1395683820-17304-15-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:43:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSsnl-0004tr-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbaCZSnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 14:43:45 -0400
Received: from na6sys009bog004.obsmtp.com ([74.125.150.48]:44279 "HELO
	na6sys009bog004.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751906AbaCZSno (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 14:43:44 -0400
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Mar 2014 14:43:44 EDT
Received: from mail-ig0-f177.google.com ([209.85.213.177]) (using TLSv1) by na6sys009bob004.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUzMf4GX8c5y8rla2wzgasWU2d2GfjGOF@postini.com; Wed, 26 Mar 2014 11:43:44 PDT
Received: by mail-ig0-f177.google.com with SMTP id ur14so858093igb.10
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 11:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Q0MwkifJmEV8H0apbY82AqXF5/Tnls3UG9LTp9XOZYg=;
        b=lRBs8qjH3bbBruAcnJkiyWxvB8YW52DilUty+REZcjOQkM2mCMAaAkcZLTwei79EoP
         +4Qx0zzG/D19f8SqhX7unq83/ERSBgotOF8kC/HgMSG95s5nMlYswyCglJi5m3//wSRK
         b1Jv7ntqMLRZ2TviTILeiPtRIPbSBULQS19ZSCOR0aWimsxgcESQWHk/XRSzJ+nWgUbQ
         6mlzPVy+M6p1ec6h1gSg8UCHHuFbjiU5wR77XHzuZ6zG1tZeEFhUXB4TDquXF5EEcbz2
         D1sQFfwCMBeC84vS2xmKyQABmNh7LqhtrXxS569eMAcEB1RV39m3STR40k47Jwxo3JW8
         jWlQ==
X-Received: by 10.50.87.2 with SMTP id t2mr25236541igz.1.1395859101809;
        Wed, 26 Mar 2014 11:38:21 -0700 (PDT)
X-Gm-Message-State: ALoCoQnPleKQBMPT1/F5xL5aeG4BVp0ghi27mgieLxidaOnUIILDhKTL5ddrqp203f5utL2QW01ZBpTwRGiqlL/drXekCc2OuvuskQqPfBDKGz3n5T2GViV2ThMPWdtnf7979FV2pK+TJnWaK2nClt8ZyVtHkQ6gaw==
X-Received: by 10.50.87.2 with SMTP id t2mr25236538igz.1.1395859101735;
        Wed, 26 Mar 2014 11:38:21 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id s3sm60561igr.14.2014.03.26.11.38.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 11:38:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1395683820-17304-15-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245204>

On 03/24/2014 01:56 PM, Michael Haggerty wrote:
> +/*
> + * For backwards compatibility, accept an empty string for create's
> + * <newvalue> in binary mode to be equivalent to specifying zeros.
> + */
> +#define PARSE_SHA1_ALLOW_EMPTY 0x02

The comment should say "update's", not "create's".

-Brad
