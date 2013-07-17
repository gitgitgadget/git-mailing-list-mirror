From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: maintainer question: config http.<url>.* patch administrivia
Date: Wed, 17 Jul 2013 08:02:33 -0700
Message-ID: <68EA6AFC-D90D-4704-AF1A-92AF15617E23@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 17:02:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzTFa-0004TB-0v
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 17:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab3GQPCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 11:02:37 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:60131 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab3GQPCg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 11:02:36 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so1993554pbc.26
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:content-type:content-transfer-encoding:subject
         :mime-version:date:cc:x-mauler;
        bh=KmPuHMPgO0hvxOkjSF3lpo/uywnUcOArj/fAIK289F0=;
        b=HvEE1OiDWF2i34eyq+8UL0+NHcJQcoilZfkE6ZJC1th9n+ceaaakaEvvCuljrS356S
         S582whOT/bCwk88TljfO8/C82jG+B+OIGPkEyCAsk1/80TzeSVGXyDn1hvdjK/G2Mjz/
         vZ/84uLe0ZuC0Nm28DxpjzsClHYTxIVdQiQvceQFrogAJ8Y9eRMk+Ys8NcZUx2Z7Z8FR
         5Peb7PRKmgGee0CP8Soqo9RwTqeZv9ktgfRWs4mWoeP96H4TaQUlAubqF/FqbEndxsht
         IL36DrE2G+tnCp2LBTrAF0uWP5jQu5RLnjsaq3TOk1VPgi6/rm0Gl6ReSjKBPDSKQWs4
         5Nyw==
X-Received: by 10.68.178.161 with SMTP id cz1mr7292395pbc.123.1374073356261;
        Wed, 17 Jul 2013 08:02:36 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id aj3sm11013019pad.8.2013.07.17.08.02.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 08:02:35 -0700 (PDT)
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230627>

I have pondered these items:

On Jul 12, 2013, at 11:48, Junio C Hamano wrote:
> Perhaps we should fix it as a preparatory patch (1/2) before the
> main "feature addition" patch.


On Jul 12, 2013, at 11:52, Junio C Hamano wrote:
> Subject: [PATCH] http.c: fix parsing of  
> http.sslCertPasswordProtected variable

On Jul 14, 2013, at 21:02, Junio C Hamano wrote:
> Assuming that Aaron and Peff's enhancement will not be a backward
> incompatible update, my preference is to take the posted matching
> semantics as-is (you may have some other changes that does not
> change the "strictly textual match" semantics).

And in response I have previously sent out a combined v5 patch that has:

0001: your preparatory http.sslCertPasswordProtected patch
0002: logically related GIT_SSL_CERT_PASSWORD_PROTECTED patch
0003: textual matching http.<url>.* patch
0004: url normalization matching http.<url>.*
0005: test for url normalization function

However, upon further consideration (I noticed that the preparatory  
patch and v4 of the textual matching patch made their way into pu),  
perhaps it would be more convenient for you if I re-released the  
following patch series:


[PATCH v5]: config: support http.<url>.* settings - (1) textual matching

* contains 0001 the same preparatory http.sslCertPasswordProtected
* contains 0002 the same v5 textual matching http.<url>.* patch


[PATCH v2]: config: support http.<url>.* settings - (2) url  
normalization

* contains 0001 url normalization matching with feedback updates
* contains 0002 url normalization test


[PATCH v1]: config: support http.<url>.* settings - (3) any user  
matching

* contains 0001 a new patch that extends (2) to include any user  
matching


And drop the GIT_SSL_CERT_PASSWORD_PROTECTED patch as while it's  
logically related to the http.sslCertPasswordProtected patch it's not  
logistically related since independent areas of the file are touched  
and it could be successfully applied before or after the other  
patches.  It can go together with any forthcoming enable-only fix for  
GIT_SSL_CERT_PASSWORD_PROTECTED and other such environment variables  
or just be dropped entirely.

I do not, however, wish to create any additional maintainer work, so  
wanted to check with you before sending out any of the reissues.
