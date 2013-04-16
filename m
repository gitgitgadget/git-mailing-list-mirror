From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitweb/INSTALL: GITWEB_CONFIG_SYSTEM is for backward
 compatibility
Date: Tue, 16 Apr 2013 15:26:00 -0700
Message-ID: <20130416222600.GG29773@google.com>
References: <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
 <20130412064953.GB5710@elie.Belkin>
 <7vy5cnd0m4.fsf@alter.siamese.dyndns.org>
 <516888C0.90501@gmail.com>
 <CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com>
 <7vobdfnlc7.fsf@alter.siamese.dyndns.org>
 <CAM9Z-nm=SUNAHXZtOnz_BSS8VrVYPczicX99FUmDJe6Lj_oKpQ@mail.gmail.com>
 <516D4359.2070501@gmail.com>
 <CAM9Z-nkbBS5qvbkocdGWj7rwtSxB86+R4jdjcBOxCU4YjtgZ1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 00:26:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USEKM-0003xg-6o
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 00:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965471Ab3DPW0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 18:26:09 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:59576 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965353Ab3DPW0I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 18:26:08 -0400
Received: by mail-pb0-f49.google.com with SMTP id um15so529909pbc.36
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 15:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=S/BAXuikg0Fgc80mreYGluD3KHMTF8KDG+H63co2kyY=;
        b=OdHeWEtRVHGDyHCQ3QH9T1BEA2QzI97FAInvmzsvvtZZdhdJC4ZjLduwxqhuaxMuED
         chvblSK8nBZ2YfN7kFaoaZyxJRsNJlakSBXXoA3B32x5J2rir0vmrrITEEBe7+dMNveM
         7rkDNf0IDmLx5M23tiPSpb6xv+K6rA/2h2zcgSigWgs8VddRcoHJ69koFCRSGoemTwjK
         PxvoerlSYboWp1Bfi7zjBMOnvwlcG5h2DL8IT7GTjooxjBReqYC4LYUBUE30ufyd6FlL
         759YZYGO75kCouqVzeVbWl4U2/TN4+cecu+k38Fc+0HBsJ16QTUPzJwki93yTnYm38Af
         e8zQ==
X-Received: by 10.68.204.71 with SMTP id kw7mr5913150pbc.40.1366151164651;
        Tue, 16 Apr 2013 15:26:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id dr4sm3580306pbb.19.2013.04.16.15.26.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 15:26:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAM9Z-nkbBS5qvbkocdGWj7rwtSxB86+R4jdjcBOxCU4YjtgZ1A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221484>

Drew Northup wrote:

>                             This is unobtrusive yet to the point.

I agree with the spirit.

[...]
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -55,7 +55,8 @@ following order:
>     then fallback system-wide configuration file (defaults to
> '/etc/gitweb.conf').
> 
>  Values obtained in later configuration files override values obtained earlier
> -in the above sequence.
> +in the above sequence. This is different from many system-wide software
> +installations and will stay this way for historical reasons.

That makes it sound like the "per instance overrides common overrides
built-in" cascading is what is unusual and what we need to apologize
for.

How about something like the following?  (It uses a BUGS section to
make the warning easy to notice for people tracking down confusing
behavior by searching for "gitweb.conf".)

diff --git i/Documentation/gitweb.conf.txt w/Documentation/gitweb.conf.txt
index eb63631..ea0526e 100644
--- i/Documentation/gitweb.conf.txt
+++ w/Documentation/gitweb.conf.txt
@@ -857,6 +857,13 @@ adding the following lines to your gitweb configuration file:
 	$known_snapshot_formats{'zip'}{'disabled'} = 1;
 	$known_snapshot_formats{'tgz'}{'compressor'} = ['gzip','-6'];
 
+BUGS
+----
+Debugging would be easier if the fallback configuration file
+(`/etc/gitweb.conf`) and environment variable to override its location
+('GITWEB_CONFIG_SYSTEM') had names reflecting their "fallback" role.
+The current names are kept to avoid breaking working setups.
+
 ENVIRONMENT
 -----------
 The location of per-instance and system-wide configuration files can be
